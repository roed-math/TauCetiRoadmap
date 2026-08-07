# Roadmap: local fields, ramification, and local class field theory

Mathlib defines a nonarchimedean local field. The class is
[`IsNonarchimedeanLocalField`](https://leanprover-community.github.io/mathlib4_docs/Mathlib/NumberTheory/LocalField/Basic.html),
in `Mathlib/NumberTheory/LocalField/Basic.lean`. It is built on the `ValuativeRel` framework. A
nonarchimedean local field is a topological field whose topology comes from its valuation class,
and which is locally compact and not discrete. That one file derives
`IsDiscreteValuationRing 𝒪[K]`, `Finite 𝓀[K]`, compactness of `𝒪[K]`, and the value-group
isomorphism `ValueGroupWithZero K ≃*o ℤᵐ⁰`.

Almost all of the arithmetic of local fields is absent from Mathlib. There is no unit filtration,
and no unramified-extension theory with Frobenius. There is no higher ramification: the file
`Mathlib/RingTheory/Valuation/RamificationGroup.lean` has decomposition and inertia groups only,
and its own TODO asks for the higher groups in the lower numbering. There is no tame quotient, no
Herbrand quotient, no invariant map, no fundamental class, no reciprocity map, no local Tate
duality, and no Euler characteristic.

This roadmap builds that arithmetic:

- the structure theory of local fields and of their finite extensions;
- the ramification filtration in the lower numbering and in the upper numbering;
- the tame quotient of the absolute Galois group;
- local class field theory, through duality, the Euler characteristic, and the topological finite
  generation of `G_K`.

Each layer carries the complete basic theory of the objects it introduces, and not only the
theorem that the layer is named for.

Suggested home: `TauCeti/NumberTheory/LocalField/`. That path mirrors the Mathlib path which owns
the `IsNonarchimedeanLocalField` class. Use one subdirectory per layer: `Basic/`,
`UnitFiltration/`, `Unramified/`, `Ramification/`, `TameQuotient/`, `Cohomology/`,
`ClassFormation/`, `Reciprocity/`, `Duality/`, and `FiniteGeneration/`.

One theorem proved along the way is not about number theory. The finite-group class formation and
the Tate–Nakayama theorem
of Layer 6 are about finite groups and their cohomology. Their home is
`TauCeti/RepresentationTheory/Homological/GroupCohomology/ClassFormation/`.

## How to read a milestone

Each milestone is one bullet with a name in bold, a statement, and the fields below.

- **Prerequisites.** The direct prerequisites of the milestone. Every entry has one of these three
  forms, and no other form is permitted:
  1. `Mathlib:` a declaration or a file of the Mathlib version named below;
  2. `Tau Ceti:` a declaration that Tau Ceti has already accepted;
  3. `Layer n:` an earlier milestone of this roadmap.
- **Supplied hypotheses.** Present only where the *statement* of the milestone carries an
  operation that this roadmap does not own. See below.
- **Proof obligations.** Present only where the *proof* uses such an operation, while no statement
  of the milestone mentions it.
- **API.** For a milestone that introduces an object: the basic theory to prove about it.
- **Source.** For a hard theorem: the reference, the true hypotheses, and, where one exists, a
  nearby false statement that the hypotheses exclude.

A Mathlib pull request, a Mathlib branch, a repository outside Mathlib, an unfinished
formalization, and a roadmap that Tau Ceti has not accepted are never prerequisites. They are
recorded in [`PROVENANCE.md`](PROVENANCE.md), which is a dated survey and is not normative.

### Operations that this roadmap does not own

Two developments carry operations that this roadmap uses and should not build a second time:
cohomology of a profinite group, and the group theory of pro-`p` groups. This roadmap does not
postulate them. It states the theorems that use them with the operation as an **explicit
argument**, bundled in a structure of [`Suggested.lean`](Suggested.lean):

- `Supplied.CohomologyOps`, the coefficient object of a cup product and the cup product itself;
- `Supplied.ProPOps`, the theorems of pro-`p` Sylow theory, the universal property of the free
  profinite group, the two rank inequalities, and the Burnside generation criterion;
- `Supplied.ProPRankInputs`, the rank of the maximal pro-`p` quotient of an absolute Galois group,
  in the two cases that Layer 9 uses.

A theorem with such an argument is an honest theorem, and not an axiom: it asserts an implication
that a reader can check, and its proof needs nothing outside Mathlib and the earlier milestones.
A `sorry` that postulates an object owned elsewhere would assert more than that, so this roadmap
carries none.

An operation is a field of one of these structures exactly when it occurs in a **statement** here.
Corestriction, Mackey, Shapiro, and the finite-quotient colimit occur only inside proofs, so they
are proof obligations and not fields. The three structures are stated once, in the section
[Operations taken as hypotheses](#operations-taken-as-hypotheses), with the field-by-field
mathematical content of each. Where a supplier eventually proves those fields, a term of the
structure is produced once and every theorem here is applied to it.

Everything else this roadmap needs, it owns and builds. In particular it owns the Tate cup product
in all integer bidegrees, the finite class-formation structure, Tate–Nakayama, the local
fundamental class, and every statement about the multiplicative module `(Kˢ)ˣ`.

## Standing hypotheses

The standing setting is a field `K` with `[Field K] [ValuativeRel K] [TopologicalSpace K]
[IsNonarchimedeanLocalField K]`. For extensions there is a second such field `L` with
`[Algebra K L] [ValuativeExtension K L]` and `[Module.Finite K L]`. Write these hypotheses out. Do
not collect them into a new class. Where a statement needs completeness, add the uniform
hypotheses `[UniformSpace K] [IsUniformAddGroup K]`, as the `CompleteSpace` instances of Mathlib
do.

Do not fix a prime `p`, and do not assume that `K/ℚ_p` is finite, in the common structural layers.
Every power-class statement, Kummer statement, cohomological-dimension statement, duality
statement, and Euler statement names its regime:

1. **regime 1**, prime to the residue characteristic, valid in mixed and in equal characteristic;
2. **regime 2**, mixed-characteristic `p`-primary, where `K` is a finite extension of `ℚ_p`.

Positive characteristic `K = 𝔽_q((t))` remains a worked example in the common part and in the
regime-1 part. Layer 9 and its `ℚ_p`-specific examples are in regime 2.

Do not assume `p ≠ 2` inside a mixed-characteristic statement. Every downstream consumer of this
roadmap works at `p = 2`. The literature contains many odd-`p` shortcuts: the NSW (7.5.14)
subsection assumes `p ≠ 2`, and tame arguments assume `p ∤ e` without saying so. Each statement
carries its true hypotheses.

### Scope boundary: `p`-power coefficients in equal characteristic

Let `char K = p` and let `p` divide `n`. This roadmap asserts no statement of regime 1 or regime 2
in that case. No milestone below may be extended to it by the removal of a hypothesis. The reason
is not the order of work. The statements are false there:

- at `K = 𝔽_q((t))` and `n = p`, the classes of `1 + t^m` for `p ∤ m` are pairwise distinct in
  `Kˣ/(Kˣ)^p`, so that group is infinite, and `H¹(G_K, ℤ/p)` is infinite with it;
- `cd_p(G_K)` is `1`, and not `2`;
- `μ_{p^r}` is not the finite étale dual that the duality pairing needs.

Artin–Schreier–Witt theory and finite flat (Cartier) duality replace them. This roadmap builds
neither. Every regime-1 hypothesis below is written `IsUnit (n : 𝒪[K])`. The excluded case then
fails the hypothesis, and it is not held back by a side condition that a reader can miss.

The boundary reaches further than the duality of Layer 8. The route to the existence theorem in
Layer 7 is Kummer theory over `K(μ_n)`, which supplies nothing when `p ∣ n` and `char K = p`.
Layer 7 therefore proves the existence theorem in full for `K/ℚ_p` finite, and away from the
residue characteristic in general. In equal characteristic the full theorem is true, and its proof
belongs to a roadmap that builds Artin–Schreier–Witt theory. Three consequences of full existence
carry the mixed-characteristic hypothesis for the same reason:

- injectivity of `Art_K`;
- the identification of the normic topology with the topology of all open subgroups of finite
  index;
- the isomorphism `(Kˣ)^∧ ≅ G_K^{ab}` of the ordinary profinite completion.

## Pinned conventions

| object | convention | source of truth |
|---|---|---|
| valuation, multiplicative | the canonical `ValuativeRel.valuation K` of Mathlib, into `ValueGroupWithZero K ≃*o ℤᵐ⁰`. For a uniformizer `π`, `v(π) = exp (−1)`, so `v < 1` on `𝓂[K]`. This matches `Padic.mulValuation x = exp (−x.valuation)` | `Mathlib/NumberTheory/Padics/PadicNumbers.lean`, `Mathlib/RingTheory/Valuation/ValuativeRel/Basic.lean` |
| valuation, normalized additive | on nonzero elements use `v_K^× : Kˣ →* Multiplicative ℤ`, the additive valuation in multiplicative encoding. Write `v_K(x) := Multiplicative.toAdd (v_K^× x)` when an integer is wanted. For a uniformizer `π`, `v_K^×(π) = Multiplicative.ofAdd 1`, equivalently `v_K(π) = 1`. The equation `v_K^×(x) = 1` is reserved for the unit condition, that is, additive value `0`. Extend across zero separately, with `ℤᵐ⁰`. Never write `v_K^×(π) = 1`, which is ambiguous | this roadmap (Layer 0). The translation from the canonical multiplicative valuation carries a minus sign and is a named lemma |
| absolute value | `‖x‖_K = q^{−v_K(x)}` with `q = Nat.card 𝓀[K]`, with values in `ℚ≥0`. This normalization makes the Euler characteristic of Layer 8 read `‖#M‖_K`, and it matches `Padic.norm_eq_zpow_neg_valuation` | Layer 0 |
| residue field, integers | `𝒪[K]`, `𝓂[K]`, `𝓀[K]`, the notations scoped to `ValuativeRel`, that is `Valuation.integer (valuation K)` and its companions. Never a second valuation subring | `Mathlib/Topology/Algebra/Valued/ValuativeRel.lean` |
| unit filtration | `U(K, i) : Subgroup Kˣ` indexed by `i : ℕ`, with `U(K, 0) = 𝒪[K]ˣ`, and `U(K, i) = 1 + 𝓂[K]^i` for `i ≥ 1`. The literature writes `U_K^{(i)}` | Layer 1 |
| ramification filtration | lower numbering `G_i`, indexed by `i : ℤ`, total, with `G_i = ⊤` for `i ≤ −1`. `G_0` is the inertia group and `G_1` is the wild inertia group (Serre LF IV §1). The real index is `G_u := G_{⌈u⌉}` for `u : ℝ`. The Herbrand functions are `φ_{L/K}, ψ_{L/K} : ℝ → ℝ`, and the upper numbering is `G^u = G_{ψ(u)}`. The two filtrations use different index sets on purpose. A statement that relates `U(K, i)` to `G_j` writes the shift out | Layer 3 |
| Herbrand values as unit depths | `ψ_{L/K}` carries `ℕ` into `ℕ`. The resulting `ψℕ_{L/K} : ℕ → ℕ` is the one conversion in use. A unit group is indexed by a natural number, or by a value of `ψℕ`, and never by `φ` or by a real number. `φ` keeps its real values, and occurs only inside the Herbrand calculus and inside a floor, as in `⌊φ_{L/K}(i)⌋` | Layer 3 |
| Frobenius | the **arithmetic** Frobenius `x ↦ x^q` on residue fields is the distinguished generator. The unqualified word "Frobenius" always means the arithmetic one. The geometric Frobenius is its inverse, and its name always contains `geometric` | Layer 2 |
| absolute Galois group | `Field.absoluteGaloisGroup K`, that is `Gal(AlgebraicClosure K / K)`, in every public statement, and in every characteristic. Restriction to the separable closure is a topological isomorphism, proved once as a comparison theorem | Layer 4 |
| coefficient field | every coefficient module is built inside the **separable** closure `Kˢ := SeparableClosure K`, and never inside `AlgebraicClosure K`. So the multiplicative module is `(Kˢ)ˣ`, and the roots of unity are `μ_n(Kˢ)`. ⚠ For an imperfect field of equal characteristic, the fixed field of `Field.absoluteGaloisGroup K` acting on the full algebraic closure is the perfect closure, and not `K`, so `H⁰` of the multiplicative module would be wrong. The group stays `Field.absoluteGaloisGroup K`, acting on `Kˢ` through the comparison isomorphism of Layer 4 | Layer 4 |
| reciprocity normalization | `Art_K : Kˣ →* G_K^{ab}` sends **uniformizers to arithmetic Frobenius**. Equivalently `ν_K ∘ Art_K = ι ∘ v_K`, where `ν_K : G_K^{ab} →* Ẑ` is normalized by `ν_K(Frob) = 1`, and `ι : ℤ → Ẑ` is the completion map. This is the Neukirch and NSW convention. The geometric normalization `Art_K^{geo} = Art_K ∘ (·)⁻¹` is one definition plus one translation lemma, and never a second convention | Layer 7 |
| unramified coordinate target | `ν_K` has target `Ẑ`, which is profinite, and **never** `ℤ`. A continuous homomorphism from the compact group `G_K^{ab}` to the discrete group `ℤ` is trivial. The `ℤ`-valued form of the normalization is therefore inconsistent, and not merely inconvenient | Layer 2 and Layer 7 |
| conductor | `c(L/K) : ℕ` is the conductor exponent, and `𝔣(L/K) = 𝓂[K]^{c(L/K)}` is the conductor ideal. The letter `f` is reserved for the residue degree, and is never reused for a conductor | Layer 7 |
| invariant map | `inv_{L/K} : H²(Gal(L/K), Lˣ) ≃ (1/[L:K])ℤ/ℤ` in the unramified case, normalized by evaluation at Frobenius: under `H²(Ẑ-quotient, ℤ) ≅ H¹(·, ℚ/ℤ) = Hom(·, ℚ/ℤ)`, the class maps to evaluation at the **arithmetic** Frobenius. For the fundamental class, `inv_K(u_{L/K}) = 1/[L:K]` | Layer 5 |
| Herbrand quotient | `h(G, M) = #H²(G, M) / #H¹(G, M)` for finite cyclic `G`, equivalently `#Ĥ⁰/#Ĥ¹`. The two values used are `h(Gal(L/K), Lˣ) = [L:K]` and `h(Gal(L/K), 𝒪[L]ˣ) = 1` | Layer 5 |
| tame relation | `σ τ σ⁻¹ = τ^q`, where `σ` is an **arithmetic** Frobenius lift and `τ` is a topological generator of the tame inertia `I_t ≅ Ẑ^{(p')}(1)`. The `(1)` records that the action of `G_K` on `I_t ≅ lim_{p∤m} μ_m` is the cyclotomic one, which is the same statement as the relation. The presentation with a geometric `σ`, that is `σ⁻¹ τ σ = τ^q`, is isomorphic to it under `σ ↦ σ⁻¹`, and is supplied as a translation lemma | Layer 4 |
| cohomology carrier | continuous cohomology of `G_K` is `continuousCohomology n A` of Mathlib, for `A` the topological representation attached to a discrete module with continuous action. This roadmap states nothing against a private carrier, and any comparison with an explicit cochain description is a statement about the Mathlib carrier. Finite-level statements use `groupCohomology` and `tateCohomology` of Mathlib | Layer 5 |
| Tate dual | one dual for each `n`, and only when `char K ∤ n`. For a finite discrete `G_K`-module `M` killed by `n`, the étale dual is `Hom(M, μ_n)` with the conjugation action. This covers regime 1, and every `n` in regime 2. Compatibility along `μ_n ⊆ μ_{nm}` is a named milestone inside those regimes | Layer 8 |
| class formation interface | at finite level, a distinguished class `σ_H ∈ H²(H, M)` for every subgroup `H ≤ G`, with `H¹(H, M) = 0` and `H²(H, M)` cyclic of order `Nat.card H`. ⚠ The order is `Nat.card H`, and never the index `[G : H]`. The profinite-level formation `(G_K, (Kˢ)ˣ)`, with compatible invariant maps, is stated on top of the finite-level one, in the style of NSW II §1 | Layer 5 and Layer 6 |

## What Mathlib has (consume)

Checked against Mathlib `v4.32.2`, which is the version this repository requires. Every
declaration below exists at that version. Do not rebuild any of it.

- **The local-field class:** `Mathlib/NumberTheory/LocalField/Basic.lean`, with
  `IsNonarchimedeanLocalField`. It carries the instances `IsTopologicalDivisionRing K`,
  `CompactSpace 𝒪[K]`, `IsDiscreteValuationRing 𝒪[K]`, `Finite 𝓀[K]`, `ValuativeRel.IsDiscrete K`,
  `IsRankLeOne K`, and `IsCyclic (ValueGroupWithZero K)ˣ`. It also has the isomorphism
  `valueGroupWithZeroIsoInt : ValueGroupWithZero K ≃*o ℤᵐ⁰`. Under the uniform hypotheses it has
  `CompleteSpace K`, `CompleteSpace 𝒪[K]`, and `IsAdicComplete 𝓂[K] 𝒪[K]`.
- **The valuative framework:** `Mathlib/RingTheory/Valuation/ValuativeRel/Basic.lean`
  (`ValuativeRel`, the canonical `valuation`, `Valuation.Compatible`, `ValuativeExtension`,
  `IsNontrivial`, `IsRankLeOne`); `Mathlib/RingTheory/Valuation/DiscreteValuativeRel.lean`
  (`IsDiscrete`, through compatibility with `ℤᵐ⁰`);
  `Mathlib/Topology/Algebra/Valued/ValuativeRel.lean` (`IsValuativeTopology`, and the notations
  `𝒪[K]`, `𝓂[K]`, `𝓀[K]`); `Mathlib/Topology/Algebra/Valued/LocallyCompact.lean` (the
  characterization of compactness by completeness, discreteness, and finiteness of the residue
  field, with the closed-ball API).
- **`ℚ_p`:** `Mathlib/NumberTheory/Padics/`, with `PadicInt` and its `unitCoeff`, Hensel's lemma
  (`Hensel.lean`), `ProperSpace ℚ_[p]`, `Padic.valuation` and `addValuation`, and
  `Padic.mulValuation : Valuation ℚ_[p] ℤᵐ⁰` with the instances `ValuativeRel ℚ_[p]`,
  `Valuation.Compatible`, `IsNontrivial`, and `IsRankLeOne` (`Padics/ValuativeRel.lean`). ⚠
  Mathlib `v4.32.2` has **no** `IsValuativeTopology ℚ_[p]`, and therefore no
  `IsNonarchimedeanLocalField ℚ_[p]`. That instance is the first milestone of Layer 0.
- **Valuation extension:** `Mathlib/RingTheory/Valuation/Extension.lean` (the valuation-extension
  class, which uses equivalence and not equality by design, with the normalization discussion of
  uniformizer against `p` in its docstring); `Mathlib/RingTheory/Valuation/AlgebraInstances.lean`
  and `Minpoly.lean`; the spectral norm in `Mathlib/Analysis/Normed/Unbundled/SpectralNorm.lean`;
  and **Krasner's lemma** in `Mathlib/Analysis/Normed/Field/Krasner.lean`.
- **Ramification at Dedekind level:** `Mathlib/NumberTheory/RamificationInertia/`, with
  - `Ideal.ramificationIdx`, `Ideal.inertiaDeg`, and `sum_ramification_inertia`, that is
    `∑ e_P f_P = [L:K]`, in `Basic.lean`;
  - transitivity of the Galois action on `primesOver`, and the well-defined `ramificationIdxIn`
    and `inertiaDegIn`, in `Galois.lean`;
  - the decomposition field and the inertia field, as the classes `IsDecompositionField` and
    `IsInertiaField`, in `HilbertTheory.lean`;
  - compatibility with valuations, in `Valuation.lean`.

  The residue action of Hilbert theory is available at ring level:
  `Ideal.inertia`, the kernel of the action of a subgroup on `S/Q`, in
  `Mathlib/Algebra/Group/Subgroup/Basic.lean`, and the isomorphism
  `stabilizer G Q ⧸ Q.inertia (stabilizer G Q) ≃* Gal(residue extension)`, in
  `Mathlib/RingTheory/Invariant/Basic.lean`.
- **Decomposition and inertia for valuation subrings:**
  `Mathlib/RingTheory/Valuation/RamificationGroup.lean`, with
  `ValuationSubring.decompositionSubgroup`, a stabilizer, and `inertiaSubgroup`, the kernel of the
  residue action. The file contains nothing else, and its TODO asks for the higher ramification
  groups.
- **Unramifiedness, algebraic:** `Mathlib/RingTheory/Unramified/` (`Algebra.FormallyUnramified`,
  `Unramified/Field.lean`, and `Locus.lean` with `Algebra.IsUnramifiedAt`), and
  `Mathlib/RingTheory/Etale/`. These are the formal notion and the étale notion. The arithmetic
  notion for local fields, that is `e = 1` with separability of the residue extension, is built in
  Layer 2 and compared with them there.
- **Galois theory of infinite extensions:** `Mathlib/FieldTheory/KrullTopology.lean`;
  `Mathlib/FieldTheory/Galois/Profinite.lean` (`CompactSpace Gal(K/k)`, `profiniteGalGrp`);
  `Mathlib/FieldTheory/AbsoluteGaloisGroup.lean` (`Field.absoluteGaloisGroup`, and
  `absoluteGaloisGroupAbelianization`, the topological abelianization);
  `Mathlib/FieldTheory/SeparableClosure.lean` (`separableClosure`, and
  `separableClosure.algEquivOfAlgEquiv`, the restriction map whose bijectivity Layer 4 proves);
  `Mathlib/FieldTheory/Galois/IsGaloisGroup.lean` (the class `IsGaloisGroup`, used by the
  Hilbert-theory files); and `Mathlib/Topology/Algebra/Category/ProfiniteGrp/` (`Basic.lean`,
  `Limits.lean`, and `Completion.lean` with `profiniteCompletion`, the home of `Ẑ`).
- **Group cohomology**, in `Mathlib/RepresentationTheory/Homological/`:
  - `GroupCohomology/Basic.lean` and `LowDegree.lean`, with explicit `H0`, `H1`, `H2`, cocycles,
    and `H1IsoOfIsTrivial`;
  - `GroupCohomology/Hilbert90.lean`, with `groupCohomology.H1ofAutOnUnitsUnique`, that is
    `H¹(Gal(L/K), Lˣ) = 0` for finite Galois `L/K`, and the cocycle form of Noether;
  - `GroupCohomology/LongExactSequence.lean`, `Shapiro.lean`, and `Functoriality.lean`;
  - `GroupCohomology/FiniteCyclic.lean`, the periodicity of `Hⁱ` for a finite cyclic group. It
    uses the bicomplex of the norm and `ρ(g) − 1`, which is the engine of the Herbrand quotient;
  - `TateCohomology/Basic.lean`, Tate cohomology;
  - `ContCohomology/`, continuous cochain cohomology, in `Basic.lean`, `Functoriality.lean`, and
    `LowDegree.lean`.
  ⚠ There is no cup product anywhere in that directory at `v4.32.2`, and no corestriction for
  group cohomology. Both are fields of `Supplied.CohomologyOps`.
- **Cyclotomic characters and Teichmüller lifts:**
  `Mathlib/NumberTheory/Cyclotomic/CyclotomicCharacter.lean` (`cyclotomicCharacter`, with values
  in `ℤ_[p]ˣ`); `Mathlib/RingTheory/Teichmuller.lean` (`Perfection.teichmuller₀ : Perfection (R ⧸
  I) p →*₀ R` for `I`-adically complete `R`, the engine for the multiplicative section of Layer
  1); `Mathlib/FieldTheory/Finite/` (the Frobenius of a finite field, `GaloisField`);
  `Mathlib/RingTheory/Henselian.lean` (`HenselianLocalRing`); and
  `Mathlib/RingTheory/Perfection.lean`.
- **Eisenstein polynomials:** `Mathlib/RingTheory/Polynomial/Eisenstein/` (`IsEisensteinAt`,
  irreducibility, and the consequences for `IsIntegrallyClosed`). This is the algebraic half of
  the totally-ramified correspondence of Layer 3.
- **Trace forms and duality:** `Mathlib/RingTheory/Trace/` and
  `Mathlib/RingTheory/DedekindDomain/Different.lean` (`differentIdeal` for an extension of
  Dedekind domains, through the trace dual). Layer 3 specializes and computes these, and does not
  redefine them.

## What is missing (build here)

Everything below is specific to the arithmetic of local fields, and none of it exists in Mathlib
`v4.32.2` in the form stated here.

- The normalized `ℤ`-valued valuation and the absolute value `‖·‖_K`.
- The unit filtration `U(K,i)`, with its graded pieces `𝒪[K]ˣ/U(K,1) ≅ 𝓀[K]ˣ` and
  `U(K,i)/U(K,i+1) ≅ 𝓀[K]⁺`. With it: the Teichmüller section `𝓀[K]ˣ →* 𝒪[K]ˣ`, the decomposition
  `Kˣ ≅ πᶻ × μ_{q−1} × U(K,1)` with `U(K,1)` pro-`p`, and the cardinality of `Kˣ/(Kˣ)ⁿ` in the two
  regimes.
- The theory of finite extensions at local-field level: the canonical valuation on an abstract
  finite extension, `e` and `f` defined without a choice of uniformizer, `e · f = [L:K]`, and the
  local-field instance on `L`.
- Unramified extensions, with the residue correspondence and Frobenius. This includes one such
  extension of each degree inside a fixed closure, the maximal unramified extension with
  `Gal(K^{ur}/K) ≅ Ẑ`, and surjectivity of the norm on units.
- The equivalence of totally ramified with Eisenstein; the tame case and the wild case; the lower
  numbering `G_i` with its subgroup compatibility and the embeddings `G_0/G_1 ↪ 𝓀ˣ` and
  `G_i/G_{i+1} ↪ 𝓀⁺`; the Herbrand functions `φ` and `ψ`; the upper numbering; the theorem of
  Herbrand on quotients; the effect of the norm on the unit filtration; and Hasse–Arf.
- The tame quotient `1 → Ẑ^{(p')}(1) → G_K^{t} → Ẑ → 1`, with its Frobenius splitting and the
  relation `στσ⁻¹ = τ^q`.
- On the cohomological side: Kummer theory `Kˣ/(Kˣ)ⁿ ≅ H¹(G_K, μ_n)` for `char K ∤ n`; the
  Herbrand-quotient computations `h(Lˣ) = [L:K]` and `h(𝒪[L]ˣ) = 1`; cohomological triviality of
  unramified units; `H²(unramified) ≅ (1/n)ℤ/ℤ`; solvability of local Galois groups; the invariant
  map `inv_K : Br(K) ≅ ℚ/ℤ`; fundamental classes; the class formation; Tate–Nakayama; finite-level
  reciprocity with tower functoriality; the Artin map with its normalizations; norm groups; norm
  limitation; and the existence theorem, away from the residue characteristic for a general local
  field and in full for `K/ℚ_p` finite.
- Local Tate duality and the Euler characteristic in the two regimes, the identification of the
  mod-2 pairing with the Hilbert symbol, and the exact rank `d(G_K) = [K:ℚ_p] + 2`.

---

## The build, in layers

The order below is the dependency order. Layers 0 to 4 use no cohomology. Layers 5 to 9 use the
fields of `Supplied.CohomologyOps` that the milestones name. As each layer makes the types of the
next layer expressible, add the milestones of that layer to `Suggested.lean` with `sorry`.

### Layer 0: local fields and their finite extensions

- **`ℚ_p` is a local field.** Prove `IsValuativeTopology ℚ_[p]`, that is, the valuation topology
  is the norm topology, and derive `IsNonarchimedeanLocalField ℚ_[p]`, for every prime `p`. ⚠
  Instance hygiene: `ℚ_[p]` carries a metric `UniformSpace`. Its compatibility with
  `IsTopologicalAddGroup.rightUniformSpace` must be a lemma, and not an accident of unification,
  or the `CompleteSpace` instances will not fire.
  - *Prerequisites:*
    - `Mathlib: Padic.mulValuation` and the instances of
      `Mathlib/NumberTheory/Padics/ValuativeRel.lean`;
    - `Mathlib: IsNonarchimedeanLocalField`.
  - *API:*
    - the instance itself;
    - the compatibility lemma for the two uniformities;
    - agreement of `Padic.valuation` with the normalized valuation of the next milestone;
    - `IsNonarchimedeanLocalField ℤ_[p]`-facing corollaries, that is `CompactSpace ℤ_[p]` and
      `IsAdicComplete`;
    - the same instance for a finite extension of `ℚ_[p]`, through Layer 0.III.
- **The normalized valuation.** Define `v_K^× : Kˣ →* Multiplicative ℤ` through
  `valueGroupWithZeroIsoInt` and `WithZero.log`, and extend it across zero with `ℤᵐ⁰`. Prove the
  uniformizer equation `v_K^×(π) = Multiplicative.ofAdd 1`, surjectivity, and that `v_K^×(x) = 1`
  holds exactly on `𝒪[K]ˣ`. Decode with `v_K(x) := Multiplicative.toAdd (v_K^× x)` when an integer
  is wanted. Define the absolute value `‖x‖_K = q^{−v_K(x)}` with `q = Nat.card 𝓀[K]`, with values
  in `ℚ≥0`, and prove that it agrees with the `Padic` norm on `ℚ_[p]`. ⚠ The canonical valuation
  of Mathlib has `v(π) = exp(−1)`, so the integers are the elements with `v ≤ 1`, and the additive
  normalization carries a minus sign. Every statement that mixes the two cites the one named
  `−log` translation lemma.
  - *Prerequisites:* `Mathlib: valueGroupWithZeroIsoInt`, `WithZero.log`,
    `Padic.norm_eq_zpow_neg_valuation`.
  - *API:*
    - the two constructors, `v_K^×` and `‖·‖_K`, and the translation lemma between them;
    - `v_K^×` is a monoid homomorphism, and `‖·‖_K` is multiplicative and ultrametric;
    - the value on a uniformizer, on a unit, and on a root of unity;
    - monotonicity against divisibility in `𝒪[K]`;
    - the point-set consequences, namely `𝒪[K]` open and compact, the family `𝓂[K]^i` a
      neighbourhood basis of `0`, and `Kˣ` locally compact with `𝒪[K]ˣ` compact open;
    - naturality along a finite extension, which is the characteristic property of `e` below;
    - the worked values on `ℚ_2` in the examples section.
- **Finite extensions, I: construction of the valuation.** Let `[Field L] [Algebra K L]
  [Module.Finite K L]`, with no valuative structure assumed on `L`. Construct a valuation
  `w : Valuation L ℤᵐ⁰` whose restriction along `algebraMap K L` is equivalent to `valuation K`.
  Use the spectral norm. The output type is fixed: a `Valuation L ℤᵐ⁰`, a `ValuativeRel L` built
  from it as a definition and not as a global instance, the compatibility `Valuation.Compatible`,
  `IsValuativeTopology L` for the induced topology, and `ValuativeExtension K L`. A definition
  rather than an instance keeps a field that already carries a `ValuativeRel` free of a diamond.
  - *Prerequisites:*
    - `Mathlib: Mathlib/RingTheory/Valuation/Extension.lean`;
    - `Mathlib: spectralNorm` and `Mathlib/Analysis/Normed/Field/Krasner.lean`;
    - `Mathlib: Mathlib/RingTheory/Valuation/AlgebraInstances.lean`.
  - *Source:* Neukirch ANT II §6 and II §8, for a complete discretely valued base. The hypotheses
    used are completeness of `K` and finiteness of `L/K`. *False generalization:* a valuation on
    an incomplete field has several inequivalent extensions to a finite extension, so completeness
    is not a convenience here.
- **Finite extensions, II: uniqueness.** Any two valuations on `L` that restrict to the valuation
  class of `K` are equivalent, in the sense of `Valuation.IsEquiv`. Any two `ValuativeRel L`
  structures for which `ValuativeExtension K L` holds are equal. Corollary: every `K`-algebra
  automorphism of `L` preserves the valuation, and therefore acts on `𝒪[L]`, `𝓂[L]`, and `𝓀[L]`.
  The corollary is stated here because Layers 2 and 3 use it many times.
  - *Prerequisites:*
    - `Layer 0: finite extensions, I`;
    - `Mathlib: Valuation.IsEquiv`.
  - *API:*
    - uniqueness in both forms above;
    - the action of `L ≃ₐ[K] L` on `𝒪[L]`, on `𝓂[L]`, and on `𝓀[L]`, with functoriality in the
      extension;
    - invariance of `v_L` under that action;
    - the induced map `Gal(L/K) → Gal(𝓀[L]/𝓀[K])`, whose kernel Layer 3 names the inertia group.
- **Finite extensions, III: consequences.** From I and II derive `IsNonarchimedeanLocalField L`,
  completeness of `L`, the instances `Algebra 𝒪[K] 𝒪[L]` and `Algebra 𝓀[K] 𝓀[L]`, and freeness of
  `𝒪[L]` as a finite `𝒪[K]`-module.
  - *Prerequisites:*
    - `Layer 0: finite extensions, I`;
    - `Layer 0: finite extensions, II`;
    - `Mathlib: IsNonarchimedeanLocalField`.
  - *API:*
    - the four instances;
    - transitivity in a tower `M/L/K`;
    - the comparison of `𝒪[L]` with the integral closure of `𝒪[K]` in `L`;
    - a basis of `𝒪[L]` over `𝒪[K]` in the unramified case and in the totally ramified case, which
      Layers 2 and 3 use.
- **`e` and `f`, intrinsically.** Define `ramificationIndex K L : ℕ` as the index of the image of
  the normalized value group. Equivalently, it is the unique positive integer `e` with
  `v_L(algebraMap K L x) = e * v_K(x)` for all `x : Kˣ`. Positivity is part of the
  characterization. Define `inertiaDegree K L := Module.finrank 𝓀[K] 𝓀[L]`, which Layer 0.III
  makes available. Prove `v_L(algebraMap K L π_K) = e` for **every** uniformizer `π_K` of `K`, so
  that no statement below has to choose one; `0 < e`; `0 < f`; `e * f = Module.finrank K L`;
  multiplicativity of each in a tower; and the comparison lemmas with `Ideal.ramificationIdx` and
  `Ideal.inertiaDeg`. The comparison needs one bridging fact, proved once: at a local field
  `primesOver 𝓂[K] 𝒪[L]` is the singleton `{𝓂[L]}`. Do not re-derive the Dedekind theory here, and
  do not force a consumer through the `sSup` in `Ideal.ramificationIdx`.
  - *Prerequisites:*
    - `Layer 0: the normalized valuation`;
    - `Layer 0: finite extensions, III`;
    - `Mathlib: Ideal.ramificationIdx`, `Ideal.inertiaDeg`, `sum_ramification_inertia`.
  - *API:*
    - the two definitions and their characteristic properties;
    - positivity;
    - the product formula;
    - multiplicativity in towers;
    - the values in the unramified case and in the totally ramified case;
    - the comparison lemmas with the Dedekind-level pair;
    - the singleton lemma for `primesOver`;
    - the worked values for `ℚ_2(√2)/ℚ_2` in the examples section.
  - *Source:* Serre LF I §4 and Neukirch ANT II §6, for `e · f = [L:K]` over a complete discretely
    valued base. *False generalization:* over an incomplete base, or with more than one prime
    above `𝓂[K]`, the identity becomes `∑_P e_P f_P = [L:K]`, which is `sum_ramification_inertia`
    and is a different theorem.

### Layer 1: units, the filtration, and the multiplicative group

- **The unit filtration as an object.** Define `unitFiltration K i : Subgroup Kˣ` for `i : ℕ`,
  with the depth-zero case explicit: `U(K,0)` is the image of `𝒪[K]ˣ → Kˣ`, and for `i ≥ 1`,
  `U(K,i) = {x : Kˣ | x ∈ 𝒪[K] ∧ v_K(x − 1) ≥ i}`. State membership in the two forms that are
  used, namely the congruence `x ≡ 1 mod 𝓂[K]^i` inside `𝒪[K]` and the valuation inequality on
  `x − 1`, and prove that they agree. Indices are natural numbers throughout. Layers 3 and 7
  compare `U(K,i)` with a ramification group `G_j`. Each such statement writes out the shift
  between the two index conventions.
  - *Prerequisites:*
    - `Layer 0: the normalized valuation`;
    - `Mathlib: Subgroup`, `Valuation`.
  - *API:*
    - the definition with both membership forms;
    - `U(K,0) = 𝒪[K]ˣ` as a subgroup of `Kˣ`;
    - antitonicity in `i`;
    - `⋂_i U(K,i) = 1`;
    - each `U(K,i)` open and compact in `Kˣ`;
    - the family a neighbourhood basis of `1`;
    - stability under every `K`-automorphism of a Galois extension, which Layer 3 uses;
    - the index `[U(K,i) : U(K,i+1)]`, which is `q − 1` at `i = 0` and `q` otherwise;
    - naturality along a finite extension, which is the norm package of Layer 3.
- **Graded pieces.** Prove `U(K,0)/U(K,1) ≃* 𝓀[K]ˣ` by reduction, and, for `i ≥ 1`,
  `U(K,i)/U(K,i+1) ≃* 𝓀[K]⁺` through `1 + x ↦ x mod 𝓂^{i+1}`. The counts `q − 1` and `q` are
  corollaries. ⚠ The depth-zero piece is multiplicative and the deeper pieces are additive. The
  two isomorphisms stay separate, and do not combine into one statement.
  - *Prerequisites:*
    - `Layer 1: the unit filtration as an object`;
    - `Layer 0: the normalized valuation`.
  - *API:*
    - the two isomorphisms;
    - independence of the choice of uniformizer in the second, up to the induced automorphism of
      `𝓀[K]⁺`;
    - naturality in `i`;
    - the two counts;
    - the compatibility of the second isomorphism with the embeddings `θ_i` of Layer 3, which is
      where the choice of uniformizer is fixed again.
  - *Source:* Serre LF IV §2; Neukirch ANT II §3 and II §5.
- **Teichmüller.** Define the multiplicative section `ω : 𝓀[K]ˣ →* 𝒪[K]ˣ` of the reduction map.
  Characterize it as the unique section whose image consists of `(q−1)`-torsion elements, and
  prove `μ_{q−1}(K) ≅ 𝓀[K]ˣ`. That characterization is the public statement. Whether the proof
  uses `Perfection.teichmuller₀`, since a finite field is perfect and `𝒪[K]` is `𝓂[K]`-adically
  complete, or Hensel's lemma applied to `X^{q−1} − 1`, is an implementation note.
  - *Prerequisites:*
    - `Mathlib: Perfection.teichmuller₀`, `HenselianLocalRing`, `IsAdicComplete 𝓂[K] 𝒪[K]`;
    - `Layer 1: graded pieces`.
  - *API:*
    - the definition, the section property, and the uniqueness characterization;
    - `ω` is a monoid homomorphism and is injective;
    - `ω(1) = 1`;
    - the image is exactly `μ_{q−1}(K)`;
    - naturality along an unramified extension, which Layer 2 uses for the Frobenius;
    - the values on `ℚ_2` and on `ℚ_5` in the examples section.
- **Structure of `Kˣ`.** Prove the topological isomorphism `Kˣ ≃ ℤ × 𝒪[K]ˣ` attached to a choice
  of uniformizer, and `𝒪[K]ˣ ≃ μ_{q−1} × U(K,1)`. Prove that `U(K,1)` is pro-`p`, as the inverse
  limit of the `p`-groups `U(K,1)/U(K,i)`. State it in quotient form: every continuous finite
  quotient of `U(K,1)` is a `p`-group. That is the shape `Supplied.IsProP` unfolds to, so the two
  statements are the same statement and not two rephrasings. Prove that the torsion subgroup
  `μ(K)` is finite.
  - *Prerequisites:*
    - `Layer 1: the unit filtration as an object`;
    - `Layer 1: Teichmüller`;
    - `Mathlib: OpenNormalSubgroup`, `IsPGroup`.
  - *API:*
    - the two isomorphisms, with their inverses and their continuity;
    - the dependence on the uniformizer, which is an isomorphism of the two splittings;
    - finiteness of `μ(K)` and its order;
    - the `p`-part and the prime-to-`p` part of `μ(K)`;
    - the projection `Kˣ → ℤ`, which is `v_K`, and its splitting.
  - *Source:* Serre LF II §§4–5; Neukirch ANT II §5.
- **Deep units in mixed characteristic.** Let `K/ℚ_p` be finite of degree `N`, with absolute
  ramification index `e`. Let `i : ℕ` satisfy the integer inequality `(p − 1) * i > e`. Then the
  logarithm is an isomorphism of topological groups `U(K,i) ≃ (𝓂[K]^i, +)`, with `exp` as its
  inverse, and therefore `U(K,i) ≃ ℤ_p^N` as `ℤ_p`-modules. State the threshold as that integer
  inequality, and never as `i > e/(p−1)`, so that no division of natural numbers occurs.
  - *Prerequisites:*
    - `Layer 1: the unit filtration as an object`;
    - `Layer 0: finite extensions, III`;
    - `Mathlib: exp` and `log` for a `p`-adic field.
  - *Source:* NSW (7.4.4); Neukirch ANT II §5. The hypotheses used are `char K = 0` and the
    integer inequality. *False generalization:* at `(p − 1) * i = e` the series `log` still
    converges, but it is not injective on `U(K,i)`, since a `p`-th root of unity can lie there.
- **Power classes, the primary statement.** For `n : ℕ` with `n ≠ 0`, the primary theorem is an
  equality of natural numbers:

  ```text
  Nat.card (Kˣ ⧸ (powMonoidHom n).range) = n * Nat.card (μ_n(K)) * q ^ v_K(n),
  ```

  where `μ_n(K)` is the group of `n`-th roots of unity in `K`, and `v_K(n) : ℕ` is the normalized
  valuation of the image of `n` in `K`. In regime 1 the hypothesis `IsUnit (n : 𝒪[K])` gives
  `v_K(n) = 0` as a named lemma, and the formula becomes `n · #μ_n(K)`; that case holds in either
  characteristic. In regime 2, with `K/ℚ_p` finite, the formula holds for every `n ≠ 0`, including
  `p ∣ n`; the deep-unit logarithm supplies the `p`-primary factor. Finiteness of the quotient
  follows from the formula, and is not a separate theorem.
  - *Prerequisites:*
    - `Layer 1: structure of Kˣ`;
    - `Layer 1: deep units in mixed characteristic` (regime 2 only);
    - `Layer 0: the normalized valuation`.
  - *Source:* the formula follows from the structure of `Kˣ` above, with the logarithm in regime
    2; compare NSW VII §3. *False generalization:* at `K = 𝔽_q((t))`, `n = p`, the left side is
    infinite, so the equation fails in equal characteristic when `p ∣ n`. The hypothesis
    `IsUnit (n : 𝒪[K])` excludes that case in regime 1, and `char K = 0` excludes it in regime 2.
- **Power classes, the absolute-value form.** After the theorem in `ℕ`, derive
  `#(Kˣ/(Kˣ)ⁿ) = n · #μ_n(K) · ‖n‖_K⁻¹` as an equality in `ℚ≥0`, with the coercion `ℕ → ℚ≥0` named
  in the statement. This form makes the comparison with the Euler characteristic of Layer 8
  possible. It is the only place in this layer where the absolute value occurs.
  - *Prerequisites:*
    - `Layer 1: power classes, the primary statement`;
    - `Layer 0: the normalized valuation`.
- **The power subgroup is open.** For `n : ℕ` with `n ≠ 0`, the primary theorem is

  ```text
  IsOpen ((powMonoidHom n : Kˣ →* Kˣ).range).
  ```

  The name is `isOpen_range_powMonoidHom`. It holds in regime 1 for either characteristic, and in
  regime 2 for every `n`. ⚠ This does **not** follow from the count above. Finiteness of an
  abstract quotient of a topological group says nothing about the topology of the kernel: the
  additive group `ℚ_p` with the discrete topology has finite quotients by non-open subgroups. The
  proof exhibits an open subgroup inside the range:
  - in regime 1, `U(K,1) ⊆ (Kˣ)^n`, by Hensel's lemma applied to `X^n − u` at the approximate
    root `1`. The derivative `n X^{n−1}` is a unit there, because `n` is a unit in `𝒪[K]`, and
    `1 − u ∈ 𝓂[K]` for `u ∈ U(K,1)`;
  - in regime 2, take `i` with `(p − 1) · i > e`. The logarithm of the deep-unit milestone carries
    `x ↦ x^n` on `U(K,i)` to `y ↦ n · y` on `𝓂[K]^i`, and `n · 𝓂[K]^i = 𝓂[K]^{i + v_K(n)}`. So
    `(U(K,i))^n = U(K, i + v_K(n))`, which is open. This covers the `p`-primary case, where the
    argument of regime 1 is unavailable.

  A subgroup of a topological group that contains an open subgroup is open, and is then also
  closed and of finite index.
  - *Prerequisites:*
    - `Layer 1: the unit filtration as an object`;
    - `Layer 1: deep units in mixed characteristic` (regime 2 only);
    - `Mathlib: Hensel's lemma in Mathlib/RingTheory/Henselian.lean` (regime 1 only);
    - `Mathlib: Subgroup.isOpen_of_isOpen_subgroup_le`.
  - *API:*
    - the openness statement in each regime;
    - the containment `U(K,1) ⊆ (Kˣ)^n` in regime 1, and `U(K, i + v_K(n))` inside the range in
      regime 2, as named lemmas, because Layer 7 uses the containment and not only the openness;
    - closedness and finite index of the range;
    - the corollary that every subgroup of `Kˣ` of finite index whose exponent satisfies the
      regime hypothesis is open, which is what Layer 7 consumes.
  - *Source:* Serre LF V §3 and Neukirch ANT II §5. The hypotheses are the regime hypotheses.
    *False generalization:* at `K = 𝔽_q((t))` and `n = p` the range is not open, because
    `1 + t^m` is not a `p`-th power for `p ∤ m` and those elements accumulate at `1`.
- **The dyadic square-class count.** Prove `#(ℚ_2ˣ/(ℚ_2ˣ)²) = 8`. This is an instance of the
  primary statement, and not a separate theorem.
  - *Prerequisites:* `Layer 1: power classes, the primary statement`.
- **Deep units are squares, in mixed characteristic.** Let `K/ℚ_2` be finite, and let
  `e = v_K(2)`. Then `U(K, 2e+1) ⊆ (Kˣ)²`. The threshold is sharp: at `K = ℚ_2`, `e = 1`, and
  `U(K,3) = 1 + 8ℤ_2` consists of squares while `U(K,2)` does not. ⚠ This is **not** an instance
  of the cardinality count, which decides how many square classes there are and not which
  subgroup lies inside the squares. The proof is Hensel's lemma applied to `X² − u`, or the
  deep-unit logarithm with the fact that multiplication by `2` carries the logarithmic lattice at
  depth `2e+1` into the lattice at depth `e+1`. ⚠ The hypothesis is mixed characteristic. In
  equal characteristic `2` the element `2` is zero, `e` is not defined, and the displayed
  statement is a different assertion.
  - *Prerequisites:*
    - `Layer 1: deep units in mixed characteristic`;
    - `Layer 1: the unit filtration as an object`;
    - `Mathlib: Hensel's lemma in Mathlib/NumberTheory/Padics/Hensel.lean`.
  - *Source:* Serre, *A Course in Arithmetic*, II §3, for `ℚ_2`; Neukirch ANT II §5 in general.

### Layer 2: unramified extensions and Frobenius

- **The arithmetic predicate.** Define `IsUnramified K L` for a finite extension of local fields:
  the map of value groups is bijective, equivalently `ramificationIndex K L = 1`, and the residue
  extension `𝓀[L]/𝓀[K]` is separable. Separability is automatic for finite residue fields. Carry
  it in the definition, so that the statement matches the general definition for valued fields and
  survives generalization. Compare the predicate once, as a theorem, with `Algebra.IsUnramifiedAt`
  and `Algebra.FormallyUnramified` over `𝒪[K]`, so that the étale library becomes usable. Do not
  redefine those notions.
  - *Prerequisites:*
    - `Layer 0: e and f, intrinsically`;
    - `Mathlib: Algebra.IsUnramifiedAt`, `Algebra.FormallyUnramified`.
  - *API:*
    - the definition;
    - the equivalence with `e = 1`;
    - stability in towers, in both directions;
    - stability under composita and under base change to an unramified extension;
    - the comparison theorem with the étale notions;
    - the negative instance `ℚ_2(√2)/ℚ_2`, which is ramified.
- **Residue correspondence.** For `L/K` unramified and Galois, prove `Gal(L/K) ≃* Gal(𝓀[L]/𝓀[K])`
  through the machinery of `Mathlib/RingTheory/Invariant/`, with trivial inertia group. Define the
  **Frobenius element** `Frob L/K ∈ Gal(L/K)` as the preimage of `x ↦ x^q`, and prove that
  `Gal(L/K)` is cyclic of order `f`, generated by it.
  - *Prerequisites:*
    - `Layer 2: the arithmetic predicate`;
    - `Layer 0: finite extensions, II`;
    - `Mathlib: Ideal.inertia`, `stabilizer G Q ⧸ inertia G Q ≃* Gal(residue extension)`;
    - `Mathlib: GaloisField` and the Frobenius of a finite field.
  - *API:*
    - the isomorphism and its inverse;
    - `Frob` and its order;
    - functoriality in a tower, that is, restriction of `Frob` to a subextension is `Frob`;
    - compatibility with the Teichmüller section of Layer 1;
    - the action of `Frob` on `μ_{q^f−1}`;
    - the worked case `ℚ_2(√5)/ℚ_2` in the examples section.
- **Existence and uniqueness, stated precisely.** These four statements together replace the
  informal phrase "the unramified extension of degree `f`".
  1. *Inside a fixed algebraic closure.* For every `f ≥ 1` there is exactly one unramified
     intermediate field `K_f` of `AlgebraicClosure K` with `[K_f : K] = f`, namely the splitting
     field of `X^{q^f} − X`, equivalently `K(μ_{q^f−1})`.
  2. *Abstract extensions.* Reduction is an equivalence between the finite unramified extensions
     of `K` and the finite extensions of `𝓀[K]`.
  3. *After a choice of residue data.* A chosen `𝓀[K]`-isomorphism of the residue extensions lifts
     to a unique `K`-isomorphism of the unramified extensions. Without that choice the lift is not
     unique.
  4. *Automorphisms.* `Gal(K_f/K)` is cyclic of order `f`, generated by the arithmetic Frobenius.
     So `K_f` has exactly `f` automorphisms over `K`. The condition of commuting with Frobenius
     selects none of them, because an abelian group is centralized by its own elements. Statement
     3, which fixes the map on residue fields, is the correct rigidity statement.

  Prove also that a compositum of unramified extensions is unramified. Prove that the finite
  unramified subextensions of `K` inside the fixed closure, ordered by inclusion, form a lattice.
  That lattice is isomorphic to the positive integers ordered by divisibility. The statement is
  about the finite subextensions: the maximal unramified extension has infinite intermediate
  fields as well.
  - *Prerequisites:*
    - `Layer 2: residue correspondence`;
    - `Mathlib: GaloisField` and the classification of finite extensions of a finite field;
    - `Mathlib: IntermediateField`.
  - *Source:* Serre LF III §5; Neukirch ANT II §7. *False generalization:* uniqueness of the
    isomorphism holds only after statement 3 fixes the residue map. The phrase "the unique
    unramified extension of degree `f`, with its unique `K`-isomorphism" is false for `f > 1`.
- **The maximal unramified extension.** Define `K^{ur} ⊆ AlgebraicClosure K` as the union of the
  `K_f`. Prove `Gal(K^{ur}/K) ≅ Ẑ`, carrying Frobenius to the canonical topological generator `1`,
  with `Ẑ ≅ lim ℤ/n` built on the completion API of `ProfiniteGrp`. Every unramified coordinate
  below is expressed through this isomorphism, whose target is `Ẑ` and never `ℤ`.
  - *Prerequisites:*
    - `Layer 2: existence and uniqueness`;
    - `Mathlib: profiniteCompletion`, `Mathlib/Topology/Algebra/Category/ProfiniteGrp/`.
  - *API:*
    - the intermediate field `K^{ur}`;
    - the isomorphism to `Ẑ` and its inverse;
    - the image of `Frob`;
    - compatibility with the finite levels;
    - the induced surjection `G_K → Ẑ`, which Layer 4 names;
    - the fixed field of a closed subgroup, in the two directions.
- **Norms.** For `L/K` unramified prove `N_{L/K}(𝒪[L]ˣ) = 𝒪[K]ˣ`, and
  `N_{L/K}(Lˣ) = π^{fℤ} × 𝒪[K]ˣ`. This is the concrete form of the statement that units are
  universal norms in the unramified direction. Layer 5 and Layer 7 both use it.
  - *Prerequisites:*
    - `Layer 2: residue correspondence`;
    - `Layer 1: graded pieces`;
    - `Layer 0: finite extensions, III`.
  - *Source:* Serre LF V §2. The proof is surjectivity on each graded piece, plus completeness.
    *False generalization:* for a ramified extension the norm of a unit is a unit, but the image
    is a proper subgroup: at `L = ℚ_2(√2)` the image of `𝒪[L]ˣ` has index `2` in `ℤ_2ˣ`.

### Layer 3: ramification, the tame and wild cases, and the filtration

- **Totally ramified is equivalent to Eisenstein.** Prove that `e = [L:K]` holds if and only if
  `L = K(π_L)` for a root `π_L` of an Eisenstein polynomial over `𝒪[K]`. Prove also that an
  Eisenstein polynomial is irreducible, and that it generates a totally ramified extension in
  which its root is a uniformizer. Prove the factorization of an arbitrary finite `L/K` as
  `L/L_0/K`, where `L_0/K` is the maximal unramified subextension and `L/L_0` is totally ramified
  of degree `e`.
  - *Prerequisites:*
    - `Layer 0: e and f, intrinsically`;
    - `Layer 2: existence and uniqueness`;
    - `Mathlib: Polynomial.IsEisensteinAt` and its irreducibility results.
  - *API:*
    - the equivalence in both directions;
    - the uniformizer produced by the Eisenstein polynomial;
    - the factorization `L/L_0/K` and its uniqueness;
    - the degree of `L_0/K`, which is `f`;
    - the behaviour of the factorization in a tower.
- **Tame and wild.** Define `IsTamelyRamified K L` by `p ∤ e`, and the totally wildly ramified
  case by `e` a power of `p`. The public theorem about tame extensions is:

  ```text
  If L/K is finite, totally ramified, and tamely ramified of degree e,
  then there are a uniformizer π of K and α ∈ L with α^e = π and L = K(α).
  ```

  The corollaries carry their own hypotheses. `L/K` is Galois exactly when `μ_e ⊆ K`, and then
  `Gal(L/K) ↪ μ_e` by `σ ↦ σ(α)/α`. The proof may enlarge the residue field, prove the statement
  over `K^{ur}`, and descend. That belongs to the proof, and not to the public statement.
  - *Prerequisites:*
    - `Layer 3: totally ramified is equivalent to Eisenstein`;
    - `Layer 2: the maximal unramified extension`;
    - `Layer 1: graded pieces`.
  - *API:*
    - the two predicates;
    - the theorem above;
    - the Galois criterion;
    - the embedding into `μ_e`;
    - stability of tameness in towers and under composita;
    - the degree of the maximal tamely ramified subextension.
  - *Source:* Serre LF IV §2; Neukirch ANT II §7. *False generalization:* in residue
    characteristic `2` every totally ramified quadratic extension is wild. Keep the dyadic
    examples in the test suite, so that a hypothesis `p ∤ e` cannot enter a statement about the
    tame case that is later applied at `p = 2`.
- **The lower-numbering filtration.** For `L/K` finite Galois with group `G`, define `G_i = {σ | ∀
  x : 𝒪[L], v_L(σ x − x) ≥ i + 1}` for `i : ℤ`. The function is total, with `G_i = ⊤` for
  `i ≤ −1`. Equivalently, `σ` acts trivially on `𝒪[L]/𝓂[L]^{i+1}`. Prove that each `G_i` is a
  normal subgroup of `G`, and that the family is antitone. Prove that `G_0` is the inertia group,
  with one comparison lemma to `ValuationSubring.inertiaSubgroup` and one to `Ideal.inertia`.
  Prove that `G_i = 1` for large `i`. Extend to a real index by `G_u := G_{⌈u⌉}` for `u : ℝ` with
  `u ≥ −1`, and prove that the two definitions agree at integers. The Herbrand integral below
  needs `G_t` for real `t`. Prove compatibility with subgroups: `H_i = H ∩ G_i` for
  `H = Gal(L/K')`.
  - *Prerequisites:*
    - `Layer 0: finite extensions, II`;
    - `Layer 0: the normalized valuation`;
    - `Mathlib: ValuationSubring.inertiaSubgroup`, `Ideal.inertia`.
  - *API:*
    - the definition at integer and at real index, with the agreement lemma;
    - normality;
    - antitonicity;
    - the two comparison lemmas at `i = 0`;
    - the finiteness statement `G_i = 1` for large `i`, and the largest jump as a definition;
    - compatibility with subgroups;
    - the failure of compatibility with quotients, which is the next milestone;
    - the computation for `ℚ_2(μ_8)/ℚ_2` in the examples section.
  - *Source:* Serre LF IV §1.
- **Lower numbering is not compatible with quotients.** State this as a theorem with a witness,
  and not as a warning. In `L = ℚ_2(ζ_8)` over `K = ℚ_2`, with `G = (ℤ/8)ˣ` and `H = ⟨σ_7⟩` the
  subgroup generated by `ζ ↦ ζ^{-1}`, so that `L^H = ℚ_2(√2)`, one has `G_3 = ⟨σ_5⟩` and therefore
  `G_3H/H = G/H`, while `(G/H)_3 = 1`, because `v_{ℚ_2(√2)}(σ(√2) − √2) = v_{ℚ_2(√2)}(2√2) = 3`.
  The upper numbering repairs this failure.
  - *Prerequisites:* `Layer 3: the lower-numbering filtration`.
- **The quotient embeddings.** One formula covers every level:
  `θ_i : G_i/G_{i+1} ↪ U(L,i)/U(L,i+1)` by `σ ↦ σ(π_L)/π_L`. Prove injectivity and independence of
  the uniformizer. Composed with the graded pieces of Layer 1 this reads `θ_0 : G_0/G_1 ↪ 𝓀[L]ˣ`,
  the tame character, so `G_0/G_1` is cyclic of order prime to `p`; and
  `θ_i : G_i/G_{i+1} ↪ 𝓀[L]⁺` for `i ≥ 1`, by `σ ↦ (σ(π_L) − π_L)/π_L^{i+1}`, so those quotients
  are elementary abelian `p`-groups. Prove the consequences: `G_1` is the unique `p`-Sylow
  subgroup of `G_0` and is normal, which is wild inertia at finite level; and `G_0` has the cyclic
  tame quotient `G_0/G_1`. Prove the action formula: for `σ ∈ G_0` and `τ ∈ G_i/G_{i+1}`,
  `στσ⁻¹ = θ_0(σ)^i · τ`. This is the finite-level form of the twist in the tame sequence of Layer
  4, and `θ_t` is the constant in the norm computation below.
  - *Prerequisites:*
    - `Layer 3: the lower-numbering filtration`;
    - `Layer 1: graded pieces`.
  - *API:*
    - the embeddings at every level, with injectivity and independence of the uniformizer;
    - the two composed forms;
    - the group-theoretic consequences above;
    - the action formula;
    - naturality under passage to a subgroup `H ≤ G`.
  - *Source:* Serre LF IV §2.
- **Herbrand functions and the upper numbering.** Define `φ_{L/K}(u) = ∫_0^u dt/[G_0 : G_t]` for
  `u ≥ −1`, with the usual convention that the integrand is `[G_t : G_0]` on `[−1, 0]`. Prove the
  analytic facts as milestones: `φ` is continuous, piecewise linear with an explicit finite-sum
  formula, strictly increasing and concave, `φ(0) = 0`, and `φ(u) = u` for `−1 ≤ u ≤ 0`. Define
  `ψ_{L/K} : ℝ → ℝ` as its inverse on `[−1, ∞)`, with `φ ∘ ψ = id` and `ψ ∘ φ = id` there. Prove
  that `ψ` carries the jumps of the upper filtration to the jumps of the lower one. The upper
  numbering is `G^u := G_{ψ(u)}`, with the real-index groups above. Two theorems justify it:
  **Herbrand's theorem** `(G/H)^u = G^u H/H`, and transitivity in a tower `M/L/K`, which is
  `φ_{M/K} = φ_{L/K} ∘ φ_{M/L}` for `φ` and `ψ_{M/K} = ψ_{M/L} ∘ ψ_{L/K}` for `ψ`. State both
  orders: inverting a composite reverses it, and the two orders differ as soon as one step of the
  tower is wild. The upper numbering is defined here because Layer 7 needs it for the conductor
  and for the compatibility with reciprocity.
  - *Prerequisites:*
    - `Layer 3: the lower-numbering filtration`;
    - `Mathlib: intervalIntegral` and the API for piecewise linear monotone functions.
  - *API:*
    - the two functions;
    - continuity, monotonicity, concavity, and the values at `0`;
    - the finite-sum formula at integers;
    - the inverse relations;
    - the image of a jump;
    - the upper numbering as a filtration, with normality and antitonicity;
    - Herbrand's theorem;
    - the two transitivity statements;
    - the computation for `ℚ_2(μ_8)/ℚ_2` in the examples section.
  - *Source:* Serre LF IV §3.
- **Herbrand values as unit depths.** `φ` takes non-integral values at integers: in `ℚ_2(μ_8)/ℚ_2`
  below, `φ(2) = 3/2`. Its inverse does not. Prove that `ψ_{L/K}(n)` is a natural number for every
  `n : ℕ`, and package the proof as `ψℕ_{L/K} : ℕ → ℕ`, with the characterizing lemma
  `(ψℕ_{L/K} n : ℝ) = ψ_{L/K} n`. This is the only conversion from a Herbrand value to a unit
  depth in this roadmap. Every index of `U(K, −)` and of `U(L, −)` below is a literal natural
  number or a value of `ψℕ`, and `φ` never indexes a unit group. The proof is the piecewise
  formula with Lagrange's theorem: write `g_i = #G_i`, and take `t` to be the largest jump with
  `φ(t) ≤ n`; then `ψ(n) = t + (g_0·n − ∑_{i=1}^{t} g_i) / g_{t+1}`, and `g_{t+1}` divides `g_0`
  and every `g_i` with `i ≤ t`, because the filtration is decreasing.
  - *Prerequisites:* `Layer 3: Herbrand functions and the upper numbering`.
  - *API:*
    - the function `ψℕ`;
    - the characterizing lemma;
    - `ψℕ 0 = 0`;
    - monotonicity;
    - `n ≤ ψℕ n`;
    - transitivity `ψℕ_{M/K} = ψℕ_{M/L} ∘ ψℕ_{L/K}`, in the order inherited from the real-valued
      statement;
    - the closed form in the cyclic prime-degree case, which is `ψℕ v = v` for `v ≤ t` and
      `ψℕ v = t + ℓ(v − t)` for `v ≥ t`.
- **The norm on the unit filtration.** ⚠ `N_{L/K}(U(L,i)) ⊆ U(K,i)` is **false** for a ramified
  extension `L/K`. In a tame quadratic extension in residue characteristic `3`, the norm of an
  element of `U(L,2)` is outside `U(K,2)`; the examples section has the computation. The true
  inclusion carries a Herbrand shift, which no milestone may remove. Each item names its consumer.
  1. *The norm on valuations and on units, for any finite `L/K`.* `v_K(N_{L/K}(x)) = f · v_L(x)`
     for `x : Lˣ`. Therefore `N_{L/K}(𝒪[L]ˣ) ⊆ 𝒪[K]ˣ`, which is `N_{L/K}(U(L,0)) ⊆ U(K,0)`. If
     `L/K` is totally ramified, `N_{L/K}(π_L)` is a uniformizer of `K`. This is the basic API of
     the norm at a local field. The last part fixes the coordinate on the target of the graded
     maps in item 4.
  2. *The Herbrand-shifted inclusion, for `L/K` finite Galois.*
     `N_{L/K}(U(L, ψℕ_{L/K}(i))) ⊆ U(K, i)` for every `i : ℕ`. Both depths are natural numbers,
     because `ψℕ` is. The unshifted corollary is `N_{L/K}(U(L,i)) ⊆ U(K, ⌊φ_{L/K}(i)⌋)`, which
     follows from `ψ(⌊φ(i)⌋) ≤ i`. The conductor of Layer 7, and its compatibility statement
     `Art_K(U(K,n)) = (G_K^{ab})^{(n)}`, consume the shifted form.
  3. *Unramified `L/K`.* `N_{L/K}(U(L,i)) = U(K,i)` for every `i : ℕ`, an equality, and here `ψℕ`
     is the identity. The case `i = 0` is the norm surjectivity of Layer 2. The vanishing
     `Hⁱ(Gal(L/K), 𝒪[L]ˣ) = 0` of Layer 5 is the cohomological form of the same computation.
  4. *Cyclic totally ramified of prime degree `ℓ`: the graded maps.* Write `G = ⟨σ⟩`, and let
     `t ≥ 0` be the unique jump, so that `G_i = G` for `i ≤ t` and `G_i = 1` for `i > t`. Then
     `t = 0` holds exactly in the tame case `ℓ ≠ p`, where the Galois hypothesis forces `μ_ℓ ⊆ K`
     and therefore `ℓ ∣ q − 1`. Coordinatize the graded pieces by a uniformizer `π_L` and by
     `π_K = N_{L/K}(π_L)`. The norm induces `gr_v N : U(L, ψℕ v)/U(L, ψℕ v + 1) → U(K, v)/U(K,
     v+1)`. The milestone is the computation of that map in the four cases that occur:
     - `v = t = 0`, the tame case: `y ↦ y^ℓ` on `𝓀ˣ`, with kernel and cokernel `μ_ℓ(𝓀)` of order
       `ℓ`, by `ℓ ∣ q − 1`;
     - `v = 0 < t`, so `ℓ = p`: `y ↦ y^p` on `𝓀ˣ`, the Frobenius of a finite field, bijective;
     - `0 < v < t`, which again forces `ℓ = p`: `y ↦ y^p` on `𝓀⁺`, Frobenius again, bijective;
     - `v = t > 0`: the additive map `y ↦ y^ℓ − c^{ℓ−1}·y` on `𝓀⁺`, where `c = θ_t(σ) ∈ 𝓀ˣ` is the
       value at a generator `σ` of `G` of the level-`t` embedding `θ_t` above. The map is
       `𝔽_ℓ`-linear, with kernel the line `𝔽_ℓ·c` and cokernel of order `ℓ`.

     ⚠ The exponent on `c` is not a slip. The element `c` changes when the generator `σ` changes,
     and `c^{ℓ−1}` does not, because `λ^{ℓ−1} = 1` for `λ ∈ 𝔽_ℓˣ`. A version with a bare `c` would
     make the kernel depend on the choice of `σ`, which the norm map cannot see. In summary:
     `gr_v N` is bijective for `v ≠ t`, and at `v = t` its kernel and its cokernel both have order
     `ℓ`.
  5. *The consequences of item 4, for the same extensions.* `N_{L/K}(U(L, ψℕ v)) = U(K,v)` for
     every `v > t`, by successive approximation from item 4 and completeness. `[U(K,v) :
     N_{L/K}(U(L, ψℕ v)) · U(K,v+1)] = ℓ` for `v = t`, and `= 1` for `v ≠ t`. Multiplication up
     the filtration then gives `[𝒪[K]ˣ : N_{L/K}(𝒪[L]ˣ)] = ℓ`. The induction for Hasse–Arf
     consumes item 4 and these indices, and the conductor of a cyclic extension of prime degree is
     `c(L/K) = t + 1`.
  - *Prerequisites:*
    - `Layer 3: Herbrand values as unit depths`;
    - `Layer 3: the quotient embeddings`;
    - `Layer 1: graded pieces`;
    - `Layer 2: norms` (for item 3);
    - `Layer 0: e and f, intrinsically`.
  - *Source:* Serre LF V §2 for item 3, Serre LF V §3 for item 4, and Serre LF V §6 for item 2.
    *False generalization:* the unshifted inclusion in item 2, which the counterexample in the
    examples section refutes.
- **Hasse–Arf.** For `G` abelian, the jumps of the upper-numbering filtration are integers.
  - *Prerequisites:*
    - `Layer 3: the norm on the unit filtration` (items 4 and 5);
    - `Layer 3: Herbrand functions and the upper numbering` (transitivity of `φ`, which reduces
      the general abelian case to the cyclic case of prime degree).
  - *Source:* Serre LF V §7. The hypothesis is that `G` is abelian. *False generalization:* for
    `G` non-abelian the jumps of the upper numbering need not be integers; the quaternion
    extension in Serre LF IV §3, exercise 3, is the standard witness.
- **The different and the discriminant.** Let `L/K` be finite separable. Define the different
  `𝔡_{L/K} ⊆ 𝒪[L]` from the trace form, as the inverse of the trace dual of `𝒪[L]`. Compare it
  with `differentIdeal` of Mathlib. Define the discriminant `𝔩_{L/K} = N_{L/K}(𝔡_{L/K}) ⊆ 𝒪[K]`,
  which is an ideal of the base. The two are not to be conflated. Prove: `𝔡_{L/K} = 𝒪[L]` if and
  only if `L/K` is unramified; for `L/K` Galois, `v_L(𝔡_{L/K}) = ∑_{i≥0} (#G_i − 1)`; and in the
  tame case `v_L(𝔡_{L/K}) = e − 1`. The trace-dual definition comes before the valuation formula,
  which needs `L/K` Galois.
  - *Prerequisites:*
    - `Mathlib: differentIdeal`, `Mathlib/RingTheory/Trace/`;
    - `Layer 3: the lower-numbering filtration`;
    - `Layer 0: finite extensions, III`.
  - *API:*
    - the two ideals;
    - the comparison lemma with `differentIdeal`;
    - multiplicativity in a tower;
    - the unramified criterion;
    - the valuation formula in the Galois case;
    - the tame value;
    - the value for `ℚ_2(√2)/ℚ_2`, which is `3`.
  - *Source:* Serre LF III §§3–6 for the different and the discriminant, and Serre LF IV §1 for
    the valuation formula, which needs `L/K` Galois.

### Layer 4: the tame quotient of the absolute Galois group

- **The ambient model, fixed once.** Use `G_K := Field.absoluteGaloisGroup K` with the Krull
  topology, in every public statement and in every characteristic. Prove once, as a comparison
  theorem, that the restriction `Gal(AlgebraicClosure K / K) → Gal(separableClosure K / K)`, that
  is `separableClosure.algEquivOfAlgEquiv`, is an isomorphism of topological groups. A proof that
  is more convenient over a separable closure may then transport along it. No theorem below
  chooses its own model. Every infinite subextension, that is `K^{ur}`, `K^{t}`, and `K^{ab}`, is
  an `IntermediateField K (AlgebraicClosure K)`. Inertia, wild inertia, and the unramified
  quotient are the corresponding closed subgroups and quotients, and are named as such.
  - *Prerequisites:* `Mathlib: Field.absoluteGaloisGroup`, `separableClosure.algEquivOfAlgEquiv`,
    `Mathlib/FieldTheory/KrullTopology.lean`.
  - *API:*
    - the comparison isomorphism, with continuity in both directions;
    - the transport lemmas for subgroups and for quotients;
    - the profinite structure;
    - the correspondence between closed subgroups and intermediate fields, specialized to the
      three named fields.
- **Inertia.** Define `I_K = Gal(Kˢ/K^{ur})`, and prove that it is closed and normal. Prove the
  exact sequence `1 → I_K → G_K → Ẑ → 1`, with the surjection of Layer 2, and construct the
  arithmetic Frobenius lifts.
  - *Prerequisites:*
    - `Layer 2: the maximal unramified extension`;
    - `Layer 4: the ambient model`.
  - *API:*
    - the subgroup and its properties;
    - the exact sequence;
    - existence of a Frobenius lift and the description of the set of lifts as a coset of `I_K`;
    - functoriality in a finite extension of `K`;
    - the image of `I_K` in a finite quotient, which is `G_0` of Layer 3.
- **Wild inertia.** Define `P_K = Gal(Kˢ/K^{t})`, where `K^{t} = ⋃_{p ∤ m} K^{ur}(π^{1/m})` is the
  maximal tamely ramified extension. Prove that `P_K` is the inverse limit of the finite-level
  `G_1`. Prove that it is a closed normal pro-`p` subgroup of `G_K`. Prove that it is the unique
  maximal such subgroup of `I_K`, that is, its pro-`p` Sylow subgroup. Sylow theory for profinite
  groups is free of Galois vocabulary, and this roadmap does not restate it in that vocabulary.
  What is proved here is the identification of that Sylow subgroup with `Gal(Kˢ/K^t)`.
  - *Prerequisites:*
    - `Layer 3: tame and wild`;
    - `Layer 4: inertia`;
    - `Mathlib: Subgroup.normalClosure`, `OpenNormalSubgroup`.
  - *Supplied hypotheses:* the four Sylow theorems of `Supplied.ProPOps`, that is existence, the
    containment of every closed pro-`p` subgroup in one, uniqueness of a normal one, and the image
    under a continuous surjection. The predicate `Supplied.IsProPSylow` is a definition and not a
    hypothesis.
  - *API:*
    - the field `K^{t}` and the subgroup `P_K`;
    - the pro-`p` property;
    - the limit description;
    - the Sylow identification;
    - the image of `P_K` in a finite quotient, which is `G_1` of Layer 3.
- **The tame character and the twist.** Prove `I_K/P_K ≅ lim_{p∤m} μ_m(Kˢ) = Ẑ^{(p')}(1)`, by
  `σ ↦ (σ(π^{1/m})/π^{1/m})_m`. Prove independence of the choices, and `G_K`-equivariance:
  conjugation acts through the cyclotomic action on the right-hand side. ⚠ The notation
  `Ẑ^{(p')}(1)` is *defined* here, as the prime-to-`p` Tate module of `μ`. As a profinite group it
  is `∏_{ℓ ≠ p} ℤ_ℓ`, and the `(1)` is the equivariance statement.
  - *Prerequisites:*
    - `Layer 4: wild inertia`;
    - `Layer 3: the quotient embeddings`;
    - `Mathlib: rootsOfUnity`, `Mathlib/Topology/Algebra/Category/ProfiniteGrp/Limits.lean`.
  - *API:*
    - the object `Ẑ^{(p')}(1)`;
    - the isomorphism and its inverse;
    - independence of the choice of `π` and of the compatible system of roots;
    - the equivariance statement;
    - the finite-level form, which is the action formula of Layer 3;
    - the specialization at one prime `ℓ ≠ p`.
- **The Iwasawa presentation.** Prove that the tame quotient `G_K^{t} = G_K/P_K` sits in a split
  exact sequence `1 → Ẑ^{(p')}(1) → G_K^{t} → Ẑ → 1`; that a Frobenius lift `σ` and a topological
  generator `τ` of the kernel satisfy `σ τ σ⁻¹ = τ^q`; and that `G_K^t` is the profinite group on
  `σ` and `τ` with that single relation. State the presentation through its universal property. It
  is a continuous surjection from the free profinite group on two generators. Its kernel is the
  closed normal closure of the relator. That is, state it as `presentedProfiniteGroup (Fin 2) {σ τ
  σ⁻¹ τ^{−q}}`, with `σ` and `τ` the images of `freeProfiniteGroup.of 0` and
  `freeProfiniteGroup.of 1`. ⚠ The object needed here is the **profinite** one. The presented
  pro-`p` group of the same shape is its pro-`p` quotient, which forgets the prime-to-`p` tame
  inertia that this presentation is about, so it is a different group.
  - *Prerequisites:*
    - `Layer 4: the tame character and the twist`;
    - `Mathlib: ProfiniteGrp.profiniteCompletion`, `FreeGroup`, `Subgroup.normalClosure`, and
      `Subgroup.topologicalClosure`. `Supplied.freeProfiniteGroup` and
      `Supplied.presentedProfiniteGroup` are definitions built from these, with no `sorry`.
  - *Supplied hypotheses:* the universal property of the free profinite group,
    `ProPOps.freeProfiniteGroupLift`, with its uniqueness clause.
  - *Source:* NSW (7.5.2) and (7.5.3), after Iwasawa. The hypotheses are that `K` is a
    nonarchimedean local field with finite residue field of order `q`. *False generalization:* the
    analogous presentation of `G_K` itself is false; `G_K` is not 2-generated, and Layer 9
    computes its rank as `[K:ℚ_p] + 2`.
- **Translation lemmas.** Prove the presentation with a geometric `σ`, through `σ ↦ σ⁻¹`. Prove
  the finite-level compatibility: the restriction of the sequence to a finite tame quotient
  recovers the twist formula of Layer 3. Two statements face reciprocity: units land in inertia,
  and a uniformizer maps to the Frobenius coordinate. Both are theorems of Layer 7, and neither is
  an assumption here. This layer supplies only the group-theoretic frame in which they are stated.
  - *Prerequisites:*
    - `Layer 4: the Iwasawa presentation`;
    - `Layer 3: the quotient embeddings`.

### Layer 5: cohomology of local fields, part one, the invariant map and the class formation

Finite-level statements use `groupCohomology` and `tateCohomology` of Mathlib directly. They need
nothing outside Mathlib, and can be built first. Statements about `G_K` use the continuous
theory. Mathlib `v4.32.2` supplies the continuous cochain complex in `ContCohomology`, together
with compatible-pair functoriality, but not the colimit description over finite Galois quotients,
not corestriction, and not cup products. Those three are fields of `Supplied.CohomologyOps`.

- **Hilbert 90, at both levels.** The finite level is `H1ofAutOnUnitsUnique` of Mathlib. Restate
  it as `H¹(Gal(L/K), Lˣ) = 0` in the chosen cohomology API, and derive `H¹(G_K, (Kˢ)ˣ) = 0`
  from the colimit description.
  - *Prerequisites:* `Mathlib: groupCohomology.H1ofAutOnUnitsUnique`.
  - *Proof obligations:* the finite-quotient colimit, in degrees `≤ 2`. It occurs in the proof,
    and in no statement, so it is not a hypothesis of the milestone.
- **Kummer theory.** Let `char K ∤ n`. Prove `Kˣ/(Kˣ)ⁿ ≅ H¹(G_K, μ_n)`, through the Kummer cocycle
  `a ↦ (σ ↦ σ(a^{1/n})/a^{1/n})`, from the `n`-th power sequence and Hilbert 90. Keep the
  `μ_n`-twist. Trivialize it only under the extra hypothesis `μ_n ⊆ K`. With the cardinality
  formula of Layer 1 for the regime in question, this computes `#H¹(G_K, μ_n)`. The isomorphism is
  `kummerEquiv`, and the square that relates Kummer classes to the cup product is
  `cup_kummerEquiv`. Both are exports of this roadmap, consumed by Layer 8C below and by the
  downstream table, so neither may be restated at a use site.
  - *Prerequisites:*
    - `Layer 5: Hilbert 90`;
    - `Layer 1: power classes, the primary statement`;
    - `Mathlib: rootsOfUnity`, `IsPrimitiveRoot`.
  - *Supplied hypotheses:* `CohomologyOps.tensorObj`, `CohomologyOps.cup`, and
    `CohomologyOps.coeff`, for the square `cup_kummerEquiv` only. The isomorphism `kummerEquiv`
    uses none of them.
  - *API:*
    - the isomorphism, in both directions;
    - the restriction square: for a finite separable `L/K` inside `Kˢ`, restriction on `H¹`
      corresponds to the inclusion of power classes `Kˣ/(Kˣ)ⁿ → Lˣ/(Lˣ)ⁿ`;
    - the corestriction square: corestriction corresponds to the field norm `N_{L/K}`;
    - the compatibility along `μ_n ⊆ μ_{nm}`;
    - the cup-product square `cup_kummerEquiv`;
    - the cardinality corollary;
    - the trivialized form under `μ_n ⊆ K`;
    - the value at `n = 2` over `ℚ_2`, in the examples section.
  - ⚠ **The coefficients of the cup product of two Kummer classes.** The cup product of two
    classes of `H¹(G_K, μ_n)` lands in `H²(G_K, μ_n ⊗ μ_n)`, and not in `H²(G_K, μ_n)`.
    Multiplication `μ_n × μ_n → μ_n` is not biadditive: written additively it would need
    `(x₁ + x₂) + y = (x₁ + y) + (x₂ + y)`, which fails by one copy of `y`. So `μ_n` is not a
    coefficient target for a cup product of two `μ_n`-classes, and the tensor square is. Two
    reductions to a `μ_n`-valued symbol exist, and each carries its own datum:
    - a choice of primitive `n`-th root of unity `ζ ∈ K` gives `μ_n ≅ ZMod n` and hence
      `μ_n ⊗ μ_n ≅ μ_n`. The isomorphism depends on `ζ`, so `ζ` is an argument of every statement
      that uses it;
    - at `n = 2` the identification is canonical, because `μ_2 = {±1} ≅ ZMod 2` needs no choice,
      and `ZMod 2 ⊗ ZMod 2 ≅ ZMod 2`. That is why Layer 8C states the Hilbert symbol with no
      chosen root of unity, while a general `n` cannot.
- **The Herbrand quotient.** Define `h(G, M) = #H²/#H¹` for finite cyclic `G`, on top of the
  periodicity in `FiniteCyclic` and of `tateCohomology`. Prove multiplicativity in a short exact
  sequence, `h = 1` on a finite module, and the two computations `h(Gal(L/K), Lˣ) = [L:K]` and
  `h(Gal(L/K), 𝒪[L]ˣ) = 1` for cyclic `L/K`. The second comes from a cohomologically trivial open
  `G`-stable subgroup of `𝒪[L]ˣ`. Scale a normal basis element by a high power of `π_L`. This
  produces an open `G`-stable sublattice of `𝒪[L]` that is free over `𝒪[K][G]`; note that `𝒪[L]`
  itself is free only in the tame case. Carry that lattice into the unit filtration. With `h = 1`
  on the finite quotient this gives the second computation. The first then follows from the second
  and from the valuation sequence `0 → 𝒪[L]ˣ → Lˣ → ℤ → 0` of Layer 0.
  - *Prerequisites:*
    - `Mathlib: groupCohomology.FiniteCyclic`, `tateCohomology`;
    - `Layer 1: the unit filtration as an object`;
    - `Layer 0: the normalized valuation`.
  - *API:*
    - the definition and its independence of the generator of `G`;
    - multiplicativity in short exact sequences;
    - the value `1` on finite modules;
    - the two computations;
    - the effect of passing to a subgroup;
    - the value for `ℚ_2(√2)/ℚ_2`, which is `2` on `Lˣ` and `1` on `𝒪[L]ˣ`.
  - *Source:* Serre LF VIII §4 for the Herbrand quotient, and Serre LF V §1 for the lattice
    argument. Neither computation uses the norm package of Layer 3; those theorems are for
    Hasse–Arf and for the conductor.
- **Unramified cohomology.** Let `L/K` be unramified, hence cyclic and generated by Frobenius.
  Prove `Hⁱ(Gal(L/K), 𝒪[L]ˣ) = 0` for `i ≥ 1`, from the filtration, the vanishing over a finite
  field, and completeness. Derive `H²(Gal(L/K), Lˣ) ≅ H²(Gal(L/K), ℤ) ≅ ℤ/[L:K]` through the
  valuation sequence. Define the **unramified invariant map** with the normalization of the
  conventions table, prove its compatibility with inflation up the unramified tower, and derive
  `H²(Gal(K^{ur}/K), (K^{ur})ˣ) ≅ ℚ/ℤ`.
  - *Prerequisites:*
    - `Layer 2: residue correspondence`;
    - `Layer 3: the norm on the unit filtration` (item 3);
    - `Layer 5: the Herbrand quotient`;
    - `Layer 2: the maximal unramified extension`.
  - *API:*
    - the vanishing statement in every degree `i ≥ 1`;
    - the two isomorphisms;
    - the invariant map at each finite level, with its normalization lemma at Frobenius;
    - compatibility with inflation;
    - the colimit form over the unramified tower.
- **Local Galois groups are solvable.** Let `L/K` be finite Galois with group `G`. In the chain
  `G ⊇ G_0 ⊇ G_1 ⊇ 1` of Layer 3, the quotient `G/G_0` is cyclic, the quotient `G_0/G_1` is
  cyclic, and `G_1` is a `p`-group. Therefore `G` is solvable.
  - *Prerequisites:*
    - `Layer 3: the quotient embeddings`;
    - `Layer 2: residue correspondence`.
- **Induction from the cyclic case to an arbitrary finite Galois extension.** Let `N ⊴ G` with
  `G/N` cyclic and `L^N = K'`. Inflation and restriction, with `H¹(N, Lˣ) = 0` from Hilbert 90,
  give the exact sequence `0 → H²(Gal(K'/K), K'ˣ) → H²(G, Lˣ) → H²(N, Lˣ)`, and therefore `#H²(G,
  Lˣ) ≤ #H²(Gal(K'/K), K'ˣ) · #H²(N, Lˣ)`. With solvability and the cyclic bound
  `#H²(Gal(L/K), Lˣ) ≤ [L:K]`, this gives `#H²(Gal(L/K), Lˣ) ≤ [L:K]` for **every** finite Galois
  `L/K`.
  - *Prerequisites:*
    - `Layer 5: local Galois groups are solvable`;
    - `Layer 5: Hilbert 90`;
    - `Layer 5: the Herbrand quotient`;
    - `Mathlib: groupCohomology.map` and `groupCohomology.H1InfRes`, of
      `RepresentationTheory/Homological/GroupCohomology/Functoriality.lean`. This milestone is at
      finite level, so the restriction and inflation of Mathlib suffice.
- **`Br(K)` is unramified.** Prove that every class in `H²(G_K, (Kˢ)ˣ)` is inflated from the
  unramified tower, and therefore `H²(G_K, (Kˢ)ˣ) ≅ ℚ/ℤ`. That isomorphism is the **invariant map**
  `inv_K`. The proof combines the upper bound of the previous milestone with the unramified lower
  bound. Prove the functoriality statements `inv_{K'} ∘ res = [K':K] · inv_K` and
  `inv ∘ cores = inv`.
  - *Prerequisites:*
    - `Layer 5: unramified cohomology`;
    - `Layer 5: induction from the cyclic case`;
    - `Mathlib: continuousCohomology` and the compatible-pair `cochainsMap` of
      `RepresentationTheory/Homological/ContCohomology/Functoriality.lean`, from which restriction
      and inflation on `continuousCohomology` are a short derivation.
  - *Proof obligations:* corestriction and the finite-quotient colimit. ⚠ Mathlib `v4.32.2` has
    no corestriction for group cohomology. `GroupHomology/Functoriality.lean` has a corestriction
    for group *homology*, which is a different map.
  - *API:*
    - the map `inv_K`, with injectivity and surjectivity;
    - the two functoriality squares, written out: `inv_L(res α) = [L:K] · inv_K(α)` for a finite
      separable `L/K` inside `Kˢ`, and `inv_K(cor β) = inv_L(β)`;
    - the value on the class of a cyclic algebra;
    - the restriction to the `n`-torsion, which is Layer 8A;
    - the normalization lemma at an unramified class.
  - ⚠ There is no canonical map between separately chosen separable closures, so every
    compatibility above fixes one `Kˢ` and an embedding `L ↪ Kˢ`. "Natural in `K`" is not a
    statement; a named square with its embedding is.
- **The finite class-formation structure.** Define the interface before any instance of it, so
  that Layer 5 needs nothing from Layer 6. For a finite group `G` and a `G`-module `M`, the
  structure `FiniteClassFormation` carries a distinguished class `σ_G ∈ H²(G, M)`, a distinguished
  class `σ_H ∈ H²(H, M)` for every subgroup `H ≤ G`, and these five fields:
  1. `H¹(H, M) = 0` for every `H ≤ G`;
  2. `H²(H, M)` is cyclic of order `Nat.card H`, generated by `σ_H`;
  3. `res^G_H σ_G = σ_H`;
  4. `res^H_{H'} σ_H = σ_{H'}` for `H' ≤ H ≤ G`;
  5. `cor^G_H σ_H = [G : H] • σ_G`.

  ⚠ The order in field 2 is `Nat.card H`, and never the index `[G : H]`. The trivial subgroup
  refutes the index form at once: `H²(1, M) = 0` has order `1`, while `[G : 1] = Nat.card G`. The
  local model is the reason: for `G = Gal(L/K)`, `M = Lˣ` and `H = Gal(L/E)`, the group
  `H²(H, M)` is `Br(L/E)`, which is cyclic of order `[L : E] = Nat.card H`, while `[G : H]` is
  `[E : K]`. Fields 3 and 5 are then forced by the two scaling laws of `inv`: restriction
  multiplies the invariant by `[G : H]`, so `inv_H(res σ_G) = [G:H] / Nat.card G = 1 / Nat.card H`,
  and corestriction preserves it, so `inv_G(cor σ_H) = 1 / Nat.card H = [G:H] · inv_G(σ_G)`.

  The home of the structure is
  `TauCeti/RepresentationTheory/Homological/GroupCohomology/ClassFormation/`, because it is about
  finite groups. Nothing in it mentions a local field.
  - *Prerequisites:*
    - `Mathlib: groupCohomology`, `tateCohomology`;
    - `Mathlib: groupCohomology.map` of
      `RepresentationTheory/Homological/GroupCohomology/Functoriality.lean`, for restriction.
  - *Proof obligations:* corestriction on `Ĥ²`. ⚠ It is data of the structure, so it does not
    block the definition. Pinning it to the corestriction of group cohomology is a Layer 6
    obligation. The law that this layer states about it is `res_comp_cor`.
  - *API:*
    - the structure and its five fields;
    - restriction of the structure to a subgroup, that is `FiniteClassFormation H M` from
      `FiniteClassFormation G M`;
    - inflation to a quotient;
    - uniqueness of the distinguished class given its invariant;
    - the order of `H²(H, M)` as a corollary of field 2, and the vanishing `H²(1, M) = 0`;
    - the induced map on `Ĥ⁰`, which Layer 6 turns into reciprocity.
  - *Source:* Artin–Tate, *Class Field Theory*, Ch. XIV; Serre LF XI §3; NSW (3.1.11). The
    hypotheses are the five fields on **every** subgroup. *False generalization:* `H²(H, M)`
    cyclic of order `[G : H]`, which `H = 1` refutes.
- **Fundamental classes and the class formation.** Define `u_{L/K} ∈ H²(Gal(L/K), Lˣ)` as the
  class with `inv = 1/[L:K]`. The pair of statements `H¹(H, Lˣ) = 0` and `H²(H, Lˣ)` cyclic of
  order `Nat.card H` for every `H ≤ Gal(L/K)`, with compatible invariant maps, is the
  **class-formation structure** on `(G_K, (Kˢ)ˣ)`. Instantiating field 2 of the structure above at
  `H = Gal(L/E)` is the statement that `Br(L/E)` is cyclic of order `[L : E]`. At
  a single finite level use the class-formation structure of the milestone above. State the
  profinite-level formation, that is all layers at once with invariant maps into `ℚ/ℤ`, on top of
  the finite-level instances. Record for each later theorem which of the two it consumes. No part
  of this construction uses Tate–Nakayama, which is Layer 6.
  - *Prerequisites:*
    - `Layer 5: the finite class-formation structure`;
    - `Layer 5: Br(K) is unramified`;
    - `Layer 5: Hilbert 90`.
  - *API:*
    - the class `u_{L/K}` and its characterization;
    - compatibility in a tower, that is inflation and restriction of fundamental classes;
    - the finite-level instance;
    - the profinite-level formation;
    - the value of `inv` on `u_{L/K}`.

⚠ No milestone of this layer may be proved from reciprocity, from the existence theorem, or from
local duality. The dependency order is: solvability, then the induction, then the invariant map,
then the fundamental class, then the class formation, then Tate–Nakayama, then reciprocity. A
proof that takes a shortcut through a later layer is circular.

### Layer 6: Tate–Nakayama and finite-level reciprocity

The abstract theorem of this layer is about finite groups, and not about local fields. The
generic cohomological operations, that is comparison maps, exact sequences, corestriction,
Shapiro, and ordinary cup products, are the fields of `Supplied.CohomologyOps`. This roadmap owns
the Tate cup product in all integer bidegrees and Tate–Nakayama, because local reciprocity is the
theory that needs them.
The class-formation structure they use is defined in Layer 5. Their home
is `TauCeti/RepresentationTheory/Homological/GroupCohomology/ClassFormation/`, where any other
development with a class formation can use them. `TauCeti/NumberTheory/LocalField/` then
constructs the local fundamental class, instantiates the generic structure, and specializes.

- **The Tate cup product, in all integer bidegrees.** Tate–Nakayama needs cup product with a
  class in `Ĥ²`, acting on `Ĥ^r` for **every** integer `r`, including negative `r`. An ordinary
  cup product does not provide that, in low degrees or in all bidegrees, because ordinary
  cohomology has no negative degree. Mathlib `v4.32.2` has no Tate cup product. So it is a
  milestone here. Construct it from a
  complete resolution, and prove compatibility with the periodicity isomorphism of a finite
  cyclic group, with restriction, and with corestriction. An Ext or dimension-shifting
  construction is an acceptable substitute, provided it is stated in all integer degrees and
  compared with the `r = −2` norm-residue map.
  - *Prerequisites:*
    - `Mathlib: tateCohomology`, and the complete resolution behind it;
    - `Mathlib: Rep.tensor`, for the coefficient object of the pairing.
  - *Supplied hypotheses:* an ordinary cup product, for the comparison in non-negative degrees
    only. It is an explicit argument of `tateCup_agrees_ordinary`, and the construction of the
    Tate cup product itself uses none.
  - *API:*
    - the pairing `Ĥ^r(G, A) × Ĥ^s(G, B) → Ĥ^{r+s}(G, A ⊗ B)`, for integers `r` and `s`;
    - the two induced additive homomorphisms, one in each variable;
    - biadditivity, the unit of `Ĥ⁰(G, ℤ)` on each side, associativity, and graded commutativity;
    - compatibility with restriction, corestriction, and inflation, with the projection formula
      `cor(res x ⌣ y) = x ⌣ cor y`;
    - agreement with the ordinary cup product in non-negative degrees;
    - the specialization `tateCupSigma`, cup product with a class of `Ĥ²`, **defined from** the
      pairing above and never independently of it;
    - the map whose bijectivity is Tate–Nakayama, that is `tateCupSigma` followed by the
      coefficient isomorphism `ℤ ⊗ M ≅ M`.
  - ⚠ A family of additive maps `Ĥ^r(G, ℤ) → Ĥ^{r+2}(G, M)` of the right type is not a cup
    product, and supports no part of the theorem below. The laws are what make the family usable.
    So the specialization is a definition, and the laws are theorems about it.
- **Duality for Tate cohomology of a finite group.** Let `G` be finite and let `A` be a finite
  `G`-module. Put `A^D = Hom(A, ℚ/ℤ)` with the contragredient action. Cup product induces a
  pairing of finite groups

  ```text
  Ĥ^r(G, A) × Ĥ^{−r−1}(G, A^D) → Ĥ^{−1}(G, ℚ/ℤ) ≅ ZMod (Nat.card G),
  ```

  and the theorem is that it is perfect for every integer `r`. This is a statement about finite
  groups. It uses no class formation, and its home is the directory named above. ⚠ Layer 8 does
  not obtain local duality from this by a formal step. The local dual is `Hom(M, μ_n)` and not
  `Hom(M, ℚ/ℤ)`, and the two agree only when the field contains `μ_n`. What Layer 8 takes from
  here is the finite-level input and the shape of the dévissage.
  - *Prerequisites:*
    - `Layer 6: the Tate cup product, in all integer bidegrees`;
    - `Mathlib: tateCohomology`.
  - *API:*
    - the pairing, and the induced map `Ĥ^{−r−1}(G, A^D) → Hom(Ĥ^r(G, A), ℚ/ℤ)`;
    - bijectivity of that map;
    - the identification `Ĥ^{−1}(G, ℚ/ℤ) ≅ ZMod (Nat.card G)`;
    - naturality in `A`, and compatibility with restriction and corestriction;
    - the case `r = 0`, which is the one Layer 8 cites.
  - *Source:* Cassels–Fröhlich IV §7, after Tate; Brown, *Cohomology of Groups*, VI §7. The
    hypotheses are `G` finite and `A` finite. *False generalization:* the same statement for an
    infinite `A`, where the groups need not be finite and the pairing need not be perfect.
- **Tate–Nakayama, in the fixed generality.** Let `G` be a finite group. Let `σ ∈ H²(G, M)` be a
  distinguished class that satisfies the class-formation hypotheses. Then cup product with `σ`
  induces isomorphisms `Ĥ^r(H, ℤ) ≅ Ĥ^{r+2}(H, M)`, for every subgroup `H ≤ G` and every `r`.
  Formalize the statement in all degrees, with the splitting-module argument of Artin and Tate.
  Consume it here only at `r = −2`, which reads `G^{ab} = Ĥ^{−2}(G, ℤ) ≅ Ĥ⁰(G, M) = M^G/N_G M`.
  The all-degrees form is the form that Layer 8 and the downstream table cite.
  - *Prerequisites:*
    - `Layer 5: the finite class-formation structure`;
    - `Layer 6: the Tate cup product, in all integer bidegrees`;
    - `Mathlib: tateCohomology`.
  - *Source:* Artin–Tate, *Class Field Theory*, and Serre LF IX. The hypotheses are the two
    class-formation conditions on every subgroup. *False generalization:* the conclusion fails
    without the hypothesis on subgroups; vanishing of `H¹(G, M)` alone does not suffice.
- **Finite-level reciprocity.** For every finite Galois `L/K`, construct the **norm-residue
  isomorphism** `θ_{L/K} : Kˣ/N_{L/K}Lˣ ≅ Gal(L/K)^{ab}` from Tate–Nakayama applied to `u_{L/K}`,
  in the direction and the normalization of the conventions table. For `L/K` unramified prove
  `θ(π) = Frob` as its own lemma. That lemma is the compatibility between `inv(u) = 1/n` and the
  Frobenius normalization.
  - *Prerequisites:*
    - `Layer 6: Tate–Nakayama`;
    - `Layer 5: fundamental classes and the class formation`;
    - `Layer 5: the finite class-formation structure`;
    - `Layer 2: residue correspondence`.
  - *API:*
    - the isomorphism and its inverse;
    - the image of a uniformizer in the unramified case;
    - the image of `𝒪[K]ˣ`;
    - the index formula `[Kˣ : N_{L/K}Lˣ] = [L:K]` for `L/K` abelian;
    - the behaviour under a change of `L`.
- **Functoriality.** In a tower `M/L/K`, the projection `Kˣ/N_M Mˣ → Kˣ/N_L Lˣ` matches
  `Gal(M/K)^{ab} → Gal(L/K)^{ab}`. For a base change `K'/K`, the inclusion `Kˣ ⊆ K'ˣ` matches the
  transfer `Gal(·/K)^{ab} → Gal(·/K')^{ab}`, and the norm `N_{K'/K}` matches the natural map on
  abelianizations. Prove compatibility with restriction, corestriction, and inflation throughout.
  The limit of Layer 7 needs exactly these statements, and norm limitation needs the transfer
  statement, so all of them are proved at finite level here.
  - *Prerequisites:* `Layer 6: finite-level reciprocity`.
  - *Proof obligations:* corestriction and Mackey, with the transfer `Ĥ⁻²(G, ℤ) → Ĥ⁻²(H, ℤ)` that
    the base-change square uses.

### Layer 7: the Artin map, norm groups, and the existence theorem

The order of this layer matters. The inverse limit of the finite-level isomorphisms identifies
`G_K^{ab}` with the completion of `Kˣ` for the topology defined by the norm subgroups. The
identification of that topology with the topology of *all* open subgroups of finite index is the
existence theorem. To state the second identification first would make the layer circular.

Steps 1 to 5 and step 8 hold for every local field. One exception is inside step 3: the cyclotomic
orientation has values in `ℤ_pˣ`, and says nothing in characteristic `p`.

Steps 6, 7 and 9 assume that `K` is a finite extension of `ℚ_p`. The route to the existence
theorem here is Kummer theory. Its `p`-primary half in equal characteristic would need the
Artin–Schreier–Witt machinery that the scope boundary excludes. "General local field", "prime to
the residue characteristic", and
"finite extension of `ℚ_p`" are three different hypotheses in this layer. A milestone that
exchanges one for another is a different theorem.

1. **Norm groups and the normic topology.** Define `NormGroup L/K := (N_{L/K})(Lˣ) : Subgroup Kˣ`
   for `L/K` finite abelian. Prove that each is open of finite index, with
   `[Kˣ : NormGroup L/K] = [L:K]`. Prove that the norm subgroups form a filtered family: the norm
   group of a compositum is the intersection, and containment reverses. Define the **normic
   completion** `(Kˣ)^{norm}` as `lim_L Kˣ/NormGroup L/K` over finite abelian `L/K`.
   - *Prerequisites:*
     - `Layer 6: finite-level reciprocity`;
     - `Layer 0: e and f, intrinsically`;
     - `Mathlib: Subgroup`, `Mathlib/Topology/Algebra/Category/ProfiniteGrp/Limits.lean`.
   - *API:*
     - the definition of the norm group, as the image of the field norm;
     - openness and the index formula;
     - the lattice statements for composita and intersections;
     - the normic completion, with its projections and its universal property;
     - the worked case `N(ℚ_2(√5)ˣ)` in the examples section.
2. **The limit isomorphism.** The maps `θ_{L/K}` are compatible in a tower, by Layer 6, so their
   limit is an isomorphism of topological groups `(Kˣ)^{norm} ≅ G_K^{ab}`. The target is
   `absoluteGaloisGroupAbelianization` of Mathlib.
   - *Prerequisites:*
     - `Layer 7: norm groups and the normic topology`;
     - `Layer 6: functoriality`;
     - `Mathlib: absoluteGaloisGroupAbelianization`.
3. **The Artin map and its normalizations.** Define `Art_K : Kˣ →* G_K^{ab}` as the composite of
   `Kˣ → (Kˣ)^{norm}` with the isomorphism of step 2. Prove that it is continuous, that its image
   is dense, and that its kernel is the intersection of all norm groups. The interface name is
   `artinMap`. ⚠ `Kˣ` is not compact and `Art_K` is not surjective. A `Nat.card`-style statement
   about `G_K^{ab}` is wrong for that reason. The normalizations are theorems, and not
   definitions:
   - `ν_K ∘ Art_K = ι ∘ v_K`, the unramified coordinate, with values in `Ẑ` and with `ι : ℤ → Ẑ`;
   - `Art_K(𝒪[K]ˣ) = I(G_K^{ab})`, the inertia subgroup, as an equality of images, together with
     the induced isomorphism `𝒪[K]ˣ / (ker Art_K ∩ 𝒪[K]ˣ) ≅ I(G_K^{ab})`. ⚠ The direct
     isomorphism `𝒪[K]ˣ ≅ I(G_K^{ab})` is **not** available here. It needs injectivity of
     `Art_K`, which is step 7 and carries the mixed-characteristic hypothesis. An equality of
     images says nothing about the kernel of the map that produces them. At this point that
     kernel is known only as the intersection of all norm groups;
   - the **cyclotomic orientation** in mixed characteristic. For `K/ℚ_p` finite and `u ∈ 𝒪[K]ˣ`,

     ```text
     χ_cyc(Art_K(u)) = N_{K/ℚ_p}(u)⁻¹  in ℤ_pˣ.
     ```

     Both sides lie in `ℤ_pˣ`. The field norm is part of the statement: without it the equation is
     ill-typed for `K ≠ ℚ_p`. The interface names are `cyclotomicCharacter_artinMap` for the
     theorem and `cyclotomicCharacter_artinMap_padic` for the corollary
     `χ_cyc(Art_{ℚ_p}(u)) = u⁻¹` at `u ∈ ℤ_pˣ`. A character with values in `𝒪[K]ˣ` and value `u⁻¹`
     would be a Lubin–Tate character, which this roadmap does not build;
   - the geometric translation lemmas `Art^{geo} = Art ∘ inv` and `ν^{geo} = −ν`.
   - *Prerequisites:*
     - `Layer 7: the limit isomorphism`;
     - `Layer 2: norms`;
     - `Layer 6: functoriality`;
     - `Mathlib: cyclotomicCharacter`.
   - *API:*
     - the map and its continuity;
     - density of the image;
     - the kernel;
     - the four normalizations above, with the inertia statement in its image form and its
       quotient form;
     - naturality in a finite extension of `K`;
     - the values on `−1`, `2`, and `5` over `ℚ_2`, in the examples section.
   - *Source:* Serre LF XIV §7 for the computation on `ℚ_p(μ_{p^∞})`, which gives the corollary,
     and the functoriality square of Layer 6 for the general case.
4. **Norm limitation.** Let `L/K` be finite, and not necessarily Galois. Fix `L ⊆ K^{sep}` and put
   `F := L ∩ K^{ab}`. Then `N_{L/K}(Lˣ) = N_{F/K}(Fˣ)`. The form to use in Lean is the following.
   Choose a finite Galois `M ⊇ L` over `K`. Put `G = Gal(M/K)` and `H = Gal(M/L)`, and let `F` be
   the fixed field of `H · [G,G]`. Prove that this `F` is `L ∩ K^{ab}`, and that the two norm
   groups agree. The proof uses the corestriction and transfer compatibility of Layer 6, with the
   equality of indices. It does **not** use the existence theorem, which is why it comes here.
   - *Prerequisites:*
     - `Layer 6: functoriality`;
     - `Layer 7: norm groups and the normic topology`.
   - *Source:* Serre LF XI §4; Neukirch ANT V §2. *False generalization:* `N_{L/K}(Lˣ)` is not the
     norm group of `L` itself when `L/K` is not abelian; the index is `[L ∩ K^{ab} : K]`, and not
     `[L : K]`.
5. **The existence theorem away from the residue characteristic.** Let `H ≤ Kˣ` be open of finite
   index, and let `n` be the exponent of `Kˣ/H`. If `IsUnit (n : 𝒪[K])`, then `H` is the norm
   group of a finite abelian extension. This is regime 1, so it holds in either characteristic.
   The chain is:
   1. *Upward closure.* If `H ≤ Kˣ` contains `NormGroup L/K` for some finite abelian `L/K`, then
      `H` is itself a norm group, namely of the subfield of `L` fixed by
      `θ_{L/K}(H/NormGroup L/K)`. This uses finite-level reciprocity only.
   2. *Reduction to power subgroups.* An open subgroup `H` of finite index contains `(Kˣ)^n` for
      `n` the exponent of `Kˣ/H`. So it is enough to produce a finite abelian `L/K` with
      `NormGroup L/K ⊆ (Kˣ)^n`.
   3. *Cyclotomic base change and Kummer theory.* `K' := K(μ_n)` is finite abelian over `K`. Over
      `K'`, Layer 1 makes `K'ˣ/(K'ˣ)^n` finite, so `L' := K'((K'ˣ)^{1/n})` is a finite abelian
      extension of `K'` with `Gal(L'/K') ≅ Hom(K'ˣ/(K'ˣ)^n, μ_n)`, and finite-level reciprocity
      over `K'` identifies `NormGroup L'/K' = (K'ˣ)^n`. Both hypotheses of Kummer theory are used
      here: `μ_n ⊆ K'`, and `n` invertible in `𝒪[K']`. ⚠ `[K(μ_n) : K]` is the order of `q` mod
      `n`, and can be divisible by `p`; `[ℚ_2(μ_5) : ℚ_2] = 4` is such a case. It is `n`, and not
      that degree, that is prime to the residue characteristic here.
   4. *Descent of the norm.* Transitivity of norms and `N_{K'/K}((K'ˣ)^n) ⊆ (Kˣ)^n` give
      `N_{L'/K}(L'ˣ) ⊆ (Kˣ)^n`.
   5. *Return to an abelian extension.* `L'/K` need not be abelian, so apply norm limitation: with
      `F = L' ∩ K^{ab}`, `NormGroup F/K = N_{L'/K}(L'ˣ) ⊆ (Kˣ)^n ⊆ H`.
   6. *Conclusion.* By item 1, `H` is a norm group. By Layer 6 its index is the degree of the
      corresponding extension. So `L ↦ NormGroup L/K` is an inclusion-reversing bijection between
      two families. The source is the family of finite abelian extensions of `K` of degree prime
      to the residue characteristic. The target is the family of open subgroups of `Kˣ` of index
      prime to it. A compositum corresponds to an intersection.

   No milestone in this chain uses Layer 8. The order is deliberate, and this roadmap does not
   admit a proof that reverses it. The route also avoids formal groups.
   - *Prerequisites:*
     - `Layer 7: norm limitation`;
     - `Layer 6: finite-level reciprocity`;
     - `Layer 5: Kummer theory`;
     - `Layer 1: power classes, the primary statement`.
6. **The existence theorem in full, for `K/ℚ_p` finite.** In regime 2 the same six items hold for
   every `n`, with no condition on `H` beyond openness and finite index. In characteristic `0`,
   `μ_n ⊆ K(μ_n)` for every `n`, and the regime-2 count of Layer 1 makes `K'ˣ/(K'ˣ)^n` finite for
   every `n`, including `p ∣ n`. Let `K` be a finite extension of `ℚ_p`. Then `L ↦ NormGroup L/K`
   is an inclusion-reversing bijection. Its source is all finite abelian extensions of `K`, and
   its target is all open subgroups of `Kˣ` of finite index. ⚠ In equal characteristic the theorem
   is true and is not proved here. Adjoining `μ_p` to a field of characteristic `p` adds nothing,
   `Kˣ/(Kˣ)^p` is infinite, and the replacement is Artin–Schreier–Witt theory, which the scope
   boundary excludes. No milestone below may carry a hypothesis that covers the
   equal-characteristic `p`-primary case without proof.
   - *Prerequisites:*
     - `Layer 7: the existence theorem away from the residue characteristic`;
     - `Layer 1: power classes, the primary statement`.
7. **Consequences of the full existence theorem, for `K/ℚ_p` finite.** The intersection of all
   norm groups is trivial, so `Art_K` is injective. With injectivity available, the image equality
   of step 3 becomes the direct isomorphism `𝒪[K]ˣ ≅ I(G_K^{ab})` onto the inertia subgroup; that
   isomorphism belongs here, and carries the same mixed-characteristic hypothesis as the existence
   theorem it uses. The normic topology on `Kˣ` is the topology of all open subgroups of finite
   index. Only now, `Art_K` extends to an isomorphism `(Kˣ)^∧ ≅ G_K^{ab}`. Two completions could
   be meant here, so the milestone names the one used:
   - `(Kˣ)^{top}`, the completion of the topological group over its open subgroups of finite
     index;
   - `(Kˣ)^{abs}`, the profinite completion of the underlying abstract group, over all subgroups
     of finite index, which is `ProfiniteGrp.profiniteCompletion` of Mathlib.

   Prove that the two agree for `K/ℚ_p` finite. The bridge is that every subgroup of finite index
   of `Kˣ` is open: such a subgroup contains `(Kˣ)^n` for `n` the exponent of the quotient, and
   `(Kˣ)^n` is open by `isOpen_range_powMonoidHom` of Layer 1. ⚠ Cite that theorem, and not the
   cardinality formula of Layer 1, which counts the power classes and says nothing about the
   topology. With the bridge proved, the isomorphism holds for either completion. ⚠ Step 5
   alone gives none of these, in either characteristic. Injectivity uses `⋂_n (Kˣ)^n = 1`, and at
   `K = 𝔽_q((t))` the intersection over `n` prime to `p` still contains `U(K,1)`, which is
   `n`-divisible for every such `n`, because it is pro-`p`. One statement here is valid in either
   characteristic, and uses no existence theorem: `Kˣ/N_{L/K}Lˣ` is finite for every finite `L/K`,
   abelian or not, of order `[L ∩ K^{ab} : K]`.
   - *Prerequisites:*
     - `Layer 7: the existence theorem in full`;
     - `Layer 7: norm limitation`;
     - `Layer 1: structure of Kˣ`.
8. **Ramification compatibility and the conductor.** `U(K,n)` is compact, so its continuous image
   is closed, and the statement is an equality and not a statement about density. At finite level,
   for `L/K` finite abelian, `θ_{L/K}(U(K,n)·N_{L/K}Lˣ / N_{L/K}Lˣ) = Gal(L/K)^{(n)}`, the
   upper-numbering ramification subgroup. At infinite level, `Art_K(U(K,n)) = (G_K^{ab})^{(n)}`,
   where the upper-numbering filtration on `G_K^{ab}` is defined as the limit of the finite-level
   ones, which is well defined by Herbrand's theorem. Both statements use Hasse–Arf. Then define

   ```text
   c(L/K) := sInf { n : ℕ | U(K,n) ≤ NormGroup L/K }      (the conductor exponent)
   𝔣(L/K) := 𝓂[K] ^ c(L/K)                                (the conductor ideal)
   ```

   and prove: the set above is not empty, so the infimum is attained; `c(L/K) = 0` if and only if
   `L/K` is unramified, stated separately because `U(K,0) = 𝒪[K]ˣ`; and, for `c(L/K) = n > 0`,
   minimality reads `U(K,n) ≤ NormGroup L/K` and `U(K, n−1) ≰ NormGroup L/K`, where `n − 1` is
   meaningful because `n > 0`. The letter `f` keeps its Layer-0 meaning throughout.
   - *Prerequisites:*
     - `Layer 3: Hasse–Arf`;
     - `Layer 3: the norm on the unit filtration` (item 2);
     - `Layer 6: finite-level reciprocity`;
     - `Layer 7: the Artin map and its normalizations`.
   - *API:*
     - the two definitions;
     - attainment of the infimum;
     - the unramified criterion;
     - the minimality statement;
     - the conductor of a cyclic extension of prime degree, which is `t + 1` for the jump `t`;
     - the conductor-discriminant relation for an abelian extension;
     - the value for `ℚ_2(√5)/ℚ_2`, which is `0`, and for `ℚ_2(√2)/ℚ_2`, which is `3`.
   - *Source:* Neukirch ANT V §6 for the finite-level statement.
9. **The interface for a modularity-lifting consumer, for `K/ℚ_p` finite.** Assemble four items
   into one structure: the finite-abelian-level isomorphisms, the arithmetic-Frobenius
   normalization, the tower compatibility, and the full existence theorem of step 6. The structure
   carries compatible isomorphisms `Kˣ ⧸ NormGroup L/K ≃* Gal(L/K)` for finite abelian `L/K`. It
   carries the arithmetic-Frobenius normalization at uniformizers of an unramified extension. It
   carries the statement that the open subgroups of finite index are exactly the norm subgroups.
   Prove the translation between that structure and the milestones above. The mixed-characteristic
   hypothesis is inherited from step 6, and costs nothing, because the consumer works over finite
   extensions of `ℚ_p`.
   - *Prerequisites:*
     - `Layer 7: the existence theorem in full`;
     - `Layer 6: finite-level reciprocity`;
     - `Layer 7: the Artin map and its normalizations`.

### Layer 8: local Tate duality and the Euler characteristic

The order inside the layer is: the invariant map on finite coefficients, then duality, then the
Euler characteristic. Every milestone carries its regime. No statement of the form "all finite
modules over every local field" occurs.

#### 8A. Prime to the residue characteristic, in both characteristics

- **`H²(G_K, μ_n) ≅ ℤ/n` under `IsUnit (n : 𝒪[K])`.** Derive it from `inv_K` and the Kummer
  sequence on `(Kˢ)ˣ`, that is from `Br(K)[n]`. Compute the finite groups `H^i(G_K, μ_n)` for
  `i = 0, 1, 2`, and prove vanishing above degree `2`, which records `cd_ℓ(G_K) = 2` for primes
  `ℓ ≠ p`. The name is `h2MuEquivZMod_unit`, and the unit hypothesis is part of it. ⚠ This
  statement says nothing at `n = p` in mixed characteristic, where `p` is not a unit in `𝒪[K]`.
  The case `n = p` is the separate milestone `h2MuEquivZMod_mixed` of 8B.
  - *Prerequisites:*
    - `Layer 5: Br(K) is unramified`;
    - `Layer 5: Kummer theory`.
  - ⚠ The vanishing above degree `2` is proved here, as a statement about `H^i(G_K, μ_n)`. It is
    not consumed from a definition of cohomological dimension. Whichever roadmap defines
    `cd_ℓ`, the record `cd_ℓ(G_K) = 2` is a restatement of the vanishing proved here.
  - *API:*
    - the isomorphism and its inverse;
    - the three finite groups and their orders;
    - the vanishing above degree `2`;
    - compatibility along `μ_n ⊆ μ_{nm}`;
    - the restriction and corestriction squares, with the embedding `L ↪ Kˢ` in the statement.
- **Duality.** Let `M` be a finite discrete `G_K`-module killed by such an `n`. Put
  `M' = Hom(M, μ_n)` with the conjugation action. The coefficient map is **evaluation**,
  `M' ⊗ M → μ_n`, which is equivariant and biadditive. Cup product with it gives
  `H^i(G_K, M') × H^{2−i}(G_K, M) → H²(G_K, μ_n) ≅ ℤ/n`, and the theorem is that this pairing of
  finite groups is perfect for `i = 0, 1, 2`. Compatibility along `μ_n ⊆ μ_{nm}` stays inside
  this regime. The proof is a chain, and each step is a milestone of its own. Those facts that
  make the pairing typeable do not make it perfect.
  1. *The map.* Define `α^i(M) : H^i(G_K, M') → Hom(H^{2−i}(G_K, M), ℤ/n)` by
     `x ↦ (y ↦ inv(x ⌣ y))`. Perfectness is bijectivity of `α^i`, and the milestones below are
     about that map and not about an abstract equivalence.
  2. *Finiteness.* Each `H^i(G_K, M)` is finite for `i = 0, 1, 2`. Every later cardinality
     statement depends on this one, because `Nat.card` is `0` on an infinite type.
  3. *The base case: trivial coefficients.* Let `M = ℤ/m` with trivial action and `m ∣ n`, so
     that `M' = μ_m`. Three separate statements:
     - `H²(G_K, μ_m) ≅ ℤ/m` pairs with `H⁰(G_K, ℤ/m) = ℤ/m`, by the milestone above;
     - `H⁰(G_K, μ_m) = μ_m(K)` pairs with `H²(G_K, ℤ/m)`;
     - `H¹(G_K, μ_m) = Kˣ/(Kˣ)^m` pairs with `H¹(G_K, ℤ/m) = Hom_cont(G_K^{ab}, ℤ/m)` by
       `(a, χ) ↦ χ(Art_K a)`, and that pairing is perfect by the existence theorem of Layer 7.

     ⚠ The third statement is where local class field theory enters the proof of duality. There
     is no abstract substitute for it, and it is the reason Layer 8 comes after Layer 7.
  4. *The pairing is a morphism of δ-functors.* For a short exact sequence
     `0 → M₁ → M₂ → M₃ → 0` of finite discrete `G_K`-modules killed by `n`, the dual sequence is
     exact, and `α` commutes with the two families of connecting maps up to the sign that the cup
     product carries. Write the sign into the statement.
  5. *Dévissage to the split case.* Every finite discrete `G_K`-module `M` is split by a finite
     Galois `L/K` inside `Kˢ`, that is, `G_L` acts trivially on `M`. Embed `M` in the coinduced
     module `M* = Coind^{G_K}_{G_L}(Res M)` by `m ↦ (g ↦ g · m)`, and put `M₁ = M*/M`. Shapiro
     identifies `H^i(G_K, M*)` with `H^i(G_L, M)`, the dual of `M*` is the coinduced module of the
     dual, and under Shapiro on both sides `α^i(K, M*)` becomes `α^i(L, M)`. Over `L` the action
     is trivial, so `M` is a finite direct sum of cyclic groups and step 3 applies to each
     summand. ⚠ There is **no** filtration of a general `M` by modules with trivial `G_K`-action.
     At `K = ℚ_2`, let the unramified quadratic quotient of `G_K` act on `M = ℤ/3` through the
     nontrivial character. As a module over `𝔽_3[C_2]` this `M` is one-dimensional and nontrivial,
     so it has no nonzero submodule and no nonzero quotient with trivial action, and its only
     composition factor is not trivial. Trivial action is reached by base change to a splitting
     field and Shapiro, and never by a filtration over `K`.
  6. *The induction.* Apply the five lemma to the two exact sequences of step 5, in this order:
     - surjectivity of `α^i` for every `M`, by descending induction on `i` from `i = 2`, using
       bijectivity for `M*`;
     - injectivity of `α^i` for every `M`, from surjectivity for `M₁`.

     The induction parameter is the degree, and not the order of `M`.
  7. *Perfectness.* `α^i` is bijective in degrees `0`, `1`, and `2`.
  8. *Change of exponent.* The pairings for `n` and for `nm` agree along `μ_n ⊆ μ_{nm}`.
  - *Prerequisites:*
    - `Layer 8A: H²(G_K, μ_n) ≅ ℤ/n`;
    - `Layer 7: the existence theorem away from the residue characteristic`;
    - `Layer 7: the Artin map and its normalizations`;
    - `Layer 5: Kummer theory`;
    - `Layer 1: power classes, the primary statement`.
  - *Supplied hypotheses:* `CohomologyOps.tensorObj`, `CohomologyOps.cup`, and
    `CohomologyOps.coeff`, which step 1 uses to write `α^i`.
  - *Proof obligations:* Shapiro in degrees `≤ 2`, for step 5, and the finite-quotient colimit.
  - *API:*
    - the dual module and its functoriality;
    - the evaluation coefficient map, and its equivariance;
    - the map `α^i` in each of the three degrees;
    - perfectness, as bijectivity of `α^i`;
    - the induced isomorphism `H^i(G_K, M') ≅ Hom(H^{2−i}(G_K, M), ℤ/n)`;
    - finiteness of each group;
    - compatibility across `n`;
    - the restriction and corestriction squares for a finite separable `L/K` inside `Kˢ`.
  - *Source:* Milne ADT I.2.1 and I.2.3; Serre, *Galois Cohomology*, II §5.2; NSW (7.2.6). The
    hypotheses are `M` finite and discrete, and `#M` invertible in `𝒪[K]`. *False
    generalization:* at `char K = p` and `M = ℤ/p` the pairing is not perfect, and `μ_p` is not
    the correct dual.
- **Unramified subgroups and their annihilators.** Define `H¹_{ur}(K, M)` as the kernel of the
  restriction `H¹(G_K, M) → H¹(I_K, M)`. Prove that it equals the image of inflation from
  `H¹(G_K/I_K, M^{I_K})`, so that the two usual descriptions are interchangeable. Make the
  definition for both coefficient modules, and use for `M'` the dual action of the pairing. Let
  `M` be unramified, that is, let `I_K` act trivially, and let `#M` be prime to the residue
  characteristic. Then `H¹_{ur}(K, M)` and `H¹_{ur}(K, M')` are exact annihilators of each other
  under the pairing above, and their orders are

  ```text
  #H¹_ur(K, M)  = #H⁰(K, M),
  #H¹_ur(K, M') = #H⁰(K, M').
  ```

  ⚠ These are two formulas, and no equality is asserted between their right-hand sides.
  `H¹_ur(K,M)` is `M/(Frob − 1)M`, whose order equals the order of `M^{G_K}`. The same computation
  on `M'` gives `#H⁰(K,M')`, which is a different number in general. At `K = ℚ_2` and `M = ℤ/3`
  with trivial action, `#H¹_ur(K,M) = 3`, while `M' = μ_3` and `μ_3(ℚ_2) = 1`, so
  `#H¹_ur(K,M') = 1`. Write the degrees, the coefficient dual, and the value group into the
  statement, and not into the prose around it.
  - *Prerequisites:*
    - `Layer 8A: duality`;
    - `Layer 4: inertia`;
    - `Mathlib: continuousCohomology` and the compatible-pair `cochainsMap`, for the restriction
      and the inflation in the two descriptions.
  - *Source:* Milne ADT I.2.6; NSW (7.2.15). The hypotheses are that `M` is unramified and that
    `#M` is prime to the residue characteristic. *False generalization:* the common value
    `#H⁰(G_K, M)` for both subgroups, which the example above refutes.
- **Euler characteristic.** For finite `M` of order prime to `p`, `#H⁰(G_K,M) · #H²(G_K,M) /
  #H¹(G_K,M) = 1`. This is the specialization of `‖#M‖_K`, because `#M` is a unit in `𝒪[K]`.
  - *Prerequisites:*
    - `Layer 8A: duality`;
    - `Layer 0: the normalized valuation`.
  - *Source:* Milne ADT I.2.8; NSW (7.3.1); Serre, *Galois Cohomology*, II §5.7.

#### 8B. Mixed-characteristic `p`-primary theory

Write `N = [K : ℚ_p]` throughout, as in Layer 9. The letter `d` is reserved for a topological
rank, and is never a degree here.

- **The trace isomorphism.** `H²(G_K, μ_n) ≃ ZMod n` for **every** `n ≥ 1`, and not only for `n`
  prime to the residue characteristic. This is the value object of the pairing above, and it is a
  milestone of this subsection and not a corollary of 8A. The name is `h2MuEquivZMod_mixed`. When
  `μ_p ⊆ K`, a choice of primitive `p`-th root of unity transports it to `H²(G_K, 𝔽_p) ≃ ZMod p`,
  named `h2FpEquivZMod_of_mu`; that choice is an argument of the statement, and not a global
  convention. ⚠ The transported statement is about the **trivial** `ZMod p`-module. It is not a
  statement about an arbitrary coefficient object `A` killed by `p`: the zero representation has
  `H² = 0`, which refutes the unquantified form.
  - *Prerequisites:*
    - `Layer 5: Br(K) is unramified`;
    - `Layer 5: Kummer theory`;
    - `Layer 0: finite extensions, III`.
  - ⚠ This milestone comes **before** duality in 8B, and not after it. It is derived from `inv_K`
    and the `n`-th power sequence on `(Kˢ)ˣ`, which is surjective because `char K = 0`. Duality
    then uses it as the value object of the pairing.
  - *API:*
    - the isomorphism for every `n`;
    - compatibility along `μ_n ⊆ μ_{nm}`;
    - the transported form under `μ_p ⊆ K`, with the dependence on the chosen root of unity;
    - the restriction and corestriction squares, which inherit the scaling laws of `inv`:
      restriction multiplies by `[L:K]`, and corestriction is the identity on invariants.
- **Duality.** Assume `K/ℚ_p` finite. For every finite discrete `G_K`-module `M`, including
  `p`-primary ones, choose an exponent `n`. Since `char K = 0`, the étale dual `M' = Hom(M, μ_n)`
  is available. Prove the same perfect pairings, the same finiteness, and compatibility across
  exponents. Perfectness in degrees `0`, `1`, and `2` is `tateDualityPairing_perfect_mixed`.
  Record `cd_p(G_K) = 2` as its own statement, and not as part of an unqualified `cd(G_K) = 2`.
  ⚠ This is not a formal consequence of 8A. The `p`-primary case needs its own argument at
  steps 2, 3, and 7 of the chain in 8A. Step 2, finiteness of `H^i(G_K, M)` for `p`-primary `M`,
  uses the finite index of `(Kˣ)^{p^k}` from Layer 1. Step 3, the base case at `M = ℤ/p^k`, uses
  the **full** existence theorem of Layer 7, and not its regime-1 half. Step 7 is perfectness.
  State those three steps again here, with `K/ℚ_p` finite.
  - *Prerequisites:*
    - `Layer 8A: duality`, for the shape of the statement and for the prime-to-`p` part;
    - `Layer 8B: the trace isomorphism`;
    - `Layer 7: the existence theorem in full`;
    - `Layer 7: the Artin map and its normalizations`;
    - `Layer 1: power classes, the primary statement`;
    - `Layer 1: the power subgroup is open`.
  - *Supplied hypotheses:* the three fields of `Supplied.CohomologyOps`, as in 8A.
  - *Proof obligations:* Shapiro in degrees `≤ 2`.
  - *Source:* Milne ADT I.2.3; NSW (7.2.6). The hypothesis is `K/ℚ_p` finite. *False
    generalization:* the same statement in equal characteristic at `n = p`, which the scope
    boundary excludes.
- **Euler characteristic.** For every finite `M`, `#H⁰(G_K,M) · #H²(G_K,M) / #H¹(G_K,M) = ‖#M‖_K`,
  in the normalized absolute value of Layer 0, as an equality in `ℚ≥0`. The name is
  `eulerCharacteristic_mixed`. State that form first. Then derive the corollary for an
  `𝔽_p`-module, `dim H¹ = dim H⁰ + dim H² + N · dim M`, named `eulerCharacteristic_finrank_fp`.
  - *Prerequisites:*
    - `Layer 8B: duality`;
    - `Layer 1: power classes, the absolute-value form`;
    - `Layer 0: the normalized valuation`.
  - *Source:* NSW (7.3.1); Serre, *Galois Cohomology*, II §5.7. *False generalization:* the same
    formula in equal characteristic with `p ∣ #M`, where `H¹` is infinite.

#### 8C. The mod-2 Hilbert symbol

This is a deliverable of this roadmap. The theorem below is stated against the norm criterion,
which is the definition of the symbol and needs no object from another roadmap.

- **The mod-2 pairing is the norm criterion.** Let `2` be invertible in `𝒪[K]`. At `n = 2` the
  coefficient identification `μ_2 ⊗ μ_2 ≅ μ_2` is canonical, because `μ_2 ≅ ZMod 2` needs no
  chosen root of unity. So the 8A pairing at `n = 2` reads
  `H¹(G_K, μ_2) × H¹(G_K, μ_2) → H²(G_K, μ_2) ≅ ZMod 2`, and Kummer theory identifies each factor
  with `Kˣ/(Kˣ)²`. The theorem is

  ```text
  localPairing (kummerClass 2 a) (kummerClass 2 b) = 0  ↔  a ∈ N_{K(√b)/K} (K(√b)ˣ),
  ```

  named `tateDualityPairing_eq_normCriterion`. Four ingredients belong in the statement: the
  Kummer identification used on each factor; the order of the two arguments of the cup product;
  the canonical identification `μ_2 ⊗ μ_2 ≅ μ_2`; and the invariant isomorphism
  `H²(G_K, μ_2) → ZMod 2`. The right-hand side is a statement about `K` alone, so this milestone
  is complete inside this roadmap.
  - *Prerequisites:*
    - `Layer 8A: duality`;
    - `Layer 5: Kummer theory` (`kummerEquiv` and `cup_kummerEquiv`);
    - `Layer 7: norm groups and the normic topology`;
    - `Layer 1: power classes, the primary statement`.
  - *API:*
    - the named theorem;
    - nondegeneracy of the pairing, as a corollary of duality here;
    - symmetry, and bimultiplicativity, from `cup_kummerEquiv`;
    - the value on the basis `{−1, 2, 5}` over `ℚ_2`, in the examples section.
  - *Source:* Serre, *A Course in Arithmetic*, III §1, for the criterion over `ℚ_p`; Milne ADT
    I.2.4; NSW (7.2.13). The hypothesis is that `2` is invertible in `𝒪[K]`. *False
    generalization:* the same identification at an odd `n` with values in `μ_n`, which needs a
    chosen primitive `n`-th root of unity, as the Layer 5 note explains.
- **Transport to a `{±1}`-valued symbol.** A symbol with values in `{±1} ⊆ ℤˣ` is the theorem
  above composed with the dictionary between `ZMod 2` and `{±1}`. Name that composite
  `hilbertSymbol_eq_tateDuality_pairing`, and prove it from the milestone above and the
  dictionary. ⚠ Quaternion algebras, the splitting criterion over an arbitrary field, the
  quadratic defect, and the classification of forms over a local field are the theory of
  quadratic forms, and this roadmap builds none of them. What it builds is one symbol, from the
  norm criterion, and the dictionary `ZMod 2 ≃ {±1}` of Mathlib. The theory of quadratic forms
  states the same norm-criterion symbol over an arbitrary field, so the two definitions agree
  literally over a nonarchimedean local field. The identification with the cohomological
  pairing is this milestone's, and no development restates it.
  - *Prerequisites:*
    - `Layer 8C: the mod-2 pairing is the norm criterion`;
    - `Mathlib: ZMod 2` and `Units.val`, for the dictionary.
  - *API:*
    - the `{±1}`-valued symbol as a definition, with its two values;
    - the comparison theorem;
    - symmetry and bimultiplicativity, transported;
    - the values `(−1,−1)_2 = −1` and `(5, 5)_2 = 1` over `ℚ_2`, in the examples section.

### Layer 9: topological finite generation of `G_K`

Let `K/ℚ_p` be finite of degree `N`. This layer comes after Layers 7 and 8, and it is last. Its
lower bound carries `Supplied.ProPRankInputs`, the rank of the maximal pro-`p` quotient `G_K(p)`,
which is proved from the duality statements of Layer 8. No milestone here uses an unqualified
`scd(G_K) = 2`: conventions for the strict cohomological dimension vary, and that statement is not
what the argument needs.

- **Counts of `H¹`-dimensions.** Compute `dim_{𝔽_ℓ} H¹(G_K, 𝔽_ℓ)` for every prime `ℓ`. It is
  `N + 1 + dim H⁰(μ_p)` at `ℓ = p`, and at most `2` at `ℓ ≠ p`. ⚠ The naive criterion "if every
  `H¹(G, 𝔽_ℓ)` is finite then `G` is topologically finitely generated" is **false** for profinite
  groups. The group `∏_ℕ A₅` has `H¹(−, 𝔽_ℓ) = 0` for every `ℓ`, because each factor is perfect,
  and it is not topologically finitely generated, because `d(A₅^m) → ∞`. So these counts are an
  input to the argument below, and not a proof on their own.
  - *Prerequisites:*
    - `Layer 5: Kummer theory`;
    - `Layer 1: power classes, the primary statement`;
    - `Layer 8B: duality`.
- **The tame frame.** `G_K^{t}` is topologically 2-generated, by Layer 4, and `P_K` is pro-`p`,
  also by Layer 4. Use the Burnside generation criterion for pro-`p` groups, with its relative
  form for a closed normal pro-`p` subgroup. Finite generation of `G_K` then reduces to finite
  generation of the `ℤ_p[[G_K^t]]`-coinvariants of `P_K^{ab}(p)`.
  - *Prerequisites:*
    - `Layer 4: the Iwasawa presentation`;
    - `Layer 4: wild inertia`.
  - *Supplied hypotheses:* the Burnside generation criterion
    `ProPOps.topologicallyGenerates_iff_frattiniQuotient`, with its relative form for a closed
    normal pro-`p` subgroup.
- **The module of the multiplicative group.** Prove the reciprocity-side input: the
  `ℤ_p`-completion `A(L) = lim Lˣ/(Lˣ)^{p^m} ≅ G_L^{ab}(p)`; the `ℚ_p[G]`-module structure
  `A(L) ⊗ ℚ ≅ ℚ_p[G]^N ⊕ ℚ_p` for `L/K` Galois with group `G`, from the deep-unit logarithm of
  Layer 1 and the normal basis theorem; and cohomological triviality of the modules of type
  `U(L,1)/p` in a tame extension.
  - *Prerequisites:*
    - `Layer 7: consequences of the full existence theorem`;
    - `Layer 1: deep units in mixed characteristic`;
    - `Layer 3: tame and wild`.
  - *Source:* NSW VII §4, with (7.4.3) and (7.4.4) as the module inputs.
- **The exact rank.** The theorem is an equality:

  ```text
  d(G_K) = N + 2   for every finite extension K/ℚ_p of degree N.
  ```

  Here `d` is `Supplied.topologicalGeneratorRankNat`. The upper bound is the
  relation-module count of NSW VII §4. That count uses three inputs: the free presentation of the
  tame quotient, the degree-`2` vanishing and comparison statements of Layer 8, and lifting along
  the Frattini reduction. The lower bound has two cases, and both use the rank of `G_K(p)`:
  - if `μ_p ⊆ K`, then `d(G_K) ≥ d(G_K(p)) = N + 2`, by monotonicity of `d` under a continuous
    surjection;
  - if `μ_p ⊄ K`, put `L = K(μ_p)` and `m = [L:K]`, which divides `p − 1`. Then `μ_p ⊆ L`, so
    `d(G_L) ≥ d(G_L(p)) = mN + 2`, while the Schreier bound gives `d(G_L) ≤ 1 + m(d(G_K) − 1)`.
    Hence `m · d(G_K) ≥ m(N + 1) + 1`, and `d(G_K) ≥ N + 2`, because `d(G_K)` is an integer.
  - *Prerequisites:*
    - `Layer 9: the tame frame`;
    - `Layer 9: the module of the multiplicative group`;
    - `Layer 8B: duality`;
    - `Mathlib: Subgroup.closure`, `Subgroup.topologicalClosure`, and `IsLeast`, from which
      `Supplied.topologicalGeneratorRankNat` is a definition, with no `sorry`.
  - *Supplied hypotheses:*
    - `ProPOps.rank_le_of_surjective` and `ProPOps.rank_le_of_isOpen`, the monotonicity of the
      rank under a continuous surjection and the Schreier bound;
    - `ProPRankInputs`, the rank of `G_F(p)` in the two cases, for `F/ℚ_p` finite.
  - *Source:* Jarden–Shusterman, Theorem 2.1, for the equality; NSW (7.4.1) for the upper bound.
    *False generalization:* `d(G_K) = N + 1` when `μ_p ⊄ K`. That count is about the maximal
    pro-`p` quotient, and is the next milestone.
- **What belongs to the pro-`p` quotient.** The statement "if `μ_p ⊄ K` then `N + 1` generators
  are enough" is about `G_K(p)`, and not about `G_K`. Its two cases are
  `μ_p ⊄ K ⟹ d(G_K(p)) = N + 1`, by the theorem of Shafarevich that `G_K(p)` is then free pro-`p`
  of that rank, and `μ_p ⊆ K ⟹ d(G_K(p)) = N + 2`, by the theorem of Demushkin. Both are theorems
  about pro-`p` groups. This roadmap consumes them for the lower bound as the two fields of
  `Supplied.ProPRankInputs`, and states neither as a fact about `G_K`.
  - *Supplied hypotheses:* `ProPRankInputs.rank_of_mu` and `ProPRankInputs.rank_of_not_mu`.

## Worked examples (acceptance criteria)

Discharge these with the layers named. Each one catches a specific class of error: a vacuous
instance, a sign error, a wrong normalization, or a dropped dyadic case.

- **`ℚ_p` and `𝔽_q((t))` are local fields, and `ℚ` and `ℂ` are not** (Layer 0). This is the
  non-vacuity check, with two negative instances: `ℚ` with any `p`-adic valuation class is
  incomplete, and therefore not locally compact; and for `ℂ` no valuation class with a compatible
  topology qualifies, because a nonarchimedean local field is never algebraically closed.
- **`v_2`, `‖·‖`, and `q` on `ℚ_2`** (Layer 0): `v_2^×(2) = Multiplicative.ofAdd 1`, equivalently
  `v_2(2) = 1`; `‖2‖ = 1/2`; `q = 2`. On `K = ℚ_2(√2)`: `e = 2`, `f = 1`, and
  `v_K^×(2) = Multiplicative.ofAdd 2`.
- **`ℚ_2ˣ/(ℚ_2ˣ)²` has order 8** (Layer 1), with the classes of `−1`, `2`, and `5` as a basis,
  where `5 ≡ −3 mod (ℚ_2ˣ)²`. For odd `p`, `ℚ_pˣ/(ℚ_pˣ)²` has order `4`. The sharp deep-square
  bound is `1 + 8ℤ_2 ⊆ (ℤ_2ˣ)²`, that is `U(2e+1) = U(3)` at `K = ℚ_2`.
- **The Teichmüller subgroup of `ℚ_2` is trivial** (Layer 1): `μ_{q−1}(ℚ_2) = {1}`, which is
  degenerate on purpose, while the full torsion subgroup is `μ(ℚ_2) = {±1}`, which lies in
  `U(1) \ U(2)`. On `ℚ_5`, `μ_4 ⊆ ℤ_5ˣ` instead.
- **The unramified quadratic extension of `ℚ_2` is `ℚ_2(√5) = ℚ_2(μ_3)`** (Layer 2): `f = 2`, and
  Frobenius squares on `μ_3`. Every unit of `ℤ_2ˣ` is a norm: `∀ u : ℤ_2ˣ, ∃ x y, u = x² − 5y²`.
  The norm group is `N(ℚ_2(√5)ˣ) = ⟨4⟩ × ℤ_2ˣ`, of index `2`, and it does not contain `2`.
- **The ramification filtration of `ℚ_2(μ_8)/ℚ_2`** (Layer 3): the group is `(ℤ/8)ˣ ≅ (ℤ/2)²`,
  with `G_0 = G_1 = G`, `G_2 = G_3 = ⟨σ_5⟩`, the direction `ζ ↦ ζ⁵`, and `G_4 = 1`. Compute it
  from the cyclotomic recipe `i_G(σ_a) = v_L(ζ^a − ζ)` of Serre LF IV §4. The Herbrand transform
  puts the jumps of the upper numbering at `1` and `2`, since `φ(1) = 1` and `φ(3) = 2`, and both
  are integers, as Hasse–Arf requires. This example also carries the failure of quotient
  compatibility for the lower numbering. A tame contrast is `ℚ_3(3^{1/2})/ℚ_3`, with `G_0 = ℤ/2`
  and `G_1 = 1`.
- **The norm lowers unit depth** (Layer 3): in `L = ℚ_3(√3)` over `K = ℚ_3`, the element
  `x = 4 = 1 + π_L²` lies in `U(L,2)`, while `N_{L/K}(x) = 16` and `v_3(16 − 1) = 1`. So
  `N_{L/K}(U(L,2)) ⊄ U(K,2)`. Here `φ_{L/K}(u) = u/2` and `ψ_{L/K}(v) = 2v`, so the shifted
  inclusion `N(U(L, ψℕ(1))) = N(U(L,2)) ⊆ U(K,1)` holds, and it is sharp, as is the floored
  corollary. This example is in the test suite, so that a later simplification of the norm package
  cannot reintroduce the unshifted inclusion.
- **The tame relation over `ℚ_3`** (Layer 4): in `G_{ℚ_3}^{t}`, `στσ⁻¹ = τ³` for the arithmetic
  Frobenius lift. At finite level, in `Gal(ℚ_3(μ_8, 3^{1/8})/ℚ_3)`, the conjugation formula can be
  checked by hand from the action of `σ` on the roots of `3` indexed by `μ_8`.
- **Hilbert symbols on `ℚ_2`** (Layers 7 and 8): `(−1,−1)_2 = −1`, equivalently `−1` is not a sum
  of two squares in `ℚ_2`; `(2,5)_2 = −1`; `(2,−1)_2 = +1`; `(5,5)_2 = +1`.
- **`Art_{ℚ_2}` on `−1`, `2`, and `5`** (Layer 7): `ν(Art(2)) = 1`, and
  `ν(Art(−1)) = ν(Art(5)) = 0`; `χ_cyc(Art(−1)) = −1`, `χ_cyc(Art(5)) = 5⁻¹`, and
  `χ_cyc(Art(2)) = 1`. All are instances of the cyclotomic orientation with `K = ℚ_p`, where
  `N_{K/ℚ_p}` is the identity. In the geometric normalization `ν_ur` these read `−1`, `0`, `0`,
  which is the translation lemma in use.
- **The Euler characteristic of `μ_2` over `ℚ_2`** (Layer 8): `#H⁰ = 2` and `#H² = 2`, so the
  formula forces `#H¹(G_{ℚ_2}, μ_2) = 8`, which agrees with Kummer theory and the square-class
  group of order `8`. This example crosses Layers 1, 5, and 8, and it is the one that catches a
  wrong normalization of `‖#M‖_K`.
- **Duality at `n = 2` over `ℚ_2`** (Layer 8): the matrix of the Hilbert symbol on the basis
  `{−1, 2, 5}` is nondegenerate mod 2. This is the identification of 8C, instantiated.

## Ordering and parallelism

Layers 0 to 2 are sequential, and come first.

Layer 3, the ramification filtration, and Layer 4, the tame quotient, both need Layers 0 to 2.
Neither needs a late milestone of the other: Layer 4 uses the tame and wild vocabulary from the
start of Layer 3, and not the Herbrand functions or Hasse–Arf.

The finite-level part of Layer 5 needs Layers 2 and 3 and the group cohomology of Mathlib, and
nothing else. That part is the Herbrand quotient, unramified cohomology, solvability, and the
fundamental classes. The statements of Layer 5 about `G_K` carry the fields of
`Supplied.CohomologyOps` that each milestone names.

Layer 6 comes after Layer 5. Layer 7 comes after Layer 6, and its ramification-compatibility
milestone also needs Hasse–Arf from Layer 3. Layer 8 needs Layers 5 and 7. Layer 9 comes last,
because it needs Layers 4, 7, and 8.

No milestone waits for work outside this roadmap. A milestone with a *Supplied hypotheses* field
is proved with that hypothesis in place, in any order that the list above allows. The worked
examples are required in the layers to which they are assigned.

### Interface table: Local Fields and Pro-`p` Groups

The two roadmaps have edges in both directions, at different layers. Every crossing is a row
of the table below, and a statement that is not a row is not an interface: neither roadmap
consumes the other through prose. Each row gives the consuming layer, the supplying layer,
the exact object or theorem, and the name it goes by. The name belongs to the supplier, which
states the object once, and the consumer cites the name instead of restating the object. The
Local Fields and Pro-`p` Groups roadmaps carry the same table.

| Consumer layer | Supplier layer | Exact object or theorem | Name |
|---|---|---|---|
| Local Fields Layer 1, structure of `Kˣ` | Pro-`p` Groups Layer 3 | the quotient-form pro-`p` predicate, applied to `U(K,1) = lim_i U(K,1)/U(K,i)` | `IsProP` |
| Local Fields Layer 4, wild inertia | Pro-`p` Groups Layer 2 | pro-`p` Sylow subgroups of a profinite group: the predicate, existence, the containment of every closed pro-`p` subgroup in one, uniqueness of a normal one, and the image under a continuous surjection. All five are free of Galois vocabulary; identifying the Sylow subgroup of `I_K` with `Gal(K̄/K^t)` is the Local Fields side | `IsProPSylow`, `exists_isProPSylow`, `IsProP.exists_le_isProPSylow`, `IsProPSylow.eq_of_normal`, `IsProPSylow.map_of_surjective` |
| Local Fields Layer 4, Iwasawa presentation | Pro-`p` Groups Layer 4 | the free **profinite** group on a finite set, its generators and its universal property, together with the quotient by the closed normal closure of a set of relators. This is the shape in which `G_K^t = ⟨σ, τ ∣ στσ⁻¹τ^{−q}⟩` is stated, and it is a profinite object, not the pro-`p` `presentedProP` of the same layer | `freeProfiniteGroup`, `freeProfiniteGroup.of`, `freeProfiniteGroup.lift`, `presentedProfiniteGroup` |
| Local Fields Layer 9, rank of `G_K` | Pro-`p` Groups Layer 3 | topological finite generation, in exactly the pinned shape `∃ s : Finset G, (Subgroup.closure ↑s).topologicalClosure = ⊤` | `IsTopologicallyFinitelyGenerated` |
| Local Fields Layer 9, rank of `G_K` | Pro-`p` Groups Layer 3 | the topological rank in its cardinal and natural-number forms, its monotonicity under continuous surjections, the Schreier bound `d(U) ≤ 1 + [G : U](d(G) − 1)` for open `U`, and the Burnside generation criterion for pro-`p` groups (a subset generates topologically iff its image generates the Frattini quotient) | `topologicalGeneratorRank`, `topologicalGeneratorRankNat`, `topologicalGeneratorRank_le_of_surjective`, `topologicalGeneratorRankNat_le_of_isOpen`, `topologicallyGenerates_iff_frattiniQuotient` |
| Local Fields Layer 9, rank of `G_K` | Pro-`p` Groups Layer 11 | `G_K(p)` as a carrier, its topological finite generation, and its rank in both cases: `N + 1` when `μ_p ⊄ K` (free, Shafarevich) and `N + 2` when `μ_p ⊆ K` (Demushkin) | `absoluteGaloisGroupProP`, `isTopologicallyFinitelyGenerated_absoluteGaloisGroupProP`, `topologicalGeneratorRankNat_absoluteGaloisGroupProP_of_not_mu`, `topologicalGeneratorRankNat_absoluteGaloisGroupProP_of_mu` |
| Pro-`p` Groups Layer 11, the canonical instance | Local Fields Layers 5, 7, 8B, 8C | the construction of `LocalFieldInputs` for a finite extension `K` of `ℚ_p`, from the Local Fields theorems named in the rows below, with `G_K` Mathlib's `Field.absoluteGaloisGroup K` and with the roots-of-unity predicate that roadmap states | `localFieldInputs` |
| Pro-`p` Groups Layer 11, input 1 | Local Fields Layer 8B | the mixed-characteristic Euler characteristic `#H⁰ · #H² / #H¹ = ‖#M‖_K` and its `𝔽_p`-module corollary `dim H¹ = dim H⁰ + dim H² + N · dim M` | `eulerCharacteristic_mixed`, `eulerCharacteristic_finrank_fp` |
| Pro-`p` Groups Layer 11, input 2 | Local Fields Layer 8B | the trace isomorphism `H²(G_K, μ_n) ≃ ZMod n` for **every** `n ≥ 1` in mixed characteristic, which is the value object of the 8B pairing, together with its transport to `H²(G_K, 𝔽_p)` along a choice of `p`-th root of unity when `μ_p ⊆ K`. ⚠ The 8A statement of the same shape carries `IsUnit (n : 𝒪[K])` and therefore says nothing at `n = p`; citing 8A for this input is the mistake to avoid | `h2MuEquivZMod_mixed`, `h2FpEquivZMod_of_mu` |
| Pro-`p` Groups Layer 11, input 3 | Local Fields Layer 8B | perfectness of the local Tate duality pairing at `n = p` in mixed characteristic, in degrees `0`, `1`, `2` | `tateDualityPairing_perfect_mixed` |
| Pro-`p` Groups Layer 11, input 3 | Local Fields Layer 8C | the identification of that pairing at `p = 2` with the classical Hilbert symbol | `hilbertSymbol_eq_tateDuality_pairing` |
| Pro-`p` Groups Layer 11, input 4 | Local Fields Layer 5 | Kummer theory `Kˣ/(Kˣ)ⁿ ≃ H¹(G_K, μ_n)`, and the square relating Kummer classes to the cup product | `kummerEquiv`, `cup_kummerEquiv` |
| Pro-`p` Groups Layer 11, input 5 | Local Fields Layer 7 | the Artin map, and the cyclotomic orientation `χ_cyc(Art_K(u)) = N_{K/ℚ_p}(u)⁻¹` for `u ∈ 𝒪[K]ˣ`, with its `K = ℚ_p` corollary `χ_cyc(Art_{ℚ_p}(u)) = u⁻¹`. ⚠ The field norm is part of the statement, not decoration: without it the equation is ill-typed for `K ≠ ℚ_p`, and the `𝒪[K]ˣ`-valued character with value `u⁻¹` is a Lubin–Tate character that neither roadmap builds | `artinMap`, `cyclotomicCharacter_artinMap`, `cyclotomicCharacter_artinMap_padic` |

Throughout the table `N = [K : ℚ_p]` and `p` is the residue characteristic; `K` is a finite
extension of `ℚ_p` in every row that mentions either.

Reading the table by layer gives the schedule

```text
Pro-p Groups 0-4  →  Local Fields 0-8  →  Pro-p Groups 11  →  Local Fields 9,
```

which is acyclic. Pro-`p` Groups Layers 5–10 have no Local Fields edge in either direction, so
they are unconstrained relative to this order, and Local Fields Layers 0–3 use only the
early pro-`p` foundations.

Two conventions hold across the table, because getting either one wrong is what turns an
acyclic schedule into a circular one or grows a second carrier for an object that already has
one:

- ⚠ **`N` is the degree `[K : ℚ_p]`; `d` is a topological rank and never a degree.** The two
  occur in the same sentences (`d(G_K) = N + 2`, and `d(G_K(p))` is `N + 1` or `N + 2`), so
  neither roadmap writes `d` for the degree, in prose or in a displayed formula.
- ⚠ **Topological finite generation of `G_K` is not an input to Pro-`p` Groups.** Layer 11
  proves finite generation of `G_K(p)` from the `H¹` count alone, and Local Fields Layer 9
  consumes that result. Pro-`p` Groups Layer 8's reconstruction theorem takes
  `IsTopologicallyFinitelyGenerated` as a *hypothesis*: what it consumes is the predicate,
  which is Layer 3's, and never the Local Fields theorem that produces an instance of it.
  Reading that edge the other way would close the cycle
  `Local Fields 9 → Pro-p Groups 8 → Pro-p Groups 9 → Pro-p Groups 11 → Local Fields 9`.

### Operations taken as hypotheses

Three structures of [`Suggested.lean`](Suggested.lean) carry the operations that this roadmap
uses and does not own. A milestone that needs one names the field it uses, in its *Supplied
hypotheses* field, and the Lean statement takes the structure as an argument. No declaration here
postulates one of these operations with a `sorry`.

**`Supplied.CohomologyOps`**, the cohomology of a profinite group beyond what Mathlib `v4.32.2`
has. Mathlib supplies the carrier `continuousCohomology` and the compatible-pair `cochainsMap`,
so restriction and inflation are **not** fields here. The fields are:

| field | mathematical content | consumed by |
|---|---|---|
| `tensorObj` | the coefficient object `A ⊗ B` of a cup product. ⚠ Naming it is what stops a statement from asserting a coefficient identification that does not exist | Layer 5 Kummer, Layers 8A, 8B, 8C |
| `cup` | for coefficients `A` and `B`, the map `H^i(G,A) × H^j(G,B) → H^{i+j}(G, A ⊗ B)`, additive in each variable | Layer 5 Kummer, Layers 8A, 8B, 8C |
| `coeff` | the map on cohomology induced by a morphism of coefficient objects. Mathlib's `cochainsMap` at the identity group homomorphism gives it; it is a field so that the statements need no detour through the cochain complex | `localSymbol`, `tateDualityPairing` |

Four further operations are used **only inside proofs**, so no statement here mentions them and
none is a field. They are proof obligations of the milestones that name them:

| operation | mathematical content | used by |
|---|---|---|
| corestriction | for an open subgroup of finite index, with `cor ∘ res = [G:U] · id` and the projection formula | Layer 5 `Br(K)`, Layer 6 functoriality |
| Mackey | the double-coset formula for `res ∘ cor`, and the transfer `Ĥ⁻²(G, ℤ) → Ĥ⁻²(U, ℤ)` | Layer 6 functoriality |
| Shapiro | `H^i(G, Coind^G_U M) ≅ H^i(U, M)` for `U` open of finite index, natural in `M` | Layer 8A step 5 |
| the finite-quotient colimit | `H^i(G_K, M) ≅ colim_L H^i(Gal(L/K), M^{G_L})` over finite Galois `L/K`, in degrees `≤ 2` | Layer 5 Hilbert 90, Layer 5 `Br(K)` |

**`Supplied.ProPOps`**, the group theory of profinite and pro-`p` groups. The predicates
`IsProP`, `IsProPSylow`, `IsTopologicallyFinitelyGenerated`, and the two rank functions are
definitions built from Mathlib, and are not fields here. The fields are:

| field | mathematical content | consumed by |
|---|---|---|
| `exists_isProPSylow` | every profinite group has a pro-`p` Sylow subgroup | Layer 4 wild inertia |
| `exists_le_isProPSylow` | every closed pro-`p` subgroup lies in one | Layer 4 wild inertia |
| `sylow_eq_of_normal` | a normal pro-`p` Sylow subgroup is the only one | Layer 4 wild inertia |
| `sylow_map_of_surjective` | the image under a continuous surjection is one | Layer 4 wild inertia |
| `freeProfiniteGroupLift` | the universal property of the free profinite group, with uniqueness | Layer 4 Iwasawa presentation |
| `rank_le_of_surjective` | the rank does not increase under a continuous surjection | Layer 9 exact rank |
| `rank_le_of_isOpen` | the Schreier bound `d(U) ≤ 1 + [G:U](d(G) − 1)` for open `U` | Layer 9 exact rank |
| `topologicallyGenerates_iff_frattiniQuotient` | the Burnside criterion for a pro-`p` group, with its relative form | Layer 9 tame frame |

**`Supplied.ProPRankInputs`**, for `F/ℚ_p` finite. Three fields about the maximal pro-`p`
quotient `G_F(p)`, and none about `G_F`:

| field | mathematical content | consumed by |
|---|---|---|
| `finiteGen` | `G_F(p)` is topologically finitely generated | Layer 9 exact rank |
| `rank_of_mu` | `μ_p ⊆ F` implies `d(G_F(p)) = [F : ℚ_p] + 2`, by Demushkin | Layer 9 exact rank, lower bound |
| `rank_of_not_mu` | `μ_p ⊄ F` implies `d(G_F(p)) = [F : ℚ_p] + 1`, by Shafarevich | Layer 9 exact rank, lower bound |

⚠ Three things are **not** taken as hypotheses. They are milestones of this roadmap:

- the Tate cup product in all integer bidegrees, in Layer 6;
- every statement about the multiplicative module `(Kˢ)ˣ`, which is local arithmetic;
- the vanishing of `H^i(G_K, μ_n)` above degree `2`, which Layer 8A proves. No definition of
  cohomological dimension replaces it.

## Downstream consumers

The late layers are the intrinsic form of several statements that a `p = 2` formalization of the
absolute Galois group of `ℚ_2` assumes. The list is collected here, so that the layers above can
be read without it.

| consumer label | statement here |
|---|---|
| B1 | topological finite generation of `G_K` (Layer 9); at `K = ℚ_2`, generation by 3 elements |
| B5 | the Artin map with its normalizations, including the cyclotomic orientation (Layer 7, step 3) |
| B6, B7 | local Tate duality and the Euler characteristic in the mixed-characteristic regime (Layer 8B) |
| B10 | the tame quotient with `στσ⁻¹ = τ^q` (Layer 4), with the orientation statements of Layer 7 |
| B11a, the pairing part | the mod-2 identification of the duality pairing with the Hilbert symbol (Layer 8C) |

This roadmap specifies the mathematics, and not that code. See [`PROVENANCE.md`](PROVENANCE.md)
for what may be carried over from it and under what conditions.

## References

- J.-P. Serre, *Local Fields*, GTM 67 (1979). This is the primary source. Ch. I §§1–8 (discrete
  valuation rings, the Frobenius substitution); Ch. III §5 (unramified extensions); Ch. IV
  (ramification groups, the lower and upper numbering, the Herbrand functions); Ch. V (the norm:
  §2 the unramified case, §3 the cyclic totally ramified case of prime degree, §6 the Galois case
  and the shifted inclusion, §7 Hasse–Arf); Ch. VIII (Tate cohomology of finite groups, the
  Herbrand quotient); Ch. IX (Tate–Nakayama); Ch. X–XI (Galois cohomology, class formations, the
  existence theorem); Ch. XII–XIII (the Brauer group of a local field, local class field theory);
  Ch. XIV (local symbols, the existence theorem, `ℚ_pᵃᵇ`); Ch. XV (ramification and the numerics
  of norm groups).
- J. Neukirch, A. Schmidt, K. Wingberg, *Cohomology of Number Fields*, 2nd ed. (NSW), Ch. VII:
  (7.1.x) class formations; (7.2.6) local Tate duality; (7.2.15) the unramified annihilators;
  (7.3.1) the Euler characteristic; §7.4 (the Galois module structure of `Kˣ`, with (7.4.1) the
  generator theorem and (7.4.3) and (7.4.4) its module inputs); (7.5.2) and (7.5.3) the tame
  quotient, after Iwasawa; (7.5.11) Demushkin.
- M. Jarden, M. Shusterman, *The absolute Galois group of a `p`-adic field*, Theorem 2.1: the
  exact rank `d(G_K) = [K:ℚ_p] + 2` of the full absolute Galois group, and its distinction from
  the rank of the maximal pro-`p` quotient.
- J. Neukirch, *Algebraic Number Theory*, Ch. II (valuations, completions, the structure of the
  units, unramified and tame extensions), Ch. IV (abstract class field theory, the Frobenius-lift
  method), Ch. V (local class field theory; V (1.2) units are norms; V §6 the compatibility of
  reciprocity with the upper numbering, which Layer 7 states).
- I. B. Fesenko, S. V. Vostokov, *Local Fields and Their Extensions*, 2nd ed., Ch. I–III (unit
  filtrations, the norm map, Hasse–Herbrand theory without ramification groups), Ch. IV (local
  class field theory through the Neukirch map and the Hazewinkel map; §5 the Hilbert pairing,
  which is Layer 8C), Ch. VII–VIII (explicit formulas, Lubin–Tate theory).
- J. Milne, *Arithmetic Duality Theorems*, 2nd ed., Ch. I §§1–2: the primary source for Layer 8,
  with I.2.1 and I.2.3 duality, I.2.6 the unramified annihilators, and I.2.8 the Euler
  characteristic.
- J.-P. Serre, *Galois Cohomology*, Ch. I–II: conventions for profinite cohomology, II §5.2
  duality, II §5.7 the Euler characteristic, and the exercise on `𝔽_p`-dimensions behind the
  counting corollary.
- J.-P. Serre, *A Course in Arithmetic*, Ch. II–III: `ℚ_p`, squares, and the table of Hilbert
  symbols used by the worked examples.
- U. Jannsen, K. Wingberg, *Die Struktur der absoluten Galoisgruppe p-adischer Zahlkörper*
  (Invent. Math. 70, 1982); V. Diekert; I. G. Zelvenskii: the full presentation of `G_K` for odd
  `p` and the dyadic case, and Jannsen Satz 3.2 for the `N + 3` bound that precedes the sharp one.
- M. Hazewinkel, *Local class field theory is easy* (Adv. Math. 18, 1975): the alternative to the
  Neukirch route, consulted for the design of Layers 6 and 7.
- Cassels–Fröhlich (eds.), *Algebraic Number Theory*, the chapter "Local class field theory" by
  Serre; Artin–Tate, *Class Field Theory*, for the splitting-module route to Tate–Nakayama that
  Layer 6 uses; Iwasawa, *Local Class Field Theory* (1986); D. Harari, *Galois Cohomology and
  Class Field Theory*; J. Lubin, J. Tate, *Formal complex multiplication in local fields* (1965).

## Provenance

[`PROVENANCE.md`](PROVENANCE.md) records the state of the surrounding ecosystem on a fixed date.
It lists the Lean projects outside Mathlib that cover part of this ground. It lists the open
Mathlib pull requests that touch the substrate, and the design decisions recorded on the Lean
Zulip. It also records the conditions that apply to reuse of code from each project. That file is
a dated survey.
It is not normative, and nothing in it is a prerequisite of a milestone above.
