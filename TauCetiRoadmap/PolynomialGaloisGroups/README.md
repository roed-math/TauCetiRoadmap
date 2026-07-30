# Roadmap: Galois groups of polynomials

Mathlib has the Galois group of a polynomial (`Polynomial.Gal`, the automorphism group of
its splitting field) with a faithful action on roots that is transitive for irreducible
polynomials, one direction of Abel–Ruffini, and — thanks to A. Chambert-Loir's program — a
serious permutation-action toolkit: blocks, preprimitivity with the stabilizer-maximality
characterization, multiple transitivity and multiple primitivity, two of Jordan's
primitivity criteria, the Iwasawa criterion, simplicity of `Aₙ`, and the intransitive case
of O'Nan–Scott. What it does **not** have is everything the LMFDB's Galois-groups section
(transitive-group labels `nTj`) actually runs on: no discriminant ↔ `Aₙ` test (the
polynomial discriminant exists, but not its product-of-root-differences formula), no
resolvent method, no Frobenius-specialization pipeline (Frobenius *elements* exist;
Dedekind's factorization ↔ cycle-type theorem does not), no classification of transitive
groups in any degree, no `nTj` label semantics, and no general wreath products or
imprimitivity structure theory. We build all of that here: the permutation-group half as
reusable group theory, the Galois half against Mathlib's `Polynomial.Gal`, up to the
summits — every `Sₙ` (and, layered honestly, `Aₙ`) realized as a Galois group over `ℚ` —
with Hilbert irreducibility as the explicit horizon.

Suggested home: `TauCeti/GroupTheory/Permutation/` for the group-theoretic layers
(blocks-and-stabilizers dictionary, wreath products and imprimitivity, Jordan-type
recognition theorems, the transitive-subgroup classifications and label predicates —
Layers 1, 6–8's group half), and `TauCeti/FieldTheory/GaloisGroups/` for the Galois-theoretic
layers (the polynomial dictionary, discriminants, resolvents, Frobenius specialization,
labels of polynomials, the inverse-Galois summits — Layers 0, 2–5, 8's field half, 9–10).
The split follows Mathlib's own placement (its toolkit lives in
`Mathlib/GroupTheory/GroupAction/`, its Galois groups in `Mathlib/FieldTheory/`) and keeps
the permutation material consumable by non-Galois customers (the
[representation-theory family](../RepresentationTheory/README.md)'s symmetric-group
roadmaps, future O'Nan–Scott work) without dragging field theory into their imports.

This roadmap is part of the LMFDB-background family (2026-07-30): it serves the LMFDB
section `galois_groups` directly, supplies the Galois-group certification interface that
the in-flight ModularForms roadmap (upstream PR #47, C. Birkbeck) names as its Layer-9
dependency, and supplies the label semantics that the planned ArtinRepresentations and
NumberFieldArithmetic roadmaps display. It **consumes** the
[NumberFieldArithmetic](../NumberFieldArithmetic/README.md) roadmap (in preparation) at
exactly one named point — Dedekind's theorem, that away from the index divisors the
factorization type of `f mod p` is the cycle type of a Frobenius element — and pins the
expected statement shape below so work here never blocks on it. Frobenius *construction*
(decomposition groups, `IsArithFrobAt`, ramification) is NumberFieldArithmetic's;
character theory is the representation-theory family's; Artin representations are a
planned later roadmap.
Abstract-group data (character tables, group names) belongs to the RepresentationTheory
family; we own only the *permutation* data of `nTj`.

## Standing hypotheses and pinned conventions

- **Which Galois group.** "The Galois group of `p`" is Mathlib's `Polynomial.Gal p`: the
  automorphism group of `p.SplittingField` over the base field `F`, acting on
  `p.rootSet E` of any splitting extension `E` through `Polynomial.Gal.galAction`, with
  `galActionHom : p.Gal →* Equiv.Perm (p.rootSet E)` injective. All statements are made
  against this definition; do not introduce a rival. The LMFDB attaches a Galois group to
  a *number field* `K = ℚ(α)`: that is `(minpoly ℚ α).Gal` (the Galois closure's group,
  in its degree-`n` action on the roots of the minimal polynomial); the polynomial ↔ field
  dictionary is a Layer 0 target, not a convention to blur. Reducible and irreducible
  polynomials both matter (resolvents are usually reducible): no layer may assume
  irreducibility where separability suffices, and every statement says which it needs.
- **Separability, spelled out.** The degree-`n` permutation picture needs `n` distinct
  roots: the standing hypothesis is `p.Separable` (plus `p ≠ 0`; monic where it
  simplifies), under which `p.rootSet p.SplittingField` has `natDegree p` elements. Over
  `ℚ` (or any char-0 or perfect field) irreducible ⟹ separable, and the `ℚ`-facing
  corollaries drop the hypothesis; char-`p` statements carry it explicitly. ⚠ Inseparable
  polynomials have too few roots and a too-small permutation image — no statement below is
  claimed for them, and worked examples include a non-example keeping this honest.
- **Roots are intrinsic; `Fin n` is chaperoned.** The action lives on `p.rootSet E`, a
  subtype with no preferred ordering. Statements are made intrinsically wherever possible;
  a numbering `e : Fin n ≃ p.rootSet E` enters only where a comparison with a reference
  subgroup of `Equiv.Perm (Fin n)` demands it, always through an explicit equiv and only
  in up-to-conjugacy statements. The `nTj` label is a conjugacy-class predicate, so
  label statements are numbering-independent by construction; never fix a global root
  order and never state a theorem whose truth depends on one.
- **The `nTj` labels, pinned.** For `n ≤ 47` the LMFDB (following the transitive-groups
  databases: Butler–McKay for `n ≤ 11`, through Cannon–Holt, Holt–Royle, and
  Holt–Royle–Tracey beyond) numbers the conjugacy classes of transitive subgroups of `Sₙ`
  as `nT1, nT2, …`. The `T`-numbering is a database convention fixed by the published
  tables, not intrinsic mathematics; we pin it by **reference subgroups**: for each `(n, j)`
  in scope, a concrete subgroup `T(n,j) ≤ Equiv.Perm (Fin n)` given by generators
  (Layer 6 for `n ≤ 5`, Layer 7 for `n ≤ 7`, Layer 8 data for `8 ≤ n ≤ 11`), and
  `TransitiveGroupLabel n j G` means: `G` is transitive and some (equivalently, by
  transitivity of the reference data, any) numbering conjugates `G` onto `T(n,j)`. The
  degree-`≤ 5` dictionary is in Layer 6's table below, verified against the LMFDB and
  PARI's `polgalois`. A label's **invariants, as the LMFDB displays them**, are pinned to
  Mathlib vocabulary: order = `Nat.card G`; **parity** `+1` iff `G ≤ alternatingGroup`
  (iff the composite `G → Perm → ℤˣ` under `Equiv.Perm.sign` is trivial — LMFDB's
  even/odd column); **primitive** = `MulAction.IsPreprimitive G (Fin n)` for the natural
  action; solvable = `IsSolvable G`; cycle-type data through `Equiv.Perm.cycleType`.
- **Cycle types count fixed points.** Mathlib's `Equiv.Perm.cycleType` lists only cycle
  lengths `≥ 2`; the factorization type of `f mod p` is a partition of `n` *with* its
  `1`-parts. Pin the bridge once: `fullCycleType σ = σ.cycleType + (n − σ.support.card)`
  copies of `1` (prototype in `Suggested.lean`), and state every Dedekind/Frobenius
  comparison with `fullCycleType`. Never compare a factor-degree multiset with a bare
  `cycleType`; the off-by-fixed-points error is the standard trap.
- **Discriminant.** The polynomial discriminant is Mathlib's `Polynomial.discr`
  (`Mathlib/RingTheory/Polynomial/Resultant/Basic.lean`: the Sylvester-matrix resultant of
  `f` and `f'`, sign-normalized so real polynomials with all roots real have `discr ≥ 0`).
  We adopt it as *the* discriminant and build its missing theory (the root-product formula
  is that file's own TODO — see coordination). ⚠ The discriminant test `disc ∈ (Fˣ)² ⟺
  Gal ≤ Aₙ` is **false in characteristic 2** (with `−1 = 1` the product `∏_{i<j}(rᵢ−rⱼ)`
  is itself symmetric, so `√disc` is always rational and the test detects nothing);
  every statement of the test carries `ringChar F ≠ 2`, and the char-2 replacement (the
  Berlekamp discriminant) is recorded as a horizon note in Layer 3, not silently omitted.
- **Resolvent, the name.** In Mathlib `resolvent` means the spectral-theory resolvent
  (`spectrum`, `Mathlib/Algebra/Algebra/Spectrum/Basic.lean`) — a genuine name clash. Our
  objects are `galResolvent` (general orbit resolvents), `resolventCubic` (of a quartic),
  and `resolventSextic` (of a quintic, the Cayley/Dummit resolvent), in the
  `TauCeti/FieldTheory/GaloisGroups/` namespace.
- **Frobenius-specialization interface, pinned.** The consumed statement (supplied by
  [NumberFieldArithmetic](../NumberFieldArithmetic/README.md); exact name theirs, shape
  ours, stated in `Suggested.lean` so downstream layers elaborate today): for monic
  `f : ℤ[X]` and a prime `p` **not dividing `f.discr`**, there exists
  `σ : (f over ℚ).Gal` whose `fullCycleType` under the root action equals the multiset of
  degrees of the monic irreducible factors of `f mod p`. ⚠ The hypothesis is `p ∤ discr f`,
  **not** "`p` unramified in the root field": common index divisors (Dedekind's
  `x³ + x² − 2x + 8` at `p = 2`, a NumberFieldArithmetic worked example) make the
  factorization of `f mod p` lie about the splitting of `p` — but `p ∤ discr f` bounds the
  index too (`discr f = index² · disc K`), which is why it is the right polynomial-side
  hypothesis. Statements over `ℤ` with `discr ≠ 0` only; no claim at primes dividing the
  discriminant.
- **Certificates, not searches.** The degree-`8..11` layer exposes Galois-group
  computation as *certificate checking*, matching the interface upstream PR #47 (Layer 9)
  already names: a certificate bundles finitely many primes with the factorization types
  of `f mod p` (lower bounds via Dedekind), a discriminant square test, and resolvent
  root/factorization data (upper bounds); the checker verifies each item by computation
  and the soundness theorem concludes the label. Cycle types alone can never certify an
  upper bound (they only exhibit elements); resolvents and the discriminant do that. This
  asymmetry is a design principle of Layers 4–5 and 8, stated there as theorems and
  non-theorems, and it is why Galois-group *computation* is unconditional — Chebotarev
  (which lives in the LFunctions roadmap, not here) is needed only to promise that the
  exhibiting primes come fast, never for correctness.
- **Naming.** `fullCycleType`, `TransitiveGroupLabel n j`, `galResolvent`,
  `resolventCubic`, `resolventSextic`, `HasGaloisLabel f n j` (polynomials),
  `GaloisCertificate` / `GaloisCertificate.Checks` (Layer 8). `Suggested.lean` pins the
  forms.

## What Mathlib already has (consume)

At the build pin (`9caeba1000`, 2026-06-03); everything listed was re-verified there.

- **Galois groups of polynomials:** `Mathlib/FieldTheory/PolynomialGaloisGroup.lean` —
  `Polynomial.Gal`, `galAction`, `galActionHom` with `galActionHom_injective`
  (faithfulness), **`galAction_isPretransitive`** (transitivity for irreducible `p`),
  `restrict`/`restrictDvd`/`restrictProd` (with `restrictProd_injective`:
  `Gal (p*q) ↪ Gal p × Gal q`), `restrictComp_surjective`, `card_of_separable`
  (`#Gal = [SplittingField : F]`), `prime_degree_dvd_card` (char 0; the Cauchy input),
  and the `Unique` instances for split/degenerate polynomials. In
  `Mathlib/Analysis/Complex/Polynomial/Basic.lean`:
  `Polynomial.Gal.galActionHom_bijective_of_prime_degree`(`'`) — over `ℚ`, irreducible of
  prime degree with exactly two non-real roots has full Galois group (complex conjugation
  as the swap).
- **Solvability:** `Mathlib/FieldTheory/AbelRuffini.lean` — `solvableByRad` and
  `isSolvable_gal_of_irreducible` (solvable by radicals ⟹ solvable Galois group; the
  library's direction), plus the `gal_*_isSolvable` kit;
  `Archive/Wiedijk100Theorems/AbelRuffini.lean` — `x⁵ − 4x + 2` is not solvable by
  radicals, via `gal_Phi` (its Galois group is all of `S₅`). The converse direction
  (solvable group ⟹ radical tower, char 0) is **absent**; it is adjacent context for us,
  not a target — our solvability story is the group-side `IsSolvable` invariant.
- **The permutation-action toolkit (Chambert-Loir):**
  `Mathlib/GroupTheory/GroupAction/Blocks.lean` (`MulAction.IsBlock`, trivial and orbit
  blocks, `IsBlock.ncard_block_mul_ncard_orbit_eq`, the `BlockMem` bounded order;
  Wielandt-based), `Primitive.lean` (`MulAction.IsPreprimitive`, `IsQuasiPreprimitive`,
  **`isCoatom_stabilizer_iff_preprimitive`**, `IsPreprimitive.of_prime_card`, Rudio's
  theorem), `MultipleTransitivity.lean` (`MulAction.IsMultiplyPretransitive` via
  `Fin n ↪ α`; 2-transitive ⟹ preprimitive; `Equiv.Perm` is `n`-pretransitive and
  preprimitive; `alternatingGroup` is `(n−2)`-pretransitive;
  `eq_top_of_isMultiplyPretransitive`; `IsMultiplyPretransitive.alternatingGroup_le`),
  `MultiplePrimitivity.lean` (`IsMultiplyPreprimitive`), `Jordan.lean` — **Jordan's
  theorems**: `Equiv.Perm.subgroup_eq_top_of_isPreprimitive_of_isSwap_mem` (primitive +
  swap = `Sₙ`), `Equiv.Perm.alternatingGroup_le_of_isPreprimitive_of_isThreeCycle_mem`
  (primitive + 3-cycle ⊇ `Aₙ`), `MulAction.IsPreprimitive.isMultiplyPreprimitive`
  (Jordan's multiple primitivity criterion); the **prime-cycle version (Wielandt 13.9) is
  that file's own `proof_wanted alternatingGroup_le_of_isPreprimitive_of_isCycle_mem`** —
  see coordination. Also `Iwasawa.lean` (the Iwasawa simplicity criterion),
  `Transitive.lean` (pretransitivity along equivariant maps), and the
  `SubMulAction/{OfStabilizer,OfFixingSubgroup,Combination}.lean` machinery (the last:
  the action on `powersetCard α n`, PR #34307).
- **Permutations and specific groups:** `Mathlib/GroupTheory/Perm/Cycle/Type.lean`
  (`Equiv.Perm.cycleType` with sum/order/sign/conjugacy lemmas —
  `sign_of_cycleType`, `cycleType_conj`, `isConj_iff_cycleType_eq` — and
  **`Equiv.Perm.subgroup_eq_top_of_swap_mem`**: a transitive-order subgroup of `Perm α` of
  prime cardinality degree containing a swap is everything — the workhorse behind the
  prime-degree `Sₙ` certificates), `Perm/Cycle/PossibleTypes.lean`
  (`Equiv.Perm.exists_with_cycleType_iff`), `Perm/ClosureSwap.lean`,
  `SpecificGroups/Alternating/` (**`alternatingGroup.isSimpleGroup` for `5 ≤ Nat.card α`**,
  `Simple.lean`; Klein-four material in `KleinFour.lean`), `SpecificGroups/Cyclic`,
  `Dihedral.lean` (`DihedralGroup` — abstract only, no pinned embedding into `Perm`),
  `Quaternion.lean`, `Mathlib/GroupTheory/Sylow.lean` (finite Sylow theory; Cauchy via
  `exists_prime_orderOf_dvd_card`).
- **Wreath products, regular case only:** `Mathlib/GroupTheory/RegularWreathProduct.lean`
  — `D ≀ᵣ Q = (Q → D) ⋊ Q` (base indexed by `Q` itself), `toPerm` into
  `Equiv.Perm (Λ × Q)`, `IteratedWreathProduct`, and
  `Sylow.mulEquivIteratedWreathProduct` (Sylow `p`-subgroups of `S_{pⁿ}`). The **general**
  permutation wreath product (base indexed by a `Q`-set — what imprimitivity embeds into)
  is absent; Layer 1 builds it as a generalization, in coordination (below).
- **O'Nan–Scott, first case:** `Mathlib/GroupTheory/Perm/MaximalSubgroups.lean` and
  `SpecificGroups/Alternating/MaximalSubgroups.lean` — `isCoatom_stabilizer` (setwise
  stabilizers of subsets are maximal; the *intransitive* case, after
  Liebeck–Praeger–Saxl), with the *imprimitive* case named there as the next TODO — the
  exact point our wreath-product layer must coordinate with.
- **Discriminants and resultants:** `Mathlib/RingTheory/Polynomial/Resultant/Basic.lean` —
  `Polynomial.resultant` (Sylvester determinant, with `optParam` degree arguments) and
  `Polynomial.discr` (with `discr_C`, `discr_of_degree_eq_one/two/three`); the
  root-product formula is the file's TODO. `Mathlib/Algebra/CubicDiscriminant.lean` —
  `Cubic.discr` with `Cubic.discr_eq_prod_three_roots` and the distinct-roots criterion.
  `Mathlib/RingTheory/Discriminant.lean` — `Algebra.discr` (trace-form discriminant of a
  basis) with `discr_powerBasis_eq_prod''` (the `∏ (σᵢ x − σⱼ x)²` form) and
  `discr_powerBasis_eq_norm` — the number-field side our comparison layer bridges to.
  `Mathlib/Algebra/QuadraticDiscriminant.lean`.
- **The arithmetic interface (for Layer 5's consumers and suppliers):**
  `Mathlib/NumberTheory/KummerDedekind.lean` (the conductor-coprime factorization
  bijection `normalizedFactorsMapEquivNormalizedFactorsMinPolyMk` — shape and
  multiplicities of `p·𝒪` vs `f mod p`), `Mathlib/RingTheory/Frobenius.lean`
  (**`IsArithFrobAt`**, both `AlgHom` and group-element forms; existence
  `IsArithFrobAt.exists_of_isInvariant`, uniqueness mod inertia, conjugacy),
  `Mathlib/RingTheory/Invariant/Basic.lean` (`Algebra.IsInvariant`, transitivity on primes
  above `p`, `Ideal.Quotient.stabilizerHom_surjective`),
  `Mathlib/FieldTheory/Galois/IsGaloisGroup.lean` (the `IsGaloisGroup G A B` predicate —
  the modern packaging of "Galois group acting on rings of integers"),
  `Mathlib/NumberTheory/RamificationInertia/` (e/f, `sum_ramification_inertia`, the Galois
  case, and `HilbertTheory.lean`: decomposition and inertia fields),
  `Mathlib/FieldTheory/Finite/` (finite fields; `IsCyclic Gal(L/K)` for finite fields —
  Frobenius generates), `Ideal.primesOver` (`Mathlib/RingTheory/Ideal/Over.lean`). These
  are NumberFieldArithmetic's raw material; we consume its packaged theorem, and cite
  these only in the bridge lemmas that are genuinely polynomial-side.
- **Cyclotomic Galois groups:** `Mathlib/NumberTheory/Cyclotomic/Gal.lean` —
  `IsCyclotomicExtension.autEquivPow`, `galCyclotomicEquivUnitsZMod`,
  `galXPowEquivUnitsZMod` (`Gal(Φₙ) ≃* (ZMod n)ˣ`) — the abelian examples (`4T1`, `4T2`)
  ride on these.
- **Chebotarev: absent** (no statement in any form at the pin or on master); it is the
  LFunctions roadmap's summit, and nothing here depends on it (see the certificates
  convention).

## What is missing (build here)

Everything label-shaped. At the pin **and on master (re-checked 2026-07-30)**: no
orbit ↔ irreducible-factor dictionary for the Galois action; no blocks ↔ intermediate-field
dictionary; no discriminant root-product formula (named TODO upstream), hence no
`disc ↔ Aₙ`; no resolvent in the Galois sense (the identifier means spectral theory); no
Dedekind factorization ↔ cycle-type theorem (Frobenius elements exist,
`KummerDedekind` gives the shape bijection, but nobody composes them with `galActionHom`);
no general wreath product (only `RegularWreathProduct`; the imprimitive O'Nan–Scott case
is an upstream TODO); no Jordan prime-cycle theorem (an upstream `proof_wanted`); no
classification of
transitive subgroups of `Sₙ` for any `n ≥ 3`; no `nTj` labels, no parity/primitivity
invariant layer, no certificates; no inverse-Galois realizations beyond the prime-degree
`S_p` criterion; no Hilbert irreducibility. Chambert-Loir's open PRs (see coordination)
head toward PSL₂ simplicity and Dieudonné generation, not toward any of this. On Zulip we
found no thread claiming any of it (the searchable trail for this area is his mathlib PR
review threads, not Zulip).

---

## The build, in layers

The ordering below is the dependency order; Layer 1 is pure group theory and can run in
parallel with Layers 0/2–3. As each layer makes the next layer's *types* expressible in
`TauCeti/`, state its milestones in `Suggested.lean` (with `sorry`).

### Layer 0: the permutation representation of a polynomial

The dictionary between polynomial data and the image subgroup
`(galActionHom p E).range ≤ Equiv.Perm (p.rootSet E)`.

- **Degree bookkeeping.** For separable `p ≠ 0`: `p.rootSet p.SplittingField` has
  `p.natDegree` elements (assemble from `card_rootSet_eq_natDegree`); the action of
  `p.Gal` on it is faithful (consume `galActionHom_injective`), so
  `Nat.card p.Gal = Nat.card (galActionHom …).range` and every permutation invariant of
  `p.Gal` is computed in the image.
- **Orbits ↔ irreducible factors.** For separable `p`, the orbits of `p.Gal` on
  `p.rootSet E` biject with the distinct monic irreducible factors of `p`, the orbit of a
  root `α` being the root set of `minpoly F α`, of size `(minpoly F α).natDegree`. Derive
  both directions of the transitivity dictionary: transitive ⟺ `p` is (up to units) a
  power of one irreducible, and for separable `p`: transitive ⟺ irreducible (consume
  `galAction_isPretransitive` for one direction). This is the reducible-polynomial
  workhorse every resolvent argument uses.
- **Invariants of the image.** Order (`card_of_separable`), parity (the sign character
  `p.Gal →* ℤˣ` through `galActionHom`; evenness ⟺ image `≤ alternatingGroup`),
  solvability (`IsSolvable p.Gal` — consume the AbelRuffini kit for radical examples),
  cycle types of elements. These are definitions-plus-transport lemmas; their *tests* come
  in Layers 3–5.
- **The polynomial ↔ number-field dictionary.** For `K = ℚ(α)` with `f = minpoly ℚ α`:
  `f.Gal` is the Galois group of the Galois closure of `K/ℚ` (Mathlib's
  `IntermediateField.normalClosure`), acting with point stabilizer of index `n = [K : ℚ]`;
  under this dictionary the LMFDB's "Galois group of `K`" is `TransitiveGroupLabel n j`
  applied to the image. Includes the sibling-fields remark: conjugate fields = cosets of
  the stabilizer, `K` determined by `f.Gal` with its point stabilizer up to conjugacy.

### Layer 1: the permutation toolkit — blocks, wreath products, recognition

Pure group theory (`TauCeti/GroupTheory/Permutation/`), stated for abstract group actions
in Mathlib's vocabulary (`MulAction.IsBlock`, `IsPreprimitive`, …), never mentioning
fields. Consume the Chambert-Loir suite wholesale; build:

- **The block–stabilizer Galois connection.** For a transitive action of `G` on `α` and
  `a : α`: the map `B ↦ stabilizer G B` (setwise) is an order isomorphism from blocks
  containing `a` onto the interval `[stabilizer G a, ⊤]` of subgroups, with inverse
  `H ↦ H • a` (Wielandt 7.5; Dixon–Mortimer 1.5A). Mathlib has the two endpoints
  (`BlockMem` is a bounded order; `isCoatom_stabilizer_iff_preprimitive` is the coatom
  shadow of this iso); build the full lattice isomorphism — Layer 2 will read
  intermediate fields off it.
- **General wreath products.** `WreathProduct D ι := (ι → D) ⋊ Equiv.Perm ι` (and, for a
  point-group `Q ≤ Perm ι`, the sub-wreath `(ι → D) ⋊ Q`), generalizing Mathlib's
  `RegularWreathProduct` (which is the case `ι = Q` with the translation action): the
  imprimitive action on `ι × Λ` for a `D`-set `Λ`, the product action on `ι → Λ` as a
  definite later milestone (it is the primitive O'Nan–Scott case; state it, use it
  nowhere below), compatibility `D ≀ᵣ Q = ` sub-wreath of `WreathProduct D Q` along the
  regular embedding, order formula `|D|^|ι| · |ι|!`. **Coordinate before building**: the
  `RegularWreathProduct` authors and Chambert-Loir's imprimitive-O'Nan–Scott TODO both
  border this file (see coordination); the design (which of `(ι → D) ⋊ Perm ι` and the
  restricted variants is primary) should be agreed on Zulip first.
- **Imprimitivity ⟹ wreath embedding.** For a transitive action with a block `B` of size
  `l`, `1 < l < n`: the block system `{g • B}` has `m = n/l` blocks; the action induces
  `G →* Equiv.Perm` (block system) whose kernel embeds in `∏ (blocks) Perm(block)`; and
  the whole of `G` embeds in `WreathProduct (Perm B) (block system)` compatibly with a
  bijection `α ≃ (block system) × B` — the imprimitivity structure theorem
  (Dixon–Mortimer 2.6A). Sharpened form: minimal blocks give primitive block quotients;
  iterating yields the imprimitivity chain (Hulpke §3's inflation/base-group vocabulary —
  the data-semantics layer's structure method).
- **Jordan's prime-cycle theorem** (Wielandt 13.9): a primitive subgroup of `Sₙ`
  containing a `p`-cycle with `p + 3 ≤ n`, `p` prime, contains `Aₙ`. Mathlib's
  `Jordan.lean` already states it verbatim as
  `proof_wanted alternatingGroup_le_of_isPreprimitive_of_isCycle_mem`; **upstream-first**:
  offer the proof to Chambert-Loir's program (it discharges his `proof_wanted`), and
  consume from here either way. Corollaries in his vocabulary:
  with `MultipleTransitivity`'s `alternatingGroup_le`, the recognition statements below.
- **The recognition kit** (each a small named theorem; together they discharge every
  `n ≤ 5` certificate and the `Sₙ`-summit):
  - a transitive subgroup of `S_p` (`p` prime) contains a `p`-cycle (Cauchy);
  - transitive + swap + prime degree ⟹ `S_p` (consume
    `Equiv.Perm.subgroup_eq_top_of_swap_mem`);
  - transitive + `(n−1)`-cycle ⟹ 2-transitive ⟹ primitive (stabilizer transitivity;
    consume `isPreprimitive_of_is_two_pretransitive`);
  - primitive + swap ⟹ `Sₙ`; primitive + 3-cycle ⟹ `⊇ Aₙ` (consume Jordan);
  - order-based recognition in low degree: e.g. a transitive `G ≤ S₅` with an element of
    order 6 is `S₅`; with an element of order 3 and even, contains `A₅` — the lemmas that
    turn one exhibited cycle type into a classification, proved from the Layer 6 tables.

### Layer 2: the Galois ↔ permutation dictionary

For irreducible separable `p` over `F` with a root `α` in `L = p.SplittingField`:

- **Stabilizers are relative Galois groups.** `stabilizer p.Gal (α : rootSet)` is
  `(IntermediateField.adjoin F {α}).fixingSubgroup`; its index is `natDegree p`; the
  Galois correspondence transports the Layer 1 block–stabilizer isomorphism to:
  **blocks containing `α` ↔ intermediate fields of `F(α)/F`**, `B ↦ F(` the
  `B`-symmetric functions `)` — concretely, the block through `α` for `F ⊆ E ⊆ F(α)` is
  the root set of `minpoly E α` inside the roots of `p`.
- **Primitivity ⟺ no proper intermediate field.** The action of `p.Gal` on the roots is
  preprimitive ⟺ `F(α)/F` has no intermediate field other than the ends ⟺
  `IntermediateField.adjoin F {α}` is an atom (consume
  `isCoatom_stabilizer_iff_preprimitive` + the correspondence). Corollary (also directly
  from `IsPreprimitive.of_prime_card`): irreducible of prime degree ⟹ primitive.
- **2-transitivity.** The action is 2-pretransitive ⟺ `p / (X − α)` is irreducible over
  `F(α)` (stabilizer transitivity on the remaining roots; state with
  `SubMulAction.ofStabilizer`'s `isMultiplyPretransitive_iff`).
- **Products and towers.** Describe the image of `restrictProd`: `Gal (p*q)` is the fiber
  product — the subgroup of `Gal p × Gal q` of pairs agreeing on the intersection of the
  splitting fields (both projections surjective by `restrictDvd_surjective`); coprime
  splitting-field case: an isomorphism onto the product. The compositum/tower lemma set
  needed by resolvents: a `Gal p`-equivariant polynomial map of root data induces
  `Gal p ↠ Gal q` when `q`'s splitting field embeds in `p`'s.
- ⚠ **Reducible conventions.** For reducible separable `p` the stabilizer/block dictionary
  is stated per-orbit (per irreducible factor); no statement quantifies over "the" root of
  a reducible polynomial.

### Layer 3: discriminant ↔ alternating

- **The root-product formula** (the upstream TODO; coordinate — see below): for monic `f`
  of degree `n` splitting in `L` with roots `r : Fin n → L` (with multiplicity),
  `algebraMap R L f.discr = ∏_{i < j} (r i − r j)²`; consequences: `discr (f*g)`
  product formula with the `resultant f g` cross term; **base-change**
  `(f.map φ).discr = φ f.discr` for a ring hom `φ` (degree-preserving case) — the exact
  bridge Layer 5 uses at `ℤ → ZMod p`; `f.discr ≠ 0 ⟺ f.Separable` (monic case);
  comparison lemmas `Cubic.discr P = (P.toPoly).discr` (monic normalization) and, for a
  power basis, `Algebra.discr` of the basis = `(minpoly).discr` (route through
  `discr_powerBasis_eq_norm`) — the polynomial ↔ number-field discriminant bridge that
  NumberFieldArithmetic's `disc f = ind² · disc K` consumes.
- **`√disc` and the sign character.** For separable monic `f` over `F` with
  `ringChar F ≠ 2`: setting `δ = ∏_{i<j} (rᵢ − rⱼ)`, each `σ ∈ f.Gal` has
  `σ δ = sign (galActionHom σ) • δ`; hence the **discriminant test**:
  `IsSquare f.discr ⟺ (galActionHom …).range ≤ alternatingGroup`, and the quadratic
  subextension `F(δ)` is the fixed field of the even subgroup. ⚠ Char 2: the statement
  fails (see conventions); record the failure as a documented non-theorem with the
  Berlekamp-discriminant horizon note (Berlekamp 1976; the Artin–Schreier class of
  `∑_{i<j} rᵢrⱼ/(rᵢ+rⱼ)²` replaces `√disc`) — a definite later milestone for char-2
  completeness, consumed by nobody below.
- **Worked instances** (acceptance): degree 2 (the test is quadratic-formula folklore);
  degree 3 — irreducible separable cubic has group `A₃ = C₃` or `S₃` by squareness of the
  discriminant (`x³ − 3x − 1` vs `x³ − 2`, the Layer 6 table's degree-3 column); the
  `Cubic.discr` comparison keeps the two discriminant APIs honest.

### Layer 4: the resolvent method

The engine that converts subgroup constraints into factorization facts. Fix separable
monic `f` of degree `n` over `F`, a numbering `e : Fin n ≃ rootSet`, a subgroup
`H ≤ Equiv.Perm (Fin n)`, and an invariant `Φ : MvPolynomial (Fin n) F` with
`stabilizer (Perm (Fin n)) Φ = H` (under `MvPolynomial.rename`).

- **The orbit resolvent.** `galResolvent Φ f := ∏_{Ψ ∈ orbit of Φ} (X − C (Ψ(r)))`, the
  product over the (finite, size `[Sₙ : H]`) rename-orbit of `Φ`, evaluated at the roots.
  First theorems: it lies in `F[X]` (its coefficients are symmetric — the fundamental
  theorem of symmetric polynomials in its `MvPolynomial.IsSymmetric` form, consuming
  `Mathlib`'s symmetric-functions API), it is independent of the numbering up to nothing
  at all (it is literally invariant), and its degree is `[Sₙ : H]`.
- **The factorization theorem.** Assume the resolvent is separable ⚠. Then the Galois
  action on the orbit of `Φ` matches the action on cosets `Sₙ/H` transported by `e`, and:
  monic irreducible factors of `galResolvent Φ f` ↔ orbits of (the image of) `Gal f` on
  `Sₙ/H`, degrees = orbit sizes. Headline corollaries: `galResolvent` has a root in `F` ⟺
  the image is conjugate into `H`; more finely, the multiset of factor degrees equals the
  multiset of orbit sizes — the constraint the databases tabulate.
- ⚠ **Degeneracy and Tschirnhaus.** When the resolvent is inseparable (two coset
  invariants collide at the roots of this particular `f`) the theorem gives only the easy
  containment; the classical remedy is a Tschirnhaus transformation. Target, stated
  honestly for infinite `F`: for separable `f` there is a polynomial substitution
  `f ↦ f_T` (same splitting field, same Galois image up to the induced numbering) whose
  `Φ`-resolvent is separable. This is a genuine theorem (finitely many bad coincidences,
  infinite field), and it is what makes the method total; never state the factorization
  theorem without the separability hypothesis.
- **The quartic, worked in full.** For `f = X⁴ + pX² + qX + r` (every quartic reduces by
  translation; the depressed form is a convention, not a loss): the `D₄`-invariant
  `x₁x₃ + x₂x₄` has orbit `{x₁x₃+x₂x₄, x₁x₂+x₃x₄, x₁x₄+x₂x₃}` and
  `resolventCubic f = X³ − pX² − 4rX + (4pr − q²)`. Prove: `f.discr =
  (resolventCubic f).discr`; the **full degree-4 decision table** (`f` irreducible
  separable, char `F ∉ {2, 3}` where needed): resolvent irreducible + disc nonsquare ⟹
  `S₄`; resolvent irreducible + disc square ⟹ `A₄`; resolvent splits completely ⟹ `V₄`;
  resolvent has exactly one root in `F` ⟹ `D₄` or `C₄`, separated by whether `f` stays
  irreducible over `F(√disc)` (equivalently the classical `x² − …` auxiliary test). Each
  row is a theorem; together with Layer 6 they give `HasGaloisLabel` for every quartic.
- **The quintic sextic resolvent, as data with a proved criterion.** The degree-6
  resolvent of the `F₂₀ ≤ S₅` invariant (Cayley; explicit coefficient formulas as in
  Dummit's *Solving solvable quintics*): define `resolventSextic` for
  `X⁵ + pX³ + qX² + rX + s` by Dummit's closed formula (data — a large but finite
  definition), prove it *is* the `galResolvent` of the `F₂₀`-invariant (so Layer 4's
  general theorem applies), and conclude the **solvability criterion**: an irreducible
  separable quintic is solvable (image conjugate into `F₂₀`) ⟺ its sextic resolvent has a
  root in `F` (under the ⚠ separability proviso). This is the upper-bound engine for
  `5T1/5T2/5T3` labels.
- **Linear resolvents, noted.** Root-sum/root-difference resolvents (`x₁ + x₂`,
  `x₁ − x₂`, …) as instances of the same framework — the degree-≤ 7 practical toolkit
  (Soicher–McKay); no separate theory, one worked example (the degree-6 `x₁+x₂` resolvent
  of a quintic distinguishing nothing that the sextic does not, kept as a test that the
  framework composes).

### Layer 5: Frobenius specialization — the computational workhorse

- **The consumed statement** (NumberFieldArithmetic; shape pinned in conventions and
  `Suggested.lean`): for monic `f : ℤ[X]`, prime `p ∤ f.discr`: some `σ ∈ (f/ℚ).Gal` has
  `fullCycleType (galActionHom σ) = ` degrees of the monic irreducible factors of
  `f mod p`. Its supplier composes Mathlib's `IsArithFrobAt` +
  `KummerDedekind` + `galRestrict`; *we* own only the polynomial-side packaging:
  `f mod p` is separable (base-change of `discr` from Layer 3 + `discr ≠ 0` in `ZMod p`),
  the factor-degree multiset as computable data
  (`normalizedFactors`, `Multiset.map natDegree`, with decidability over `ZMod p`), and
  the sum-check `∑ degrees = n`.
- **The membership oracle.** Corollary, the form everything downstream uses: the multiset
  of factor degrees of `f mod p` lies in
  `{ fullCycleType g ∣ g ∈ image of Gal }`. Consequences via Layer 1's recognition kit,
  each a named theorem: `f mod p` irreducible ⟹ `Gal f` contains an `n`-cycle (⟹
  transitive ⟹ `f` irreducible over `ℚ` — also derive the classical mod-`p`
  irreducibility criterion this way); type `(1,…,1,2)` at prime degree + transitivity ⟹
  `S_p`; type `(1, …, 1, 3)` + primitivity ⟹ `⊇ Aₙ` (Jordan, Layer 1); the `n ≤ 5`
  order-recognition lemmas lifted to polynomials.
- **What Frobenius cannot do, stated.** Cycle types certify only *lower* bounds
  (exhibited elements); no finite set of factorization types certifies `Gal ≤ H` for
  proper `H` — upper bounds come from Layers 3–4 (discriminant, resolvents). Record the
  `D₅`-vs-`A₅` worked pair (below) as the canonical illustration, and the pointer:
  the *statistics* of cycle types (Chebotarev) belong to LFunctions; correctness of every
  certificate here is unconditional.
- ⚠ **Index divisors.** All statements at `p ∤ discr f` only (see conventions); the
  Dedekind `x³ + x² − 2x + 8, p = 2` example is cited from NumberFieldArithmetic as the
  reason the hypothesis is on `discr f`, not on ramification.

### Layer 6: transitive subgroups of `Sₙ` for `n ≤ 5`, classified, with the label dictionary

The reference subgroups, pinned by generators inside `Equiv.Perm (Fin n)` (cycle notation):

| label | reference `T(n,j)` | name | order | parity | primitive | solvable |
|---|---|---|---|---|---|---|
| `1T1` | `⊥` | trivial | 1 | + | yes | yes |
| `2T1` | `⟨(12)⟩` | `C₂` | 2 | − | yes | yes |
| `3T1` | `⟨(123)⟩` | `C₃` | 3 | + | yes | yes |
| `3T2` | `S₃` | `S₃` | 6 | − | yes | yes |
| `4T1` | `⟨(1234)⟩` | `C₄` | 4 | − | no | yes |
| `4T2` | `⟨(12)(34), (13)(24)⟩` | `V₄` | 4 | + | no | yes |
| `4T3` | `⟨(1234), (13)⟩` | `D₄` | 8 | − | no | yes |
| `4T4` | `A₄` | `A₄` | 12 | + | yes | yes |
| `4T5` | `S₄` | `S₄` | 24 | − | yes | yes |
| `5T1` | `⟨(12345)⟩` | `C₅` | 5 | + | yes | yes |
| `5T2` | `⟨(12345), (25)(34)⟩` | `D₅` | 10 | + | yes | yes |
| `5T3` | `⟨(12345), (2354)⟩` | `F₂₀` | 20 | − | yes | yes |
| `5T4` | `A₅` | `A₅` | 60 | + | yes | no |
| `5T5` | `S₅` | `S₅` | 120 | − | yes | no |

(Order/parity/primitivity/solvability verified against the LMFDB `gps_transitive` data and
PARI's `polgalois`; the `T`-numbering is Butler–McKay's, which GAP and the LMFDB share.)

- **The classification theorems.** For each `n ≤ 5`: every transitive subgroup of
  `Perm (Fin n)` is conjugate to exactly one `T(n,j)` — existence (conjugating any
  transitive subgroup onto a reference) and disjointness (no two references conjugate).
  Proof skeleton to follow (Dixon–Mortimer §2 flavor): prime degrees 2, 3, 5 via Cauchy's
  `p`-cycle + normalizer analysis of `⟨p-cycle⟩` (the subgroups between `C_p` and its
  normalizer `F_{p(p−1)}`, plus the `≥ A_p` cases via the recognition kit); degree 4 via
  order + block analysis (`|G| ∈ {4, 8, 12, 24}`; blocks for the order-4/8 cases).
- **Order recognizes, in low degree.** `n = 5`: transitive `G` has
  `Nat.card G ∈ {5, 10, 20, 60, 120}` and the order determines the label; `n = 4`: order
  determines it except order 4, where `IsCyclic` splits `4T1` from `4T2`; `n = 3`: order.
  These are the theorems that make the Layer 5+4 certificates terminate: lower bounds
  (cycle types) + upper bounds (resolvent/discriminant) meet in an order count.
- **The label predicates.** `TransitiveGroupLabel n j G` per the pinned convention;
  well-definedness (conjugacy invariance, invariance under renumbering), the partition
  theorem (every transitive `G` has exactly one label), computation of each label's
  invariants (the table above, as theorems), and `HasGaloisLabel f n j` for separable
  degree-`n` polynomials via the image of `galActionHom` under a numbering.
- **Solvable ⟺ label-solvable, degree 5:** an irreducible quintic is solvable iff its
  label is `5T1/5T2/5T3` — tying Layer 4's sextic-resolvent criterion to the table (and,
  for the radical direction, to the AbelRuffini interface as far as Mathlib's one
  direction goes).

### Layer 7: degrees 6 and 7 (proved, later)

Same deliverables as Layer 6 — reference subgroups, classification, label predicates,
invariant tables — one degree at a time; these are definite later layers, sequenced after
the Layer 6 machinery has been through review once.

- **Degree 7** (7 classes: `C₇, D₇, F₂₁, F₄₂, PSL(3,2), A₇, S₇`): prime degree, so all
  transitive groups contain a 7-cycle and all are primitive; the solvable ones lie in the
  normalizer `F₄₂` (Galois's theorem on solvable prime-degree groups — a Layer 6
  by-product worth stating in general for `S_p`), and the insolvable ones are pinned by
  Jordan's criteria plus the order count for `PSL(3,2)` (order 168; its 2-transitivity via
  the `Fano`-plane action is an honest sub-target — coordinate with any mathlib
  projective-action work before building).
- **Degree 6** (16 classes): the first composite non-prime-power degree; the imprimitive
  ones via Layer 1's wreath embeddings for block shapes `2·3` and `3·2`
  (`D ≀`-subgroups), the primitive ones (`PSL(2,5) ≅ A₅`, `PGL(2,5) ≅ S₅`, `A₆`, `S₆`) via
  the projective line over `𝔽₅` — with the outer automorphism of `S₆` surfacing in the
  sibling structure (a remark plus the two inequivalent degree-6 actions of `S₅`/`A₅` as
  worked data, not a theory of `Out(S₆)`).

### Layer 8: degrees 8–11 as data semantics, with certification interfaces

The honesty pattern for big finite classifications (family ground rule): *state* the
reference data, *prove* the checkable parts, *interface* the rest.

- **Reference data.** For `8 ≤ n ≤ 11`: the Butler–McKay tables (50, 34, 45, 8 classes;
  counts as in Butler–McKay 1983 / OEIS A002106, matching the LMFDB) as generator lists
  defining `T(n,j) ≤ Equiv.Perm (Fin n)`; per-label invariant *computations* (order,
  parity, primitivity, solvability, cycle-type statistics — each decidable for an
  explicit finite subgroup, so these are `decide`/`Decidable.decide`-discharged theorems,
  engineered to actually reduce); the LMFDB display invariants as computable predicates.
  What is **not** claimed at this layer: completeness (that the 50 classes of degree 8
  are *all* transitive subgroups of `S₈`) — that is stated as a definite later milestone
  per degree (the Hulpke §3 inflation method over Layer 1's wreath machinery is the
  intended route), so the label predicates never silently assume it: `TransitiveGroupLabel`
  membership is meaningful without completeness; only "every transitive group has a label"
  waits for it.
- **The certificate checker** (the PR #47 Layer-9 interface, quoted from that roadmap:
  "a *certificate checker* rather than a search — Dedekind/Frobenius cycle-type
  certificates … and the discriminant square test"). A `GaloisCertificate` for monic
  `f : ℤ[X]` bundles: a list of primes with claimed factorization types of `f mod p`
  (checked by kernel computation over `ZMod p`; admissible only when `p ∤ discr f`,
  checked); a discriminant-square claim (checked); resolvent data when present (an
  `Option` field: a resolvent polynomial, its claimed rational roots / factor degrees —
  checked when supplied). Soundness theorems:
  a checked certificate yields the claimed lower bounds (Layer 5), upper bounds
  (Layers 3–4), and — when they pin a unique label through the order-recognition
  theorems — `HasGaloisLabel f n j`. Design constraint: the checker is the API a
  downstream computational repo calls (`CBirkbeck/CertifyingInvariantsNF` is the existing
  implementation pattern — per-object `Results` files proving `K_discr' : discr K = …`
  etc.; our per-polynomial results files prove `HasGaloisLabel f n j`), and the label
  predicates are the declarations LMFDB knowls link via LeanBridge's `DEFINES` mechanism.
- **Sibling/subfield semantics.** The LMFDB's "siblings" (other transitive actions of the
  same abstract group) and "resolvents/subfields" columns as mathematics: actions on block
  systems (Layer 1) and on coset spaces of the reference subgroups; statement-level here,
  consumed by the NumberFieldArithmetic subfield-lattice layer.

### Layer 9: the inverse-Galois summits — `Sₙ` and `Aₙ` over `ℚ`

- **`Sₙ` for every `n`, by the three-primes construction** (van der Waerden §61; Serre,
  *Topics*, §4.4): choose `f ≡ f₁ mod 2` irreducible, `f ≡ f₂ mod 3` an irreducible-times-
  linear of degree `n − 1`, `f ≡ f₃ mod 5` a quadratic times distinct odd-degree
  irreducibles; CRT the coefficients. Layer 5 gives an `n`-cycle (transitive), an
  `(n−1)`-cycle (2-transitive, hence primitive), and a power reaching a transposition;
  Jordan's swap theorem closes: `Gal f ≅ Sₙ`. Fully within Layers 1 + 5; **theorem, not
  horizon**: for every `n ≥ 1` there is an explicit monic `f : ℤ[X]` of degree `n` with
  full Galois group. (The classical one-polynomial family `xⁿ − x − 1` — Selmer
  irreducibility, Osada's `Sₙ` theorem — is a named *later* alternative with its own
  literature; the roadmap's theorem is the CRT construction, which our machinery proves
  without new inputs.)
- **`Aₙ`:** realizations with square discriminant. Proved now: the `n ≤ 11` instances
  through the certificate layer (e.g. `x⁵ + 20x − 16` below; per-degree certified
  polynomials as data). General `n`: Serre, *Topics*, §4.5 constructs, for each `n`,
  polynomials with square discriminant and group `Aₙ` by a refined specialization
  argument; pinned as this layer's second theorem with the specialization step gated on
  Layer 10 where Serre's proof invokes it (the `Sₙ` part of his argument does not).
  State the `n ≤ 11` and general cases separately so the first never waits.
- **Consequence for the labels:** `nT(last)` and `nT(last−1)` are realized over `ℚ` for
  all `n` in scope — the LMFDB's "all groups of degree ≤ 11 occur as Galois groups over
  `ℚ`" fact is recorded per-label as certified data (Layer 8), with these two families as
  the only general-`n` theorems.

### Layer 10: Hilbert irreducibility (the horizon layer)

A definite later layer with definite content — the standard gate between "over `ℚ(t)`"
and "over `ℚ`":

- **Thin sets and HIT.** Thin subsets of `ℚⁿ` (Serre, *Topics*, §3.1); Hilbert's
  irreducibility theorem for `ℚ`: for `f(t, X)` irreducible over `ℚ(t)`, the
  specializations `t₀` with `f(t₀, X)` irreducible (indeed with equal Galois group) are
  the complement of a thin set; the count/route pinned to Serre's §3.2–3.4
  (counting integral points on curves via Puiseux expansions — elementary but long) with
  Fried–Jarden Ch. 12–13 as the cross-check citation.
- **Consequences.** Galois-group preservation under specialization off a thin set;
  regular realizations over `ℚ(t)` descend to `ℚ`; completion of Layer 9's general-`Aₙ`
  theorem; the statement-level bridge to Noether's problem and beyond is *cited*, not
  scoped.

## Worked examples (acceptance criteria, keeping the definitions honest)

Every polynomial below was re-verified for this roadmap with PARI (`polgalois`, `nfdisc`)
and against the LMFDB field pages; each pins a specific layer.

- **Degree 3** (Layer 3): `x³ − 3x − 1` — disc `81 = 9²`, group `C₃ = 3T1` (LMFDB
  `3.3.81.1`, the cyclic cubic field of conductor 9); `x³ − 2` — disc `−108`, group
  `S₃ = 3T2` (`3.1.108.1`). The discriminant test alone decides irreducible cubics.
- **Degree 4** (Layers 4, 6): `x⁴ + x + 1` — resolvent cubic `X³ − 4X − 1` irreducible,
  disc `229` nonsquare ⟹ `S₄ = 4T5` (`4.0.229.1`). `x⁴ + 8x + 12` — resolvent cubic
  `X³ − 48X − 64` irreducible, disc `331776 = 576²` square ⟹ `A₄ = 4T4` (field
  `4.0.5184.1`). `x⁴ − 2` — `D₄ = 4T3` (`4.2.2048.1`). `x⁴ + 1` — `V₄ = 4T2`
  (`4.0.256.1`, `ℚ(ζ₈)`; consume `galXPowEquivUnitsZMod`-adjacent cyclotomic API), with
  the Frobenius footnote: no 4-cycle in `V₄`, so `x⁴ + 1` is reducible mod *every* prime
  — the membership oracle run backwards, an acceptance test for Layer 5's contrapositive.
  `x⁴ + x³ + x² + x + 1` — `C₄ = 4T1` (`4.0.125.1`, `ℚ(ζ₅)`, via
  `galCyclotomicEquivUnitsZMod`: `Gal ≃* (ZMod 5)ˣ`). Together: all five quartic labels,
  and the full decision table exercised.
- **Degree 5, the full ladder** (Layers 4–6):
  - `x⁵ + x⁴ − 4x³ − 3x² + 3x + 1` (`ℚ(ζ₁₁)⁺`) — `C₅ = 5T1` (`5.5.14641.1`, disc `11⁴`).
  - `x⁵ − 5x − 12` — `D₅ = 5T2` (`5.1.1000000.1`; polynomial disc `8000²`). **The
    canonical upper-bound demonstration:** cycle types can prove at most
    "`⊇ D₅`" (a 5-cycle and a `(1,2,2)`-element occur; every unramified factorization
    type of this `f` is a cycle type of `D₅ ⊂ A₅`, so no prime ever rules `A₅` out);
    the certificate needs the disc-square test (kills `S₅, F₂₀`) *and* the sextic
    resolvent's rational root (kills `A₅`), then the order count reads `5T2` off the
    Layer 6 table.
  - `x⁵ − 2` — `F₂₀ = 5T3` (`5.1.50000.1`): the Kummer example; solvable, sextic
    resolvent criterion positive, disc `50000` nonsquare.
  - `x⁵ + 20x − 16` — `A₅ = 5T4` (`5.1.1000000.2`): disc `32000²` square; a
    `(1,1,3)`-type prime plus primitivity (prime degree) gives `⊇ A₅` by Jordan's
    3-cycle theorem; disc square caps it at `A₅`. (Same field discriminant `10⁶` as the
    `D₅` example — a deliberate pair showing the label is not a function of
    `(n, r₁, |disc|)`.)
  - `x⁵ − x − 1` — `S₅ = 5T5` (`5.1.2869.1`, disc `2869 = 19·151`): factorization
    `(x² + x + 1)(x³ + x² + 1)` mod 2 exhibits a `(2,3)`-element of order 6; mod 5 it is
    the Artin–Schreier polynomial `x⁵ − x − 1`, irreducible, exhibiting a 5-cycle (and
    proving irreducibility over `ℚ`); transitive + order-6 element ⟹ `S₅` by the
    recognition kit. Two primes, no discriminant needed — the minimal-certificate
    showcase.
- **The cross-roadmap instance** (Layers 5, 8; PR #47's weight-60 example): a quintic
  that is irreducible mod 83 and factors with type `(1,1,1,2)` mod 17 has group `S₅`
  (transitive + transposition + prime degree; consume
  `Equiv.Perm.subgroup_eq_top_of_swap_mem`). Our certificate checker must accept exactly
  this two-line certificate; that is the acceptance test for the #47 Layer-9 interface.
- **Non-examples (honesty tests):** `x⁴` and `(x² − 2)²` — not separable, no permutation
  claims; `(x² − 2)(x² − 3)` — separable, reducible: `Gal ≅ V₄` acting with two orbits of
  size 2 (orbits ↔ factors, Layer 0), and `TransitiveGroupLabel` correctly refuses it;
  `x⁵ + x + 1 = (x² + x + 1)(x³ − x² + 1)` — the reducible cousin of `x⁵ − x − 1`, a
  regression test that no `5Tj` label is assigned to a reducible quintic.

## Ordering and parallelism

Layer 1 (pure group theory) and Layers 0/2 (polynomial dictionary) can start immediately
and in parallel; Layer 3 needs only Layer 0 and the resultant API (coordinate the
root-product formula upstream early — it is Mathlib's own TODO); Layer 4 needs Layers 0–3
plus the symmetric-functions API; Layer 5's polynomial-side lemmas need Layer 3
(base-change of `discr`) and its main theorem consumes NumberFieldArithmetic — pin the
interface first (`Suggested.lean` does) so everything downstream of it elaborates now;
Layer 6 needs Layers 1–2 (and feeds the recognition kit back into Layer 1's tail);
Layer 7 needs 1 + 6; Layer 8 needs 5 + 6 (its per-label computations are independent of
completeness and can land degree by degree); Layer 9's `Sₙ` theorem needs 1 + 5 only —
it can land before Layers 6–8 — and its general `Aₙ` gate is Layer 10. Deliver early, in
this order: the Layer 5 interface statement, the Layer 6 degree-≤ 5 tables, and the
certificate checker's shape — those three are what PR #47's Layer 9, ArtinRepresentations,
and NumberFieldArithmetic's display layer are waiting on.

## References

- J. D. Dixon, B. Mortimer, *Permutation Groups*, GTM 163, Springer, 1996 — **the source
  of record for Layers 1 and 6–7** (blocks and imprimitivity §1.5, wreath products §2.6,
  Jordan's theorems §7.4, the low-degree tables Appendix B). *Not yet in `references/`;
  the primary acquisition for this roadmap.*
- H. Wielandt, *Finite Permutation Groups*, Academic Press, 1964 — the toolkit's
  original (Mathlib's `Blocks`/`Jordan` files cite it; Theorems 7.5, 13.3, 13.9). *To
  acquire.*
- A. Hulpke, *Constructing transitive permutation groups*, J. Symbolic Comput. 39 (2005)
  1–30 — the classification method (inflation/base groups §3) and the degree-landscape
  history. *To acquire.*
- G. Butler, J. McKay, *The transitive groups of degree up to eleven*, Comm. Algebra 11
  (1983) 863–911 — the Layer 8 reference tables and the `T`-numbering. *To acquire.*
- J. H. Conway, A. Hulpke, J. McKay, *On transitive permutation groups*, LMS J. Comput.
  Math. 1 (1998) 1–8 — names and properties for degree ≤ 15 (the LMFDB name column).
- H. Cohen, *A Course in Computational Algebraic Number Theory*, GTM 138, Springer, 1993
  — resolvent algorithms and the degree-≤ 7 decision trees (§6.3). *To acquire.*
- J.-P. Serre, *Topics in Galois Theory*, 2nd ed., A K Peters, 2008 — Layers 9–10
  (§§3–4: thin sets, HIT, the `Sₙ`/`Aₙ` constructions). *To acquire.*
- L. Soicher, J. McKay, *Computing Galois groups over the rationals*, J. Number Theory 20
  (1985) 273–281 — linear resolvents (Layer 4's practical tail).
- D. S. Dummit, *Solving solvable quintics*, Math. Comp. 57 (1991) 387–401 — the sextic
  resolvent's explicit coefficients (Layer 4).
- R. P. Stauduhar, *The determination of Galois groups*, Math. Comp. 27 (1973) 981–996 —
  the numerical-approximation alternative (context for why our resolvents are exact).
- K. Geissler, J. Klüners, *Galois group computation for rational polynomials*,
  J. Symbolic Comput. 30 (2000) 653–674 — degree ≤ 15 practice; certification context.
- B. L. van der Waerden, *Algebra* I, §61 — the three-primes `Sₙ` construction (Layer 9).
- E. R. Berlekamp, *An analog of the discriminant over fields of characteristic two*,
  J. Algebra 38 (1976) 315–317 — the char-2 horizon note (Layer 3).
- H. Osada, *The Galois groups of the polynomials `xⁿ + axˡ + b`*, J. Number Theory 25
  (1987) 230–238 — the `xⁿ − x − 1` alternative (Layer 9 remark).
- LMFDB, *Galois group labels* (`gg.label` and related knowls),
  <https://www.lmfdb.org/GaloisGroup/> — the label semantics being formalized; data
  cross-checks for the tables above (spot-verified 2026-07-30).

## Provenance, coordination, and licensing

- **A. Chambert-Loir's mathlib program** is the substrate of Layer 1 and must not be
  forked around: at the pin his suite comprises `GroupAction/{Blocks, Primitive,
  Transitive, MultipleTransitivity, MultiplePrimitivity, Jordan, Iwasawa}.lean`, the
  `SubMulAction/{OfStabilizer, OfFixingSubgroup, Combination}.lean` machinery, the
  alternating-group simplicity and `MaximalSubgroups` files (all merged before
  2026-06-03; e.g. PRs #33082/#36524 — `Aₙ` simple, #34307 — `powersetCard`
  primitivity, #33715 — projectivization 2-transitivity). Still open on 2026-07-30 and
  relevant: #33916 (PSL₂ simplicity), the Dieudonné/transvection series
  (#33692, #33560, #33485, #33402), none overlapping this roadmap. Two of our targets
  are *his files' own TODOs* — the Jordan prime-cycle theorem (`Jordan.lean`) and the
  imprimitive O'Nan–Scott case (`Perm/MaximalSubgroups.lean`) — and the general wreath
  product borders `RegularWreathProduct.lean`: for these three, propose upstream on
  Zulip first (mathlib-first is the right home; consume from Tau Ceti either way), and
  follow his vocabulary (`IsPreprimitive`, `IsBlock`) everywhere regardless. No Zulip
  thread currently claims any of them (checked 2026-07-30; the area's discussion trail
  is his PR review threads).
- **C. Birkbeck's certification line** is the consumer contract of Layer 8:
  `CBirkbeck/CertifyingInvariantsNF` (extends `alainchmt/RingOfIntegersProject`;
  certifies ring of integers, discriminant, signature, class groups and units through
  per-field `Results…` files such as `K_discr' : NumberField.discr K = 3790297`; active,
  last commit 2026-06-30) has **no Galois-group component yet** — our
  `HasGaloisLabel`-certificates are its missing column, and the upstream ModularForms
  roadmap (TauCetiRoadmap PR #47, Layer 9) explicitly requests them as "Dedekind/Frobenius
  cycle-type certificates … and the discriminant square test", to be "bridged into
  LeanBridge". `CBirkbeck/LeanBridge` links LMFDB knowls to Lean declarations (`DEFINES`
  macro): the Layer 6/8 label predicates are the declarations the `gg.*` knowls should
  point at. Coordinate the checker's input format with him before freezing Layer 8.
- **Tau Ceti, already landed:** `TauCeti/NumberTheory/Multiquadratic/Galois/*` and
  `Multiquadratic/Frobenius.lean` (the merged Multiquadratic roadmap) prove the
  elementary-abelian instance of exactly our Layers 0 + 5 pattern — `signPattern` as the
  explicit `Gal ↪ (ι → ZMod 2)`, `exists_isArithFrobAt_multiquadratic`,
  `signPattern_frobenius`, `galoisGroupEquiv_frobenius` — consuming Mathlib's
  `IsArithFrobAt` just as Layer 5 will. Cite it as the worked `(ℤ/2)ⁿ` case; generalize,
  don't duplicate its bespoke lemmas.
- **Siblings:** [NumberFieldArithmetic](../NumberFieldArithmetic/README.md) (in
  preparation) supplies Layer 5's Dedekind theorem (interface pinned here and in
  `Suggested.lean`) and consumes Layer 0's dictionary, Layer 3's discriminant bridge, and
  the labels; ArtinRepresentations (planned) consumes the labels and the
  certificate layer; the [representation-theory family](../RepresentationTheory/README.md)
  owns abstract-group data (character tables); LFunctions (sibling, in preparation) owns
  Chebotarev — the one theorem people expect here that is deliberately elsewhere.
- **Licensing / migration:** nothing is ported from GPL sources; the Butler–McKay/LMFDB
  generator tables are mathematical data (regenerated and re-verified for Layer 8, cited
  to their publications and to the LMFDB), and PARI/GAP outputs were used only as
  cross-checks, never as code. Register intentions per the repository's claims process
  before substantial pushes.
