# Roadmap: local fields, ramification, and local class field theory

Mathlib has a definition of a nonarchimedean local field: the class
[`IsNonarchimedeanLocalField`](https://leanprover-community.github.io/mathlib4_docs/Mathlib/NumberTheory/LocalField/Basic.html)
in `Mathlib/NumberTheory/LocalField/Basic.lean` (Andrew Yang, 2025), built on the `ValuativeRel`
framework as a topological field whose topology comes from its valuation class, locally compact
and nondiscrete. At the pin this is one thin file, but a well-chosen one: it derives
`IsDiscreteValuationRing 𝒪[K]`, `Finite 𝓀[K]`, compactness of `𝒪[K]`, and the value-group
isomorphism `ValueGroupWithZero K ≃*o ℤᵐ⁰` from the definition, and it is the vocabulary that the
active class-field-theory formalization ([kbuzzard/ClassFieldTheory](https://github.com/kbuzzard/ClassFieldTheory))
has adopted. Beyond the definition, almost the entire arithmetic of local fields is missing
upstream. There is no unit-filtration theory, no unramified-extension theory with Frobenius, no
higher ramification (the pin's `RingTheory/Valuation/RamificationGroup.lean` has only
decomposition and inertia groups, with an explicit `TODO: Define higher ramification groups in
lower numbering`), no tame quotient, no Herbrand quotient, no invariant map, no fundamental
classes, no reciprocity map, no local Tate duality, no Euler characteristic. This roadmap builds
that arithmetic: the structure theory of local fields and their extensions, the ramification
filtration in both numberings, the tame quotient of the absolute Galois group, and local class
field theory through duality, the Euler characteristic, and the topological finite generation of
`G_K`, each layer with its complete basic theory rather than only its headline theorem.

Local class field theory is being formalized in `kbuzzard/ClassFieldTheory` (the 2025 Clay
Summer School project, maintained by Yunzhou "Edison" Xie). Its abstract half is done: Tate cohomology (since upstreamed to Mathlib master), the Herbrand-quotient calculus, and a
`FiniteClassFormation` interface with a sorry-free abstract reciprocity isomorphism. Its local
half (unramified-unit cohomology, the local-unit Herbrand quotient, fundamental classes, the
Artin map) is open at the audited revision. Ramification filtrations have a partial, stalled
formalization in [Akwardbro/RamificationGroup](https://github.com/Akwardbro/RamificationGroup)
(Junjie Bai, Jiedong Jiang, et al., following Serre *Local Fields* IV). This roadmap develops the
same mathematics **independently in Tau Ceti**, in Mathlib's
`IsNonarchimedeanLocalField`/`ValuativeRel` vocabulary, citing and staying convention-compatible
with both projects (see Provenance): the interfaces are aligned so that milestones can refactor
onto their work if it lands in Mathlib, and so that results proved here are usable by their
consumers (the [FLT](https://github.com/ImperialCollegeLondon/FLT) blueprint explicitly consumes
local reciprocity as a `\notready` input).

Suggested home: `TauCeti/NumberTheory/LocalField/`, mirroring the Mathlib path that owns the
`IsNonarchimedeanLocalField` class, with subdirectories per layer (`Basic/`, `UnitFiltration/`,
`Unramified/`, `Ramification/`, `TameQuotient/`, `Cohomology/`, `ClassFormation/`,
`Reciprocity/`, `Duality/`, `FiniteGeneration/`). One generic theorem proved along the way does
not belong under `NumberTheory/`: the finite-group class formation and Tate–Nakayama material of
Layer 6 is about finite groups and their cohomology, and its home is
`TauCeti/RepresentationTheory/Homological/GroupCohomology/ClassFormation/`. Keeping the Tau Ceti
paths parallel to the Mathlib ones makes eventual upstreaming a file move rather than a renaming.

This roadmap is one of four coordinated developments. It **consumes** PR
[#1, Profinite Cohomology](https://github.com/roed-math/TauCetiRoadmap/pull/1): its Layers 0–7
supply the explicit and canonical comparison maps, finite-quotient colimits, exact sequences,
restriction and corestriction, Shapiro, and cup products used in Layers 5–8 here, and its Layer 9
supplies Kummer theory. It consumes PR
[#3, Pro-p Groups](https://github.com/roed-math/TauCetiRoadmap/pull/3) **Layer 3** for the
topological rank `d(G)`, the maximal pro-`p` quotient, the Frattini subgroup, the Burnside basis
theorem, and the Schreier bound `d(U) ≤ 1 + [G : U](d(G) − 1)`, all used in Layers 1, 4, and 9;
and PR #3 **Layer 11** for the rank of the maximal pro-`p` quotient `G_K(p)`, used only in
Layer 9. In the other direction, Layers 5, 7, and 8 here supply the invariant map, Kummer and
local reciprocity, the two regimes of duality, and the Euler characteristic consumed by PR #3
Layer 11. The resulting order is `LocalFields 0–8 → PR #3 Layer 11 → LocalFields 9`, which is
acyclic; PR #3 Layer 3 precedes everything here. Layer 8 also supplies the mixed-characteristic
mod-2 duality statement consumed by PR
[#4, Quadratic Form Invariants](https://github.com/roed-math/TauCetiRoadmap/pull/4) Layers 6–7.
The neighboring
[adic-spaces roadmap (PR #80)](https://github.com/TauCetiProject/TauCetiRoadmap/pull/80)
shares only the `ValuativeRel` substrate: it develops valuation *spectra* and Huber/Tate rings
toward the Fargues–Fontaine curve and does not touch local-field arithmetic (ramification, unit
filtrations, reciprocity), so the two do not overlap.

## Standing hypotheses

The standing setting is a field `K` with `[Field K] [ValuativeRel K] [TopologicalSpace K]
[IsNonarchimedeanLocalField K]`, and for extensions a second such field `L` with
`[Algebra K L] [ValuativeExtension K L]` and finiteness `[Module.Finite K L]`. Spell these out;
do not bundle them into a new class. Where a statement needs completeness, add the uniform
hypotheses `[UniformSpace K] [IsUniformAddGroup K]` as Mathlib's own `CompleteSpace` instances
do. Do not fix `p` prime or `K/ℚ_p` finite in the common structural layers. Instead, every
power-class, Kummer, cohomological-dimension, duality, and Euler statement names its regime:

1. **prime to the residue characteristic**, valid in mixed and equal characteristic; or
2. **mixed-characteristic `p`-primary**, where `K` is a finite extension of `ℚ_p`.

Positive characteristic `K = 𝔽_q((t))` remains a worked example in the common and
prime-to-residue-characteristic parts. Layer 9 and its `ℚ_p`-specific examples are
mixed-characteristic. Never assume `p ≠ 2` inside the mixed-characteristic statements: every
downstream consumer of this roadmap lives at `p = 2`, and the literature is full of odd-`p`
shortcuts (NSW's (7.5.14) subsection assumes `p ≠ 2`; tame arguments silently assume `p ∤ e`).
Statements must carry their true hypotheses.

### Scope boundary: `p`-power coefficients in equal characteristic

When `char K = p` and `p` divides `n`, none of the statements in regimes 1 and 2 is asserted
here, and no milestone below may be extended to that case by weakening a hypothesis. The reason
is not sequencing: the statements are false there. At `K = 𝔽_q((t))` and `n = p` the classes of
`1 + t^m` for `p ∤ m` are pairwise distinct in `Kˣ/(Kˣ)^p`, so that group is infinite, and
`H¹(G_K, ℤ/p)` is infinite with it; `cd_p(G_K)` is `1`, not `2`; and `μ_{p^r}` is not the finite
étale dual that the duality pairing needs. Artin–Schreier–Witt theory and finite flat (Cartier)
duality are what replace them, and this roadmap does not build either. Every regime-1 hypothesis
below is stated as `IsUnit (n : 𝒪[K])` precisely so that this case is excluded by the
hypothesis rather than by a side condition a reader can overlook.

## Pinned conventions

| object | convention | source of truth |
|---|---|---|
| valuation, multiplicative | Mathlib's canonical `ValuativeRel.valuation K` into `ValueGroupWithZero K ≃*o ℤᵐ⁰`; `v(π) = exp (−1)` for a uniformizer `π` (so `v < 1` on `𝓂[K]`), matching `Padic.mulValuation x = exp (−x.valuation)` | `Mathlib/NumberTheory/Padics/PadicNumbers.lean`, `Mathlib/RingTheory/Valuation/ValuativeRel/Basic.lean` |
| valuation, normalized additive | on nonzero elements use `v_K^× : Kˣ →* Multiplicative ℤ`, the multiplicatively encoded additive valuation, and write `v_K(x) := Multiplicative.toAdd (v_K^× x)` when an integer is wanted. For a uniformizer `π`, `v_K^×(π) = Multiplicative.ofAdd 1` (equivalently `v_K(π) = 1`), while `v_K^×(x) = 1` is reserved for the kernel/unit condition (additive value `0`). Extend separately across zero using `ℤᵐ⁰`; never write the ambiguous Lean-facing equation `v_K^×(π) = 1` | this roadmap (Layer 0); translation from the canonical multiplicative valuation carries a sign and is a named lemma |
| absolute value | `‖x‖_K = q^{−v_K(x)}` with `q = Nat.card 𝓀[K]`, valued in `ℚ≥0`; this is what makes the Euler characteristic read `‖#M‖_K` (Layer 8) and matches `Padic.norm_eq_zpow_neg_valuation` | Layer 0 |
| residue field, integers | `𝒪[K]`, `𝓂[K]`, `𝓀[K]`, the `ValuativeRel`-scoped notations (`Valuation.integer (valuation K)` and friends); never a rival valuation subring | `Mathlib/Topology/Algebra/Valued/ValuativeRel.lean` |
| unit filtration | `U(K, i) : Subgroup Kˣ` indexed by `i : ℕ`, with `U(K, 0) = 𝒪[K]ˣ` and `U(K, i) = 1 + 𝓂[K]^i` for `i ≥ 1` (literature `U_K^{(i)}`) | Layer 1 |
| ramification filtration | lower numbering `G_i` indexed by `i : ℤ`, total, with `G_i = ⊤` for `i ≤ −1`, `G_0` the inertia group and `G_1` the wild inertia group (Serre LF IV §1); real index `G_u := G_{⌈u⌉}` for `u : ℝ`; Herbrand functions `φ_{L/K}, ψ_{L/K} : ℝ → ℝ`; upper numbering `G^u = G_{ψ(u)}`. The two filtrations use different index sets on purpose: any statement relating `U(K, i)` to `G_j` writes the shift out | Layer 3 |
| Frobenius | **arithmetic** Frobenius `x ↦ x^q` on residue fields is the distinguished generator; "Frobenius" unqualified always means arithmetic; geometric Frobenius is its inverse and is always named `geometric` | Layer 2 |
| absolute Galois group | `Field.absoluteGaloisGroup K`, that is `Gal(AlgebraicClosure K / K)`, in every public statement, including in characteristic `p`. Restriction to the separable closure is a topological isomorphism, proved once as a comparison theorem and used wherever a separable-closure model is convenient internally | Layer 4 |
| reciprocity normalization | `Art_K : Kˣ →* G_K^{ab}` sends **uniformizers to arithmetic Frobenius**; equivalently `ν_K ∘ Art_K = ι ∘ v_K`, where `ν_K : G_K^{ab} →* Ẑ` is normalized by `ν_K(Frob) = 1` and `ι : ℤ → Ẑ` is the completion map (the Neukirch/NSW convention). The geometric normalization `Art_K^{geo} = Art_K ∘ (·)⁻¹` is a definition plus a translation lemma, never a second convention | Layer 7 |
| unramified coordinate target | `ν_K` targets `Ẑ` (profinite), **never** `ℤ`: a continuous homomorphism from the compact `G_K^{ab}` to discrete `ℤ` is trivial, so the `ℤ`-valued version of the normalization is *inconsistent*, not merely inconvenient | Layer 2/7 (⚠) |
| conductor | `c(L/K) : ℕ` for the conductor exponent and `𝔣(L/K) = 𝓂[K]^{c(L/K)}` for the conductor ideal. The letter `f` is reserved for the residue degree and is never reused for a conductor | Layer 7 |
| invariant map | `inv_{L/K} : H²(Gal(L/K), Lˣ) ≃ (1/[L:K])ℤ/ℤ` in the unramified case, normalized by Frobenius evaluation: under `H²(Ẑ-quotient, ℤ) ≅ H¹(·, ℚ/ℤ) = Hom(·, ℚ/ℤ)`, the class maps to evaluation at **arithmetic** Frobenius; `inv_K(u_{L/K}) = 1/[L:K]` for the fundamental class | Layer 5 |
| Herbrand quotient | `h(G, M) = #H²(G, M) / #H¹(G, M)` for finite cyclic `G` (equivalently `#Ĥ⁰/#Ĥ¹`); `h(Gal(L/K), Lˣ) = [L:K]`, `h(Gal(L/K), 𝒪[L]ˣ) = 1` | Layer 5; matches `herbrandQuotient` in kbuzzard/ClassFieldTheory |
| tame relation | `σ τ σ⁻¹ = τ^q` with `σ` an **arithmetic** Frobenius lift and `τ` a topological generator of tame inertia `I_t ≅ Ẑ^{(p')}(1)`; the `(1)` records that the `G_K`-action on `I_t ≅ lim_{p∤m} μ_m` is the cyclotomic one, which is the same statement as the relation. The geometric-`σ` presentation (`σ⁻¹ τ σ = τ^q`, used by gq2) is an isomorphic presentation via `σ ↦ σ⁻¹`, provided as a translation lemma | Layer 4 |
| Tate dual | per `n`, only when `char K ∤ n`: for an `n`-torsion finite discrete `G_K`-module `M`, the étale dual is `Hom(M, μ_n)` with the conjugation action. This covers regime 1 and every `n` in regime 2. Compatibility along `μ_n ⊆ μ_{nm}` is a named milestone inside those regimes | Layer 8 |
| class formation interface | finite level: align with kbuzzard/ClassFieldTheory's sorry-free `FiniteClassFormation` (a distinguished class `σ ∈ H²(G, M)` with `H¹`-vanishing on subgroups and an `H²`-generation hypothesis), a design that is settled and proven there; the profinite-level formation `(G_K, K̄^{sep,×})` with compatible invariants is stated NSW-style on top of it | Layer 5/6 |

## What Mathlib already has (consume)

Verified against the pin `9caeba1000` (2026-06-03); "master:" flags material that landed after
the pin, to be consumed on the next toolchain bump rather than rebuilt.

- **The local-field class:** `Mathlib/NumberTheory/LocalField/Basic.lean` with
  `IsNonarchimedeanLocalField`, and the instances `IsTopologicalDivisionRing K`,
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
- **`ℚ_p`:** `Mathlib/NumberTheory/Padics/` with `PadicInt` and its `unitCoeff`, Hensel's lemma
  (`Hensel.lean`), `ProperSpace ℚ_[p]`, `Padic.valuation`/`addValuation`, and
  `Padic.mulValuation : Valuation ℚ_[p] ℤᵐ⁰` together with the instances `ValuativeRel ℚ_[p]`,
  `Valuation.Compatible`, `IsNontrivial`, `IsRankLeOne` (`Padics/ValuativeRel.lean`). ⚠ The pin
  has **no** `IsValuativeTopology ℚ_[p]` and hence no `IsNonarchimedeanLocalField ℚ_[p]`; that
  instance is Layer 0's first milestone (it exists sorry-free in kbuzzard/ClassFieldTheory's
  `IsNonarchimedeanLocalField/Qp.lean`: coordinate, do not copy).
- **Valuation extension:** `Mathlib/RingTheory/Valuation/Extension.lean` (the
  valuation-extension typeclass, equivalence rather than equality by design, with the
  uniformizer-versus-`p` normalization discussion in its docstring),
  `Mathlib/RingTheory/Valuation/AlgebraInstances.lean` and `Minpoly.lean` (de
  Frutos-Fernández–Nuccio), the spectral norm
  (`Mathlib/Analysis/Normed/Unbundled/SpectralNorm.lean`) and **Krasner's lemma**
  (`Mathlib/Analysis/Normed/Field/Krasner.lean`).
- **Dedekind-level ramification:** `Mathlib/NumberTheory/RamificationInertia/` with
  `Ideal.ramificationIdx`, `Ideal.inertiaDeg`, `sum_ramification_inertia`
  (`∑ e_P f_P = [L:K]`, `Basic.lean`), transitivity of the Galois action on `primesOver`
  and the well-defined `ramificationIdxIn`/`inertiaDegIn` (`Galois.lean`), decomposition and
  inertia **fields** as the classes `IsDecompositionField`/`IsInertiaField`
  (`HilbertTheory.lean`), and compatibility with valuations (`Valuation.lean`).
  `Mathlib/RingTheory/Invariant/Basic.lean` has Hilbert's residue-action machinery at ring
  level: `Ideal.inertia G P` (the kernel of the action on `S/P`, defined in
  `RingTheory/Ideal/Defs.lean`) and the isomorphism
  `stabilizer G Q ⧸ inertia G Q ≃* Gal(residue extension)`.
- **Decomposition and inertia for valuation subrings:**
  `Mathlib/RingTheory/Valuation/RamificationGroup.lean` with
  `ValuationSubring.decompositionSubgroup` (a stabilizer), `inertiaSubgroup` (the kernel of the
  residue action), and nothing else; the file's own TODO asks for higher ramification groups.
- **Unramifiedness, algebraic:** `Mathlib/RingTheory/Unramified/` (`Algebra.FormallyUnramified`,
  `Unramified/Field.lean`, `Locus.lean` with `Algebra.IsUnramifiedAt`) and
  `Mathlib/RingTheory/Etale/`. These are the formal and étale notions; the arithmetic notion for
  local fields (`e = 1` plus residue separability) is built in Layer 2 and *compared* to them,
  not duplicated.
- **Galois theory of infinite extensions:** `Mathlib/FieldTheory/KrullTopology.lean`,
  `Mathlib/FieldTheory/Galois/Profinite.lean` (`CompactSpace Gal(K/k)`, `profiniteGalGrp`),
  `Mathlib/FieldTheory/AbsoluteGaloisGroup.lean` (`Field.absoluteGaloisGroup`,
  `absoluteGaloisGroupAbelianization`, the topological abelianization),
  `Mathlib/FieldTheory/SeparableClosure.lean` (`separableClosure`, and
  `separableClosure.algEquivOfAlgEquiv`, the restriction map whose bijectivity Layer 4 proves),
  `Mathlib/FieldTheory/Galois/IsGaloisGroup.lean` (the `IsGaloisGroup` class the Hilbert-theory
  files use), `Mathlib/Topology/Algebra/Category/ProfiniteGrp/` (limits and
  `profiniteCompletion`, the home of `Ẑ`).
- **Discrete group cohomology:** `Mathlib/RepresentationTheory/Homological/GroupCohomology/` with
  `Basic/LowDegree` (explicit `H0/H1/H2`, cocycles, `H1IsoOfIsTrivial`), `Hilbert90.lean`
  (`groupCohomology.H1ofAutOnUnitsUnique`: `H¹(Gal(L/K), Lˣ) = 0` for finite Galois `L/K`, plus
  Noether's cocycle version), `LongExactSequence.lean`, `Shapiro.lean`, `Functoriality.lean`,
  and `FiniteCyclic.lean` (periodicity of `Hⁱ` for a finite cyclic group via the norm/`ρ(g) − 1`
  bicomplex, which is exactly the Herbrand-quotient engine). **master:**
  `RepresentationTheory/Homological/TateCohomology/Basic.lean` (Tate cohomology, upstreamed
  from the CFT project as PR #38553, merged 2026-06-09) and
  `RepresentationTheory/Homological/ContCohomology/` (`Basic/Functoriality/LowDegree`,
  continuous cochain cohomology; R. Hill, A. Yang, E. Xie; redefined in PR #41144, merged
  2026-07-02) landed after the pin. ⚠ The continuous theory's categorical carrier (`TopRep`)
  is under open design debate on Zulip as of 2026-07 (threads "Continuous cohomology" and
  "Understanding ContCohomology and TopRep": whether objects should require joint continuity
  of `G × V → V`, with Brasca proposing the strong condition and Hill defending the weak one
  for resolution-stability). That risk is tracked by PR #1, which this roadmap consumes through;
  the discrete-module, open-stabilizer case used here is stable under every proposal on the
  table. There are no cup products anywhere at the pin (FLT stages them for the continuous
  theory; PR #1 owns them for this program).
- **Cyclotomic and Teichmüller:** `Mathlib/NumberTheory/Cyclotomic/CyclotomicCharacter.lean`
  (`cyclotomicCharacter`, with values in `ℤ_[p]ˣ`), `Mathlib/RingTheory/Teichmuller.lean`
  (`Perfection.teichmuller₀ : Perfection (R ⧸ I) p →*₀ R` for `I`-adically complete `R`, the
  engine for Layer 1's multiplicative section), `Mathlib/FieldTheory/Finite/`
  (finite-field Frobenius, `GaloisField`), `Mathlib/RingTheory/Henselian.lean`
  (`HenselianLocalRing`), `Mathlib/RingTheory/Perfection.lean`.
- **Eisenstein polynomials:** `Mathlib/RingTheory/Polynomial/Eisenstein/` (`IsEisensteinAt`,
  irreducibility, `IsIntegrallyClosed` consequences), the algebraic half of Layer 3's
  totally-ramified correspondence.
- **Trace forms and duality:** `Mathlib/RingTheory/Trace/` and
  `Mathlib/RingTheory/DedekindDomain/Different.lean` (`differentIdeal` for an extension of
  Dedekind domains, via the trace dual), which Layer 3 specializes and computes rather than
  redefines.

### Work under way elsewhere (checked 2026-08-06; coordinate, cite, do not fork)

- **kbuzzard/ClassFieldTheory** (`main` at `ccc3323c6750`, 2026-07-31; active maintainer
  Yunzhou "Edison" Xie). Sorry-free and directly relevant: the `FiniteClassFormation` class with
  the abstract Tate–Nakayama `reciprocityIso` (`Cohomology/SplittingModule.lean`); the
  Herbrand-quotient calculus (`Cohomology/FiniteCyclic/HerbrandQuotient/`); `localInv`
  (`Cohomology/LocalInv.lean`); the valuation short exact sequence
  `0 → 𝒪[L]ˣ → Lˣ → ℤ → 0` (`IsNonarchimedeanLocalField/ValuationExactSequence.lean`); the
  canonical `UnramifiedExtension K n` with its universal property and `maximalUnramified`
  (`IsNonarchimedeanLocalField/Unramified.lean`); the Teichmüller character
  (`LocalCFT/Teichmuller.lean`); `IsNonarchimedeanLocalField ℚ_[p]` (`Qp.lean`). Open at that
  revision, each a single explicit `sorry` or not started: positive-degree vanishing of
  `Hⁱ(Gal(L/K), 𝒪[L]ˣ)` for unramified `L/K` (`UnramifiedCohomology.lean`), the local-unit
  Herbrand quotient `h(𝒪[L]ˣ) = 1` (`IsNonarchimedeanLocalField/HerbrandQuotient.lean`, marked
  "hard work"), the fundamental-class construction, and the Artin map (no files yet). This
  updates the gq2 planning document's §7.2 gap list: all four gaps are still gaps, and the
  abstract machinery above is new since that survey. Owner override to that document's
  §7.1/§21: this roadmap develops local CFT **in Tau Ceti**, not as contributions into
  ClassFieldTheory; the alignment obligations of the Provenance section remain.
- **Akwardbro/RamificationGroup** (Junjie Bai, Jiedong Jiang, Prowler99, Yicheng Tao; last
  commit `c3fd8515a8e3`, 2026-03-01, stalled; built on the dormant mariainesdff stack rather
  than on `IsNonarchimedeanLocalField`): lower-numbering ramification groups,
  `AlgEquiv.lowerIndex`, Herbrand `φ`/`ψ`, upper numbering, aimed at Kronecker–Weber; roughly 27
  of 41 files still carry sorries; no Mathlib PRs have come out of it. Layer 3 is an independent
  development in the pin's vocabulary; cite this repository and Serre LF IV, and coordinate with
  the authors before any code reuse.
- **mariainesdff/LocalClassFieldTheory** (de Frutos-Fernández–Nuccio, arXiv:2310.01998; last
  commit `9ebdafa0b464`, 2025-07-02, dormant): complete-DVR local fields in both
  characteristics, unique valuation extension to finite extensions
  (`DiscreteValuationRing/Extensions.lean`, **not** yet in Mathlib), an empty
  `ClassFormation.lean`, no Lubin–Tate. Their spectral-norm and valuation-algebra layers *did*
  land in Mathlib (see the consume list) and are used here.
- **Mathlib open PRs shaping the substrate** (2026-07): the `ValuativeRel` wave, namely
  #26886/#26885/#26827 (pechersky: `ValuativeRel ℚ_[p]` follow-ups, `ValuativeTopology 𝒪[K]`,
  normed-field helpers), #40309/#36769/#40315 (jjdishere: `Normed → IsValuativeTopology`,
  instances on completions), #30135 (erdOne: `ValuativeRel` on subrings), #27181/#27180
  (ADedecker: `ValueGroupWithZero` refactor), #38009 (CBirkbeck: the valuation spectrum, which
  is PR #80's substrate); the `RamificationInertia` refactor wave, namely
  #41591/#35808/#36843/#35991/#36733/#37031 (xroblot: ring-level decomposition and inertia
  predicates, splitting in the inertia ring, compositum results) and #40955/#40387/#40952
  (tb65536: Galois groups generated by inertia, inertia of quotient groups); and WenrongZou's
  `FormalGroup` series #38213/#36167/#41710 (formal group homomorphisms, the seed of any future
  Lubin–Tate development, which this roadmap's reciprocity deliberately does not depend on, see
  Layer 6, matching Buzzard–Hill's 2025-04 decision to "define the Artin map via the group
  cohomology approach" and not via Lubin–Tate). No open Mathlib PR on higher ramification
  groups, Herbrand quotients, class formations, or reciprocity exists at the audit date.
- **The `erd1/LCFT` interface** (erdOne's mathlib4 branch, file
  `Mathlib/NumberTheory/ClassFieldTheory/Local/Basic.lean`; per Andrew Yang's FLT update of
  2026-07-27 this is the exact statement his four-axiom modularity-lifting artifact assumes as
  its local-CFT axiom, which he "tried (and failed) to get it into mathlib last year"). It is
  `SatisfiesLocalExistenceTheorem K` (open finite-index subgroups of `Kˣ` are exactly the norm
  subgroups) plus `LocalArtinMapData K` (compatible isomorphisms
  `Kˣ ⧸ normSubgroup K L ≃* Gal(L/K)` for finite abelian `L/K`, **arithmetic-Frobenius
  normalization** at uniformizers in unramified extensions via `IsArithFrobAt`, and tower
  compatibility), assembled as `SatisfiesLocalClassFieldTheory K`. Layer 7's finite-level
  interface is aligned with it (same normalization, same norm-subgroup lattice), so that a Tau
  Ceti proof discharges the FLT axiom by direct translation.
- **Zulip decisions in force** (threads listed in the Provenance section): `ValuativeRel` is
  slated to replace `Valued` (deprecation project opened 2026-03-23 by Jiedong Jiang; "there is
  an ongoing refactor to remove `Valued` from Mathlib in favor of `ValuativeRel`", de
  Frutos-Fernández, 2026-04-20), so ⚠ nothing in this roadmap may be stated against `Valued`;
  and the unramified-extension API direction (thread of 2025-10-20: unramifiedness for valued
  fields is bijectivity on value groups plus separability of the residue extension) fixes
  Layer 2's predicate.

## What is missing (build here)

Everything specific to the arithmetic of local fields. The normalized `ℤ`-valued valuation and
`‖·‖_K`. The unit filtration `U(K,i)` with its graded pieces `𝒪[K]ˣ/U(K,1) ≅ 𝓀[K]ˣ` and
`U(K,i)/U(K,i+1) ≅ 𝓀[K]⁺`, the Teichmüller section `𝓀[K]ˣ →* 𝒪[K]ˣ`, the decomposition
`Kˣ ≅ πᶻ × μ_{q−1} × U(K,1)` with `U(K,1)` pro-`p`, and the cardinality of `Kˣ/(Kˣ)ⁿ` in the two
regimes named above. The theory of finite extensions at local-field level: the canonical
valuation on an abstract finite extension, `e` and `f` defined without choosing a uniformizer,
`e · f = [L:K]`, and the local-field instance on `L`. Unramified extensions with the residue
correspondence and Frobenius, one such extension of each degree inside a fixed closure, the
maximal unramified extension with `Gal(K^{ur}/K) ≅ Ẑ`, and norm surjectivity on units. Totally
ramified equals Eisenstein; tame versus wild; the lower-numbering filtration `G_i` with its
subgroup compatibility and the embeddings `G_0/G_1 ↪ 𝓀ˣ`, `G_i/G_{i+1} ↪ 𝓀⁺`; Herbrand `φ/ψ`,
upper numbering, Herbrand's quotient-compatibility theorem, the behavior of the norm on the unit
filtration, and Hasse–Arf. The tame quotient `1 → Ẑ^{(p')}(1) → G_K^{t} → Ẑ → 1` with its
Frobenius splitting and `στσ⁻¹ = τ^q`. On the cohomological side (consuming PR #1): Kummer
theory `Kˣ/(Kˣ)ⁿ ≅ H¹(G_K, μ_n)` for `char K ∤ n`, the Herbrand-quotient computations
`h(Lˣ) = [L:K]` and `h(𝒪[L]ˣ) = 1`, cohomological triviality of unramified units,
`H²(unramified) ≅ (1/n)ℤ/ℤ`, solvability of local Galois groups, the invariant map
`inv_K : Br(K) ≅ ℚ/ℤ`, fundamental classes, the class formation, Tate–Nakayama, finite-level
reciprocity with tower functoriality, the Artin map with its normalizations, norm groups, norm
limitation, the existence theorem, local Tate duality and Euler characteristics in the two
regimes, the mod-2 Hilbert-symbol identification, and the exact rank `d(G_K) = [K:ℚ_p] + 2`. None
of this exists upstream as stated.

---

## The build, in layers

The ordering below is the dependency order. Layers 0–4 are cohomology-free and can start now;
Layers 5–9 consume the PR #1 milestones flagged below. As each layer makes the next layer's types
expressible, its milestones are added to `Suggested.lean` with `sorry`.

### Layer 0: local fields and their finite extensions

- **`ℚ_p` is a local field.** Prove `IsValuativeTopology ℚ_[p]` (the valuation topology is the
  norm topology) and derive `IsNonarchimedeanLocalField ℚ_[p]`, for every prime `p`. ⚠ Instance
  hygiene: `ℚ_[p]` carries a metric `UniformSpace`, and its compatibility with
  `IsTopologicalAddGroup.rightUniformSpace` must be a lemma rather than an accident, or the
  `CompleteSpace` instances will not fire. The same statement is sorry-free in
  kbuzzard/ClassFieldTheory (`Qp.lean`); coordinate as described under Provenance.
- **The normalized valuation.** `v_K^× : Kˣ →* Multiplicative ℤ` (extended separately across
  zero using `ℤᵐ⁰`) via `valueGroupWithZeroIsoInt` and `WithZero.log`, with the Lean-facing
  uniformizer equation `v_K^×(π) = Multiplicative.ofAdd 1`, surjectivity, and `v_K^×(x) = 1`
  exactly on `𝒪[K]ˣ`; decode `v_K(x) := Multiplicative.toAdd (v_K^× x)` when an integer is
  wanted. The absolute value is `‖x‖_K = q^{−v_K(x)}` with `q = Nat.card 𝓀[K]`, valued in `ℚ≥0`,
  and it agrees with the `Padic` norm on `ℚ_[p]`. ⚠ Mathlib's canonical valuation has
  `v(π) = exp(−1)`, so integers are the elements with `v ≤ 1` and the additive normalization
  carries a minus sign; every statement mixing the two cites the one named `−log` translation
  lemma. This milestone also carries the basic point-set API: `𝒪[K]` open and compact, the
  `𝓂[K]^i` a neighborhood basis of `0`, `Kˣ` locally compact with `𝒪[K]ˣ` compact open.
- **Finite extensions, I: construction of the valuation.** For `[Field L] [Algebra K L]
  [Module.Finite K L]` with no valuative structure assumed on `L`, construct a valuation
  `w : Valuation L ℤᵐ⁰` whose restriction along `algebraMap K L` is equivalent to
  `valuation K`, using the spectral norm and `RingTheory/Valuation/Extension.lean`. The output
  type is pinned: a `Valuation L ℤᵐ⁰` together with a `ValuativeRel L` built from it (as a
  definition, not a global instance, so that no diamond is created on fields that already carry
  one), the compatibility `Valuation.Compatible`, `IsValuativeTopology L` for the induced
  topology, and `ValuativeExtension K L`.
- **Finite extensions, II: uniqueness.** Any two valuations on `L` restricting to the valuation
  class of `K` are equivalent (`Valuation.IsEquiv`), and any two `ValuativeRel L` structures
  making `ValuativeExtension K L` hold are equal. Corollary: every `K`-algebra automorphism of
  `L` preserves the valuation, hence acts on `𝒪[L]`, `𝓂[L]`, and `𝓀[L]`. This corollary is what
  Layers 2 and 3 use constantly, so it is stated here rather than rediscovered there.
- **Finite extensions, III: consequences.** With the structure of I and the uniqueness of II:
  `IsNonarchimedeanLocalField L`, completeness of `L`, the instances `Algebra 𝒪[K] 𝒪[L]` and
  `Algebra 𝓀[K] 𝓀[L]`, and finite freeness of `𝒪[L]` over `𝒪[K]`.
- **`e` and `f`, intrinsically.** Define `ramificationIndex K L : ℕ` as the index of the image of
  the normalized value group, that is, the unique positive integer `e` with
  `v_L(algebraMap K L x) = e * v_K(x)` for all `x : Kˣ`; positivity is part of the definition's
  characterization. Define `inertiaDegree K L := Module.finrank 𝓀[K] 𝓀[L]`, available once
  Layer 0.III supplies `Algebra 𝓀[K] 𝓀[L]`. Prove: `v_L(algebraMap K L π_K) = e` for **every**
  uniformizer `π_K` of `K` (so no statement downstream has to choose one); `0 < e`, `0 < f`;
  `e * f = Module.finrank K L`; multiplicativity of each in towers; and the comparison lemmas
  with the Dedekind-level `Ideal.ramificationIdx` and `Ideal.inertiaDeg` of the pin. The
  comparison needs one bridging fact proved once, that `primesOver 𝓂[K] 𝒪[L] = {𝓂[L]}` is a
  singleton at a local field. ⚠ Do not re-derive the Dedekind theory here, and do not force
  every consumer through `Ideal.ramificationIdx`'s `sSup`.

### Layer 1: units, the filtration, and the multiplicative group

- **The unit filtration as an object.** `unitFiltration K i : Subgroup Kˣ` for `i : ℕ`, defined
  with the depth-zero branch explicit: `U(K,0)` is the image of `𝒪[K]ˣ → Kˣ`, and for `i ≥ 1`,
  `U(K,i) = {x : Kˣ | x ∈ 𝒪[K] ∧ v_K(x − 1) ≥ i}`. State membership in both forms that get used,
  the congruence `x ≡ 1 mod 𝓂[K]^i` inside `𝒪[K]` and the valuation inequality on `x − 1`, and
  prove they agree. Then, before any quotient, norm, or cardinality statement consumes the
  object: antitonicity in `i`, `⋂_i U(K,i) = 1`, each `U(K,i)` open and compact in `Kˣ`, and the
  family a neighborhood basis of `1`. Indices are `ℕ` throughout; where a statement compares
  `U(K,i)` with a ramification group `G_j` (Layers 3 and 7), the shift between the two index
  conventions is written out in the statement.
- **Graded pieces.** `U(K,0)/U(K,1) ≃* 𝓀[K]ˣ` by reduction and, for `i ≥ 1`,
  `U(K,i)/U(K,i+1) ≃* 𝓀[K]⁺` via `1 + x ↦ x mod 𝓂^{i+1}` (Serre LF IV §2 Prop. 6), with the
  counts `q − 1` and `q` as corollaries. ⚠ The depth-zero piece is multiplicative and the deeper
  pieces are additive; the two isomorphisms stay separate and do not assemble into one statement.
- **Teichmüller.** The multiplicative section `ω : 𝓀[K]ˣ →* 𝒪[K]ˣ` of the reduction map,
  characterized as the unique section whose image consists of `(q−1)`-torsion elements, together
  with `μ_{q−1}(K) ≅ 𝓀[K]ˣ`. That characterization is the public statement; whether the proof
  goes through `Perfection.teichmuller₀` (a finite field is perfect and `𝒪[K]` is
  `𝓂[K]`-adically complete) or through Hensel applied to `X^{q−1} − 1` is an implementation
  note, not an API decision.
- **Structure of `Kˣ`.** The topological isomorphism `Kˣ ≃ ℤ × 𝒪[K]ˣ` attached to a choice of
  uniformizer, and `𝒪[K]ˣ ≃ μ_{q−1} × U(K,1)`; `U(K,1)` is pro-`p`, being the inverse limit of
  the `p`-groups `U(K,1)/U(K,i)` (the pro-`p` vocabulary is PR #3 Layer 3's); and the torsion
  subgroup `μ(K)` is finite.
- **Deep units in mixed characteristic.** For `K/ℚ_p` finite of degree `N` with absolute
  ramification `e`, and for `i : ℕ` satisfying the integer inequality `(p − 1) * i > e`, the
  logarithm is an isomorphism of topological groups `U(K,i) ≃ (𝓂[K]^i, +)`, and hence
  `U(K,i) ≃ ℤ_p^N` as `ℤ_p`-modules, with `exp` as its inverse. State the threshold as that
  inequality, never as `i > e/(p−1)`, so that no natural-number division enters. This is the
  input NSW (7.4.4) uses and Layer 9 needs.
- **Power classes, the primary statement.** For `n : ℕ` with `n ≠ 0`, the primary theorem is an
  equality of natural numbers,

  ```text
  Nat.card (Kˣ ⧸ (powMonoidHom n).range) = n * Nat.card (μ_n(K)) * q ^ v_K(n),
  ```

  where `μ_n(K)` is the group of `n`-th roots of unity in `K` and `v_K(n) : ℕ` is the normalized
  valuation of the image of `n` in `K`. In regime 1, `IsUnit (n : 𝒪[K])` gives `v_K(n) = 0` as a
  named lemma and the formula collapses to `n · #μ_n(K)`; that case holds in either
  characteristic. In regime 2, `K/ℚ_p` finite, the formula holds for every `n ≠ 0`, including
  `p ∣ n`, with the `p`-primary factor supplied by the deep-unit logarithm above. Finiteness of
  the quotient is a corollary of the formula rather than a separate theorem.
- **Power classes, the absolute-value form.** Only after the `ℕ`-valued theorem, derive
  `#(Kˣ/(Kˣ)ⁿ) = n · #μ_n(K) · ‖n‖_K⁻¹` as an equality in `ℚ≥0`, with the coercion `ℕ → ℚ≥0`
  named in the statement. This is the form that makes the comparison with Layer 8's Euler
  characteristic visible, and it is the only place the absolute value appears in this layer.
- **Dyadic instances.** `#(ℚ_2ˣ/(ℚ_2ˣ)²) = 8` and `U(K, 2e+1) ⊆ (Kˣ)²` in residue
  characteristic `2` are worked instances of the primary statement, not separate theorems.

### Layer 2: unramified extensions and Frobenius

- **The arithmetic predicate.** `IsUnramified K L` for finite extensions of local fields, spelled
  as the 2025-10-20 Zulip consensus for valued fields: the value-group map is bijective
  (equivalently here, `ramificationIndex K L = 1`) and the residue extension `𝓀[L]/𝓀[K]` is
  separable (automatic for finite residue fields, but carried anyway so that the statement
  matches the general definition and survives generalization). Compare it once to the pin's
  `Algebra.IsUnramifiedAt`/`FormallyUnramified` over `𝒪[K]`, as a theorem, so that the étale
  library becomes usable; do not redefine.
- **Residue correspondence.** For `L/K` unramified and Galois, `Gal(L/K) ≃* Gal(𝓀[L]/𝓀[K])`,
  proved through the pin's `RingTheory/Invariant` machinery with the inertia group trivial. The
  **Frobenius element** `Frob L/K ∈ Gal(L/K)` is the preimage of `x ↦ x^q`, and `Gal(L/K)` is
  cyclic of order `f` generated by it.
- **Existence and uniqueness, stated precisely.** Four statements, which together replace the
  usual informal "the unramified extension of degree `f`":
  1. *Inside a fixed algebraic closure*: for every `f ≥ 1` there is exactly one unramified
     intermediate field `K_f` of `AlgebraicClosure K` with `[K_f : K] = f`, namely the splitting
     field of `X^{q^f} − X`, equivalently `K(μ_{q^f−1})`.
  2. *Abstract extensions*: reduction is an equivalence between finite unramified extensions of
     `K` and finite extensions of `𝓀[K]`.
  3. *After fixing residue data*: a chosen `𝓀[K]`-isomorphism of the residue extensions lifts to
     a unique `K`-isomorphism of the unramified extensions. Without that choice the lift is not
     unique.
  4. *Automorphisms*: `Gal(K_f/K)` is cyclic of order `f`, generated by arithmetic Frobenius, so
     `K_f` has exactly `f` automorphisms over `K`, and commuting with Frobenius singles none of
     them out, an abelian group being centralized by its own elements. Statement 3, which fixes
     the map on residue fields, is the correct rigidity.

  Also: a compositum of unramified extensions is unramified, and the finite unramified
  subextensions of `K` inside the fixed closure, ordered by inclusion, form a lattice isomorphic
  to the positive integers ordered by divisibility. (The maximal unramified extension has
  infinite intermediate fields as well, so this is a statement about the finite ones.)
  kbuzzard/ClassFieldTheory's `Unramified.lean` proves this material sorry-free; align statement
  forms with it.
- **The maximal unramified extension.** `K^{ur} ⊆ AlgebraicClosure K` as the union of the `K_f`;
  `Gal(K^{ur}/K) ≅ Ẑ` carrying Frobenius to the canonical topological generator `1`, with
  `Ẑ ≅ lim ℤ/n` built on `ProfiniteGrp`'s completion API. Every unramified coordinate downstream
  is expressed through this isomorphism (⚠ target `Ẑ`, never `ℤ`).
- **Norms.** For `L/K` unramified: `N_{L/K}(𝒪[L]ˣ) = 𝒪[K]ˣ` (Serre LF V §2; by the filtration,
  surjectivity on each graded piece plus completeness) and `N_{L/K}(Lˣ) = π^{fℤ} × 𝒪[K]ˣ`. This
  is the concrete form of "units are universal norms in the unramified direction", used by the
  fundamental-class layer and by Layer 7's orientation statements.

### Layer 3: ramification: totally ramified, tame and wild, and the filtration

- **Totally ramified equals Eisenstein.** `e = [L:K]` if and only if `L = K(π_L)` for `π_L` a
  root of an Eisenstein polynomial over `𝒪[K]`; conversely an Eisenstein polynomial is
  irreducible and generates a totally ramified extension in which its root is a uniformizer
  (consume `RingTheory/Polynomial/Eisenstein/`). Factorization of an arbitrary finite `L/K` as
  `L/L_0/K` with `L_0/K` the maximal unramified subextension and `L/L_0` totally ramified of
  degree `e`.
- **Tame and wild.** `IsTamelyRamified K L` (`p ∤ e`) and totally wildly ramified (`e` a power of
  `p`). The public theorem about tame extensions is:

  ```text
  If L/K is finite, totally ramified, and tamely ramified of degree e,
  then there are a uniformizer π of K and α ∈ L with α^e = π and L = K(α).
  ```

  Its corollaries carry their own hypotheses: `L/K` is Galois exactly when `μ_e ⊆ K`, and then
  `Gal(L/K) ↪ μ_e` by `σ ↦ σ(α)/α`. Enlarging the residue field, taking the statement over
  `K^{ur}` and descending, is one way to prove this and belongs in the proof, not in the public
  statement. ⚠ In residue characteristic `2` every totally ramified quadratic extension is wild;
  keep the dyadic examples in the test suite so that no `p ∤ e` hypothesis creeps into a "tame"
  statement that is later applied at `p = 2`.
- **The lower-numbering filtration.** For `L/K` finite Galois with group `G`, define
  `G_i = {σ | ∀ x : 𝒪[L], v_L(σ x − x) ≥ i + 1}` for `i : ℤ`, a total function with `G_i = ⊤`
  for `i ≤ −1` (equivalently, `σ` acts trivially on `𝒪[L]/𝓂[L]^{i+1}`). Prove: each `G_i` is a
  normal subgroup of `G`, the family is antitone, `G_0` is the inertia group (with one
  comparison lemma each to `ValuationSubring.inertiaSubgroup` and to `Ideal.inertia`), and
  `G_i = 1` for `i` large. Extend to a real index by `G_u := G_{⌈u⌉}` for `u : ℝ`, `u ≥ −1`, and
  prove the two are consistent at integers, since the Herbrand integral below needs `G_t` for
  real `t`. **Compatibility with subgroups**: `H_i = H ∩ G_i` for `H = Gal(L/K')`.
- **Lower numbering is not compatible with quotients.** State this as a theorem with a witness,
  not as a warning: in `L = ℚ_2(ζ_8)` over `K = ℚ_2`, with `G = (ℤ/8)ˣ`, `H = ⟨σ_7⟩` the
  subgroup generated by `ζ ↦ ζ^{-1}` (so `L^H = ℚ_2(√2)`), one has `G_3 = ⟨σ_5⟩` and hence
  `G_3H/H = G/H`, while `(G/H)_3 = 1` because
  `v_{ℚ_2(√2)}(σ(√2) − √2) = v_{ℚ_2(√2)}(2√2) = 3`. Upper numbering exists to repair exactly
  this failure.
- **The quotient embeddings.** `G_0/G_1 ↪ 𝓀[L]ˣ` (hence cyclic of order prime to `p`) and
  `G_i/G_{i+1} ↪ 𝓀[L]⁺` for `i ≥ 1` (hence elementary abelian `p`); consequently `G_1` is the
  unique `p`-Sylow subgroup of `G_0` and is normal, which is wild inertia at finite level, and
  `G_0` has the cyclic tame quotient `G_0/G_1`. The action formula: for `σ ∈ G_0` and
  `τ ∈ G_i/G_{i+1}`, `στσ⁻¹ = θ_0(σ)^i · τ`, where `θ_0 : G_0/G_1 ↪ 𝓀[L]ˣ` is the tame
  character. This is the finite-level form of the `(1)`-twist in Layer 4's tame sequence.
- **Herbrand functions and upper numbering.** `φ_{L/K}(u) = ∫_0^u dt/[G_0 : G_t]` for `u ≥ −1`,
  with the usual convention that the integrand is `[G_t : G_0]` on `[−1, 0]`. Pin the analytic
  facts as milestones: `φ` is continuous, piecewise linear with an explicit finite-sum formula,
  strictly increasing, concave, `φ(0) = 0`, `φ(u) = u` for `−1 ≤ u ≤ 0`; `ψ_{L/K} : ℝ → ℝ` is
  its inverse on `[−1, ∞)`, with `φ ∘ ψ = id` and `ψ ∘ φ = id` there; both send integers to
  rationals and `ψ` sends the jumps of the upper filtration to the jumps of the lower one.
  Upper numbering is `G^u := G_{ψ(u)}` (using the real-index groups above), and the two theorems
  that justify it are **Herbrand's theorem** `(G/H)^u = G^u H/H` (Serre LF IV §3) and
  transitivity `φ_{L/K} = φ_{L'/K} ∘ φ_{L/L'}`. Upper numbering is defined here because Layer 7
  needs it for reciprocity compatibility and the conductor.
- **The norm on the unit filtration.** These are the theorems that Hasse–Arf and Layer 5's
  Herbrand-quotient computation both consume, so they are built once, here, as named results.
  For `L/K` finite Galois:
  1. `N_{L/K}(U(L, ψ_{L/K}(i))) ⊆ U(K, i)` for all `i ≥ 0`, and `N_{L/K}(U(L,i)) ⊆ U(K,i)`.
  2. For `L/K` unramified: `N_{L/K}(U(L,i)) = U(K,i)` for every `i ≥ 0` (this is the graded
     refinement of Layer 2's norm surjectivity).
  3. For `L/K` cyclic totally ramified of prime degree `ℓ` with its single ramification jump at
     `t` (so `G_i = G` for `i ≤ t` and `G_i = 1` for `i > t`), the induced maps on graded pieces,
     in the three cases that occur: for `i > t` the map
     `U(L,ψ(i))/U(L,ψ(i)+1) → U(K,i)/U(K,i+1)` is an isomorphism; for `0 < i < t` (which forces
     `ℓ = p`, since a tame extension has `t = 0`) it is `y ↦ y^ℓ`, the Frobenius of `𝓀`, hence
     injective; at `i = t` it is the Artin–Schreier-type map `y ↦ y^ℓ − c·y` determined by
     `σ(π_L)/π_L`, an `𝔽_ℓ`-linear map whose kernel and cokernel have order `ℓ` (Serre LF V §3).
  4. Consequently `N_{L/K}(U(L,i)) = U(K, φ_{L/K}(i))` for `i` large, and the index
     `[U(K,i) : N_{L/K}(U(L,ψ(i)))]` is computed in each of the three cases above.

  Consumers, so that nothing here is built speculatively: Hasse–Arf uses 1, 3, and 4;
  `h(G, 𝒪[L]ˣ) = 1` in Layer 5 uses 1, 2, and 4; Layer 2's norm surjectivity is 2; Layer 7's
  reciprocity/ramification compatibility uses 1 together with Hasse–Arf.
- **Hasse–Arf.** For `G` abelian the jumps of the upper-numbering filtration are integers (Serre
  LF V §7). Sequenced after the norm computations above, which are its input.
- **The different and the discriminant.** For `L/K` finite separable, the different
  `𝔡_{L/K} ⊆ 𝒪[L]` is defined from the trace form, as the inverse of the trace dual of `𝒪[L]`
  (compare with Mathlib's `differentIdeal` and prove the two agree); the discriminant
  `𝔩_{L/K} = N_{L/K}(𝔡_{L/K}) ⊆ 𝒪[K]` is an ideal of the base, and the two are not to be
  conflated. Then: `𝔡_{L/K} = 𝒪[L]` if and only if `L/K` is unramified; for `L/K` Galois,
  `v_L(𝔡_{L/K}) = ∑_{i≥0} (#G_i − 1)` (Serre LF IV §1 Prop. 4); and in the tame case
  `v_L(𝔡_{L/K}) = e − 1`. The trace-dual definition comes before the valuation formula, which
  needs `L/K` Galois.

### Layer 4: the tame quotient of the absolute Galois group

- **The ambient model, fixed once.** `G_K := Field.absoluteGaloisGroup K` with the Krull
  topology, in every public statement and in every characteristic. Prove once, as a comparison
  theorem, that restriction `Gal(AlgebraicClosure K / K) → Gal(separableClosure K / K)` (that
  is, `separableClosure.algEquivOfAlgEquiv`) is an isomorphism of topological groups; a proof
  that is more convenient over a separable closure may then transport along it. No theorem below
  chooses its own model. All infinite subextensions (`K^{ur}`, `K^{t}`, `K^{ab}`) are
  `IntermediateField K (AlgebraicClosure K)`, and inertia, wild inertia, and the unramified
  quotient are the corresponding closed subgroups and quotients, named as such.
- **Inertia.** `I_K = Gal(K̄/K^{ur})`, closed and normal, the exact sequence
  `1 → I_K → G_K → Ẑ → 1` from Layer 2, and arithmetic Frobenius lifts.
- **Wild inertia.** `P_K = Gal(K̄/K^{t})` where `K^{t} = ⋃_{p ∤ m} K^{ur}(π^{1/m})` is the
  maximal tamely ramified extension. `P_K` is the inverse limit of the finite-level `G_1`, a
  closed normal pro-`p` subgroup of `G_K`, and it is the unique maximal such subgroup of `I_K`,
  that is, its pro-`p` Sylow subgroup. Profinite Sylow theory is PR #3 Layer 2's, consumed here;
  what is proved here is the identification of that Sylow subgroup with `Gal(K̄/K^t)`.
- **The tame character and the twist.** `I_K/P_K ≅ lim_{p∤m} μ_m(K̄) = Ẑ^{(p')}(1)` via
  `σ ↦ (σ(π^{1/m})/π^{1/m})_m`, independence of the choices, and `G_K`-equivariance:
  conjugation acts through the cyclotomic action on the right-hand side. ⚠ `Ẑ^{(p')}(1)` is
  notation *defined* here, as the prime-to-`p` Tate module of `μ`; as a profinite group it is
  `∏_{ℓ ≠ p} ℤ_ℓ`, and the `(1)` is the equivariance statement.
- **The Iwasawa presentation.** The tame quotient `G_K^{t} = G_K/P_K` sits in a split exact
  sequence `1 → Ẑ^{(p')}(1) → G_K^{t} → Ẑ → 1`; a Frobenius lift `σ` and a topological generator
  `τ` of the kernel satisfy `σ τ σ⁻¹ = τ^q`; and `G_K^t` is the profinite group on `σ, τ` with
  that single relation (NSW (7.5.2)/(7.5.3), Iwasawa). State the presentation through its
  universal property, as a continuous surjection from the free profinite group on two generators
  whose kernel is the closed normal closure of the relator, consuming PR #3 Layer 4's free
  profinite groups rather than defining a local copy.
- **Translation lemmas.** The geometric-`σ` presentation (`σ ↦ σ⁻¹`), and the finite-level
  compatibility: restricting the sequence to finite tame quotients recovers Layer 3's
  `G_0/G_1`-twist formula. The reciprocity-facing statements ("units land in inertia, a
  uniformizer goes to the Frobenius coordinate") are Layer 7 theorems, not assumptions here;
  this layer supplies only the group-theoretic frame in which they are stated.

### Layer 5: cohomology of local fields I, the invariant map and the class formation

Everything from here on consumes PR #1 Layers 1–7 for continuous cohomology of `G_K` (the
low-degree explicit theory, restriction/inflation/corestriction, cup products, long exact
sequences, Shapiro, and the colimit description `H^i(G_K, M) = colim H^i(Gal(L/K), M^{G_L})`
over finite Galois `L/K`). Finite-level statements use Mathlib's discrete `groupCohomology`
(and, after the next bump, `TateCohomology`) directly; that part is pin-expressible and can
proceed **in parallel with** PR #1.

- **Hilbert 90, both levels.** The finite level is Mathlib's `H1ofAutOnUnitsUnique`; restate it
  as `H¹(Gal(L/K), Lˣ) = 0` in the chosen cohomology API, and derive
  `H¹(G_K, K̄^{sep,×}) = 0` by the colimit description.
- **Kummer theory.** For `n` with `char K ∤ n`, and with `μ_n ⊆ K` when a trivialized twist is
  wanted (otherwise keep the `μ_n`-twist): `Kˣ/(Kˣ)ⁿ ≅ H¹(G_K, μ_n)` via the Kummer cocycle
  `a ↦ (σ ↦ σ(a^{1/n})/a^{1/n})`, from the `n`-th power sequence and Hilbert 90, consuming PR #1
  Layer 9. With Layer 1's cardinality formula for the appropriate regime this computes
  `#H¹(G_K, μ_n)`.
- **The Herbrand quotient.** `h(G, M) = #H²/#H¹` for finite cyclic `G`, defined on top of
  Mathlib's `FiniteCyclic` periodicity (and restated against `TateCohomology` after the bump):
  multiplicativity in short exact sequences, `h = 1` on finite modules, and the two computations
  `h(Gal(L/K), Lˣ) = [L:K]` and `h(Gal(L/K), 𝒪[L]ˣ) = 1` for cyclic `L/K`, the second from
  Layer 3's norm-on-filtration theorems together with a cohomologically trivial open submodule
  (the `lem:serre_approx` argument of the ClassFieldTheory blueprint; both are open sorries
  there at the audit date, so this is live coordination territory rather than duplication of
  finished work).
- **Unramified cohomology.** For `L/K` unramified, so cyclic and generated by Frobenius:
  `Hⁱ(Gal(L/K), 𝒪[L]ˣ) = 0` for `i ≥ 1` (filtration, finite-field vanishing, completeness),
  hence `H²(Gal(L/K), Lˣ) ≅ H²(Gal(L/K), ℤ) ≅ ℤ/[L:K]` through the valuation sequence
  `0 → 𝒪[L]ˣ → Lˣ → ℤ → 0`; the **unramified invariant map** normalized as in the convention
  table, compatible with inflation up the unramified tower, giving
  `H²(Gal(K^{ur}/K), (K^{ur})ˣ) ≅ ℚ/ℤ`.
- **Local Galois groups are solvable.** For `L/K` finite Galois with group `G`, the chain
  `G ⊇ G_0 ⊇ G_1 ⊇ 1` of Layer 3 has cyclic quotient `G/G_0` (a finite residue extension),
  cyclic quotient `G_0/G_1`, and `p`-group `G_1`; hence `G` is solvable. State it as a theorem
  here, since the next milestone's induction needs it.
- **Induction from cyclic to arbitrary finite Galois.** For `N ⊴ G` with `G/N` cyclic and
  `L^N = K'`, inflation–restriction with `H¹(N, Lˣ) = 0` (Hilbert 90) gives the exact sequence
  `0 → H²(Gal(K'/K), K'ˣ) → H²(G, Lˣ) → H²(N, Lˣ)`, hence
  `#H²(G, Lˣ) ≤ #H²(Gal(K'/K), K'ˣ) · #H²(N, Lˣ)`. Combined with solvability and the cyclic
  computation `#H²(Gal(L/K), Lˣ) ≤ [L:K]` in the cyclic case, this gives
  `#H²(Gal(L/K), Lˣ) ≤ [L:K]` for **every** finite Galois `L/K`.
- **`Br(K)` is unramified.** Every class in `H²(G_K, K̄ˣ)` is inflated from the unramified tower,
  so `H²(G_K, K̄ˣ) ≅ ℚ/ℤ`: the **invariant map** `inv_K`. The proof combines the upper bound of
  the previous milestone with the unramified lower bound. Functoriality:
  `inv_{K'} ∘ res = [K':K] · inv_K`, and `inv ∘ cores = inv`.
- **Fundamental classes and the class formation.** `u_{L/K} ∈ H²(Gal(L/K), Lˣ)` is the class
  with `inv = 1/[L:K]`; the pair (`H¹ = 0`, `H²` cyclic of the right order with compatible
  invariants) is the **class-formation structure** on `(G_K, K̄ˣ)`. At a single finite level
  adopt the form of ClassFieldTheory's `FiniteClassFormation`; the profinite-level formation
  (all layers at once, invariants in `ℚ/ℤ`, NSW II §1 style) is stated on top of the finite-level
  instances. Record for each later theorem which of the two it consumes.

⚠ Nothing in this layer may be proved using reciprocity (Layer 6), the existence theorem, or
local duality (Layer 8). The dependency runs solvability → induction → invariant map →
fundamental class → class formation → Tate–Nakayama → reciprocity, in that order, and a proof
that shortcuts it would be circular.

### Layer 6: Tate–Nakayama and finite-level reciprocity

The abstract theorem in this layer is about finite groups, not about local fields. **PR #1 owns**
the cohomology objects themselves: comparison maps, exact sequences, restriction and
corestriction, Shapiro, and cup products. **This roadmap owns** the generic finite class
formation and Tate–Nakayama, because local reciprocity is what needs them, and their home is
`TauCeti/RepresentationTheory/Homological/GroupCohomology/ClassFormation/`, reusable by anything
else with a class formation. `TauCeti/NumberTheory/LocalField/` then constructs the local
fundamental class, instantiates the generic structure, and specializes.

- **Tate–Nakayama, in the pinned generality.** For a finite group `G` and a distinguished class
  `σ ∈ H²(G, M)` satisfying the class-formation hypotheses, cup product with `σ` induces
  isomorphisms `Ĥ^r(H, ℤ) ≅ Ĥ^{r+2}(H, M)` for every subgroup `H ≤ G` and every `r`. Formalize
  the all-degrees statement, following the splitting-module argument of Artin–Tate (the same
  route that is already sorry-free in ClassFieldTheory's `SplittingModule.lean`), and consume it
  here only at `r = −2`: `G^{ab} = Ĥ^{−2}(G, ℤ) ≅ Ĥ⁰(G, M) = M^G/N_G M`. The all-degrees form is
  the one Layer 8 and PR #3 cite.
- **Finite-level reciprocity.** For every finite Galois `L/K`, the **norm-residue isomorphism**
  `θ_{L/K} : Kˣ/N_{L/K}Lˣ ≅ Gal(L/K)^{ab}`, obtained from Tate–Nakayama at `u_{L/K}`, in the
  direction and normalization of the convention table. For `L/K` unramified, `θ(π) = Frob`;
  prove that as its own lemma, since it is the compatibility between `inv(u) = 1/n` and the
  Frobenius normalization, and it is where a sign error would hide.
- **Functoriality.** In a tower `M/L/K` the projection `Kˣ/N_M Mˣ → Kˣ/N_L Lˣ` matches
  `Gal(M/K)^{ab} → Gal(L/K)^{ab}`. For a base change `K'/K`, the inclusion `Kˣ ⊆ K'ˣ` matches
  the transfer (Verlagerung) `Gal(·/K)^{ab} → Gal(·/K')^{ab}`, and the norm `N_{K'/K}` matches
  the natural map on abelianizations. Compatibility with restriction, corestriction, and
  inflation throughout. These are exactly the compatibilities the limit in Layer 7 needs, and
  the transfer statement is also what norm limitation uses, so all of them are stated at finite
  level here.

### Layer 7: the Artin map, norm groups, and the existence theorem

The order of this layer matters. The inverse limit of the finite-level isomorphisms identifies
`G_K^{ab}` with the completion of `Kˣ` for the topology defined by norm subgroups; identifying
that topology with the topology of *all* open finite-index subgroups is the existence theorem.
Stating the second identification first would make the layer circular, so the milestones are
sequenced as follows.

1. **Norm groups and the normic topology.** `NormGroup L/K := (N_{L/K})(Lˣ) : Subgroup Kˣ` for
   `L/K` finite abelian; each is open of finite index with `[Kˣ : NormGroup L/K] = [L:K]`
   (Layer 6). The norm subgroups are a filtered family: `NormGroup` of a compositum is the
   intersection, and containment reverses. Define the **normic completion** `(Kˣ)^{norm}` as
   `lim_L Kˣ/NormGroup L/K` over finite abelian `L/K`.
2. **The limit isomorphism.** The `θ_{L/K}` are compatible in towers (Layer 6), so their limit
   is an isomorphism of topological groups `(Kˣ)^{norm} ≅ G_K^{ab}`, where the target is
   Mathlib's `absoluteGaloisGroupAbelianization`.
3. **The Artin map and its normalizations.** `Art_K : Kˣ →* G_K^{ab}` is the composite of
   `Kˣ → (Kˣ)^{norm}` with the isomorphism of step 2: continuous, with dense image, and with
   kernel the intersection of all norm groups. ⚠ `Kˣ` is not compact and `Art_K` is not
   surjective; `Nat.card`-style statements about `G_K^{ab}` are wrong for that reason. Its
   normalizations are theorems, not definitions:
   - `ν_K ∘ Art_K = ι ∘ v_K`, the unramified coordinate, valued in `Ẑ` with `ι : ℤ → Ẑ`;
   - `Art_K(𝒪[K]ˣ)` is the inertia subgroup of `G_K^{ab}`, and `𝒪[K]ˣ ≅ I(G_K^{ab})` (using
     Layer 2's norm computation);
   - the **cyclotomic orientation** in mixed characteristic: for `K/ℚ_p` finite and
     `u ∈ 𝒪[K]ˣ`,

     ```text
     χ_cyc(Art_K(u)) = N_{K/ℚ_p}(u)⁻¹  in ℤ_pˣ.
     ```

     Both sides lie in `ℤ_pˣ`; the field norm is not optional decoration, and without it the
     equation is ill-typed for `K ≠ ℚ_p`. The proof is the functoriality square of Layer 6
     (reciprocity for `K` followed by restriction to `G_{ℚ_p}^{ab}` corresponds to
     `N_{K/ℚ_p}` on multiplicative groups) applied to the case `K = ℚ_p`, which is Serre LF
     XIV §7's computation on `ℚ_p(μ_{p^∞})` and gives the corollary
     `χ_cyc(Art_{ℚ_p}(u)) = u⁻¹` for `u ∈ ℤ_pˣ`. An `𝒪[K]ˣ`-valued character with value `u⁻¹`
     would be a Lubin–Tate character, which this roadmap does not build.
   - the geometric translation lemmas `Art^{geo} = Art ∘ inv` and `ν^{geo} = −ν`.
4. **Norm limitation.** For `L/K` finite but not necessarily Galois, fix `L ⊆ K^{sep}` and put
   `F := L ∩ K^{ab}`. Then `N_{L/K}(Lˣ) = N_{F/K}(Fˣ)`. Equivalently and more usably in Lean:
   choose a finite Galois `M ⊇ L` over `K`, put `G = Gal(M/K)` and `H = Gal(M/L)`, and let `F`
   be the fixed field of `H · [G,G]`; prove that this `F` is `L ∩ K^{ab}` and that the norm
   groups agree. The proof uses Layer 6's corestriction/transfer compatibility and the finite
   index equality, and it does **not** use the existence theorem, which is why it appears here.
5. **The existence theorem.** A subgroup of `Kˣ` is a norm group of a finite abelian extension
   if and only if it is open of finite index. One direction is step 1. The other is the
   following chain, each item a milestone:
   1. *Upward closure.* If `H ≤ Kˣ` contains `NormGroup L/K` for some finite abelian `L/K`,
      then `H` is itself a norm group, namely of the subfield of `L` fixed by
      `θ_{L/K}(H/NormGroup L/K)`. Uses finite reciprocity only.
   2. *Reduction to power subgroups.* An open subgroup `H` of finite index contains `(Kˣ)^n`
      for `n` the exponent of `Kˣ/H`. So it suffices to produce a finite abelian `L/K` with
      `NormGroup L/K ⊆ (Kˣ)^n`.
   3. *Cyclotomic base change and Kummer.* `K' := K(μ_n)` is finite abelian over `K`. Over `K'`,
      Layer 1 makes `K'ˣ/(K'ˣ)^n` finite, so `L' := K'((K'ˣ)^{1/n})` is a finite abelian
      extension of `K'` with `Gal(L'/K') ≅ Hom(K'ˣ/(K'ˣ)^n, μ_n)`, and finite-level reciprocity
      over `K'` identifies `NormGroup L'/K' = (K'ˣ)^n`. This is where Kummer theory is used, with
      its true hypothesis `μ_n ⊆ K'`.
   4. *Descent of the norm.* Transitivity of norms and `N_{K'/K}((K'ˣ)^n) ⊆ (Kˣ)^n` give
      `N_{L'/K}(L'ˣ) ⊆ (Kˣ)^n`.
   5. *Back to an abelian extension.* `L'/K` need not be abelian, so apply norm limitation
      (step 4): with `F = L' ∩ K^{ab}`, `NormGroup F/K = N_{L'/K}(L'ˣ) ⊆ (Kˣ)^n ⊆ H`.
   6. *Conclusion.* By item 1, `H` is a norm group, and by Layer 6 its index equals the degree
      of the corresponding extension, so the correspondence `L ↦ NormGroup L/K` is an
      inclusion-reversing bijection between finite abelian extensions of `K` and open
      finite-index subgroups of `Kˣ`, with `NormGroup` of a compositum the intersection and of
      an intersection the compositum's norm group.

   No milestone in this chain uses Layer 8; the sequencing is deliberate, and the roadmap does
   not admit a proof that reverses it. This route also avoids formal groups: if Mathlib's
   `FormalGroup` series grows a Lubin–Tate theory, the note in Provenance applies.
6. **Consequences of existence.** The intersection of all norm groups is trivial, so `Art_K` is
   injective; the normic topology on `Kˣ` is the topology of all open finite-index subgroups;
   and only now, `Art_K` extends to an isomorphism `(Kˣ)^∧ ≅ G_K^{ab}` from the profinite
   completion of `Kˣ` in the ordinary sense. `Kˣ/N_{L/K}Lˣ` is finite for every finite `L/K`,
   abelian or not, with order `[L ∩ K^{ab} : K]` by step 4.
7. **Ramification compatibility and the conductor.** `U(K,n)` is compact, so its continuous
   image is closed, and the correct statement is an equality rather than a density statement. At
   finite level, for `L/K` finite abelian,
   `θ_{L/K}(U(K,n)·N_{L/K}Lˣ / N_{L/K}Lˣ) = Gal(L/K)^{(n)}`, the upper-numbering ramification
   subgroup (Neukirch ANT V (6.2)); at infinite level, `Art_K(U(K,n)) = (G_K^{ab})^{(n)}`, where
   the upper-numbering filtration on `G_K^{ab}` is defined as the limit of the finite-level ones,
   which is well defined by Herbrand's theorem. Both need Layer 3's Hasse–Arf. Then define

   ```text
   c(L/K) := sInf { n : ℕ | U(K,n) ≤ NormGroup L/K }      (the conductor exponent)
   𝔣(L/K) := 𝓂[K] ^ c(L/K)                                (the conductor ideal)
   ```

   and prove: `c(L/K) = 0` if and only if `L/K` is unramified (the depth-zero case, stated
   separately because `U(K,0) = 𝒪[K]ˣ`); the set above is nonempty, so the infimum is attained;
   and for `c(L/K) = n > 0`, minimality reads `U(K,n) ≤ NormGroup L/K` and
   `U(K, n−1) ≰ NormGroup L/K`, a statement whose `n − 1` is meaningful exactly because `n > 0`.
   The letter `f` keeps its Layer-0 meaning throughout.
8. **The FLT-facing interface.** Assemble the finite-abelian-level isomorphisms, the
   arithmetic-Frobenius normalization, the tower compatibility, and the existence theorem in the
   form of the `erd1/LCFT` interface (`LocalArtinMapData` plus `SatisfiesLocalExistenceTheorem`,
   described above under work under way elsewhere), and prove the translation as a milestone.
   That interface is what a confirmed downstream consumer (FLT's modularity-lifting artifact)
   axiomatizes at the snapshot date.

### Layer 8: local Tate duality and the Euler characteristic

The sequence within the layer is: invariant map on finite coefficients, then duality, then the
Euler characteristic. Every milestone is labelled by regime, and no unqualified "all finite
modules over every local field" theorem appears.

#### 8A. Prime to the residue characteristic (both characteristics)

- **`H²(G_K, μ_n) ≅ ℤ/n`,** assuming `IsUnit (n : 𝒪[K])`. Derive it from `inv_K` and the Kummer
  sequence on `K̄ˣ` (`Br(K)[n]`), compute the finite groups `H^i(G_K, μ_n)` for `i = 0, 1, 2`,
  and prove vanishing above degree `2`. In PR #1 Layer 8's vocabulary this records
  `cd_ℓ(G_K) = 2` for primes `ℓ ≠ p`.
- **Duality.** For a finite discrete `G_K`-module `M` killed by such an `n`, put
  `M' = Hom(M, μ_n)` with the conjugation action. The cup pairing
  `H^i(G_K, M') × H^{2−i}(G_K, M) → H²(G_K, μ_n) ≅ ℤ/n` is a perfect pairing of finite groups
  for `i = 0, 1, 2`. Compatibility along `μ_n ⊆ μ_{nm}` stays inside this regime.
- **Unramified subgroups and their annihilators.** Define `H¹_{ur}(K, M)` as the kernel of
  restriction `H¹(G_K, M) → H¹(I_K, M)`, and prove it equals the image of inflation from
  `H¹(G_K/I_K, M^{I_K})`, so that the two usual descriptions are interchangeable. For `M`
  unramified (that is, `I_K` acts trivially) and `#M` prime to the residue characteristic,
  `H¹_{ur}(K, M)` and `H¹_{ur}(K, M')` are exact annihilators of each other under the pairing
  above, and each has order `#H⁰(G_K, M)`. State the degrees, the coefficient dual, and the
  value group explicitly in the statement rather than in prose (Milne ADT I.2.6, NSW (7.2.15)).
- **Euler characteristic.** For finite `M` of order prime to `p`,
  `#H⁰(G_K,M) · #H²(G_K,M) / #H¹(G_K,M) = 1`, which is the specialization of `‖#M‖_K` because
  `#M` is a unit in `𝒪[K]`.

#### 8B. Mixed-characteristic `p`-primary theory

- Assume `K/ℚ_p` finite. For every finite discrete `G_K`-module `M`, including `p`-primary ones,
  choose an exponent `n`; since `char K = 0` the étale dual `M' = Hom(M, μ_n)` is available.
  Prove the same perfect pairings, the same finiteness, and compatibility across exponents.
  Record `cd_p(G_K) = 2` as its own statement rather than folding it into an unqualified
  `cd(G_K) = 2`.
- **Euler characteristic.** For every finite `M`,
  `#H⁰(G_K,M) · #H²(G_K,M) / #H¹(G_K,M) = ‖#M‖_K`, in the normalized absolute value of Layer 0
  and as an equality in `ℚ≥0`. State that form first, then derive the `𝔽_p`-module corollary
  `dim H¹ = dim H⁰ + dim H² + [K:ℚ_p] · dim M`. This is the statement PR #3 Layer 11 and the
  dyadic examples consume.

#### 8C. The mod-2 Hilbert symbol

This is a deliverable of this roadmap, and the one statement at which this roadmap and PR #4
must agree.

- At `n = 2` with `char K ≠ 2`, Kummer theory identifies `Kˣ/(Kˣ)² ≅ H¹(G_K, μ_2)` on both
  factors of the 8A pairing, and the pairing
  `H¹(G_K, μ_2) × H¹(G_K, μ_2) → H²(G_K, μ_2) ≅ ℤ/2` **is the classical Hilbert symbol**. State
  it as one named theorem (suggested name `hilbertSymbol_eq_tateDuality_pairing`), with all four
  ingredients written into the statement: the Kummer identification used on each factor, the
  order of the two arguments of the cup product, the invariant isomorphism
  `H²(G_K, μ_2) → ZMod 2`, and the conversion between `ZMod 2` and the classical `{±1} ⊆ ℤˣ`.
- The value conversion is not restated here: PR #4 Layer 2 defines the symbol with values in
  `{±1}` and fixes the dictionary between `{±1}`, `ZMod 2`, and `μ₂` in one place, and PR #4
  Layer 7 is the cohomological side. Cite those milestones; do not switch codomains silently
  inside a displayed formula.
- PR #4 Layer 2 also pins the orientation of the norm criterion as `(a,b) = 1 ↔ a ∈ N(K(√b)ˣ)`,
  together with the symmetry lemma that makes the other orientation available; this roadmap uses
  `(a,b)_K = 1 ↔ b ∈ N(K(√a)ˣ)` through that lemma. Nondegeneracy of the symbol is then a
  corollary of duality here rather than an independent computation there (FV IV §5,
  O'Meara 63:13).

### Layer 9: topological finite generation of `G_K`

For `K/ℚ_p` finite of degree `N`. Sequenced after Layers 7 and 8, and after PR #3 Layer 11, which
computes the rank of the maximal pro-`p` quotient `G_K(p)` from the duality statements of Layer 8.
The order `LocalFields 0–8 → PR #3 Layer 11 → LocalFields 9` is acyclic. No unqualified
`scd(G_K) = 2` milestone is used: strict cohomological dimension conventions vary, and that
slogan is not the statement the argument needs.

- **`H¹`-dimension counts.** `dim_{𝔽_ℓ} H¹(G_K, 𝔽_ℓ)` for every prime `ℓ`: it is
  `N + 1 + dim H⁰(μ_p)` at `ℓ = p` and at most `2` at `ℓ ≠ p` (Kummer, Layer 1's cardinality
  formula, and duality). ⚠ The naive criterion "all `H¹(G, 𝔽_ℓ)` finite implies `G`
  topologically finitely generated" is **false** for profinite groups: `∏_ℕ A₅` has
  `H¹(−, 𝔽_ℓ) = 0` for every `ℓ`, each factor being perfect, yet is not topologically finitely
  generated since `d(A₅^m) → ∞`. The argument below is why the theorem is true regardless, and
  this is why route (c) of the gq2 planning document §13.1 (bounded-degree extension finiteness
  plus a generic criterion) was rejected: no such generic criterion exists at this generality.
- **The tame frame.** `G_K^{t}` is topologically 2-generated (Layer 4) and `P_K` is pro-`p`
  (Layer 4), so by the pro-`p` Frattini generation criterion of PR #3 Layer 3 (a subset generates
  a pro-`p` group if and only if it generates its Frattini quotient, together with the relative
  form for a closed normal pro-`p` subgroup), finite generation of `G_K` reduces to finite
  generation of the `ℤ_p[[G_K^t]]`-coinvariants of `P_K^{ab}(p)`.
- **The multiplicative-group module.** The reciprocity-side input (NSW VII §4): the
  `ℤ_p`-completion `A(L) = lim Lˣ/(Lˣ)^{p^m} ≅ G_L^{ab}(p)` (Layer 7); the `ℚ_p[G]`-module
  structure `A(L) ⊗ ℚ ≅ ℚ_p[G]^N ⊕ ℚ_p` for `L/K` Galois with group `G` (the deep-unit logarithm
  of Layer 1 plus the normal basis theorem); and cohomological triviality of `U(L,1)/p`-type
  modules in tame extensions (NSW (7.4.3)).
- **The exact rank.** The theorem is an equality:

  ```text
  d(G_K) = N + 2   for every finite extension K/ℚ_p of degree N,
  ```

  where `d` is the topological rank of PR #3 Layer 3. Upper bound: the relation-module
  bookkeeping of NSW VII §4 ((7.4.1)), using the free presentation of the tame quotient, the
  degree-`2` vanishing and comparison statements of Layer 8, and lifting along the Frattini
  reduction. Lower bound, in two cases, both consuming PR #3 Layer 11's computation of
  `d(G_K(p))`:
  - if `μ_p ⊆ K`, then `d(G_K) ≥ d(G_K(p)) = N + 2` by monotonicity of `d` under continuous
    surjections (PR #3 Layer 3);
  - if `μ_p ⊄ K`, put `L = K(μ_p)` and `m = [L:K]`, which divides `p − 1`. Then `μ_p ⊆ L`, so
    `d(G_L) ≥ d(G_L(p)) = mN + 2`, while the Schreier bound of PR #3 Layer 3 gives
    `d(G_L) ≤ 1 + m(d(G_K) − 1)`. Hence `m · d(G_K) ≥ m(N + 1) + 1`, and since `d(G_K)` is an
    integer, `d(G_K) ≥ N + 2`.

  The exact equality for the full group is Jarden–Shusterman Theorem 2.1. Do not replace the
  upper-bound input by a convention-dependent `scd` slogan.
- **What belongs to the pro-`p` quotient.** The statement "if `μ_p ⊄ K` then `N + 1` generators
  suffice" is about `G_K(p)`, not about `G_K`:
  `μ_p ⊄ K ⟹ d(G_K(p)) = N + 1` (Shafarevich: `G_K(p)` is free pro-`p` of that rank), and
  `μ_p ⊆ K ⟹ d(G_K(p)) = N + 2` (Demushkin). Both are PR #3 Layer 11's theorems, consumed here
  for the lower bound and stated nowhere here as facts about `G_K`.

## Worked examples (acceptance criteria)

Discharge these alongside the layers; each catches a specific class of error, such as a vacuous
instance, a sign flip, a wrong normalization, or a dropped dyadic case.

- **`ℚ_p` and `𝔽_q((t))` are local fields; `ℚ` and `ℂ` are not** (Layer 0). Non-vacuity, plus
  the negative instances: `ℚ` with any `p`-adic valuation class is incomplete, hence not locally
  compact, and for `ℂ` no valuation class and compatible topology qualify at all, a
  nonarchimedean local field never being algebraically closed.
- **`v_2`, `‖·‖`, `q` on `ℚ_2`** (Layer 0): `v_2^×(2) = Multiplicative.ofAdd 1` (equivalently
  `v_2(2) = 1`), `‖2‖ = 1/2`, `q = 2`; and on `K = ℚ_2(√2)`: `e = 2`, `f = 1`,
  `v_K^×(2) = Multiplicative.ofAdd 2`.
- **`ℚ_2ˣ/(ℚ_2ˣ)²` has order 8** (Layer 1), with the classes of `−1, 2, 5` as a basis
  (`5 ≡ −3 mod (ℚ_2ˣ)²`), while `ℚ_pˣ/(ℚ_pˣ)²` has order 4 for odd `p`. The sharp deep-square
  bound is `1 + 8ℤ_2 ⊆ (ℤ_2ˣ)²`, that is `U(2e+1) = U(3)` at `K = ℚ_2`.
- **The Teichmüller subgroup of `ℚ_2` is trivial** (Layer 1): `μ_{q−1}(ℚ_2) = {1}`, degenerate on
  purpose, while the full torsion subgroup is `μ(ℚ_2) = {±1}`, living in `U(1) \ U(2)`. On `ℚ_5`,
  `μ_4 ⊆ ℤ_5ˣ` instead.
- **The unramified quadratic extension of `ℚ_2` is `ℚ_2(√5) = ℚ_2(μ_3)`** (Layer 2): `f = 2` and
  Frobenius squares on `μ_3`; **every unit of `ℤ_2ˣ` is a norm**, `∀ u : ℤ_2ˣ, ∃ x y,
  u = x² − 5y²`; and `N(ℚ_2(√5)ˣ) = ⟨4⟩ × ℤ_2ˣ`, of index 2, missing `2` itself.
- **Ramification filtration of `ℚ_2(μ_8)/ℚ_2`** (Layer 3): the group is `(ℤ/8)ˣ ≅ (ℤ/2)²`, with
  `G_0 = G_1 = G`, `G_2 = G_3 = ⟨σ_5⟩` (the `ζ ↦ ζ⁵` direction), `G_4 = 1`, computed from Serre
  LF IV §4's cyclotomic recipe `i_G(σ_a) = v_L(ζ^a − ζ)`. The Herbrand transform puts the
  upper-numbering jumps at `1` and `2` (`φ(1) = 1`, `φ(3) = 2`), integers as Hasse–Arf demands.
  This example also carries the failure of lower-numbering quotient compatibility recorded in
  Layer 3. A tame contrast: `ℚ_3(3^{1/2})/ℚ_3` has `G_0 = ℤ/2`, `G_1 = 1`.
- **The tame relation over `ℚ_3`** (Layer 4): in `G_{ℚ_3}^{t}`, `στσ⁻¹ = τ³` for the arithmetic
  Frobenius lift; at finite level, in `Gal(ℚ_3(μ_8, 3^{1/8})/ℚ_3)`, the conjugation formula is
  checkable by hand from the `σ`-action on the `μ_8`-indexed roots of `3`.
- **Hilbert symbols on `ℚ_2`** (Layers 7–8): `(−1,−1)_2 = −1` (equivalently, `−1` is not a sum of
  two squares in `ℚ_2`), `(2,5)_2 = −1`, `(2,−1)_2 = +1`, `(5,5)_2 = +1`, the table that seeds
  gq2's initial form `α² + βγ + γβ`.
- **`Art_{ℚ_2}` on `−1, 2, 5`** (Layer 7): `ν(Art(2)) = 1`, `ν(Art(−1)) = ν(Art(5)) = 0`;
  `χ_cyc(Art(−1)) = −1`, `χ_cyc(Art(5)) = 5⁻¹`, `χ_cyc(Art(2)) = 1`, all instances of the
  cyclotomic orientation with `K = ℚ_p` and `N_{K/ℚ_p}` the identity. In gq2's geometric `ν_ur`
  these read `−1, 0, 0`, the translation lemma in action, matching its eq. (13) row
  `ν_ur(ā, s̄, ȳ) = (−2, 1, 0)` after its dictionary `ā = rec(−4)`, `s̄ = rec(2)⁻¹`,
  `ȳ = rec(−3)`.
- **Euler characteristic of `μ_2` over `ℚ_2`** (Layer 8): `#H⁰ = 2` and `#H² = 2`, so the formula
  forces `#H¹(G_{ℚ_2}, μ_2) = 8`, consistent with Kummer plus the order-8 square-class group.
  This single example crosses Layers 1, 5, and 8, and it is the one that catches a wrong
  normalization of `‖#M‖_K`.
- **Duality at `n = 2` over `ℚ_2`** (Layer 8): the matrix of the Hilbert symbol on the basis
  `{−1, 2, 5}` is nondegenerate mod 2, the identification of 8C instantiated.

## Ordering and parallelism

Layers 0–2 are sequential and first. Layer 3 (the ramification filtration) and Layer 4 (the tame
quotient) both depend on Layers 0–2 but not on each other's later milestones: Layer 4 needs only
the tame/wild vocabulary from the start of Layer 3, not Herbrand or Hasse–Arf. Layer 5's
finite-level part (Herbrand quotient, unramified cohomology, solvability, fundamental classes)
needs Layers 2–3 and Mathlib's discrete group cohomology only, so it can run before or in
parallel with PR #1; Layer 5's continuous assembly waits on PR #1 Layers 1–4, its functoriality
on PR #1 Layers 5–7, and its Kummer theorem on PR #1 Layer 9. Layer 6 follows Layer 5; Layer 7
follows Layer 6, and its ramification-compatibility milestone also needs Layer 3's Hasse–Arf;
Layer 8 needs Layers 5 and 7. PR #3 Layer 3 is an early supplier to Layers 1, 4, and 9, and can
be built at any time. PR #3 Layer 11 consumes Layers 5, 7, and 8 and supplies Layer 9, which is
therefore last. PR #4 Layers 6–7 consume only 8C. The worked examples are required in their
assigned layers.

Until the sibling branches merge, the PR links above are canonical; relative links must not be
assumed to resolve on this branch.

## Downstream consumers in gq2

The late layers are the intrinsic form of several acceptance targets in
`GQ2/Foundations/Axioms.lean` (`github.com/roed-math/gq2-lean`). Those labels are collected here
so that the layers above can be read without them.

| gq2 label | statement here |
|---|---|
| B1 | topological finite generation of `G_K` (Layer 9); at `K = ℚ_2`, generation by 3 elements |
| B5 | the Artin map with its normalizations, including the cyclotomic orientation (Layer 7, step 3) |
| B6, B7 | local Tate duality and the Euler characteristic in the mixed-characteristic regime (Layer 8B) |
| B10 | the tame quotient with `στσ⁻¹ = τ^q` (Layer 4) together with the orientation statements of Layer 7 |
| B11a (pairing part) | the mod-2 identification of the duality pairing with the Hilbert symbol (Layer 8C) |

This roadmap specifies the mathematics, not that code; see Provenance for what may and may not be
carried over from it.

## References

- J.-P. Serre, *Local Fields*, GTM 67 (1979), the primary source: Ch. I §§1–8 (discrete valuation
  rings, Frobenius substitution), Ch. III §5 (unramified extensions), Ch. IV (ramification
  groups, lower and upper numbering, Herbrand `φ/ψ`), Ch. V (the norm on the filtration; §7
  Hasse–Arf), Ch. VIII (Tate cohomology of finite groups, Herbrand quotient), Ch. IX
  (Tate–Nakayama), Ch. X–XI (Galois cohomology, class formations, existence theorem), Ch. XII–XIII
  (the Brauer group of a local field, local CFT), Ch. XIV (local symbols, `(a,b)`, the existence
  theorem, `ℚ_pᵃᵇ`), Ch. XV (ramification and norm-group numerics).
- J. Neukirch, A. Schmidt, K. Wingberg, *Cohomology of Number Fields*, 2nd ed. (NSW), Ch. VII:
  (7.1.x) class formations, (7.2.6) local Tate duality, (7.2.15) unramified annihilators,
  (7.3.1) the Euler characteristic, §7.4 (the Galois module structure of `Kˣ`, with (7.4.1) the
  generator theorem and (7.4.3)/(7.4.4) its module inputs), (7.5.2)/(7.5.3) the tame quotient
  (Iwasawa), (7.5.11) Demushkin.
- M. Jarden, M. Shusterman, *The absolute Galois group of a `p`-adic field*, Theorem 2.1, for the
  exact rank `d(G_K) = [K:ℚ_p] + 2` of the full absolute Galois group, and for its distinction
  from the rank of the maximal pro-`p` quotient.
- J. Neukirch, *Algebraic Number Theory*, Ch. II (valuations, completions, the unit structure,
  unramified and tame extensions), Ch. IV (abstract class field theory, the Neukirch
  Frobenius-lift method), Ch. V (local CFT; V (1.2) units are norms; V §6 the
  reciprocity/upper-numbering compatibility that Layer 7 states).
- I. B. Fesenko, S. V. Vostokov, *Local Fields and Their Extensions*, 2nd ed., Ch. I–III (unit
  filtrations, the norm map, Hasse–Herbrand theory without ramification groups, an alternative
  route worth tracking for Layer 3's norm analysis), Ch. IV (local CFT via the Neukirch and
  Hazewinkel maps simultaneously; §5 the Hilbert pairing, which is Layer 8C), Ch. VII–VIII
  (explicit formulas, Lubin–Tate).
- J. Milne, *Arithmetic Duality Theorems*, 2nd ed., Ch. I §§1–2: the primary source for Layer 8
  (I.2.1/I.2.3 duality, I.2.6 unramified annihilators, I.2.8 the Euler characteristic).
- J.-P. Serre, *Galois Cohomology*, Ch. I–II (profinite cohomology conventions, II §5.2 duality,
  II §5.7 the Euler characteristic, and the `𝔽_p`-dimension exercise behind the counting
  corollary).
- J.-P. Serre, *A Course in Arithmetic*, Ch. II–III (`ℚ_p`, squares, and the Hilbert-symbol table
  used by the worked examples).
- U. Jannsen, K. Wingberg, *Die Struktur der absoluten Galoisgruppe p-adischer Zahlkörper*
  (Invent. Math. 70, 1982); V. Diekert; I. G. Zelvenskii: the full presentation of `G_K` for odd
  `p` and the dyadic case, and Jannsen Satz 3.2 for the `N + 3` bound that predates the sharp one.
- M. Hazewinkel, *Local class field theory is easy* (Adv. Math. 18, 1975), the Hazewinkel-map
  alternative to the Neukirch route, consulted for the design of Layers 6 and 7.
- Cassels–Fröhlich (eds.), *Algebraic Number Theory* (Serre's "Local class field theory"
  chapter); Artin–Tate, *Class Field Theory* (the splitting-module route to Tate–Nakayama that
  Layer 6 pins); Iwasawa, *Local Class Field Theory* (1986); D. Harari, *Galois Cohomology and
  Class Field Theory*; J. Lubin, J. Tate, *Formal complex multiplication in local fields* (1965).

## Provenance and coordination

**Coordination snapshot, checked 2026-08-06.** No external contact was made and no agreement is
claimed; public repositories and PR metadata were inspected. The conditions recorded below are
part of the milestones they attach to, not advice.

- **`kbuzzard/ClassFieldTheory`**, Kevin Buzzard, Yunzhou "Edison" Xie, and contributors.
  **Revision:**
  [`ccc3323c6750`](https://github.com/kbuzzard/ClassFieldTheory/commit/ccc3323c6750abca25b49b35106f54eb3a398509)
  (2026-07-31, the head of `main` at the snapshot date). **Licence:** Apache-2.0. **Overlap:**
  Layer 0's local-field instances and valuation sequence; Layers 5–6's finite class formations,
  Herbrand quotient, and abstract reciprocity. **Contact status:** not contacted; no ownership
  agreement recorded. **Plan:** consume their results that have landed in Mathlib; otherwise
  prove the Tau Ceti milestones independently against the same public interfaces, with three
  standing obligations. (i) *Interface alignment*: the `FiniteClassFormation` interface, the
  Herbrand-quotient convention, and the `IsNonarchimedeanLocalField` vocabulary are adopted as
  they stand, so that statements are mutually translatable. (ii) *Citation*: their blueprint's
  theorem sequence (`blueprint/src/_3_local.tex`) is the finite-level skeleton Layers 5–6 follow.
  (iii) *Refactor on landing*: if their local half lands in Mathlib, the corresponding milestones
  here become comparison-and-consume tasks, and a maintainer note to that effect belongs on each
  affected milestone at implementation time. **Before adapting unlanded code, proof structure, or
  changing a shared statement**, contact the maintainers and record the outcome; until
  then only the public API and the mathematical statements may be consulted.
- **`Akwardbro/RamificationGroup`**, Junjie Bai, Jiedong Jiang, Prowler99, Yicheng Tao, and
  contributors. **Revision:**
  [`c3fd8515a8e3`](https://github.com/Akwardbro/RamificationGroup/commit/c3fd8515a8e35c2876057ab59f4751be6638f3ab)
  (2026-03-01). **Licence:** no licence file was found in the 2026-08-06 check. **Overlap:**
  Layer 3's lower and upper numbering and Herbrand functions. **Contact status:** not contacted.
  **Plan:** independent proof from the cited mathematics in the `IsNonarchimedeanLocalField`
  substrate; their file layout (`LowerNumbering`/`HerbrandFunction`/`UpperNumbering`) and lemma
  granularity are useful prior art and are cited on Layer 3. **Refactor trigger:** compatible
  material lands in Mathlib. **No code, comments, or project-specific organization of statements
  may be transferred** unless the licence is clarified and the authors agree.
- **`mariainesdff/LocalClassFieldTheory`**, María Inés de Frutos-Fernández and Filippo A. E.
  Nuccio (arXiv:2310.01998). **Revision:**
  [`9ebdafa0b464`](https://github.com/mariainesdff/LocalClassFieldTheory/commit/9ebdafa0b464df096037c10a2597c40f7e046602)
  (2025-07-02). **Licence:** no licence file was found in the 2026-08-06 check. **Overlap:**
  the finite-extension valuation layer that has not landed upstream, which is prior art for
  Layer 0's construction milestone; their spectral-norm and valuation-algebra work did land and
  is consumed directly. **Contact status:** not contacted. **Plan:** consume only their landed
  Mathlib work; prove the intrinsic milestone independently. **Refactor trigger:** the remaining
  extension API lands upstream. **No transfer of unlanded code** without licence clarification
  and recorded permission.
- **`ImperialCollegeLondon/FLT`**: a downstream consumer. Their blueprint's
  `local_class_field_theory` assumption is `K^× ≅ W_K^{ab}`-shaped and `\notready`. The Weil-group
  packaging is outside this roadmap's scope, but Layer 7's `Art_K` with dense image is its
  substance; tell the FLT maintainers when Layer 7 lands.
- **`gq2-lean`** (Apache-2.0, same owner; `github.com/roed-math/gq2-lean`): the acceptance
  targets listed in the downstream-consumers table above are late-layer worked examples here,
  stated intrinsically. Files worth adapting, never canonizing, where they match the intrinsic
  statements: `UnitFiltration*.lean` and `UnitNormIndex.lean` (Layer 1), `TeichmullerLift.lean`
  (Layer 1), `UnramifiedBridge`/`UnramifiedModel`/`UnramifiedNorm.lean` (Layer 2), `Zhat.lean`
  (Layer 2's `Ẑ`), `Tame*.lean` (Layer 4), `LocalKummer.lean` and `MuN.lean` (Layer 5),
  `Reciprocity.lean` (Layer 7 statement forms), `TateDuality.lean` and
  `EulerCharacteristic.lean` (Layer 8 statement forms). Three deviations in those encodings are
  **repaired** here rather than inherited: per-`n` duality without cross-`n` compatibility
  (Layer 8 names the compatibility), the unnormalized `inv` (Layer 5 pins the normalization),
  and the geometric `ν_ur` as the primary convention (here a translation lemma).
- **`davidturturean/gq2-lean-turturean`** (GPL-3.0): an audit and comparison source only; the
  licence is incompatible with code reuse here.
- **Adic-spaces roadmap (TauCetiRoadmap PR #80, C. Birkbeck)**: shared `ValuativeRel` substrate,
  disjoint content (see the opening). If both land, the `ℚ_p`-instance work in Layer 0 should be
  checked against its Layer-0 examples for duplication.
- **Zulip** (audited 2026-08-06; the threads the decisions above rest on): the
  `IsNonarchimedeanLocalField` design history, PR #27465 (erdOne, merged 2025-10, out of the
  Oxford CFT workshop, including the `TopologicalSpace`-not-`UniformSpace` decision after
  Gouëzel's point about locally compact completeness), in
  [maths > "Local fields in Lean 4"](https://leanprover.zulipchat.com/#narrow/channel/116395-maths/topic/Local.20fields.20in.20Lean.204/near/530522781)
  and [mathlib4 > "Finite extensions of Q_p"](https://leanprover.zulipchat.com/#narrow/channel/287929-mathlib4/topic/Finite.20extensions.20of.20Q_p/near/501395419)
  (which also carries the "Artin map via group cohomology, not Lubin–Tate" decision); the
  `Valued`-deprecation project in
  [PR reviews > "Project: Deprecate `Valued`"](https://leanprover.zulipchat.com/#narrow/channel/144837-PR-reviews/topic/Project.3A.20Deprecate.20.60Valued.60/near/581079158)
  (Jiedong Jiang, 2026-03-23); the unramified-API direction in
  ["unramified extensions of local fields"](https://leanprover.zulipchat.com/#narrow/channel/217875-Is-there-code-for-X.3F/topic/unramified.20extensions.20of.20local.20fields/near/546006441)
  (2025-10-20); the ramification-filtration design thread
  [maths > "Formalizing Ramification Groups"](https://leanprover.zulipchat.com/#narrow/channel/116395-maths/topic/Formalizing.20Ramification.20Groups/near/426788185)
  (2024-03, Jiedong Jiang, Topaz, Buzzard); the FLT local-CFT axiom announcement in
  [FLT > "update"](https://leanprover.zulipchat.com/#narrow/channel/416277-FLT/topic/update/near/613077432)
  (A. Yang, 2026-07-27); and the open `TopRep` debate in
  [maths > "Continuous cohomology"](https://leanprover.zulipchat.com/#narrow/channel/116395-maths/topic/Continuous.20cohomology/near/610038284)
  (2026-07). ⚠ The ClassFieldTheory project's day-to-day channel is **private** (created for the
  2025 Clay workshop; access by DM to Buzzard), so the repository's sorry state is the best
  public proxy for its progress; confirm anything decision-critical in `#maths` or by requesting
  access. Announce intentions, per the root README's claims process, before starting Layer 0 and
  again before Layers 5–6.
