# Roadmap: algebraic curves — function fields, divisors, and Riemann–Roch

Mathlib at the pin (`9caeba1000`, 2026-06-03) has a rich valuation-theoretic and
Dedekind-domain substrate — `IsDedekindDomain.HeightOneSpectrum` with `ℤᵐ⁰`-valued adic
valuations, the factorization calculus `FractionalIdeal.count` (an unlabelled isomorphism
`(FractionalIdeal R⁰ K)ˣ ≅ (HeightOneSpectrum R →₀ ℤ)`), `ClassGroup`, the different ideal
with its conductor formula, `Ideal.sum_ramification_inertia`, Kähler differentials with the
full smooth/étale/separability dictionary, and even an Ostrowski theorem classifying the
places of `RatFunc K` over an arbitrary field `K` — and **no theory of algebraic curves at
all**: a whole-library grep finds **zero** occurrences of `genus`, zero of `Riemann–Roch`,
zero divisor types of any kind (every `divisor` hit in `Mathlib/AlgebraicGeometry/` is
`NoZeroDivisors`), no degree of a closed point, no `L(D)`, no canonical divisor, no Weil
differentials or repartitions, no product formula for function fields, and no
Riemann–Hurwitz. The in-flight modular-curves roadmap
([PR #81](https://github.com/TauCetiProject/TauCetiRoadmap/pull/81), Katz–Mazur,
C. Birkbeck) names this gap as its one assumed input:

> **Riemann–Roch and the coherent cohomology of curves** — an independent formalization
> effort is building these, so this roadmap never constructs them: the critical path to the
> modular curves does not use them at all, and the one milestone that mathematically needs
> them (Layer 1's genus-`1` ⟹ locally-Weierstrass converse) is stated against an **assumed
> Riemann–Roch interface**, an explicit hypothesis to be discharged by that external work
> when it lands.

This roadmap is that external work. It builds the theory of algebraic function fields of
one variable — places, divisors, the class group, Riemann–Roch spaces `L(D)` and `ℓ(D)`,
the genus, **Riemann–Roch** proved with Weil differentials and the canonical class by the
adele/repartition argument, its consequences (the `deg > 2g − 2` regime, Clifford,
Weierstrass gaps), extensions of function fields with ramification, the different and
**Riemann–Hurwitz**, constant-field extensions (with the inseparable traps pinned
honestly), the model classes (elliptic, hyperelliptic, smooth plane curves), automorphism
groups with the Hurwitz `84(g−1)` bound, and — as a definite later layer — the dictionary
between function fields and regular projective curves, where the comparison contracts with
the scheme-cohomological world live.

**Route decision (pinned).** The development is **function-field-first**, following
Stichtenoth: a curve *is* its field of algebraic functions, places are normalized discrete
valuations, and Riemann–Roch is proved by Weil's repartition argument — linear algebra over
`k` inside the restricted product `∏'_P F`, with no schemes, no sheaves, and no cohomology.
This matches where the pin is strong (valuations, Dedekind domains, `RatFunc`, Laurent
series) and where it is empty (no coherent cohomology, no scheme dimension theory, no
divisors on schemes: the sheaf-cohomological route would spend its entire budget building
`Hⁱ` before stating anything). The scheme-theoretic formulation is not abandoned but
*layered*: the merged [JacobianChallenge](../JacobianChallenge/README.md) roadmap builds
scheme divisors, coherent cohomology, and Serre duality on the way to `Pic⁰` (its Layers
A–B state Riemann–Roch as `χ(L) = deg L + 1 − g` with `g := dim H¹(X, 𝒪_X)`), and this
roadmap's final layer carries the **comparison contract** identifying the two theories over
the curves ↔ function-fields dictionary, so the two routes meet instead of duplicating
(§Provenance). Elliptic curves are deliberately *not* redeveloped here: the in-flight
[elliptic-curves roadmap (PR #68)](https://github.com/TauCetiProject/TauCetiRoadmap/pull/68)
owns the arithmetic of `WeierstrassCurve.FunctionField` and proves everything it needs
"with no Riemann–Roch anywhere"; this roadmap supplies the *general* theory its Layer-0
place-and-divisor interface instantiates, with named compatibility milestones
(§Provenance).

Suggested home: `TauCeti/FieldTheory/FunctionField/`, with subdirectories per layer
(`Place/`, `RatFunc/`, `AffineModel/`, `Divisor/`, `RiemannRoch/`, `Consequences/`,
`Extension/`, `Different/`, `ConstantExtension/`, `Differential/`, `Examples/`,
`Automorphism/`), and the final dictionary layer under `TauCeti/AlgebraicGeometry/Curve/`.
Justification: the objects of Layers 0–11 are field-theoretic — valuations of `F` trivial
on `k`, `Finsupp` divisors, subspaces of `F` — and their Mathlib substrate lives in
`Mathlib/FieldTheory/RatFunc/`, `Mathlib/RingTheory/Valuation/`, and
`Mathlib/RingTheory/DedekindDomain/`; Mathlib's own `Mathlib/NumberTheory/FunctionField.lean`
is the *global-fields* view (finite constant field, one chosen generator), which is the
CurvesOverFiniteFields specialization ("Wave 2" here and below = the planned second wave
of LMFDB-background roadmaps, following the current wave this roadmap belongs to), not
the general theory; and
`TauCeti/AlgebraicGeometry/` is where the dictionary layer's outputs belong, next to the
JacobianChallenge home, so the two roadmaps meet in one namespace. ⚠ Name hygiene: Mathlib's
`FunctionField Fq F` is an `abbrev` for `FiniteDimensional Fq⟮X⟯ F` *relative to a chosen*
`Algebra (RatFunc Fq) F` instance; the intrinsic predicate defined here gets a distinct
name (`IsFunctionField`, see conventions) and a comparison lemma, never a redefinition.
Note also the pin's notation collision: `F⟮X⟯` is scoped notation for `RatFunc F` while
`F⟮y⟯` is `IntermediateField.adjoin F {y}` — both appear in this theory; spell out
`RatFunc` where confusion is possible.

## Scope boundaries (what is deliberately not here)

- **Zeta functions and everything over finite constant fields as such** (Stichtenoth Ch. 5:
  rationality, the functional equation, Hasse–Weil) → the Wave-2 **CurvesOverFiniteFields**
  roadmap (roadmap in preparation). This roadmap proves the finite-field-relevant *inputs*
  that are pure Riemann–Roch (finiteness of the degree-zero class group over a finite
  constant field — the zeta-free half of Stichtenoth 5.1, Lemma 5.1.1 + Prop. 5.1.3; the
  class-number finiteness bridge to Mathlib's `ClassGroup (ringOfIntegers Fq F)`), and
  stops there.
- **Jacobians and abelian varieties** → [JacobianChallenge](../JacobianChallenge/README.md)
  (construction) and the Wave-2 AbelianVarieties roadmap (arithmetic). Here `Cl⁰(F)` is a
  plain abelian group; giving it a variety structure is exactly the JacobianChallenge.
- **Modular curves** → PR #81 (algebraic, Katz–Mazur) and PR #47's Layer 10 (the analytic
  quotient `Γ\ℍ*` with its genus via Euler characteristics — its dimension-formula upper
  bounds go by the valence formula, and the lower bounds are gated on a planned analytic
  compact-Riemann-surfaces Riemann–Roch, not on this roadmap, so it consumes nothing
  from here; the eventual analytic ↔ algebraic genus comparison is flagged as horizon in
  the dictionary layer).
- **Elliptic-curve specifics** → PR #68 (isogenies, torsion, heights, Mordell–Weil, …).
  Here elliptic function fields appear once, as the genus-1 model class with the
  compatibility milestones of Layer 10.
- **Hyperelliptic arithmetic invariants** (Igusa invariants, minimal models, cluster
  pictures) → Wave-2 HyperellipticCurves; here hyperelliptic function fields are a model
  class (existence of the degree-2 rational subfield, the genus formula).
- **Belyi maps and dessins** → Wave-2 BelyiMaps, which will consume this roadmap's
  extension/ramification layers and Riemann–Hurwitz.

## Standing hypotheses

The standing setting is a field `k` and a field `F` with `[Field k] [Field F]
[Algebra k F]`, satisfying the one-variable function-field predicate pinned below
(`IsFunctionField k F`: some `x : F` is transcendental over `k` with `F` finite over
`k(x)`). Spell the hypotheses out; do not bundle them into a structure. Two further
hypotheses appear constantly and must always be **explicit**, never absorbed:

- **Exactness of the constant field.** Pinned spelling: Mathlib's
  `IsIntegrallyClosedIn k F` — for a field extension integral = algebraic, so this says
  every element of `F` algebraic over `k` is in the image of `algebraMap k F` (the
  literature's "`k` is the full / exact field of constants"; Stichtenoth's standing
  assumption from Ch. 1 §1.4 on); equivalently `algebraicClosure k F = ⊥` in the pin's
  relative-algebraic-closure vocabulary, with both faces of the dictionary Layer-0
  milestones. The general theory of places (Layer 0) does not need it; everything from
  divisor degrees on behaves badly without it (`ℓ(0) = [k̃ : k]`, degrees rescale) — so it
  is a stated hypothesis from Layer 3 onward, and the finiteness of the constant field
  `k̃/k` (already in Mathlib as `FunctionField.finiteDimensional_of_constantExtension`)
  plus the base-change device `F/k̃` are early milestones, so a consumer can always *pass*
  to the exact situation.
- **Perfectness / separability, where the mathematics needs it.** ⚠ Never write
  `[PerfectField k]` as a blanket assumption. The core theory (Layers 0–5, through
  Riemann–Roch and its consequences) is characteristic-free and perfectness-free —
  Stichtenoth's Ch. 1 assumes nothing of `k`, and his Ch. 3's chapter-wide "`k` perfect"
  umbrella is consumed by far fewer results than it covers (the per-theorem audit is in
  Layers 6–8). The places where hypotheses genuinely enter,
  each pinned at its layer: separability of `F′/F` for the Hurwitz genus formula (Layer 7;
  false without it); `k` perfect (or the milder "`F/k` separably generated / conserved")
  for genus invariance under constant-field extension (Layer 8; **false in general** —
  inseparable constant extensions can drop the genus); `EssFiniteType`-style hypotheses on
  the Kähler comparison exactly as the pin's `FormallyUnramified.iff_isSeparable` carries
  them (Layer 9); characteristic-zero (or `p`-bounds) for the Hurwitz automorphism bound
  (Layer 11). Statements must carry their true hypotheses; every "char 0 for simplicity"
  shortcut in the literature is a trap flagged at its layer.

Do not fix `k` finite, algebraically closed, or of characteristic zero in the general
layers: the LMFDB consumers live over `ℚ` and number fields (genus of modular and Shimura
curves), over finite fields (Wave 2), and over `ℂ` (Belyi); the theory is stated over an
arbitrary field with the honest hypotheses above.

## Pinned conventions

| object | convention | source of truth |
|---|---|---|
| function field | `IsFunctionField k F : Prop` — `∃ x : F, Transcendental k x ∧ FiniteDimensional k(x) F` (intrinsic; no chosen generator). Comparison lemmas to Mathlib's chosen-generator `FunctionField Fq F` and to `Algebra.trdeg k F = 1` (for f.g. `F`) are Layer-0 milestones, not definitions | Layer 0; `Mathlib/NumberTheory/FunctionField.lean` |
| place | a **normalized** discrete valuation: `v : Valuation F ℤᵐ⁰` with `Function.Surjective v` and `v` trivial on `k` (`v (algebraMap k F c) = 1` for `c ≠ 0`; Mathlib's `Valuation.IsTrivialOn`). Normalization kills the equivalence-class quotient: place equality *is* valuation equality. The unnormalized view (equivalence classes of valuations / valuation subrings `k ⊆ 𝒪 ⊊ F`) is related by early milestones, aligned with the hypotheses of the pin's `RatFunc.valuation_isEquiv_infty_or_adic` (`IsRankOneDiscrete` + `IsTrivialOn`) | Layer 0 |
| multiplicative vs additive | Mathlib's multiplicative convention: integers are `v ≤ 1`, uniformizers have `v π = exp (−1)` (matching `intValuation`); the additive order `ord_P = −WithZero.log ∘ v_P : F → ℤ` (junk value `0` at `f = 0`, flagged in every statement) with `ord_P π = 1`. The translation is one named lemma, as in the LocalFields sibling | `Mathlib/RingTheory/DedekindDomain/AdicValuation.lean` |
| valuation ring, residue field, degree | `𝒪_P` = the valuation subring of `v_P`; residue field `F_P := IsLocalRing.ResidueField 𝒪_P` (never a bespoke quotient); **`deg P := Module.finrank k F_P`**. Finiteness `Module.Finite k F_P` is a theorem (Layer 0), not part of the definition; `finrank`'s junk value `0` is guarded by it | Layer 0 |
| divisor | **`Divisor k F := Place k F →₀ ℤ`** (`Finsupp`), with the pointwise partial order (`Mathlib/Data/Finsupp/Order.lean`), `D⁺/D⁻` decomposition, and support API for free. Effective means `0 ≤ D`. Never a quotient of formal sums, never a `Multiset` | Layer 3 |
| degree of a divisor | `Divisor.degree : Divisor k F →+ ℤ`, `D ↦ ∑ P ∈ D.support, D P * deg P` (`Finsupp.liftAddHom`). ⚠ `deg` weights by residue degrees; the naive `∑ D P` is only correct over algebraically closed `k` and is never the definition | Layer 3 |
| principal divisor | `div f := ∑ P, ord_P f · P` for `f ∈ Fˣ` — a group hom `Fˣ →+ Divisor k F` (additivized); support finiteness (zeros and poles are finite) is the enabling theorem. Zero divisor `div₀ f = (div f)⁺`, pole divisor `(div f)⁻` | Layer 3 |
| class group | `Cl(F) := Divisor ⧸ principal`, `Cl⁰(F) := ker deg ⧸ principal` (`deg (div f) = 0` is the product formula, a theorem). Bridge milestones to Mathlib's `ClassGroup` of affine models via `FractionalIdeal.count`, never a redefinition of `ClassGroup` | Layers 3, 10 |
| Riemann–Roch space | `L(D) : Submodule k F`, carrier `{f | ∀ P, v_P f ≤ exp (D P)}` (equivalently `f = 0 ∨ div f + D ≥ 0`); **`ℓ(D) := Module.finrank k (L D)`** with finiteness a Layer-3 theorem. `L(0) = k` iff the constant field is exact | Layer 3 |
| genus | `g(F/k) := sSup (Set.range fun D => (deg D + 1 − ℓ(D)).toNat)` — Stichtenoth's definition; well-defined (bounded) by Riemann's theorem, which also pins the characterization `∃ c, ∀ D, deg D ≥ c → ℓ(D) = deg D + 1 − g`. Genus is **defined before** Riemann–Roch and never via `H¹` or differentials; the identities `ℓ(W) = g`, `deg W = 2g − 2` are theorems | Layer 3 |
| repartitions / adeles | `A_F` := the restricted product `{a : Place k F → F // ∀ᶠ P in cofinite, ord_P (a P) ≥ 0}` — entries in `F` itself (Chevalley's repartitions; Stichtenoth's 𝒜_F), **no completions**. The completion-level `FiniteAdeleRing` of an affine model is related by a Layer-5 comparison milestone, not used in the RR proof. `A_F(D)` the sub-`k`-space with `ord_P (a P) ≥ −D P` everywhere | Layer 4 |
| Weil differential | a `k`-linear map `ω : A_F → k` vanishing on `A_F(D) + F` for some `D`; `Ω_F` the `F`-vector space of them (`(f · ω) a := ω (f · a)`), one-dimensional over `F`. The **canonical divisor** `(ω)` of `ω ≠ 0` is the largest `D` with `ω` vanishing on `A_F(D) + F`; canonical class `W = [(ω)]`, well-defined | Layer 4 |
| differential formalism | **Weil differentials are the formalism of record** for the canonical class and the RR proof (they exist at the pin's vocabulary level with no new analysis); Mathlib's Kähler differentials `Ω[F⁄k]` (`KaehlerDifferential`) enter in Layer 9, where `dim_F Ω[F⁄k] = 1` (separably generated case) and the comparison isomorphism Kähler ≅ Weil via residues are **named milestones** — after which `(dx)` is a canonical divisor and the two formalisms are interchangeable. Neither is redefined in terms of the other before that layer | Layers 4, 9 |
| extensions of function fields | `F′/F` with `[Algebra F F′]`, both function fields, `k′ ⊇ k` the respective constant fields; `P′ ∣ P` ("lies over") iff `v_{P′}` restricted to `F` is equivalent to `v_P`; `e(P′∣P)` the ramification index (`v_{P′}(x) = e · v_P(x)` on `Fˣ`, in additive form), `f(P′∣P) := [F′_{P′} : F_P]` the relative residue degree. Reconciliation lemmas with `Ideal.ramificationIdx`/`Ideal.inertiaDeg` at affine models — one bridge each, consumers never forced through the `sSup`/`if` definitions. ⚠ churn flag: the pin's own docstrings announce replacement by `ramificationIdx'`/`inertiaDeg'` | Layer 6 |
| the different | the different **divisor** `Diff(F′/F) := ∑ d(P′∣P) · P′` with `d(P′∣P)` the different exponent, defined via the trace dual as in the pin's `differentIdeal` (`Mathlib/RingTheory/DedekindDomain/Different.lean`) and computed at all places by the two-charts device; the identity `v_{P′}(differentIdeal) = d(P′∣P)` at affine models is the reconciliation milestone | Layer 7 |

## What Mathlib already has (consume)

Verified against the pin `9caeba1000` (2026-06-03). "master:" flags post-pin material, to
be consumed on a toolchain bump rather than rebuilt.

- **The chosen-generator function-field predicate**,
  `Mathlib/NumberTheory/FunctionField.lean`: `FunctionField Fq F` (an `abbrev` for
  `FiniteDimensional Fq⟮X⟯ F` given `[Algebra (RatFunc Fq) F]` — stated for an *arbitrary*
  field `Fq`, despite the file's finite-field framing), `functionField_iff`;
  `FunctionField.ringOfIntegers := integralClosure Fq[X] F` with `IsFractionRing`,
  `IsIntegrallyClosed`, and — under `[Algebra.IsSeparable Fq⟮X⟯ F]` —
  **`IsDedekindDomain (ringOfIntegers Fq F)`**; crucially
  `FunctionField.finiteDimensional_of_adjoin_transcendental` (*any* transcendental `y` has
  `F/Fq(y)` finite — the independence-of-the-variable engine) and
  `FunctionField.finiteDimensional_of_constantExtension` (finiteness of the constant
  field). ⚠ The infinity-place API moved on 2026-04-14: use `RatFunc.inftyValuation`,
  `RatFunc.inftyValued`, `RatFunc.CompletionAtInfty` in
  `Mathlib/FieldTheory/RatFunc/Valuation.lean`; the `FunctionField.inftyValuation*` and
  `FqtInfty` names are deprecated aliases.
- **The rational function field**, `Mathlib/FieldTheory/RatFunc/`: `RatFunc K` with
  `num`/`denom`, `intDegree` (`Degree.lean`), `RatFunc.inftyValuation` with
  `v_∞(f) = exp (intDegree f)` and the instances `Valuation.IsNontrivial` and
  `Valuation.IsTrivialOn` (`Valuation.lean`); `algebraicClosure k F`
  (`FieldTheory/AlgebraicClosure.lean`, the relative algebraic closure as an
  `IntermediateField`) with `IsIntegrallyClosedIn`
  (`RingTheory/IntegralClosure/IntegrallyClosed.lean`) — the constant-field/exactness
  vocabulary; `RatFunc.algEquivOfTranscendental`
  (`RatFunc K ≃ₐ[K] K(f)` for transcendental `f`), the `X`-adic
  `Polynomial.idealX : HeightOneSpectrum K[X]`;
  `RatFunc.finrank_eq_max_natDegree` (**the degree of a rational map**:
  `[K(X) : K(f)] = max (natDegree f.num) (natDegree f.denom)`), `RatFunc.adjoin_X = ⊤`,
  and Lüroth's theorem (`Luroth.lean`: every intermediate field of `K(X)/K` other than `K`
  is again rational) — prior art for the genus-0 layer.
- **Ostrowski for `RatFunc`**, `Mathlib/NumberTheory/RatFunc/Ostrowski.lean`
  (de Frutos-Fernández–Généreux, 2025):
  `RatFunc.valuation_isEquiv_infty_or_adic` — every `[IsRankOneDiscrete]`,
  `[IsTrivialOn K]` valuation on `RatFunc K` is equivalent to exactly one of `v_∞` or a
  `(p(X))`-adic valuation, over an **arbitrary** field `K`. This *is* the classification of
  places of the rational function field; Layer 1 repackages it in the normalized-place
  vocabulary rather than reproving it.
- **The Dedekind substrate** — the affine half of the divisor theory, ready-made:
  `IsDedekindDomain.HeightOneSpectrum` with `intValuation`/`valuation K : Valuation K ℤᵐ⁰`,
  `valuation_exists_uniformizer`, `valuation_surjective`,
  `eq_of_valuation_isEquiv_valuation` (places separate), `valuationSubringAtPrime`
  (`Mathlib/RingTheory/DedekindDomain/AdicValuation.lean`); the factorization calculus
  (`Factorization.lean`): **`FractionalIdeal.count K v I : ℤ`** with `count_mul`,
  `count_inv`, `count_zpow`, `count_finsuppProd`, `FractionalIdeal.finite_factors`
  (cofinite vanishing), and `finprod_heightOneSpectrum_factorization'` — collectively
  `(FractionalIdeal R⁰ K)ˣ ≅ (HeightOneSpectrum R →₀ ℤ)` in all but name, which is why
  divisors are pinned as `Finsupp`; `ClassGroup R` with `ClassGroup.mk0`,
  `ClassGroup.equivPic` (`Mathlib/RingTheory/PicardGroup.lean` — the new module-theoretic
  `CommRing.Pic`); S-integers/S-units (`SInteger.lean`); `Ideal.dvd_iff_le`,
  `UniqueFactorizationMonoid (Ideal A)`; `IsIntegralClosure.isDedekindDomain` and
  `integralClosure.isFractionRing_of_finite_extension` (`IntegralClosure.lean`) — the
  engine for Layer 2's affine models. Also `HeightOneSpectrum.valuationOfNeZero :
  Kˣ →* Multiplicative ℤ` (`SelmerGroup.lean`), the closest existing `ord_v`.
- **Ramification bookkeeping**, `Mathlib/NumberTheory/RamificationInertia/`:
  `Ideal.ramificationIdx`, `Ideal.inertiaDeg`, and
  **`Ideal.sum_ramification_inertia`** (`∑_{P ∣ p} e·f = finrank K L`, with `[IsDedekindDomain R]`,
  fraction fields, `[Module.Finite R S]`, `p` maximal `≠ ⊥`) — Layer 6's fundamental
  identity at affine models; `Galois.lean` (transitivity of the action on `primesOver`,
  well-defined `ramificationIdxIn`/`inertiaDegIn`), `HilbertTheory.lean` (decomposition and
  inertia fields). ⚠ Both core definitions carry docstrings announcing replacement by
  `ramificationIdx'`/`inertiaDeg'` (`Mathlib/RingTheory/RamificationInertia/`) — state
  reconciliation lemmas once and keep consumers off the raw definitions.
- **The different ideal**, `Mathlib/RingTheory/DedekindDomain/Different.lean` (962 lines,
  substantial): `Submodule.traceDual`, `FractionalIdeal.dual`, `differentIdeal A B` with
  `coeIdeal_differentIdeal`, **transitivity in towers**
  (`differentIdeal_eq_differentIdeal_mul_differentIdeal`), the **conductor formula**
  `conductor_mul_differentIdeal` (`𝔠(x) · 𝔡 = (f′(x))` for a generator), the divisibility
  `pow_sub_one_dvd_differentIdeal` (`P^{e−1} ∣ 𝔡`), and
  `dvd_differentIdeal_iff ↔ ¬Algebra.IsUnramifiedAt` (separable case). ⚠ The **exact tame
  valuation `v_P(𝔡) = e − 1`** is absent (within the scope of the file's generic
  properties-of-the-different TODO) — building it is a Layer-7 milestone, not an import.
- **Kähler differentials**, `Mathlib/RingTheory/Kaehler/` and friends:
  `KaehlerDifferential` (`Ω[S⁄R]`) with the universal derivation, base change,
  localization instances, `polynomialEquiv` (`Ω[R[X]⁄R] ≃ R[X]`), the second fundamental
  sequence (`exact_kerCotangentToTensor_mapBaseChange`), and
  `Algebra.Presentation.differentialsRelations`
  (`Mathlib/Algebra/Module/Presentation/Differentials.lean`) — the tools that compute
  `Ω[k(x,y)/(f) ⁄ k]` for a plane curve. Separability is fully wired:
  `Algebra.FormallyUnramified` *is* `Subsingleton Ω[A⁄R]`,
  `FormallyUnramified.iff_isSeparable` under `EssFiniteType`,
  `FormallySmooth.of_algebraicIndependent_of_isSeparable` (separably generated ⟹ formally
  smooth), and `exists_isTranscendenceBasis_and_isSeparable_of_perfectField`
  (`Mathlib/FieldTheory/SeparablyGenerated.lean`). ⚠ `KaehlerDifferential` appears
  **nowhere** in `Mathlib/FieldTheory/`: there is no `rank Ω[L⁄K] = trdeg K L`, no
  separating-basis basis of `Ω`, in particular no `dim_F Ω[F⁄k] = 1` — that is Layer 9's
  load-bearing gap.
- **Transcendence**, `Mathlib/RingTheory/AlgebraicIndependent/`: `Algebra.trdeg`
  (cardinal-valued), `trdeg_add_eq` (the tower formula, Stacks 030H),
  `Polynomial.trdeg_of_isDomain = 1`, `exists_isTranscendenceBasis`,
  `Algebra.Transcendental`/`Transcendental R x`. ⚠ No bridge `trdeg k F = 1` + f.g. ⟹
  function field — a short, real Layer-0 gap.
- **Completions at places**: `v.adicCompletion K`/`adicCompletionIntegers`
  (`AdicValuation.lean`), and the complete `X`-adic comparison
  `RatFunc → LaurentSeries` (`Mathlib/RingTheory/LaurentSeries.lean`:
  `LaurentSeriesRingEquiv`, `powerSeriesAlgEquiv`, `coe_range_dense`, `CompleteSpace K⸨X⸩`)
  — Layer 5's local-components prior art. ⚠ Only the `X`-adic place: `CompletionAtInfty`
  is a bare type with no `≃ K((1/X))`; `FiniteAdeleRing R K` exists as a topological ring
  with **no** `A(D)` filtration, no discreteness/cocompactness of `K`, no strong
  approximation.
- **Elliptic curves**, `Mathlib/AlgebraicGeometry/EllipticCurve/`: `WeierstrassCurve` with
  **`IsElliptic`** (⚠ the old `EllipticCurve` structure is gone, no alias),
  `Affine.CoordinateRing := AdjoinRoot W.polynomial` (with `IsDomain` but ⚠ **no
  `IsDedekindDomain` instance** — supplying it via the general affine-model layer is a
  milestone #68 also wants), `Affine.FunctionField := FractionRing CoordinateRing`,
  `Point.toClass : W.Point →+ Additive (ClassGroup W.CoordinateRing)` **injective only**
  (surjectivity is PR #68's seeded `toClass_surjective`), division polynomials, normal
  forms, `j`, minimal models and reduction types over DVRs (`Reduction.lean`), and the
  formal `WeierstrassCurve.LFunction` — the concrete curve family every genus-1 milestone
  is checked against.
- **Plane-curve toolkit**: `Polynomial.Bivariate` (`R[X][Y]`, `evalEval`, `swap`,
  `equivMvPolynomial` with `pderiv` bridges), `MvPolynomial.IsHomogeneous` +
  `homogeneousComponent` + Euler's identity, `Polynomial.resultant` and `Polynomial.discr`
  (`Mathlib/RingTheory/Polynomial/Resultant/Basic.lean`), `AdjoinRoot` API. ⚠ No
  homogenization operator, no Bézout, no intersection multiplicity.
- **Scheme side (for the dictionary layer only)**: `Scheme.functionField` (stalk at the
  generic point; no valuations attached), `Spec`, `Proj` **with properness over
  `Spec 𝒜₀`** (`ProjectiveSpectrum/Proper.lean`), the valuative criterion, morphism
  properties (`IsProper`, `IsSeparated`, `LocallyOfFiniteType`, smoothness with relative
  dimension), `Geometrically/{Reduced,Integral,…}`,
  `finite_appTop_of_universallyClosed` (`Γ(X,⊤)` finite over `k` for integral proper `X`
  — the `H⁰` end of finiteness and nothing more), `Scheme.Modules` an abelian category,
  `SheafOfModules.IsQuasicoherent`. ⚠ No divisors, no `Pic(X)`, no dimension theory, no
  coherent cohomology, no `ℙⁿ` as a named scheme.

### What is in motion elsewhere (checked 2026-07-30; coordinate, cite, do not fork)

The Riemann–Roch space is **crowded and hot as of July 2026** — two essentially complete
Lean 4 formalizations exist and a coordinated Mathlib PR campaign is running. This roadmap
was audited against all of it; the coordination obligations are binding (§Provenance).

- **[vaca22/riemann-roch-function-fields](https://github.com/vaca22/riemann-roch-function-fields)**
  (Guanghao Li; Apache-2.0; created 2026-07-13, against Mathlib v4.31.0). A complete,
  kernel-checked, **sorry-free, axiom-clean function-field Riemann–Roch**: intrinsic
  places (DVR-subring valuations), divisors indexed by places, adele spaces, Weil
  differentials, canonical divisors, genus, full RR
  (`ℓ(D) = deg D + 1 − g + ℓ(W − D)`), duality, Riemann's and Clifford's inequalities,
  and the applications "Weierstrass curves have genus 1" and the degree-one-places ↔
  Picard-group / elliptic-curve group-law link — **the same mathematics as Layers 0–5 and
  parts of 10 of this roadmap**, by the same (Stichtenoth-style) route. Its README states
  upstreaming to Mathlib is in progress, with live PRs #41729 (Dedekind divisor-group
  core), #41732, #41728, #41696; it already has a downstream consumer
  ([yuma-mizuno/markoff-modp](https://github.com/yuma-mizuno/markoff-modp), strong
  approximation for Markoff triples). This is the single largest overlap with this
  roadmap; the coordination stance is pinned in §Provenance.
- **Mathlib's scheme-side "conditional Riemann–Roch" campaign** (Raphael Douglas Giles,
  Raph-DG): draft PR [#41621](https://github.com/leanprover-community/mathlib4/pull/41621)
  (2026-07-11, sorry-free WIP, ~6k lines) proves `χ(𝒪_X(D)) = deg D + χ(𝒪_X)` for
  locally Noetherian integral schemes of dimension ≤ 1 over a field, *conditional on*
  finiteness/vanishing of coherent cohomology; merged substrate **already on master and
  absent from this pin**: `AlgebraicGeometry/AlgebraicCycle/Basic.lean` (#37901,
  2026-06-25 — cycles as locally finite point functions on kebekus's
  `Function.locallyFinsupp`), `AlgebraicGeometry/OrderOfVanishing.lean` (#29774,
  2026-07-02); open stack: #38472 (principal Weil divisors), #38953 (the sheaf `𝒪_X(D)`),
  #41198 (degree of a zero-cycle), #41042, #38002, #41317, #40509. ⚠ This campaign owns
  the scheme-side divisor namespace on Mathlib master; Layer 12's dictionary milestones
  must be stated against `AlgebraicCycle`/`OrderOfVanishing` vocabulary on the next
  toolchain bump (refactor-onto flags in Layer 12), and this roadmap's function-field
  divisors must never fork a rival scheme-divisor notion.
- **Sheaf-cohomology substrate** (Brian Nugent, UW; with J. Riou's sites-level
  `Sheaf.H` already at the pin): merged #34267/#35785/#34742/#32412 (abelian sheaves,
  flasque, cohomology API, Artinian schemes); open #36218 (long exact sequence), #35790
  (flasque vanishing), #36345 (affine vanishing); plus J. Alama's Euler-characteristic
  PRs (#31121 merged, #29713 open). This is the cohomological route's infrastructure —
  consumed by #41621, relevant here only to Layer 12's contract statements.
- **The algebraic Jacobian-challenge line**: Buzzard's 2026 challenge (compact Riemann
  surfaces; solved sorry-free by rkirov/jacobian-claude, lean-eval-verified 2026-06-11)
  and **Christian Merten's algebraic reformulation** (Zulip #Autoformalization > "Jacobian
  challenge") — the [JacobianChallenge](../JacobianChallenge/README.md) roadmap is its
  TauCeti home; an external workspace
  ([AxelDlv00/LeanAlgebraicGeometry](https://github.com/AxelDlv00/LeanAlgebraicGeometry),
  active 2026-07-30) attacks the Picard-scheme route with `RiemannRoch/Ledger` files.
  Overlap with this roadmap is confined to the Layer-12 contracts.
- **Graph Riemann–Roch** (Baker–Norine): DhyeyMavani2003/chip-firing-with-lean
  (Mavani–Pflueger, arXiv:2606.16679, sorry-free) — no mathematical overlap, but a
  naming precedent for `Divisor`/`deg`/`genus`-style identifiers in the Lean ecosystem,
  and a reminder to namespace ours under the function-field theory.
- **Elliptic-curve upstream motion**: PR #25983 (Angdinata, affine scheme of an elliptic
  curve, open since 2025-06); the Angdinata–Xu ITP 2023 paper's stated future work is
  exactly "a version of the Riemann–Roch theorem" to redefine elliptic curves — their
  group law deliberately routes around RR via `ClassGroup`, which is why Layer 10's
  compatibility milestones close the triangle without re-proving the group law.
- **Zulip threads of record**: #Is-there-code-for-X? > "Riemann-Roch" (latest activity
  2025-12-19); #Autoformalization > "Jacobian challenge" (Merten's algebraic version);
  #maths > "thoughts on elliptic curves" (2020 — RR named as the blocker); the Banff
  2023 "Riemann–Roch race" blog post and the AIM "Formalising algebraic geometry"
  workshop report (June 2024) — RR has been a named community target for three years;
  this roadmap is the TauCeti vehicle for the function-field lane.
- **Isabelle/Coq**: no Riemann–Roch for curves or function fields in AFP or Coq/Rocq
  (checked 2026-07-30); the Coq elliptic-curve library explicitly avoids RR. No prior-art
  obligations outside Lean.

## What is missing (build here)

Everything curve-theoretic. The intrinsic function-field predicate and its equivalence
with `trdeg = 1` (f.g. case). Places as first-class objects with the place at infinity a
citizen equal to the `HeightOneSpectrum` places; degrees of places with their finiteness
(no Zariski-lemma-shaped `FiniteDimensional k (R ⧸ m)` exists at the pin — even `deg` needs
foundational work); the classification of places of `k(x)` in place vocabulary; weak
approximation. The divisor group as `Finsupp`, degree, principal divisors with the
finiteness of zeros and poles, the **product formula `deg (div f) = 0`** (absent for
function fields despite every ingredient existing), the class group and `Cl⁰`. `L(D)`,
its finite-dimensionality, `ℓ(D)`, Riemann's theorem, the genus, the index of specialty.
Repartitions `A_F`, the filtration `A_F(D)`, `i(D) = dim (A_F / (A_F(D) + F))`, Weil
differentials, `dim_F Ω_F = 1`, the canonical divisor, **Riemann–Roch**, `deg W = 2g − 2`,
`ℓ(W) = g`, strong approximation, Clifford, Weierstrass gaps, local components. The whole
extension theory in place vocabulary (`e`, `f`, the fundamental identity, Kummer's
factoring theorem) with its affine-model reconciliations; the different divisor, the exact
tame different value, the **Hurwitz genus formula**; constant-field extension theory with
the honest inseparability hypotheses; `dim_F Ω[F⁄k] = 1` and the Kähler ↔ Weil comparison
with residues and the residue theorem; the genus computations for the model classes
(rational, elliptic, hyperelliptic, smooth plane quartics and `(d−1)(d−2)/2`); finiteness
of automorphism groups (`g ≥ 2`) and the `84(g−1)` bound; and the curves ↔ function-fields
dictionary with the cross-roadmap comparison contracts. None of this exists upstream in
any form.

---

## The build, in layers

The ordering below is the dependency order. As each layer makes the next layer's types
expressible in `TauCeti/`, its milestones are added to `Suggested.lean` with `sorry`.
Stichtenoth (2nd ed., GTM 254) is the primary source; section citations are given per
layer, theorem-level citations per milestone.

### Layer 0: function fields, constant fields, and places

Stichtenoth I.1, I.3; Appendix A. (Ch. 1 of Stichtenoth carries **no** hypotheses on `k`
beyond `Field`; the full-constant-field assumption enters only at §1.4 — mirror that.)

- **The predicate.** `IsFunctionField k F` as pinned (intrinsic; Stichtenoth Def. 1.1.1 —
  note his definition does *not* require `k` exact). Milestones: any transcendental
  `y : F` works as a variable (Rem. 1.1.2; consume
  `FunctionField.finiteDimensional_of_adjoin_transcendental`); comparison with Mathlib's
  chosen-generator `FunctionField`; `IsFunctionField` ⟺ `Algebra.trdeg k F = 1` +
  `Algebra.FiniteType k F` (the missing trdeg bridge — build it here); stability under
  finite extension and under passing to the constant field `k̃`.
- **The constant field.** `k̃ := algebraicClosure k F` — the pin's relative algebraic
  closure of `k` in `F` (an `IntermediateField k F`, Stacks 09GI), consumed, not rebuilt;
  it is finite over `k` (Cor. 1.1.16; consume
  `finiteDimensional_of_constantExtension`); `IsIntegrallyClosedIn k F` as pinned, with
  the `∀`-algebraic and `algebraicClosure k F = ⊥` equivalences as milestones;
  `F/k̃` is a function field with exact constants — the normalization device every later
  layer cites.
- **Places.** The `Place k F` structure as pinned (normalized valuation, trivial on `k`);
  the valuation subring `𝒪_P` (Stichtenoth's Def. 1.1.4: `k ⊊ 𝒪 ⊊ F` with
  `z ∈ 𝒪 ∨ z⁻¹ ∈ 𝒪`) with its `IsLocalRing`/`ValuationRing` instances, maximal ideal,
  uniformizers ("prime elements"); **`𝒪_P` is a DVR** (Thm. 1.1.6: `P` principal,
  `z = tⁿu` uniquely; in Lean: `IsDiscreteValuationRing` — for a surjective
  `ℤᵐ⁰`-valuation this is direct; consume the pin's `Valuation.IsRankOneDiscrete` API and
  `valuationSubring_isDiscreteValuationRing`); `ord_P` with the mult/additive translation
  lemma (his `v_P`, Def. 1.1.12, with the strict triangle inequality Lemma 1.1.11); the
  three-way correspondence place ↔ normalized discrete valuation (his Def. 1.1.9, axioms
  incl. triviality on `k`) ↔ valuation ring (Thm. 1.1.13, including (d): valuation rings
  are maximal proper subrings of `F`).
- **Degrees.** The residue field `F_P` (Def. 1.1.14) as pinned; **`Module.Finite k F_P`**
  with `1 ≤ deg P ≤ [F : k(x)]` for any `x` with `ord_P x ≠ 0` (Prop. 1.1.15; this is
  where the Zariski-lemma-shaped gap in the pin is filled). Rational places
  (`deg P = 1`; Rem. 1.1.17: over algebraically closed `k` all places are rational) and
  the evaluation map `f ↦ f(P) ∈ F_P` for `f ∈ 𝒪_P` (Def. 1.1.14's residue map).
- **Existence and separation.** Every subring `k ⊆ R ⊆ F` with a proper nonzero ideal
  `I` admits a place with `R ⊆ 𝒪_P`, `I ⊆ P` (Thm. 1.1.19, by Zorn); hence every
  `x ∈ F ∖ k̃` has a zero and a pole and `ℙ_F ≠ ∅` (Cor. 1.1.20); `k̃ = ⋂_P 𝒪_P`
  (constants are the everywhere-regular functions); distinct places give inequivalent
  valuations (consume the shape of `eq_of_valuation_isEquiv_valuation`).
- **Weak approximation** (Thm. 1.3.1 — the *equality* form): for pairwise distinct
  places `P₁ … Pₙ`, targets `f₁ … fₙ ∈ F` and prescribed `r₁ … rₙ ∈ ℤ`, there is
  `f ∈ F` with `ord_{Pᵢ}(f − fᵢ) = rᵢ` for all `i`. Corollaries: finitely many places
  are independent; **every function field has infinitely many places** (Cor. 1.3.2);
  `∑ᵢ ord_{Pᵢ}(x) · deg Pᵢ ≤ [F : k(x)]` over zeros of `x` (Prop. 1.3.3), whence the
  finiteness of zeros and poles (Cor. 1.3.4) consumed by Layer 3.

### Layer 1: the rational function field

Stichtenoth I.2. The base case of everything, and the first acceptance suite.

- **The places of `k(x)`.** In the normalized-place vocabulary: for each monic irreducible
  `p ∈ k[X]` the place `P_p` (via `(Polynomial.idealX)`-style `HeightOneSpectrum k[X]`
  valuations) with `deg P_p = natDegree p` and residue field `k[X]/(p)` (Prop. 1.2.1(a));
  the place at infinity `P_∞` (repackage `RatFunc.inftyValuation`;
  `v_∞ f = exp (intDegree f)`, `ord_∞ f = −intDegree f`, prime element `1/x`) with
  `deg P_∞ = 1` (Prop. 1.2.1(c)); `k` is the exact constant field of `k(x)`
  (Prop. 1.2.1(d)); **these are all the places and they are distinct** (Thm. 1.2.2) —
  repackage the pin's Ostrowski `RatFunc.valuation_isEquiv_infty_or_adic` (its `Xor`
  under `IsRankOneDiscrete` + `IsTrivialOn` becomes a bijection
  `Place k (RatFunc k) ≃ {monic irreducibles} ⊕ {∞}`), do not reprove it; the degree-one
  places are `ℙ¹(k) = k ∪ {∞}` (Cor. 1.2.3).
- **Divisor identities on `ℙ¹`** (statable as soon as Layer 3's types exist; listed here
  because they are `k(x)`-specific): `div x = P_{(X)} − P_∞`; the pole divisor of `f` has
  degree `max (natDegree f.num) (natDegree f.denom) = [k(x) : k(f)]` (consume
  `RatFunc.finrank_eq_max_natDegree`); `∑_p natDegree p · ord_p(f) = intDegree f` (the
  product formula on `ℙ¹`, concretely).
- **`L(n·P_∞)` is the polynomials of degree `≤ n`** — the model computation
  `ℓ(n·P_∞) = n + 1` (`n ≥ 0`), proved by hand here, long before Riemann–Roch; genus 0
  falls out at Layer 3. Lüroth (in Mathlib) cited as the classification of the subfields.

### Layer 2: affine models — the Dedekind bridge

Stichtenoth III.2 (subrings and integral closures), placed early because it is the
Mathlib-consumption layer: the affine half of the theory falls out of
`DedekindDomain/Factorization.lean` nearly mechanically.

- **Rings of integers.** For `x ∈ F` transcendental over `k`: `R_x` := the integral
  closure of `k[x]` in `F`; it is Dedekind with fraction field `F` (consume
  `IsIntegralClosure.isDedekindDomain` + `integralClosure.isFractionRing_of_finite_extension`;
  ⚠ the separable case is instance-level at the pin — the general case, inseparable
  included, is a stated milestone here, Krull–Akizuki-grade, exactly the input PR #81's
  Layer-2 comparison also names).
- **Places ↔ height-one primes.** The bijection `{P : Place k F | ord_P x ≥ 0} ≃
  HeightOneSpectrum R_x`, matching `v_P` with `𝔭.valuation F` and residue fields with
  `𝔭.ResidueField`; the finitely many places with `ord_P x < 0` ("places over `∞`") are
  exactly the places of `F` over `P_∞` of `k(x)`. Corollary: **the place set is the
  two-chart union** `HeightOneSpectrum R_x ⊔ {places over ∞}` — and `∞` is not special:
  it is the finite chart of `1/x` (the two-charts device used again for the different in
  Layer 7).
- **Divisor dictionary** (statable once Layer 3 exists): the group isomorphism
  `{D : Divisor k F | supp D ⊆ finite chart} ≅ (FractionalIdeal R_x⁰ F)ˣ` via
  `FractionalIdeal.count` (consume `count_mul/inv/zpow`, `finite_factors`,
  `finprod_heightOneSpectrum_factorization'` — zero new proof work is the design goal);
  `ord_P` versus `intValuation`; S-domains `𝒪_S` (holomorphy rings, Stichtenoth III.2)
  via the pin's `Set.integer` S-integers.
- **Class-group bridge** (statable once Layer 3 exists): the exact sequence
  `0 → ⟨places over ∞⟩ → Cl(F) → ClassGroup R_x → 0`-shape relating the divisor class
  group to Mathlib's `ClassGroup` of any affine model; specialization: for a model with a
  single degree-1 place at infinity, `Cl⁰(F) ≅ ClassGroup R_x` — the statement that makes
  Mathlib's elliptic-curve group law an instance of the general theory (Layer 10).

### Layer 3: divisors, `L(D)`, Riemann's theorem, and the genus

Stichtenoth I.4. From here on the standing hypothesis `IsIntegrallyClosedIn k F` is in
force (Stichtenoth's global assumption, declared at the head of §1.4).

- **Divisors.** `Divisor k F` as pinned (Def. 1.4.1); degree hom; support, partial
  order, `⊔/⊓`, positive/negative parts. **Finiteness of zeros and poles** of `f ∈ Fˣ`
  (Cor. 1.3.4, via Prop. 1.3.3's bound `∑ ord · deg ≤ [F : k(f)]`); the principal
  divisor hom `div : Fˣ → Divisor k F`, zero/pole divisors `(f)₀, (f)_∞`
  (Def. 1.4.2); `div f = 0 ↔ f ∈ kˣ` (exactness of constants entering here).
- **The product formula.** `deg (div f) = 0`, via
  **`deg (f)₀ = deg (f)_∞ = [F : k(f)]`** for nonconstant `f` (Thm. 1.4.11) — the
  theorem that makes the degree map descend to the class group. Corollaries: `Cl(F)`
  (Def. 1.4.3), `Cl⁰(F)`, the degree exact sequence `0 → Cl⁰ → Cl → deg-image → 0`;
  linear equivalence preserves `deg` and `ℓ` (Cor. 1.4.12(a)); a degree-0 divisor is
  principal iff `ℓ ≥ 1` iff `ℓ = 1` (Cor. 1.4.12(c)).
- **Riemann–Roch spaces.** `L(D)` as pinned (Def. 1.4.4, Rem. 1.4.5); `L(A) ≅ L(A′)`
  for `A ∼ A′` (Lemma 1.4.6); `L(0) = k` and `L(D) = 0` for `deg D < 0`
  (Lemma 1.4.7, Cor. 1.4.12(b)); monotonicity `D ≤ D′ ⟹ L(D) ≤ L(D′)` with
  `dim (L(D′)/L(D)) ≤ deg D′ − deg D` (Lemma 1.4.8, the one-place-at-a-time estimate);
  **finite-dimensionality** with `ℓ(D) ≤ deg D₊ + 1` (Prop. 1.4.9, Def. 1.4.10).
- **Riemann's theorem and the genus**: the quantity `deg D − ℓ(D)` is bounded above
  (Prop. 1.4.14); **the genus** `genus k F` as pinned (Def. 1.4.15:
  `g = max {deg A − ℓ(A) + 1}`; `sSup`, junk-guarded by 1.4.14), `g ≥ 0` (Cor. 1.4.16);
  **Riemann's theorem** (Thm. 1.4.17): `ℓ(D) ≥ deg D + 1 − g` for all `D`, with
  equality for `deg D ≥ c` (`∃ c` form); `g(k(x)) = 0` (Ex. 1.4.18, from Layer 1's
  computation); the **index of specialty** `i(D) := ℓ(D) − deg D − 1 + g ≥ 0`
  (Def. 1.5.1), `i(D) = 0` for large degrees.

### Layer 4: repartitions, Weil differentials, and Riemann–Roch

Stichtenoth I.5 — the summit of the first half.

- **Repartitions.** `A_F` as pinned (Def. 1.5.2 — Stichtenoth says *adeles* and notes
  "some authors use the name repartition"; entries in `F`, cofinite integrality —
  `Filter.cofinite` vocabulary, **no completions**); the diagonal `F ↪ A_F`; the
  filtration `A_F(D)` (Def. 1.5.3). **The quotient interpretation of the index of
  specialty**: `i(D) = dim_k (A_F ⧸ (A_F(D) + F))` (Thm. 1.5.4), so
  `g = dim_k (A_F ⧸ (A_F(0) + F))` (Cor. 1.5.5) — Riemann's theorem re-proved as
  finiteness of these quotients.
- **Weil differentials.** `Ω_F` as pinned (Def. 1.5.6); `dim_k Ω_F(A) = i(A)`
  (Lemma 1.5.7, so `Ω_F ≠ 0`); the `F`-action (Def. 1.5.8); **`dim_F Ω_F = 1`**
  (Prop. 1.5.9); the divisor `(ω)` of `ω ≠ 0` (existence of the maximum: Lemma 1.5.10,
  Def. 1.5.11 — also `v_P(ω)`, regular/holomorphic differentials, `dim Ω_F(0) = g` per
  Rem. 1.5.12); `(f·ω) = div f + (ω)` and any two canonical divisors are equivalent
  (Prop. 1.5.13) — the **canonical class** `W ∈ Cl(F)`.
- **Duality.** The isomorphism `L(W − D) ≅ Ω_F(D)`, `x ↦ xω`, as `k`-spaces —
  **`i(D) = ℓ(W − D)`** (Thm. 1.5.14, the Duality Theorem).
- **The Riemann–Roch theorem** (Thm. 1.5.15; hypotheses: none beyond `k` exact —
  arbitrary constant field, no perfectness, no separability):
  `ℓ(D) = deg D + 1 − g + ℓ(W − D)` for every divisor `D`. Immediate corollaries pinned
  as named milestones: **`ℓ(W) = g` and `deg W = 2g − 2`** (Cor. 1.5.16); the
  characterization of canonical divisors (`deg D = 2g − 2` and `ℓ(D) ≥ g` ⟹ `D`
  canonical, Prop. 1.6.2); and **uniqueness of the RR data** (Prop. 1.6.1: if
  `(g₀, W₀)` satisfies the RR identity for all `D` then `g₀ = g` and `W₀` is canonical
  — the milestone that makes the `Suggested.lean` existential form honest).

### Layer 5: consequences of Riemann–Roch, and local components

Stichtenoth I.6–I.7.

- **The `deg > 2g − 2` regime**: `deg D ≥ 2g − 1 ⟹ ℓ(D) = deg D + 1 − g`
  (Thm. 1.5.17; the bound is sharp — `W` fails it) — the workhorse identity (this, at
  genus 1 and `D = n·[0]`, is the fibrewise content of PR #81's assumed interface).
  Non-special divisors and their calculus (Def. 1.6.10, Rem. 1.6.11); every `P` and
  `n ≥ 2g` admit `x` with `(x)_∞ = nP` (Prop. 1.6.6); existence of an effective
  non-special divisor of degree `g` supported on ≥ `g` given rational places
  (Prop. 1.6.12).
- **Genus 0**: `g = 0` **and a divisor of degree 1** ⟺ `F` rational (Prop. 1.6.3 — the
  hypothesis is a degree-1 *divisor*, not a rational place; RR then produces the place);
  ⚠ genus 0 alone does *not* force rationality — non-rational genus-0 fields exist
  (conics; Rem. 1.6.4, which also notes a degree-1 divisor always exists over
  algebraically closed or finite `k`) — record the non-theorem; Lüroth (in Mathlib)
  cited for the subfield picture.
- **Strong approximation** (Thm. 1.6.5): for a *proper* subset `S ⊊ ℙ_F`, places
  `P₁ … P_r ∈ S`, targets and orders as in weak approximation, there is `x` with
  `ord_{Pᵢ}(x − xᵢ) = nᵢ` for all `i` **and** `ord_P x ≥ 0` at every other place of
  `S` — free behaviour only outside `S`. The statement CurvesOverFiniteFields'
  Goppa-style consumers want; proved from RR, which is why it is here and not in
  Layer 0.
- **Weierstrass gaps** (Thm. 1.6.8): at a **rational** place `P` of a function field of
  genus `g > 0`, exactly `g` numbers `i₁ < … < i_g` are pole gaps, with `i₁ = 1` and
  `i_g ≤ 2g − 1` — characteristic-free, the theorem of record. ⚠ Char-`p` honesty: the
  refined theory (all-but-finitely-many places share one gap sequence, Weierstrass
  points; Rem. 1.6.9) is stated in Stichtenoth **without proof** and only over
  algebraically closed `k`; here it is a Layer-11 development (the Wronskian/Hasse-
  derivative route), and classicality (`1, …, g` generically) is characteristic-zero
  horizon material — non-classical curves exist in char `p`.
- **Clifford's theorem** (Thm. 1.6.13): `0 ≤ deg D ≤ 2g − 2` ⟹
  `ℓ(D) ≤ 1 + (deg D)/2`. ⚠ **Proof-hypothesis trap, flagged as a cross-layer
  dependency**: Stichtenoth's proof (via Lemma 1.6.14) assumes `k` *infinite*; he
  completes the finite-`k` case only via constant-field extension (Thm. 3.6.3(d), our
  Layer 8). Either formalize the reduction in that order (Clifford for infinite `k`
  here; the finite case discharged after Layer 8) or find a uniform argument — the
  milestone records the choice.
- **Local components** (§1.7): `ι_P` and `ω_P(x) := ω(ι_P x)` (Def. 1.7.1);
  `ω(α) = ∑_P ω_P(α_P)` with cofinite vanishing (Prop. 1.7.2) — whose specialization
  `∑_P ω_P(1) = 0` (his (1.45)) is the **abstract residue theorem, valid over arbitrary
  `k`** (the analytic-looking `∑ res = 0` of Layer 9 is its refinement);
  `v_P(ω)`-characterization via local components (Prop. 1.7.3, incl. `ω_P ≠ 0` always
  and "one local component determines `ω`"); the explicit generator `η` of
  `Ω_{k(x)}` with `(η) = −2P_∞` and its local components (Prop. 1.7.4 — the seed for
  Layer 9's `δ(x) = Cotr(η)`). **Completion comparison milestone**: the pin's
  `adicCompletion`/`FiniteAdeleRing` of an affine model receives `A_F` by the natural
  map with dense image in the `D`-filtration sense — stated so the Wave-2 adelic
  consumers (and any future Tate-style residue theory) can refactor onto completions
  without touching the RR proof.

### Layer 6: extensions of function fields

Stichtenoth III.1–III.3. `F′/k′` over `F/k`, `[F′ : F] < ∞`.

- **Setup.** Extensions of function fields as pinned (Def. 3.1.1; algebra +
  compatibility of constant fields); `P′ ∣ P` characterized three ways
  (Prop. 3.1.4: `P ⊆ P′` ⟺ `𝒪_P ⊆ 𝒪_{P′}` ⟺ `v_{P′}|_F = e · v_P`), defining
  `e(P′∣P)` and `f(P′∣P)` (Def. 3.1.5); `f < ∞` ⟺ `[F′ : F] < ∞` and multiplicativity
  in towers (Prop. 3.1.6); each place of `F′` lies over exactly one place of `F`, and
  each place of `F` has at least one and finitely many extensions (Prop. 3.1.7).
  ⚠ Stichtenoth's Ch. 3 carries a chapter-wide "`k` perfect" umbrella; per the audit of
  which proofs consume it, **3.1.11, 3.3.7, 3.4.3/3.4.6, 3.4.13, 3.5.10 and 3.8.7 do
  not** — statements here carry only their true hypotheses, and each milestone records
  whether perfectness is genuinely used.
- **The conorm/pullback.** `Con : Divisor k F →+ Divisor k′ F′`,
  `P ↦ ∑ e(P′∣P) · P′` (Def. 3.1.8, transitive in towers); `Con` of principal is
  principal (Prop. 3.1.9, inducing `Cl(F) → Cl(F′)`);
  **`deg (Con D) = ([F′ : F] / [k′ : k]) · deg D`** (Cor. 3.1.14 — the `[k′ : k]`
  factor is mandatory and a classic error site ⚠).
- **The fundamental identity** `∑_{P′ ∣ P} e(P′∣P) · f(P′∣P) = [F′ : F]`
  (Thm. 3.1.11 — no perfectness consumed): proved by the affine-model reconciliation —
  consume `Ideal.sum_ramification_inertia` over `R_x ⊆ R′_x`, with the bridge lemmas
  `e = Ideal.ramificationIdx`, `f = Ideal.inertiaDeg` at the matching primes (one lemma
  each, per the convention table), plus the places-over-`∞` chart swap. Corollaries:
  `#{P′ ∣ P}, e, f ≤ [F′ : F]` (Cor. 3.1.12); splits-completely and totally-ramified
  vocabulary (Def. 3.1.13); the Eisenstein-type total-ramification criterion
  (Prop. 3.1.15, bridging to the pin's `Polynomial/Eisenstein` API).
- **Integral closures and local integral bases** (III.2–III.3): holomorphy rings
  `𝒪_S = ⋂_{P∈S} 𝒪_P` with `integrally closed ⟺ holomorphy ring` (Def. 3.2.2,
  Thm. 3.2.6, Cor. 3.2.8 — Thm. 3.2.6 needs no exact-constants hypothesis, per
  Rem. 3.2.7; `S` finite ⟹ PID, Prop. 3.2.10); `𝒪′_P = ` integral closure of `𝒪_P` in
  `F′` with **local integral bases** for separable `F′/F` (Cor. 3.3.5, Thm. 3.3.6:
  almost every basis is one); **Kummer's theorem** (Thm. 3.3.7, with the explicit
  `K(x,y)` form Cor. 3.3.8): factoring the minimal polynomial mod `P` reads off places
  above `P` with their `e`, `f` — the computational workhorse for all worked examples
  (consume `AdjoinRoot` + `quotientEquiv`-style API).
- **Galois extensions, first pass** (III.7): the Galois action on `{P′ ∣ P}` is
  transitive (Thm. 3.7.1); `e`, `f`, `d` constant over `P` and `e·f·r = [F′ : F]`
  (Cor. 3.7.2); decomposition groups. (The finer inertia/ramification filtration
  appears in Layer 8, scoped; the *local* filtration theory — Herbrand, upper
  numbering, Hasse–Arf — belongs to the [LocalFields](../LocalFields/README.md)
  roadmap (sibling, in preparation), bridged at completions.)

### Layer 7: the different and the Hurwitz genus formula

Stichtenoth III.4–III.5, in the book's order: the cotrace of Weil differentials proves
Hurwitz; the different theorem computes the exponents.

- **The different exponent and divisor.** The complementary module `C_P` (Def. 3.4.1,
  Prop. 3.4.2: principal, `= 𝒪′_P` almost everywhere) defines
  **`d(P′∣P) := −v_{P′}(t)` for `C_P = t·𝒪′_P`** and
  `Diff(F′/F) := ∑ d(P′∣P) · P′ ≥ 0` (Def. 3.4.3, Rem. 3.4.4). Lean route: consume the
  pin's `differentIdeal` machinery over `R_x`-models, with the reconciliation
  `v_{P′}(differentIdeal R R′) = d(P′∣P)` as the bridge milestone and the two-charts
  device covering the places over `∞`; finite support via
  `dvd_differentIdeal_iff`/`Algebra.IsUnramifiedAt` finiteness. Hypothesis of record for
  this layer: **`F′/F` separable** (the different is degenerate otherwise; the
  inseparable case is flagged to Layer 8).
- **Dedekind's different theorem** (Thm. 3.5.1): **(a)** `d(P′∣P) ≥ e(P′∣P) − 1`
  unconditionally; **(b)** equality ⟺ `char k ∤ e(P′∣P)` (tame) — ⚠ (b)'s proof
  consumes residue-separability (Stichtenoth via `k` perfect, Lemma 3.5.3); state (b)
  with that honest hypothesis. The pin supplies `P^{e−1} ∣ 𝔡` and the ramified ⟺
  divides criterion; the **exact tame value is built here** (it is the pin's own TODO)
  — via the trace computation on a uniformizer power basis (the `d ≤ v_{P′}(φ′(y))`
  calculus of Thm. 3.5.10 and the totally-ramified equality Prop. 3.5.12), contributed
  as the missing half of the `Different.lean` story. Also: ramified ⟺ `P′ ∈ supp Diff`,
  wild ⟺ `d ≥ e` (Cor. 3.5.5); tame/wild vocabulary (Def. 3.5.4).
- **The cotrace of Weil differentials** (III.4): `Cotr_{F′/F} : Ω_F → Ω_{F′}` through
  the trace on fibre-constant repartitions (Def. 3.4.5, Thm. 3.4.6 — existence,
  uniqueness, and **`(Cotr ω) = Con (ω) + Diff(F′/F)`**, the divisor identity from
  which Hurwitz falls out); `F`-semilinearity and tower transitivity (Prop. 3.4.11),
  transitivity of the different `d(P″∣P) = e(P″∣P′)·d(P′∣P) + d(P″∣P′)`
  (Cor. 3.4.12 — reconcile with the pin's
  `differentIdeal_eq_differentIdeal_mul_differentIdeal`).
- **The Hurwitz genus formula** (Thm. 3.4.13 — no perfectness consumed):
  for `F′/F` finite **separable** with constant fields `k′/k`,
  `2g′ − 2 = ([F′ : F] / [k′ : k]) · (2g − 2) + deg Diff(F′/F)`;
  the `F/k(x)` normalization `2g − 2 = −2[F : k(x)] + deg Diff(F/k(x))` (Cor. 3.4.14,
  via Cotr of Layer 5's `η`). Tame corollary: the inequality form
  `2g′ − 2 ≥ n(2g − 2) + ∑ (e − 1) deg P′` **with equality ⟺ `F′/F` tame**
  (Cor. 3.5.6, same-constant-field form); ⚠ wild honesty: the Artin–Schreier worked
  example below is the mandatory acceptance test that no tameness assumption has crept
  in. Corollaries: `g′ ≥ g` for same-constant-field separable extensions (Cor. 3.5.7);
  every separable `F/k(x)` of degree > 1 with exact constants ramifies (Cor. 3.5.8);
  **the function-field Riemann–Hurwitz for `y² = f(x)`** (the degree-2 worked example,
  char `≠ 2`, via the Kummer-cover data `e = n/r_P`, `d = n/r_P − 1` of Prop. 3.7.3).

### Layer 8: constant-field extensions, Galois ramification, and inseparability ⚠

Stichtenoth III.6–III.11. The trap layer: everything here is about hypotheses.
Stichtenoth's §3.6 opens by declaring perfectness *"essential for the validity of most
results in this section"*, citing counterexamples to Deuring's LNM 314 **without stating
one** — this layer states them.

- **Constant-field extensions.** `F″ := F·k″` for algebraic `k″/k` (inside a fixed
  closure): `k″` is exactly the constant field of `F″` (Prop. 3.6.1(a), `k` perfect);
  linear independence over `k` persists over `k″` (3.6.1(b));
  `[F : k(x)] = [F″ : k″(x)]` (3.6.1(c)); degree bookkeeping for general algebraic
  extensions `deg Con_{F′/F}(A) = [F′ : F k′] · deg A` (Cor. 3.6.4);
  `[F′ : F] = [F′k̄ : Fk̄]·[k′ : k]` and the absolute-irreducibility criterion for
  exactness of constants (Prop. 3.6.6, Cor. 3.6.8 — the practical test for every worked
  example's `hgen` hypothesis).
- **Genus invariance, with its true hypotheses** (Thm. 3.6.3, `k` **perfect** —
  essential): constant extension is unramified (a); **the genus is unchanged** (b);
  degrees are preserved (c); **`ℓ(Con A) = ℓ(A)` with any `k`-basis of `L(A)` staying a
  basis** (d — also the missing finite-`k` half of Layer 5's Clifford); canonical stays
  canonical (e); `Con` is injective on classes (f); residue fields compose as
  `F″_{P″} = F_P · k″` (g). Route to the honest general statement: `F/k`
  **conserved/separably generated** is the intermediate predicate — pin it, relate it to
  the pin's `SeparablyGenerated.lean` existentials, and derive the perfect-`k` case.
- **⚠ The inseparable pathology, stated as a theorem-with-counterexample**: over
  imperfect `k`, an inseparable constant extension can **strictly decrease** the genus —
  the worked example below (`y² = x^p − t` over `𝔽_p(t)`) is stated and proved here
  (Stichtenoth's own text points to Deuring and gives none, so this milestone is
  genuinely additive); with the general "genus never increases under constant extension"
  and the drop estimates (III.11) as statement-level milestones.
- **Galois II: decomposition, inertia, and the function-field ramification groups**
  (III.8, scoped): decomposition/inertia groups with
  `|G_Z| = e·f`, `|G_T| = e`, and `G_Z/G_T ≅ Gal(F′_{P′}/F_P)` (Def. 3.8.1,
  Thm. 3.8.2 — (c) consumes residue perfectness); the **`i`-th ramification groups**
  `G_i(P′∣P)` (Def. 3.8.4) with the basic structure `G₀/G₁` cyclic prime-to-`p`,
  `G_i/G_{i+1}` elementary abelian `p`, char-0 ⟹ `G₁ = 1` (Prop. 3.8.5); and
  **Hilbert's different formula `d(P′∣P) = ∑_{i≥0} (|G_i| − 1)`** (Thm. 3.8.7 — no
  perfectness consumed). ⚠ Scope wall, pinned: lower numbering only, at the
  function-field level; Herbrand functions, upper numbering, and Hasse–Arf are the
  [LocalFields](../LocalFields/README.md) sibling's Layer 3 — the completion bridge
  (`G_i` here = `G_i` of the local extension at `P′`) is stated once and the local
  theory is never redeveloped.
- **Composita** (III.9): **Abhyankar's lemma** (Thm. 3.9.1: `F′ = F₁F₂` with one of
  `Pᵢ∣P` tame ⟹ `e(P′∣P) = lcm(e₁, e₂)`); unramified-in-both ⟹ unramified in the
  compositum and in the Galois closure (Cor. 3.9.3); a rational place splitting
  completely in both splits completely in the compositum, with constants staying exact
  (Cor. 3.9.7) — the tower-builder's toolkit, consumed by Wave 2.
- **Inseparable extensions and genus estimates** (III.10–III.11): purely inseparable
  degree-`p` steps have a unique place above each `P` with `e = p`, `f = 1`
  (Lemma 3.10.1); over perfect `k`, **every function field is separably generated**,
  any `z` with `v_P(z) ≢ 0 (mod p)` is separating, and Frobenius gives `F^{pⁿ} ≅ F`
  with the same genus (Prop. 3.10.2 — Layer 9's entry ticket); genus bounds:
  `g ≤ 1 + n(g₁ − 1) + deg C` (Prop. 3.11.1), **Castelnuovo's inequality**
  `g ≤ n₁g₁ + n₂g₂ + (n₁−1)(n₂−1)` for `F = F₁F₂` (Thm. 3.11.3), **Riemann's
  inequality** `g ≤ ([F:k(x)] − 1)([F:k(y)] − 1)` (Cor. 3.11.4), and the plane-model
  bound `g ≤ ½(n−1)(n−2)` (Prop. 3.11.5) — statement-level milestones with the
  algebraically-closed reduction in their proofs flagged.

### Layer 9: Kähler differentials, residues, and the comparison

Stichtenoth IV.1–IV.3. The layer that reconciles the formalism of record (Weil) with
Mathlib's formalism (`KaehlerDifferential`), so that both this roadmap's consumers and
PR #68's invariant differential speak one language.

- **`Ω[F⁄k]` is one-dimensional.** For `F/k` a function field with a separating element
  `x` (equivalently `F/k` separably generated; over perfect `k` always, by
  Prop. 3.10.2): `dim_F Ω[F⁄k] = 1`, with basis `dx`; `dy = (dy/dx)·dx` and the formal
  derivative calculus (Stichtenoth's derivation module: Def. 4.1.1–Lemma 4.1.6; his
  differential module `Δ_F` with the universal property Prop. 4.1.8(d)). ⚠ Two
  formal-vocabulary traps, pinned: (i) Stichtenoth *defines* `dt := 0` for
  non-separating `t` inside his 1-dimensional `Δ_F` (Def. 4.1.7), whereas Mathlib's
  `Ω[F⁄k]` is the genuine Kähler module, which **jumps in dimension** for inseparably
  generated `F/k` — the identification `Δ_F ≅ Ω[F⁄k]` (via the shared universal
  property 4.1.8(d)) is a theorem **under separable generation**, and the inseparable
  degeneration is the honesty check; (ii) this is the pin's load-bearing gap
  (`KaehlerDifferential` never meets `FieldTheory/`): build it from `polynomialEquiv`,
  localization, and the second fundamental sequence.
- **Local expansions and residues** (IV.2): completions `F̂_P` and, at **rational**
  places, the `P`-adic power-series expansion in a prime element `t` (Thm. 4.2.6;
  consume the pin's Laurent-series comparison at the `X`-adic place as the model, and
  `adicCompletion` in general); `res_{P,t}(z) := a₋₁` (Def. 4.2.8) with the
  **transformation formula `res_{P,s}(z) = res_{P,t}(z · ds/dt)`** (Prop. 4.2.9 —
  well-definedness of `res_P(ω)` on differentials, Def. 4.2.10; ⚠ a theorem in char
  `p`, not a triviality).
- **The comparison theorem** (IV.3): the derivation `δ(x) := Cotr_{F/k(x)}(η)` into
  Weil differentials (Def. 4.3.1, with Layer 5's `η`); **`μ : Δ_F ≅ Ω_F` (differentials
  ≅ Weil differentials), `z dx ↦ z·δ(x)`** (Thm. 4.3.2, `k` perfect; part (d): local
  components are residues, `(z·δ(x))_P(u) = res_P(uz dx)` at rational `P`, with the
  general-degree form Rem. 4.3.7(d)); consequences: `(dx)` is a canonical divisor with
  the explicit formula **`(dx) = −2(x)_∞ + Diff(F/k(x))`** (Rem. 4.3.7(c), eq. (4.37)),
  `deg (dx) = 2g − 2`; the **residue theorem `∑_P res_P(ω) = 0`** (Cor. 4.3.3 — stated
  there over algebraically closed `k`; the arbitrary-`k` abstract form is Layer 5's
  `∑_P ω_P(1) = 0`, and the honest general-`k` residue statement goes through
  Rem. 4.3.7(d) — pin the exact hypothesis on the milestone).
- **PR #68 compatibility milestone**: for an elliptic `W` over `k`, the invariant
  differential lives in `Ω[W.FunctionField⁄k]` (their Layer 1); under the comparison,
  its Weil-differential divisor is `0` — i.e. the canonical class of a genus-1 function
  field is trivial — reconciling their concrete `ω_W` with this roadmap's canonical
  class.

### Layer 10: model classes — elliptic, hyperelliptic, plane curves

Stichtenoth VI.1–VI.3; Fulton Chs. 5, 8 for the plane-curve computations.

- **Elliptic function fields** (VI.1): definition of record = Stichtenoth Def. 6.1.1 —
  **genus 1 together with a divisor of degree 1** (⚠ a *divisor*, not a rational place;
  RR then produces the rational place, Prop. 6.1.6(a)); normal forms: char ≠ 2 gives
  `y² = f(x)`, `f` squarefree cubic, char 2 gives the two `y² + y = …` forms
  (Prop. 6.1.2, via the `ℓ(iP) = i` ladder); the converse with exactness of constants
  and `Diff(F/k(x)) = Q₁ + … + Q_r + Q_∞` (Prop. 6.1.3); **the degree-one places form
  an abelian group isomorphic to `Cl⁰(F)`** via `P ↦ [P − P₀]`, with
  `P ⊕ Q = R ⟺ P + Q ∼ R + P₀` (Prop. 6.1.6(b), 6.1.7 — the intrinsic group law).
  **Mathlib compatibility milestones** (the general theory meeting
  `Mathlib/AlgebraicGeometry/EllipticCurve/`):
  (i) `genus k W.toAffine.FunctionField = 1` for `[W.IsElliptic]` (all
  characteristics);
  (ii) `W.toAffine.CoordinateRing` is the integral closure of `k[x]` in the function
  field — hence **`IsDedekindDomain` via Layer 2** (the instance the pin lacks and
  PR #68 also wants);
  (iii) the point–place dictionary: `W.toAffine.Point ≃` degree-1 places (PR #68's
  Layer-0 bridge, supplied here as Prop. 6.1.6's general form);
  (iv) `Cl⁰(W.FunctionField) ≅ ClassGroup W.CoordinateRing` (Layer 2's bridge
  specialized to the one-rational-place-at-infinity case) — which, with Mathlib's
  `Point.toClass` (injective) and PR #68's seeded `toClass_surjective`, closes the
  triangle `E(k) ≅ Cl⁰` **without this roadmap re-proving the group law**.
- **Hyperelliptic function fields** (VI.2): definition (Def. 6.2.1: `g ≥ 2` with a
  rational subfield of index 2); the intrinsic characterization `∃ A, deg A = 2 ∧
  ℓ(A) ≥ 2`, and **every genus-2 function field is hyperelliptic** (Lemma 6.2.2);
  `F/k(x)` is automatically separable (via Prop. 3.10.2), hence cyclic; char ≠ 2
  models `y² = f(x)`, `f` squarefree of degree `2g+1` or `2g+2`, with the **converse
  genus formula `g = (m−1)/2` (`m` odd) / `(m−2)/2` (`m` even)** and the list of
  ramified places (Prop. 6.2.3 — by Layer 7's RH with the Kummer-cover different;
  char-2 models via the Artin–Schreier calculus, flagged honest); **uniqueness of the
  degree-2 rational subfield** (`[F : k(z)] ≤ g ⟹ k(z) ⊆ k(x)`) and the
  regular-differentials description of it (Prop. 6.2.4). Boundary: models over `ℤ`,
  Igusa invariants, cluster pictures → Wave-2 HyperellipticCurves.
- **Smooth plane curves** (Fulton Chs. 5, 8; Stichtenoth's Appendix B vocabulary): the
  function field of an irreducible plane curve `f(x, y) = 0`; smoothness of the
  projective plane model as the hypothesis of record (stated via the pin's
  homogeneous/`pderiv` toolkit); **`g = (d−1)(d−2)/2` for a smooth plane curve of
  degree `d`** — route of record: the canonical-divisor computation via
  `(dx) = −2(x)_∞ + Diff` (Layer 9's (4.37)) on the plane model, cross-checked against
  Stichtenoth's inequality `g ≤ ½(d−1)(d−2)` (Prop. 3.11.5) and Fulton's adjoint
  treatment (§8.3 Prop. 5 with its Corollary — the genus formula *with ordinary
  singularities* `g = ½(d−1)(d−2) − ∑ ½r_P(r_P − 1)` — and §8.5 Prop. 8: adjoints of
  degree `d − 3` cut canonical divisors; ⚠ Fulton works over algebraically closed `k`
  throughout). The Klein quartic (`d = 4`, `g = 3`) instantiated for Layer 11. Nodal
  corrections and general plane curves: horizon, flagged (needs the intersection
  multiplicities the pin lacks — Fulton Chs. 3, 5 territory, stated as the gap).
- **Kummer and Artin–Schreier covers of `ℙ¹`** (III.7 + VI.3–VI.4): **Kummer**
  `yⁿ = u` (`char ∤ n`): cyclic of degree `n` with `e = n/r_P`, `d = n/r_P − 1` for
  `r_P = gcd(n, v_P(u))` and the closed genus formula (Prop. 3.7.3, Cor. 3.7.4;
  `y² = f` squarefree as Ex. 3.7.6); **Artin–Schreier** `y^p − y = u`: the `m_P`
  invariant, `d = (p−1)(m_P + 1)`, and the genus formula (Prop. 3.7.8; elementary
  abelian generalization Prop. 3.7.10) — the two generating example families, each an
  acceptance test for the tame and wild halves of Layer 7, and the substrate the
  Wave-2 BelyiMaps and CurvesOverFiniteFields roadmaps cite (Hermitian curves are
  VI.4/§7.4 instances).

### Layer 11: automorphisms and the Hurwitz bound

⚠ Sourcing honesty first: **Stichtenoth contains no numbered theorem on automorphism
groups** — the `84(g−1)` bound is his Exercise 3.18 (algebraically closed `k`, tame
`gcd(|G|, char k) = 1`, with the `F/F^G` + `(2,3,7)` hint), finiteness of `Aut` for
`g ≥ 2` is a remark stated *without proof* (after Ex. 3.18 and again in the Ch. 6
exercises), and the counterexamples are Exercises 6.10/6.14 and 1.2. This layer is
therefore a genuine development, grounded in Layers 5–8, with Villa Salvador and
Hartshorne IV as the written sources of record.

- **The automorphism group.** `Aut(F/k)` = `k`-algebra automorphisms of `F`; the action
  on places (`v_{σP}(y) = v_P(σ⁻¹y)`, Lemma 3.5.2's shape), on divisors, on `L(D)`, and
  on `Ω_F`; the fixed field `F^G` of a finite `G ≤ Aut(F/k)` is a function field with
  `F/F^G` Galois of group `G` (Artin + Layer 6); non-finiteness at small genus, stated
  as theorems: `Aut(k(x)/k) ≅ PGL₂(k)` (Stichtenoth Ex. 1.2), and for elliptic `F` the
  translations `≅ Cl⁰(F)` form an infinite normal subgroup with finite quotient
  (Ex. 6.14) — so the `g ≥ 2` hypothesis below is visibly necessary.
- **Rigidity.** An automorphism fixing `2g + 3` distinct rational places is the
  identity (Ex. 3.17's shape; via the totally-ramified criterion Ex. 3.16) — the
  finiteness engine.
- **Weierstrass points, made real.** What Layer 5 deferred: over algebraically closed
  `k`, char 0 first — all but finitely many rational places share the generic gap
  sequence, the exceptions (Weierstrass points) number at least `2g + 2` and at most
  `g³ − g` for `g ≥ 2` (the Wronskian route; Stichtenoth's Rem. 1.6.9 cites this
  without proof, so it is built here, not imported).
- **Finiteness for `g ≥ 2`** — the headline theorem (char 0 / tame case first):
  `Aut(F/k̄)` is finite, by rigidity + the action on the finite Weierstrass-point set,
  with the hyperelliptic case (where the involution fixes every Weierstrass place)
  handled separately via the unique degree-2 subfield (Prop. 6.2.4 + Ex. 6.11(v)'s
  shape). The general perfect-`k`/char-`p` finiteness is a stated later milestone with
  the literature route flagged (Schmid; Villa Salvador Ch. 12), not silently dropped.
- **The Hurwitz `84(g−1)` bound**: for `g ≥ 2` and `char k = 0` (or
  `gcd(|G|, char k) = 1`), a finite `G ≤ Aut(F/k̄)` has `|G| ≤ 84(g−1)` — by
  Riemann–Hurwitz on `F/F^G` and the `(2, 3, 7)` extremal analysis of branch data
  (Ex. 3.18's route, promoted to a theorem). Sharpness: the **Klein quartic** (`g = 3`,
  `#Aut = 168`) from Layer 10, with the automorphism count as the acceptance criterion
  (the full computation of `Aut` for the quartic is the layer's worked summit).
- **⚠ char-`p` caveats, stated not hidden**: the bound **fails** wildly in
  characteristic `p` — the Hermitian function field over `𝔽_{q²}` has
  `#Aut = q³(q³+1)(q²−1) > 16g⁴ ≫ 84(g−1)` (Ex. 6.10(vi)(c), stated here as a
  theorem-level counterexample); the true char-`p` bounds (Roquette's `p`-bounds,
  Stichtenoth's own 1973 `16g⁴`-type theorem, Henn's classification of the large
  cases) are **horizon milestones**, cited, with the counterexample proved here so the
  tameness hypothesis is load-bearing and visible.

### Layer 12: the dictionary — function fields ↔ curves, and the comparison contracts

Stichtenoth Appendix B; Liu Ch. 7; Hartshorne I.6. The definite later layer where this
roadmap meets the scheme world. Everything below is stated against the pin's
`AlgebraicGeometry` vocabulary (`Scheme`, `IsIntegral`, `IsProper`,
`Scheme.functionField`).

- **From curves to function fields.** For `X` an integral scheme, proper over `k`, of
  dimension 1 (dimension stated via `topologicalKrullDim`/stalk-Krull-dimension at the
  pin, with the "dim = trdeg of the function field" bridge a named milestone), regular:
  `k(X) := X.functionField` is a function field over `k`; closed points ↦ places
  (`ord_x` via the DVR stalks — consume `ringKrullDim_stalk_eq_coheight` +
  DVR-characterization TFAE), matching residue fields and degrees. ⚠ Refactor-onto
  flag: Mathlib master (post-pin) has `AlgebraicGeometry/OrderOfVanishing.lean` and
  `AlgebraicCycle/Basic.lean` (Giles campaign, §What is in motion) — on the next
  toolchain bump these milestones are restated against that vocabulary, never against
  a rival one.
- **From function fields to curves.** The regular projective model of `F/k`: existence
  and uniqueness up to isomorphism (route: the place space as the underlying set,
  charted by the Layer-2 affine models `Spec R_x` glued along localizations — the
  "abstract curve" of Hartshorne I.6 in scheme clothing); the anti-equivalence
  {function fields `F/k` + `k`-embeddings} ≃ {regular projective curves + dominant
  `k`-morphisms}ᵒᵖ. ⚠ **Regular, not smooth** (PR #68's convention, adopted verbatim):
  over imperfect `k` the regular projective model need not be smooth; smooth = regular +
  geometrically-reduced-fibre hypotheses stated exactly where used (`Geometrically/`
  vocabulary at the pin).
- **The comparison contract with [JacobianChallenge](../JacobianChallenge/README.md)**
  (its Layers A–B), stated as named milestones on this side so whichever route lands
  first, the other refactors onto it: under the dictionary, (i) Weil divisors on the
  regular model ≅ `Divisor k F`, matching degrees; (ii) `H⁰(X, 𝒪_X(D)) ≅ L(D)` (its
  sheaf `𝒪(D)` vs this roadmap's `L(D)`); (iii) its cohomological genus
  `dim H¹(X, 𝒪_X)` equals this roadmap's `genus k F` — equivalently `h¹(𝒪(D)) = i(D) =
  ℓ(W − D)`, so **function-field RR + the dictionary ⟺ its `χ`-form RR + Serre duality**;
  (iv) the dualizing sheaf `ω_{X/k}` corresponds to the canonical class `W` with
  `deg ω = 2g − 2` matching. The contract is *this list*; neither roadmap builds the
  other's side.
- **The PR #81 interface, discharged fibrewise.** What #81 assumes ("the space-of-sections
  dimensions for the divisors `n·[0]` on a relative curve"): over a field, this roadmap
  supplies `ℓ(n·[0]) = n` for `n ≥ 1` on a genus-1 function field with a rational place
  `[0]` (Layer 5's regime theorem) — stated in #81's vocabulary through the dictionary as
  `h⁰(E_s, 𝒪(n·[0_s])) = n` fibrewise. The **relative** upgrade (`π_*𝒪(n·[0])` locally
  free of rank `n`, cohomology-and-base-change) is **JacobianChallenge Layer C territory,
  not this roadmap's**: the split is recorded here as an explicit hand-off milestone
  ("fibrewise supplied ← here; relative glue ← JacobianChallenge C; consumer ← #81
  Layer 1"), so the three roadmaps' claims compose without a gap or an overlap.
- **The PR #68 comparison contract engine**: the anti-equivalence restricted to elliptic
  function fields is exactly the tool its Layer 2 comparison contract cites ("the place at
  `O₁` restricting to the place at `O₂`"); the compatibility milestone here is that this
  dictionary, specialized to `W.FunctionField`, induces its `Isogeny`-to-scheme-morphism
  correspondence.
- **Analytic horizon** (flagged, not built): over `k = ℂ`, the comparison with compact
  Riemann surfaces (PR #47's Layer-10 genus; Stichtenoth's preface route) — horizon,
  gated on a GAGA-style development that belongs to no current roadmap.

### Long horizon (direction, not this roadmap's deliverables)

Nonspecial-divisor existence refinements and Brill–Noether-style statements; classicality
and Weierstrass-point theory in char `p`; Stichtenoth/Henn char-`p` automorphism bounds;
general (singular) plane curves via intersection theory (Bézout is not at the pin);
Castelnuovo-style genus bounds; the analytic dictionary over `ℂ`; zeta functions (Wave-2
CurvesOverFiniteFields consumes Layers 0–8 directly). These set direction; Layers 0–12
are the roadmap.

## Worked examples (acceptance criteria)

Discharge alongside the layers; each catches a specific class of error (vacuous
definition, wrong degree convention, dropped hypothesis, sign flip, silent tameness).

- **`ℙ¹` places and degrees** (Layers 0–1): on `k(x)`: `deg P_∞ = 1`,
  `deg P_{p(X)} = natDegree p`; `ord_∞ x = −1`; `div x = P_{(X)} − P_∞` with
  `deg (div x) = 0`. Over `k = ℚ`, the place `P_{(X²+1)}` has degree 2 and residue field
  `ℚ(i)` — the degree-weighting smoke test.
- **`ℓ(n·P_∞) = n + 1` on `k(x)`** (Layers 1, 3): `L(n·P_∞)` = polynomials of degree
  `≤ n`; hence `genus k (RatFunc k) = 0` and Riemann's inequality is sharp at every `n`.
- **RR on `ℙ¹`** (Layer 4): `W = −2·P_∞` is canonical (`= (dx)`), `deg W = −2 = 2g − 2`,
  `ℓ(W) = 0 = g`; RR at `D = n·P_∞` reproduces `n + 1` two ways.
- **Exact-constants guard** (Layers 0, 3): for `F = ℂ(x)` over `k = ℝ`
  (`IsFunctionField ℝ (RatFunc ℂ)` holds), `ℓ(0) = 2 ≠ 1` — the example that keeps
  `IsIntegrallyClosedIn` an explicit hypothesis.
- **A genus-1 cubic = Mathlib's elliptic curve** (Layers 7, 10): for `[W.IsElliptic]`
  over `k`, `genus k W.toAffine.FunctionField = 1`; `ℓ(n·[O]) = n` for `n ≥ 1` (the #81
  fibrewise interface at the curve of record); `Cl⁰ ≅ ClassGroup W.CoordinateRing`; and
  over `ℚ` with `y² = x³ − x`: the 2-torsion places, `Diff = ` the four branch places,
  Hurwitz checking `2·1 − 2 = 2·(0 − 2) + 4`.
- **Hyperelliptic genus 2** (Layers 7, 10): `y² = x⁵ − 1` over `k` with
  `char k ∉ {2, 5}`: genus 2; the different of `F/k(x)` has degree 6 (the places over
  the zeros of `x⁵ − 1` — total degree 5, however they split over `k` — plus the one
  over `∞`), Hurwitz: `2·2 − 2 = 2·(−2) + 6`. The general `g = ⌊(deg f − 1)/2⌋` for
  squarefree `f`, both parities.
- **Wild honesty: Artin–Schreier** (Layer 7): `y² − y = x³` over `𝔽₂` (or `y^p − y = x²`
  over `𝔽_p`): the unique place over `∞` is wildly ramified with `d > e − 1`; the genus
  from the conductor computation disagrees with the naive tame count — the acceptance
  test that no `p ∤ e` slipped into Riemann–Hurwitz.
- **Inseparable constant-extension drop** (Layer 8): the standard
  `k = 𝔽_p(t)`, `F = k(x, y)`, `y² = x^p − t` example (`p` odd): genus drops after
  adjoining `t^{1/p}` — stated as the counterexample theorem guarding Layer 8's
  hypotheses.
- **Weierstrass gaps at genus 2** (Layer 5): at a Weierstrass place of the `y² = x⁵ − 1`
  curve, the gap sequence is `{1, 3}`; at a non-Weierstrass rational place it is `{1, 2}`.
- **Klein quartic** (Layers 10–11): `x³y + y³ + x = 0`-model (the affine Klein quartic)
  over `ℚ̄`/any char-0 `k̄`: genus `3 = (4−1)(4−2)/2`, and `#Aut = 168 = 84·(3−1)` — the
  Hurwitz-bound sharpness witness.

## Ordering and parallelism

Layers 0–1 are first and sequential (places, then their classification on `k(x)`).
Layer 2 (affine models) needs Layer 0 only and can run in parallel with Layer 1; its
divisor-facing milestones activate once Layer 3's types exist. Layer 3 needs Layers 0–2;
Layer 4 (RR) needs Layer 3 and the repartition vocabulary only — it is the critical path.
Layer 5 follows Layer 4. Layer 6 (extensions) needs Layers 0–3 but **not** RR, so it can
proceed in parallel with Layers 4–5; Layer 7 (different/Hurwitz) needs Layers 4 (cotrace),
5 (the local-component device `η` of Prop. 1.7.4), and 6. Layer 8 (constant extensions) needs Layer 6 and touches Layer 7 only for genus
statements. Layer 9 (Kähler) needs Layer 4 and is otherwise independent of 6–8; PR #68's
invariant-differential compatibility should not wait on Hurwitz. Layer 10 (models) needs
Layers 7 and 9 for its genus computations; Layer 11 needs Layers 5–8 and 10; Layer 12
needs conceptually everything but its *statements* (the contracts) should be drafted as
soon as Layer 3 exists, so JacobianChallenge, #68, and #81 can review the interface
early. The worked examples are spread across all layers and none is deferrable to the
end.

## References

- H. Stichtenoth, *Algebraic Function Fields and Codes*, 2nd ed., GTM 254, Springer,
  2009 — **the primary source**. Ch. I (places I.1, the rational function field I.2,
  independence I.3, divisors I.4, Riemann–Roch I.5, consequences I.6, local components
  I.7) = Layers 0–5; Ch. III (extensions III.1–III.3, cotrace/Hurwitz III.4, the
  different III.5, constant extensions III.6, Galois III.7–III.8, inseparable III.10,
  genus estimates III.11) = Layers 6–8; Ch. IV (differentials, `P`-adic expansions,
  Weil-differential comparison) = Layer 9; Ch. VI (elliptic VI.1, hyperelliptic VI.2,
  Kummer/Artin–Schreier VI.3–VI.4) = Layer 10; Appendix B = Layer 12's vocabulary.
  (Ch. 5 — zeta — is Wave-2's.)
- W. Fulton, *Algebraic Curves: An Introduction to Algebraic Geometry*, 2008 ed. — the
  plane-curve route: Ch. 5 (projective plane curves, Bézout, Max Noether), Ch. 8
  (divisors §8.1–8.2, Riemann's theorem §8.3 **with the ordinary-singularities genus
  formula** (Prop. 5 + Cor.), differentials §8.4, canonical divisors via adjoints §8.5
  Prop. 8, **Riemann–Roch §8.6 by the Brill–Noether/Noether-reduction argument** — ⚠
  *not* an adelic proof; "repartition" does not occur in Fulton). Layer 10's
  plane-curve computations and an independent check on Layer 4's statements.
  ⚠ Standing hypotheses: `k` **algebraically closed** from Ch. 3 on, char 0 at several
  points (§8.4 Prop. 6(2); his Appendix A discusses the char-`p` repairs) — every
  statement ported from Fulton must be re-hypothesized.
- Q. Liu, *Algebraic Geometry and Arithmetic Curves*, Oxford GTM 6, 2002 — Ch. 7
  (divisors, RR on schemes, the dictionary), the source of record for Layer 12's
  regular-vs-smooth honesty over imperfect fields. *(Library list.)*
- R. Hartshorne, *Algebraic Geometry*, GTM 52 — I.6 (the abstract curve from its
  places), IV (curves; IV.2 Hurwitz; Ex. IV.2.5 the `84(g−1)` bound) — Layer 12 shape
  source and a Layer-11 written source. *(Library list.)*
- D. M. Goldschmidt, *Algebraic Functions and Projective Curves*, GTM 215, 2003 — an
  alternative function-field-first exposition (Weil differentials, Weierstrass points
  **with proofs**, Wronskians); the written source for Layer 11's Weierstrass-point
  development. *(Library list.)*
- G. D. Villa Salvador, *Topics in the Theory of Algebraic Function Fields*,
  Birkhäuser, 2006 — the function-field treatment of automorphism groups (finiteness
  for `g ≥ 2`) and of inseparable/constant-field pathologies; Layer 8 and Layer 11
  written source. *(Library list.)*
- M. Deuring, *Lectures on the Theory of Algebraic Functions of One Variable*, LNM 314,
  Springer, 1973 — Stichtenoth's own citation for the imperfect-constant-field
  counterexamples of §3.6 (he states none); Layer 8's counterexample provenance.
  *(Library list.)*
- M. Rosen, *Number Theory in Function Fields*, GTM 210 — the arithmetic consumer's
  view (Wave-2-facing); cited for the S-integer/class-group bridges of Layer 2.
  *(Library list.)*
- J.-P. Serre, *Local Fields* — the different and ramification background of Layers
  6–8 (already the LocalFields sibling's primary source; cited here only for the
  trace-dual computations and the `G_i`).
- P. Roquette, *Abschätzung der Automorphismenanzahl von Funktionenkörpern bei
  Primzahlcharakteristik* (Math. Z. 117, 1970); H. Stichtenoth, *Über die
  Automorphismengruppe eines algebraischen Funktionenkörpers von Primzahlcharakteristik*
  I–II (Arch. Math. 24, 1973); H.-W. Henn, *Funktionenkörper mit großer
  Automorphismengruppe* (Crelle 302, 1978) — the char-`p` bounds and classifications of
  Layer 11's horizon. *(Library list.)*

## Provenance and coordination

- **vaca22/riemann-roch-function-fields** (Guanghao Li, Apache-2.0) — the standing
  obligation of this roadmap. The same function-field route to RR exists there sorry-free
  with an active Mathlib upstreaming pipe (#41729/#41732/#41728/#41696). Per the root
  conventions ("coordinate before integrating existing work"), the stance is: (i) this
  roadmap develops the mathematics **independently in Tau Ceti** (owner decision: Tau Ceti
  is the destination), *specifying the mathematics, not that code* — nothing here is a
  file-by-file port, and this section is the only place the repo is treated as a source;
  (ii) **contact the author before Layers 3–5 start**, on Zulip, cross-linking this
  roadmap, his repo, and Mathlib #41621, and declaring the function-field lane this
  roadmap targets — if he prefers joint work or his upstreaming lands first, the affected
  milestones become comparison-and-consume tasks (same pattern as the LocalFields
  sibling's ClassFieldTheory obligations); (iii) statement-shape alignment where his
  conventions and this roadmap's pinned ones agree (places as valuation data, divisors
  over places, adelic `i(D)`, existential canonical class), and *documented divergence*
  where they do not — this roadmap pins normalized `ℤᵐ⁰`-valuations and `Finsupp`
  divisors for Mathlib-vocabulary reasons stated in the conventions table; (iv) his
  Mathlib PRs, once merged, are consumed like any upstream material (refactor-onto
  flags on Layers 2–3's divisor-group milestones).
- **Mathlib scheme-divisor campaign (R. D. Giles)** — Layer 12 must track
  `AlgebraicGeometry/AlgebraicCycle/*` and `OrderOfVanishing` (already on master) and
  state its dictionary milestones against them at the next bump; the function-field
  divisor here is a different (field-level) object, so no namespace collision, but the
  Layer-12 "Weil divisors on the regular model" side is **his namespace, not ours** —
  contract statements there consume his types, and any gap found is reported upstream,
  not forked. Cite #41621 and the open stack on every Layer-12 milestone.
- **[JacobianChallenge](../JacobianChallenge/README.md)** (merged TauCeti roadmap;
  Merten's AG formulation). The division of labor is pinned: it builds scheme divisors,
  coherent cohomology, Serre duality, `Pic⁰`, and the Jacobian; this roadmap builds the
  function-field theory and proves RR adelically; **the Layer-12 comparison contract
  (four numbered items: divisors, `H⁰ = L(D)`, `g_cohomological = g_functionfield` via
  `h¹ = i(D)`, dualizing sheaf = canonical class) is the entire interface** — stated
  here, consumable by both, so the two RRs reconcile instead of duplicating. Its
  acceptance criterion `dim Jac = g` consumes this roadmap's genus through that
  contract. Draft the contract statements as soon as Layer 3's types exist (Ordering
  section) and review them with the JacobianChallenge maintainers.
- **PR #81 (ModularCurves, C. Birkbeck)** — the named consumer. Its assumed
  Riemann–Roch interface (quoted in the opening; "the space-of-sections dimensions for
  the divisors `n·[0]` on a relative curve") is discharged in two named pieces:
  the **fibrewise dimension count is Layer 5's regime theorem** specialized to genus 1
  (`ℓ(n·[0]) = n`, stated in #81's vocabulary through Layer 12's dictionary), and the
  **relative upgrade (pushforward locally free, base change) is explicitly
  JacobianChallenge-Layer-C territory** — the hand-off is recorded as a Layer-12
  milestone so the three roadmaps compose without gap or overlap. Talk to the author
  before Layer 12 lands (the master plan already flags this conversation).
- **PR #68 (EllipticCurves, C. Birkbeck)** — the sibling instance. Its Layer 0
  deliberately leaves the place/divisor *implementation* "to the upstream coordination";
  this roadmap **is** that coordination point: the conventions table here (normalized
  valuations, `Finsupp` divisors, residue-finrank degrees) is the general theory its
  interface expects. Named compatibility milestones: the point–place dictionary in
  general form (Layer 10.iii), `Cl⁰ ≅ ClassGroup CoordinateRing` (Layer 10.iv, closing
  its `toClass_surjective` triangle without re-proving the group law), the
  `IsDedekindDomain CoordinateRing` instance both roadmaps want (Layer 10.ii), the
  fundamental identity it cites as Stichtenoth 3.1.11 (Layer 6), and the invariant
  differential in `Ω[FunctionField⁄K]` reconciled with the trivial canonical class
  (Layer 9). Its "regular, not smooth" convention over imperfect fields is adopted
  verbatim in Layer 12.
- **PR #47 (ModularForms, C. Birkbeck)** — no interface: its Layer 10 builds the genus
  of `X(Γ)` analytically (Euler characteristics; its dimension-formula lower bounds are
  gated on a planned analytic compact-Riemann-surfaces RR, not on this roadmap).
  Cited so nobody wires a false dependency; the analytic ↔ algebraic genus
  comparison is a flagged horizon of Layer 12, gated on GAGA-style work no current
  roadmap owns.
- **Wave-2 consumers** (all "roadmap in preparation"): **CurvesOverFiniteFields**
  consumes Layers 0–8 wholesale (its zeta rationality/functional equation are RR
  corollaries; the `Cl⁰` finiteness over finite `k` and strong approximation are
  supplied here); **HyperellipticCurves** consumes Layer 10's model class and Layer 7's
  Hurwitz; **BelyiMaps** consumes Layers 6–7 (ramification, RH) and Layer 12's
  dictionary; the LMFDB genus/automorphism data semantics (higher-genus section) rest
  on Layers 10–11.
- **Siblings**: [LocalFields](../LocalFields/README.md) owns the *local* ramification
  filtration (lower/upper numbering, Herbrand, Hasse–Arf); this roadmap's Layer 8 keeps
  the function-field-level `G_i` and Hilbert's different formula (Stichtenoth 3.8.7)
  and states the completion bridge once, deferring all filtration technology to that
  roadmap. `Mathlib/RingTheory/LaurentSeries.lean` (de Frutos-Fernández–Nuccio) is the
  local-expansion prior art for Layer 9.
- **Zulip** (audited 2026-07-30; threads of record listed in §What is in motion): before
  Layer 0 starts, post in #maths cross-linking this roadmap, vaca22's repo, and Mathlib
  #41621, declaring the route split (function-field/adelic here; scheme/cohomological
  in Mathlib's campaign and JacobianChallenge) — and register an intention issue per
  the root README's claims process. The 2025-12-19 "Riemann-Roch" thread in
  #Is-there-code-for-X? should be revived with the declaration.
