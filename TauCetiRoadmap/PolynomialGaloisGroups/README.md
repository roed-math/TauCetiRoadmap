# Roadmap: Galois groups of polynomials

Mathlib has the Galois group of a polynomial (`Polynomial.Gal`, the automorphism group of
its splitting field) with a faithful action on the roots that is transitive when the
polynomial is irreducible, one direction of Abel–Ruffini, and, thanks to A. Chambert-Loir's
program, a substantial permutation-action library: blocks, preprimitivity with the
stabilizer-maximality characterization, multiple transitivity and multiple primitivity, two
of Jordan's primitivity criteria, the Iwasawa criterion, simplicity of `Aₙ`, and the
intransitive case of O'Nan–Scott.

What is absent is everything the LMFDB's Galois-groups section (transitive-group labels
`nTj`) is built on. The polynomial discriminant is defined, but not its product-of-root-
differences formula, so there is no test for containment in `Aₙ`. There is no resolvent in
the Galois-theoretic sense. Frobenius elements exist, but not Dedekind's theorem identifying
the factorization type of `f mod p` with a cycle type. There is no classification of
transitive groups in any degree, no `nTj` label semantics, and no general wreath product or
imprimitivity structure theory. This roadmap builds those, in two halves that can proceed
independently: the permutation-group material as reusable group theory, and the Galois
material stated against `Polynomial.Gal`.

## Scope

The scope is bounded, and the boundary is part of the specification.

- **Complete classification of transitive subgroups of `Sₙ`: degrees `n ≤ 5` only.** For
  these degrees the roadmap proves that every transitive subgroup is conjugate to exactly one
  named reference subgroup, so every polynomial of degree at most 5 acquires a label.
- **Reference-data semantics and certificates: degrees `6 ≤ n ≤ 11`, uniformly.** For these
  degrees the roadmap supplies named reference subgroups, proves their invariants, defines the
  label predicates, and proves certificate soundness. It does **not** assert that every
  transitive subgroup of `Sₙ` is conjugate to a listed reference, so in these degrees a
  certificate concludes a label only by proving conjugacy to the named reference, never by
  elimination against a classification.
- **One general inverse-Galois theorem:** `Sₙ` is a Galois group over `ℚ` for every `n`, by
  the three-prime construction, whose prerequisites are all named in Layer 9.

Outside this roadmap, and not milestones of it:

- Hilbert irreducibility, thin sets, and specialization from `ℚ(t)` to `ℚ`. A separate
  roadmap could take these on; none exists yet, and nothing here depends on one.
- The realization of `Aₙ` over `ℚ` for general `n`, which in Serre's treatment rests on
  Hilbert irreducibility. Concrete `Aₙ` realizations in the certified degree range stay in,
  as certificates for explicit polynomials.
- Exhaustiveness of the transitive-group classification in degrees 6 to 11.
- Chebotarev density, which belongs to the LFunctions roadmap. Nothing here uses it; see the
  discussion of certificate soundness below.
- Abstract-group data (character tables, abstract group names). We own only the *permutation*
  data of `nTj`. Artin representations are a planned separate roadmap.
- The characteristic-2 replacement for the discriminant test (Berlekamp's invariant).

## Suggested home

`TauCeti/GroupTheory/Permutation/` for the group-theoretic layers (the block–stabilizer
dictionary, wreath products and imprimitivity, Jordan-type recognition theorems, the
transitive-subgroup classification and the label predicates: Layer 1, and the group half of
Layers 6 to 8). `TauCeti/FieldTheory/GaloisGroups/` for the Galois-theoretic layers (the
polynomial dictionary, discriminants, resolvents, Frobenius specialization, labels of
polynomials, certificates, and the `Sₙ` realization: Layers 0, 2 to 5, the field half of
Layers 6 to 8, and Layer 9).

The split follows Mathlib's own placement, with its permutation toolkit in
`Mathlib/GroupTheory/GroupAction/` and its Galois groups in `Mathlib/FieldTheory/`, and it
keeps the permutation material usable by customers who want no field theory: the
[representation-theory family](../RepresentationTheory/README.md)'s symmetric-group roadmaps,
and any future O'Nan–Scott work.

## Place in the family

This roadmap is part of the LMFDB-background family (2026-07-30) and serves the LMFDB section
`galois_groups` directly.

**It consumes the
[Number Field Arithmetic roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/9),
Layer 3.** Layer 5 rests on that roadmap's polynomial-side Dedekind theorem: for monic
`f : ℤ[X]` and a prime not dividing `disc f`, the factorization type of `f mod p` is the cycle
type of an arithmetic Frobenius element acting on the roots. That is a real dependency, not a
formality, and it is the only thing taken from there; that roadmap's `Suggested.lean` carries
it in the same shape, marked as the interface this one consumes. The shape is pinned again
below and in `Suggested.lean` here, so that the layers above it are precise, and the theorem
is cited by its declaration name. Frobenius *construction* (decomposition groups,
`IsArithFrobAt`, ramification) is Number Field Arithmetic's throughout; we own only the
polynomial-side packaging.

**It supplies [Modular Forms](../ModularForms/README.md), Layer 9,** which asks for exactly
the interface built here: a Galois-group certificate checker rather than a search, using
Dedekind/Frobenius cycle-type certificates and the discriminant square test, enough to decide
the small-degree patterns it needs. Its weight-60 example needs one quintic certified as `S₅`;
Layer 8 proves the general theorem that certificate rests on.
The planned Artin Representations roadmap and Number Field Arithmetic's display layer consume
the label predicates.

## Standing hypotheses and pinned conventions

- **Which Galois group.** "The Galois group of `p`" is Mathlib's `Polynomial.Gal p`: the
  automorphism group of `p.SplittingField` over the base field `F`, acting on `p.rootSet E`
  for a splitting extension `E` through `Polynomial.Gal.galAction`, with
  `galActionHom : p.Gal →* Equiv.Perm (p.rootSet E)` injective. Every statement is made
  against this definition; no rival is introduced. The LMFDB attaches a Galois group to a
  *number field* `K = ℚ(α)`, and that is `(minpoly ℚ α).Gal` in its degree-`n` action on the
  roots of the minimal polynomial. The dictionary between the two is a Layer 0 target, not a
  convention that may be blurred. Reducible and irreducible polynomials both matter, since
  resolvents are usually reducible: no layer assumes irreducibility where separability
  suffices, and every statement says which of the two it needs.
- **Separability, spelled out.** The degree-`n` permutation picture needs `n` distinct roots,
  so the standing hypothesis is `p.Separable` together with `p ≠ 0`, and monicity where it
  simplifies. Under it `p.rootSet p.SplittingField` has `natDegree p` elements. Over `ℚ`, and
  over any perfect field, irreducible implies separable, so the `ℚ`-facing corollaries drop
  the hypothesis while the characteristic-`p` statements carry it. Inseparable polynomials
  have too few roots and a correspondingly small permutation image; nothing below is claimed
  for them, and the worked examples include an inseparable non-example.
- **Roots are intrinsic; numberings are temporary.** The action lives on `p.rootSet E`, a
  subtype with no preferred ordering. Statements are made intrinsically wherever possible. A
  numbering `e : Fin n ≃ p.rootSet E` enters only where a comparison with a reference subgroup
  of `Equiv.Perm (Fin n)` requires one, always through an explicit equivalence, and only
  inside a statement that is up to conjugacy. The `nTj` label is a predicate on conjugacy
  classes, so label statements are independent of the numbering by construction. No global
  root order is ever fixed, and no theorem is stated whose truth depends on one.
- **The `nTj` labels, and their data model.** For `n ≤ 47` the LMFDB numbers the conjugacy
  classes of transitive subgroups of `Sₙ` as `nT1, nT2, …`, following the transitive-group
  databases (Butler–McKay for `n ≤ 11`, then Cannon–Holt, Holt–Royle, and Holt–Royle–Tracey).
  The `T`-numbering is a database convention fixed by published tables rather than intrinsic
  mathematics, so it is pinned by explicit reference subgroups. The data model is:

  - `numTransitiveGroups : ℕ → ℕ`, the number of classes in each degree, defined by the frozen
    table below and `0` outside its range;
  - `TransitiveGroupIndex n := Fin (numTransitiveGroups n)`, so a label index is valid by
    construction and no unconstrained natural number is ever used as one; the index `j`
    displays as the LMFDB label `nT(j+1)`;
  - `referenceSubgroup n j ≤ Equiv.Perm (Fin n)`, given by generators from the frozen export;
  - `TransitiveGroupLabel j G`, meaning that some element of `Equiv.Perm (Fin n)` conjugates
    `G` onto `referenceSubgroup n j`.

  Transitivity of each reference subgroup is proved once, so the label predicate carries no
  separate transitivity clause: a conjugate of a transitive group is transitive. For
  polynomials, `HasGaloisLabel f j` names separability, the degree, and a relabeling
  `e : Fin n ≃ f.rootSet E`, and a companion theorem says the predicate does not depend on
  which relabeling is chosen.

  The invariants the LMFDB displays are pinned to Mathlib vocabulary: order is `Nat.card G`;
  **parity** is `+1` exactly when `G ≤ alternatingGroup (Fin n)`, equivalently when the
  composite `G → Equiv.Perm (Fin n) → ℤˣ` given by `Equiv.Perm.sign` is trivial; **primitive**
  is `MulAction.IsPreprimitive G (Fin n)` for the natural action; solvable is `IsSolvable G`;
  cycle-type data goes through `Equiv.Perm.cycleType`.
- **The generator data is frozen.** An implementation agent must not be asked to recover
  Butler–McKay numbering from prose. The reference generators come from one
  reproducible export, and the Lean data file carrying them records, in its header:

  - the retrieval date and the source, namely the LMFDB `gps_transitive` table (columns `n`,
    `t`, `gens`) as served by the Galois-group search at <https://www.lmfdb.org/GaloisGroup/>;
  - a SHA-256 checksum of the raw export, so a later reader can tell whether the table moved;
  - the convention that the source writes cycles on `1, …, n` while `Fin n` is `0`-based, with
    the conversion applied stated explicitly;
  - the convention that index `j : TransitiveGroupIndex n` displays as `nT(j+1)`;
  - the result of a cross-check of each entry against the `TransitiveGroup(n, j)` identifiers
    of GAP and Magma. The cross-check is run to confirm the numbering agrees; no code or data
    is imported from either system.

  The degree-`≤ 5` entries are reproduced in Layer 6's table below, small enough to read and
  to verify by hand, and they were checked against the LMFDB and PARI's `polgalois`.
- **Cycle types count fixed points.** Mathlib's `Equiv.Perm.cycleType` lists only cycle
  lengths `≥ 2`, whereas the factorization type of `f mod p` is a partition of `n` including
  its `1`-parts. The correction is pinned once, as
  `fullCycleType σ = σ.cycleType + (n − σ.support.card)` copies of `1` (prototype in
  `Suggested.lean`), and every Dedekind or Frobenius comparison below is stated with
  `fullCycleType`. A factor-degree multiset is never compared with a bare `cycleType`; the
  off-by-fixed-points error is the standard trap here.
- **Discriminant.** The polynomial discriminant is Mathlib's `Polynomial.discr`
  (`Mathlib/RingTheory/Polynomial/Resultant/Basic.lean`), the Sylvester-matrix resultant of
  `f` and `f'`, sign-normalized so that a real polynomial with all roots real has
  `discr ≥ 0`. We adopt it as *the* discriminant and build the missing theory around it,
  starting with the root-product formula, which that file's own TODO list also heads toward;
  see the coordination section. The discriminant test `disc ∈ (Fˣ)² ↔ Gal ≤ Aₙ` is **false in
  characteristic 2**: with `−1 = 1` the product `∏_{i<j} (rᵢ − rⱼ)` is itself symmetric, so its
  square root is always rational and the test detects nothing. Every statement of the test
  carries `ringChar F ≠ 2`.
- **Resolvent, the name.** In Mathlib `resolvent` means the resolvent of spectral theory
  (`Mathlib/Algebra/Algebra/Spectrum/Basic.lean`), so the name is taken. Our objects are
  `galResolvent` (general orbit resolvents), `resolventCubic` (of a quartic), and
  `resolventSextic` (of a quintic), in the `TauCeti/FieldTheory/GaloisGroups/` namespace.
- **Frobenius specialization, consumed.** The statement supplied by Number Field Arithmetic,
  Layer 3, is: for monic `f : ℤ[X]` and a prime `p` **not dividing `f.discr`**, there is
  `σ : (f over ℚ).Gal` whose `fullCycleType` under the root action equals the multiset of
  degrees of the monic irreducible factors of `f mod p`. The hypothesis is `p ∤ discr f`, not
  "`p` is unramified in the root field". Common index divisors (Dedekind's `x³ + x² − 2x + 8`
  at `p = 2`, a worked example of that roadmap) make the factorization of `f mod p`
  misdescribe the splitting of `p`; but `p ∤ discr f` also bounds the index, since
  `discr f = index² · disc K`, which is why it is the right polynomial-side hypothesis.
  Statements are over `ℤ` with `discr ≠ 0` only, and nothing is claimed at primes dividing
  the discriminant.
- **Solvable, in which sense.** Two different properties are in play and are never written
  with the same word. `IsSolvable f.Gal` is solvability of the Galois group;
  `Polynomial.solvableByRad` is solvability by radicals. Mathlib proves that solvable by
  radicals implies solvable Galois group, and the converse is absent there and is not a target
  here. Everything this roadmap proves about quintics, including the sextic-resolvent
  criterion and the `5T1`/`5T2`/`5T3` table, is about `IsSolvable f.Gal`. No statement below
  asserts an equivalence involving `solvableByRad`.
- **What certificate soundness claims.** Galois-group computation appears here as certificate
  checking, and three separate claims must not be run together:

  1. **Soundness.** If `check cert = true` then the label follows. This is what the roadmap
     proves, and it is unconditional: no density theorem enters.
  2. **Existence.** Every polynomial in scope admits a certificate. This is *not* claimed in
     general. A search for suitable primes may need Chebotarev to be guaranteed to succeed,
     and a deterministic resolvent chain would need a different argument.
  3. **Termination and efficiency of a search.** Not addressed at all.

  Only the first is grounded here, and every statement below that mentions a certificate says
  which of the three it is about. Chebotarev belongs to the LFunctions roadmap.

  Within soundness, lower and upper bounds on the group come from different evidence, and the
  asymmetry is deliberate. Factorization types exhibit elements, so they give lower bounds
  only; no finite set of factorization types can prove `Gal ≤ H` for a proper subgroup `H`.
  Upper bounds come from the discriminant and from resolvents, and a resolvent gives one only
  when specialization is known not to have collided: the checked resolvent must have its full
  orbit degree and be separable, or the certificate must supply a Tschirnhaus transform that is
  checked to have those properties. A rational root or a list of factor degrees without that
  evidence proves no upper bound.
- **Naming.** `fullCycleType`, `numTransitiveGroups`, `TransitiveGroupIndex`,
  `referenceSubgroup`, `TransitiveGroupLabel`, `HasGaloisLabel`, `galResolvent`,
  `ResolventSpec`, `resolventCubic`, `resolventSextic`, `GaloisCertificate` with its `check`
  and `check_sound`. `Suggested.lean` pins the forms.

## What Mathlib already has (consume)

At the build pin (`9caeba1000`, 2026-06-03); everything listed was re-verified there, and the
status remarks about open work were rechecked on 2026-08-06.

- **Galois groups of polynomials:** `Mathlib/FieldTheory/PolynomialGaloisGroup.lean` has
  `Polynomial.Gal`, `galAction`, `galActionHom` with `galActionHom_injective` (faithfulness),
  `galAction_isPretransitive` (transitivity for irreducible `p`), `restrict`, `restrictDvd`
  and `restrictProd` (with `restrictProd_injective`, giving `Gal (p*q) ↪ Gal p × Gal q`),
  `restrictComp_surjective`, `card_of_separable` (`#Gal = [SplittingField : F]`),
  `prime_degree_dvd_card` (characteristic 0, the Cauchy input), and the `Unique` instances for
  split and degenerate polynomials. In `Mathlib/Analysis/Complex/Polynomial/Basic.lean`,
  `Polynomial.Gal.galActionHom_bijective_of_prime_degree`(`'`): over `ℚ`, an irreducible
  polynomial of prime degree with exactly two non-real roots has full Galois group, complex
  conjugation supplying the transposition.
- **Solvability:** `Mathlib/FieldTheory/AbelRuffini.lean` has `solvableByRad` and
  `isSolvable_gal_of_irreducible` (solvable by radicals implies solvable Galois group, the
  direction the library proves), plus the `gal_*_isSolvable` lemmas;
  `Archive/Wiedijk100Theorems/AbelRuffini.lean` shows `x⁵ − 4x + 2` is not solvable by
  radicals, via `gal_Phi` (its Galois group is all of `S₅`). The converse direction (solvable
  group gives a radical tower, in characteristic 0) is absent upstream and is not a target
  here; our solvability statements are about the group invariant `IsSolvable`.
- **The permutation-action library (Chambert-Loir):**
  `Mathlib/GroupTheory/GroupAction/Blocks.lean` (`MulAction.IsBlock`, trivial and orbit
  blocks, `IsBlock.ncard_block_mul_ncard_orbit_eq`, the `BlockMem` bounded order, after
  Wielandt), `Primitive.lean` (`MulAction.IsPreprimitive`, `IsQuasiPreprimitive`,
  `isCoatom_stabilizer_iff_preprimitive`, `IsPreprimitive.of_prime_card`, Rudio's theorem),
  `MultipleTransitivity.lean` (`MulAction.IsMultiplyPretransitive` via `Fin n ↪ α`;
  2-transitive implies preprimitive; `Equiv.Perm` is `n`-pretransitive and preprimitive;
  `alternatingGroup` is `(n−2)`-pretransitive; `eq_top_of_isMultiplyPretransitive`;
  `IsMultiplyPretransitive.alternatingGroup_le`), `MultiplePrimitivity.lean`
  (`IsMultiplyPreprimitive`), and `Jordan.lean` with Jordan's theorems
  `Equiv.Perm.subgroup_eq_top_of_isPreprimitive_of_isSwap_mem` (primitive plus a
  transposition gives `Sₙ`),
  `Equiv.Perm.alternatingGroup_le_of_isPreprimitive_of_isThreeCycle_mem` (primitive plus a
  3-cycle gives `⊇ Aₙ`), and `MulAction.IsPreprimitive.isMultiplyPreprimitive`. The
  prime-cycle version (Wielandt 13.9) is that file's own
  `proof_wanted alternatingGroup_le_of_isPreprimitive_of_isCycle_mem`, still present on
  master on 2026-08-06; see coordination. Also `Iwasawa.lean` (the Iwasawa simplicity
  criterion), `Transitive.lean` (pretransitivity along equivariant maps), and the
  `SubMulAction/{OfStabilizer,OfFixingSubgroup,Combination}.lean` machinery, the last of
  which gives the action on `powersetCard α n`.
- **Permutations and specific groups:** `Mathlib/GroupTheory/Perm/Cycle/Type.lean`
  (`Equiv.Perm.cycleType` with its sum, order, sign and conjugacy lemmas, including
  `sign_of_cycleType`, `cycleType_conj` and `isConj_iff_cycleType_eq`, and
  `Equiv.Perm.subgroup_eq_top_of_swap_mem`: a transitive subgroup of `Perm α` of prime
  cardinality degree containing a transposition is everything, which is what the prime-degree
  `Sₙ` certificates run on), `Perm/Cycle/PossibleTypes.lean`
  (`Equiv.Perm.exists_with_cycleType_iff`), `Perm/ClosureSwap.lean`,
  `SpecificGroups/Alternating/` (`alternatingGroup.isSimpleGroup` for `5 ≤ Nat.card α` in
  `Simple.lean`, and Klein-four material in `KleinFour.lean`), `SpecificGroups/Cyclic`,
  `Dihedral.lean` (`DihedralGroup`, abstract only, with no pinned embedding into `Perm`),
  `Quaternion.lean`, and `Mathlib/GroupTheory/Sylow.lean` (finite Sylow theory, with Cauchy
  as `exists_prime_orderOf_dvd_card`).
- **Wreath products, regular case only:** `Mathlib/GroupTheory/RegularWreathProduct.lean` has
  `D ≀ᵣ Q = (Q → D) ⋊ Q`, with base indexed by `Q` itself, `toPerm` into
  `Equiv.Perm (Λ × Q)`, `IteratedWreathProduct`, and `Sylow.mulEquivIteratedWreathProduct`
  (Sylow `p`-subgroups of `S_{pⁿ}`). The **general** permutation wreath product, with base
  indexed by a `Q`-set, which is where an imprimitive action lands, is absent; Layer 1 builds
  it, in coordination (below).
- **O'Nan–Scott, first case:** `Mathlib/GroupTheory/Perm/MaximalSubgroups.lean` and
  `SpecificGroups/Alternating/MaximalSubgroups.lean` have `isCoatom_stabilizer` (setwise
  stabilizers of subsets are maximal), the *intransitive* case after Liebeck–Praeger–Saxl,
  with the *imprimitive* case named there as the next TODO, still open on master on
  2026-08-06. Our wreath-product layer has to coordinate with that file.
- **Discriminants and resultants:** `Mathlib/RingTheory/Polynomial/Resultant/Basic.lean` has
  `Polynomial.resultant` (Sylvester determinant, with `optParam` degree arguments) and
  `Polynomial.discr` (with `discr_C` and `discr_of_degree_eq_one/two/three`); the root-product
  formula is absent, and the resultant version it follows from,
  `resultant (∏ a ∈ s, (X − C a)) f = ∏ a ∈ s, f.eval a`, is that file's own stated goal in its
  TODO list (rechecked on master, 2026-08-06). `Mathlib/Algebra/CubicDiscriminant.lean` has
  `Cubic.discr` with `Cubic.discr_eq_prod_three_roots` and the distinct-roots criterion.
  `Mathlib/RingTheory/Discriminant.lean` has `Algebra.discr`, the trace-form discriminant of a
  basis, with `discr_powerBasis_eq_prod''` (the `∏ (σᵢ x − σⱼ x)²` form) and
  `discr_powerBasis_eq_norm`, which is the number-field side that Layer 3 connects to.
  `Mathlib/Algebra/QuadraticDiscriminant.lean`.
- **The arithmetic interface, for Layer 5's supplier:**
  `Mathlib/NumberTheory/KummerDedekind.lean` (the conductor-coprime factorization bijection
  `normalizedFactorsMapEquivNormalizedFactorsMinPolyMk`, comparing the shape and
  multiplicities of `p·𝒪` with those of `f mod p`), `Mathlib/RingTheory/Frobenius.lean`
  (`IsArithFrobAt` in both `AlgHom` and group-element forms, with existence
  `IsArithFrobAt.exists_of_isInvariant`, uniqueness modulo inertia, and conjugacy),
  `Mathlib/RingTheory/Invariant/Basic.lean` (`Algebra.IsInvariant`, transitivity on the primes
  above `p`, `Ideal.Quotient.stabilizerHom_surjective`),
  `Mathlib/FieldTheory/Galois/IsGaloisGroup.lean` (the `IsGaloisGroup G A B` predicate),
  `Mathlib/NumberTheory/RamificationInertia/` (`e` and `f`, `sum_ramification_inertia`, the
  Galois case, and `HilbertTheory.lean` for decomposition and inertia fields),
  `Mathlib/FieldTheory/Finite/` (finite fields, and `IsCyclic Gal(L/K)` for them), and
  `Ideal.primesOver` (`Mathlib/RingTheory/Ideal/Over.lean`). These are Number Field
  Arithmetic's raw material. We consume its packaged theorem and cite these only in the few
  lemmas that are genuinely polynomial-side.
- **Cyclotomic Galois groups:** `Mathlib/NumberTheory/Cyclotomic/Gal.lean` has
  `IsCyclotomicExtension.autEquivPow`, `galCyclotomicEquivUnitsZMod` and
  `galXPowEquivUnitsZMod` (`Gal(Φₙ) ≃* (ZMod n)ˣ`), which the abelian examples `4T1` and `4T2`
  rest on.
- **Finite fields, for Layer 9:** `Mathlib/FieldTheory/Finite/GaloisField.lean` and the
  irreducible-polynomial API. Layer 9 names precisely which existence statements it needs.
- **Chebotarev: absent** (no statement in any form at the pin or on master on 2026-08-06). It
  is the LFunctions roadmap's target, and nothing here depends on it.

## What is missing (build here)

Everything label-shaped. At the pin, and on master rechecked 2026-08-06: no orbit-to-factor
dictionary for the Galois action; no correspondence between blocks and intermediate fields; no
discriminant root-product formula (upstream's resultant TODO heads that way), hence no
`disc`-to-`Aₙ` test; no resolvent in the Galois sense, the identifier being taken by spectral
theory; no Dedekind factorization-to-cycle-type theorem (Frobenius elements exist and
`KummerDedekind` gives the shape bijection, but nobody composes them with `galActionHom`); no
general wreath product, only `RegularWreathProduct`, with the imprimitive O'Nan–Scott case an
upstream TODO; no Jordan prime-cycle theorem, an upstream `proof_wanted`; no classification of
transitive subgroups of `Sₙ` for any `n ≥ 3`; no `nTj` labels, no parity or primitivity
invariant layer, and no certificates; no realization of `Sₙ` over `ℚ` beyond the prime-degree
criterion.
Chambert-Loir's open pull requests (see coordination) head toward `PSL₂` simplicity and
Dieudonné generation, not toward any of this. We found no Zulip thread claiming any of it; the
searchable discussion trail for this area is his mathlib review threads rather than Zulip.

---

## The build, in layers

The numbering is the dependency order. Layer 1 is pure group theory and can run in parallel
with Layers 0, 2 and 3. As each layer makes the next layer's types expressible in `TauCeti/`,
its milestones are stated in `Suggested.lean` with `sorry`.

### Layer 0: the permutation representation of a polynomial

The dictionary between polynomial data and the image subgroup
`(galActionHom p E).range ≤ Equiv.Perm (p.rootSet E)`.

- **Degree bookkeeping.** For separable `p ≠ 0`, the set `p.rootSet p.SplittingField` has
  `p.natDegree` elements (assemble from `card_rootSet_eq_natDegree`), and the action of
  `p.Gal` on it is faithful (consume `galActionHom_injective`). Hence
  `Nat.card p.Gal = Nat.card (galActionHom …).range`, and every permutation invariant of
  `p.Gal` may be computed in the image.
- **Orbits and irreducible factors.** The principal target is an *equivalence*, not a count.
  For separable `p ≠ 0`:

  - the orbit of a root `α` is the root set of `minpoly F α` inside `p.rootSet E`;
  - consequently the orbit quotient `orbitRel.Quotient p.Gal (p.rootSet E)` is in bijection
    with the finite set of distinct monic irreducible factors of `p`, the bijection sending
    the orbit of `α` to `minpoly F α`;
  - along that bijection, the degree of a factor equals the cardinality of the corresponding
    orbit;
  - equality of the two cardinalities is a corollary of the bijection, not the statement to
    aim at.

  Two consequences worth naming separately: for separable nonconstant `p`, the action is
  transitive if and only if `p` is irreducible (one direction consumes
  `galAction_isPretransitive`); and without separability, transitivity says only that `p` is a
  unit times a power of a single irreducible. Every resolvent argument later uses this, since
  resolvents are typically reducible.
- **Invariants of the image.** Order (`card_of_separable`); parity, through the sign character
  `p.Gal →* ℤˣ` obtained from `galActionHom`, with evenness equivalent to the image lying in
  `alternatingGroup`; solvability of `p.Gal` as `IsSolvable`; and cycle types of elements.
  These are definitions with transport lemmas. The *tests* that compute them come in
  Layers 3 to 5.
- **Polynomials and normal closures.** For `K = F(α)` with `f = minpoly F α` separable, state
  and prove a concrete isomorphism, not a prose identification: `f.Gal` is isomorphic, as a
  group, to the automorphism group of the normal closure of `K/F` (Mathlib's
  `IntermediateField.normalClosure`), by an explicit `MulEquiv` induced by an `AlgEquiv` of
  the two fields. Under it the stabilizer of the root `α` is the subgroup fixing `K`, of index
  `n = [K : F]`.
- **Conjugate fields, stated exactly.** With `G = f.Gal` and `H = stabilizer G α`:

  - `G/H` is in `G`-equivariant bijection with the roots of `f`, equivalently with the set of
    `F`-embeddings of `F(α)` into the splitting field;
  - the subfields of the splitting field conjugate to `F(α)` correspond to the conjugates of
    `H` in `G`;
  - the number of *distinct* such subfields is `[G : N_G(H)]`, so the conjugate fields are
    indexed by `G / N_G(H)`, which is a proper quotient of `G/H` whenever `H` is not
    self-normalizing.

  Under this dictionary, the LMFDB's "Galois group of `K`" is `TransitiveGroupLabel j` applied
  to the image of `galActionHom`, and `K` is determined by `f.Gal` together with its point
  stabilizer up to conjugacy.

### Layer 1: the permutation toolkit, blocks, wreath products, recognition

Pure group theory, in `TauCeti/GroupTheory/Permutation/`, stated for abstract group actions in
Mathlib's vocabulary (`MulAction.IsBlock`, `IsPreprimitive`, and so on) and never mentioning
fields. Consume the Chambert-Loir library wholesale; build:

- **The block–stabilizer correspondence.** For a transitive action of `G` on `α` and a point
  `a : α`, the map sending a block `B` containing `a` to its setwise stabilizer
  `stabilizer G B` is an order isomorphism onto the interval `[stabilizer G a, ⊤]` of
  subgroups, with inverse `H ↦ H • a` (Wielandt 7.5; Dixon–Mortimer 1.5A). Mathlib has the two
  endpoints (`BlockMem` is a bounded order, and `isCoatom_stabilizer_iff_preprimitive` is the
  coatom shadow of this isomorphism); build the isomorphism of lattices, which Layer 2
  transports to intermediate fields.
- **The two extremal cases, in the correct direction.** Minimality and maximality of blocks
  control two different actions, and they must not be interchanged.

  - If `B` is a **minimal nontrivial block** containing `a`, then `stabilizer G B` corresponds
    to a subgroup minimal above `stabilizer G a`; consequently the setwise stabilizer of `B`
    acts primitively **on `B`**.
  - If `B` is a **maximal proper block** containing `a`, then `stabilizer G B` corresponds to
    a maximal proper subgroup of `G`; consequently `G` acts primitively **on the block
    system** `{g • B}`.

  An iterated imprimitivity chain is defined from these: a maximal chain of blocks
  `{a} = B₀ ⊂ B₁ ⊂ ⋯ ⊂ B_k = α` corresponds to a maximal chain of subgroups from
  `stabilizer G a` to `G`, and at each step the stabilizer of `B_{i+1}` acts primitively on
  the `B_i`-blocks it contains. This is the structure Hulpke's construction method uses.
- **General wreath products.** Define `WreathProduct D ι := (ι → D) ⋊ Equiv.Perm ι` and, for a
  subgroup `Q ≤ Equiv.Perm ι`, the restricted wreath product `(ι → D) ⋊ Q`, generalizing
  Mathlib's `RegularWreathProduct` (the case `ι = Q` with the translation action). Targets:
  the imprimitive action on `ι × Λ` for a `D`-set `Λ`; the product action on `ι → Λ`, which is
  the primitive O'Nan–Scott case and is reusable well beyond this roadmap; and a canonical
  **isomorphism**, not an equality, `D ≀ᵣ Q ≃* (Q → D) ⋊ Q'` identifying Mathlib's regular
  wreath product with the restricted permutation wreath product along the image `Q'` of the
  regular representation of `Q`. Order formulas, for `ι` and `D` finite:
  `Nat.card ((ι → D) ⋊ Q) = Nat.card D ^ Nat.card ι * Nat.card Q`, and in particular
  `Nat.card (WreathProduct D ι) = Nat.card D ^ Nat.card ι * (Nat.card ι)!`. Two Mathlib files
  border this one, `RegularWreathProduct.lean` and the imprimitive O'Nan–Scott case that
  `Perm/MaximalSubgroups.lean` names as its next target; take the naming and the choice of
  which variant is primary from them, so that a Mathlib version would replace this one by
  deletion rather than by a rewrite.
- **Imprimitivity gives a wreath embedding.** For a transitive action with a block `B` of size
  `l`, `1 < l < n`: the block system `{g • B}` has `m = n/l` members; the induced map
  `G →* Equiv.Perm (block system)` has kernel embedding into `∏ Perm(block)`; and `G` embeds
  into `WreathProduct (Perm B) (block system)` compatibly with a bijection
  `α ≃ (block system) × B`. This is the imprimitivity structure theorem, Dixon–Mortimer 2.6A.
- **Jordan's prime-cycle theorem** (Wielandt 13.9): a primitive subgroup of `Sₙ` containing a
  `p`-cycle with `p` prime and `p + 3 ≤ n` contains `Aₙ`. Mathlib's `Jordan.lean` states it
  verbatim as `proof_wanted alternatingGroup_le_of_isPreprimitive_of_isCycle_mem`. Prove it
  here, in that statement's shape and under that name, so that the two agree if Mathlib ever
  fills its own in.
- **The recognition lemmas.** Each is a small named theorem, and together they settle every
  degree-`≤ 5` certificate and the `Sₙ` realization of Layer 9:

  - a transitive subgroup of `S_p` for `p` prime contains a `p`-cycle (Cauchy);
  - transitive, containing a transposition, of prime degree, gives `S_p` (consume
    `Equiv.Perm.subgroup_eq_top_of_swap_mem`);
  - transitive and containing an `(n−1)`-cycle gives 2-transitive, hence primitive, by
    transitivity of the point stabilizer;
  - primitive and containing a transposition gives `Sₙ`; primitive and containing a 3-cycle
    gives `⊇ Aₙ` (consume Jordan);
  - an element with exactly one 2-cycle and all other cycle lengths odd has an odd power that
    is a transposition;
  - order-based recognition in low degree, proved from the Layer 6 tables: a transitive
    `G ≤ S₅` containing an element of order 6 is `S₅`; a transitive even `G ≤ S₅` containing
    an element of order 3 contains `A₅`.

### Layer 2: the dictionary between Galois theory and permutations

For irreducible separable `p` over `F` with a root `α` in `L = p.SplittingField`:

- **Stabilizers are relative Galois groups.** `stabilizer p.Gal (α : rootSet)` equals
  `(IntermediateField.adjoin F {α}).fixingSubgroup`, of index `natDegree p`.
- **Blocks and intermediate fields.** Transporting Layer 1's block–stabilizer isomorphism
  along the Galois correspondence gives a correspondence between the blocks containing `α` and
  the intermediate fields of `F(α)/F`. Because the Galois correspondence reverses inclusion
  while the block correspondence preserves it, the composite **reverses inclusion**: state it
  as an order anti-isomorphism, or equivalently as an order isomorphism onto the `OrderDual`.
  Both directions are explicit maps, and each is proved to invert the other:

  - a block `B` containing `α` maps to the fixed field of `stabilizer p.Gal B`;
  - an intermediate field `F ⊆ E ⊆ F(α)` maps to the set of roots of `minpoly E α` lying in
    `p.rootSet L`.

  The two ends check the orientation: `E = F(α)` gives `minpoly E α = X − α` and the smallest
  block `{α}`, while `E = F` gives `minpoly E α = p` and the largest block, the whole root
  set.
- **Primitivity means no proper intermediate field.** The action of `p.Gal` on the roots is
  preprimitive if and only if `F(α)/F` has no intermediate field other than the two ends, if
  and only if `IntermediateField.adjoin F {α}` is an atom (consume
  `isCoatom_stabilizer_iff_preprimitive` and the correspondence above). The degree hypothesis
  `1 < natDegree p` is needed: in the linear case the one-point action is preprimitive while
  `F(α) = ⊥` is not an atom. Corollary, also available directly from
  `IsPreprimitive.of_prime_card`: irreducible of prime degree implies primitive.
- **2-transitivity.** For `1 < natDegree p`, the action is 2-pretransitive if and only if
  `p / (X − α)` is irreducible over `F(α)`, by transitivity of the point stabilizer on the
  remaining roots; state it with `SubMulAction.ofStabilizer`'s `isMultiplyPretransitive_iff`.
- **Products and towers.** Describe the image of `restrictProd`: `Gal (p*q)` is the fiber
  product, that is, the subgroup of `Gal p × Gal q` of pairs agreeing on the intersection
  `L_p ∩ L_q` of the two splitting fields, both projections being surjective by
  `restrictDvd_surjective`. The degenerate case is stated by the exact hypothesis it needs,
  namely `L_p ∩ L_q = F` (for Galois extensions this is the same as linear disjointness over
  `F`), and under it the map is an isomorphism onto the full product. Name the two restriction
  maps to the intersection explicitly rather than leaving the fiber product implicit. The
  lemma resolvents need: a `Gal p`-equivariant polynomial map of root data induces a
  surjection `Gal p ↠ Gal q` when `q`'s splitting field embeds in `p`'s.
- **Reducible conventions.** For reducible separable `p` the stabilizer and block statements
  are made per orbit, that is, per irreducible factor. No statement quantifies over "the" root
  of a reducible polynomial.

### Layer 3: the discriminant and the alternating group

- **The root-product formula**, stated in the shape Mathlib's resultant TODO takes (see the
  coordination section): for monic `f` of degree `n` splitting in `L` with roots
  `r : Fin n → L` listed with multiplicity,
  `algebraMap R L f.discr = ∏_{i < j} (r i − r j)²`. Consequences to state alongside it: the
  product formula for `discr (f*g)` with its `resultant f g` cross term; **base change**
  `(f.map φ).discr = φ f.discr` for a ring homomorphism `φ`, in the degree-preserving case,
  which is what Layer 5 needs at `ℤ → ZMod p`; `f.discr ≠ 0 ↔ f.Separable` for monic `f`; and
  the two comparison lemmas that keep the several discriminant APIs consistent, namely
  `Cubic.discr P = (P.toPoly).discr` after monic normalization, and, for a power basis,
  `Algebra.discr` of the basis equal to `(minpoly).discr`, routed through
  `discr_powerBasis_eq_norm`. The last of these is what Number Field Arithmetic's
  `discr f = index² · disc K` is stated against.
- **The square root of the discriminant and the sign character.** For separable monic `f` over
  `F` with `ringChar F ≠ 2`, set `δ = ∏_{i<j} (rᵢ − rⱼ)`. Then every `σ ∈ f.Gal` satisfies
  `σ δ = sign (galActionHom σ) • δ`. Hence the **discriminant test**: `IsSquare f.discr` if and
  only if `(galActionHom …).range ≤ alternatingGroup`, and the quadratic subextension `F(δ)`
  is the fixed field of the even part of the image. In characteristic 2 the statement fails
  and the hypothesis is not droppable; the characteristic-2 substitute (Berlekamp's invariant)
  is outside this roadmap's scope, as recorded above.
- **The discriminant quadratic extension, named.** Define `F(√disc f)` as the splitting field
  of `X² − C f.discr` over `F`. For `ringChar F ≠ 2` it equals `F` when `f.discr` is a square
  and is a quadratic extension otherwise, and it is the fixed field of the even part of the
  image. Layer 4's quartic table refers to this field, so it is defined once here.
- **Worked instances** (acceptance): degree 2, where the test is the quadratic formula; degree
  3, where an irreducible separable cubic has group `A₃ = C₃` or `S₃` according to whether the
  discriminant is a square, with `x³ − 3x − 1` and `x³ − 2` as the two cases. The
  `Cubic.discr` comparison checks the two discriminant APIs against each other.

### Layer 4: resolvents

A resolvent converts a constraint on the subgroup into a statement about factorization. Two
levels of data are kept apart throughout, and the soundness of the certificate layer depends
on that separation.

- **Static resolvent specifications.** A `ResolventSpec n` is library data, written and proved
  once: a subgroup `H ≤ Equiv.Perm (Fin n)`, an invariant `Φ : MvPolynomial (Fin n) ℤ`, and a
  **proved theorem** that the stabilizer of `Φ` under `MvPolynomial.rename` is exactly `H`,
  not merely contained in it. Specifications are registered in the library and referred to by
  identifier. An untrusted certificate selects a registered specification; it never supplies
  an invariant together with an unverified claim about its stabilizer.
- **The orbit resolvent.** For a specification with invariant `Φ` and a root vector `x`,
  `galResolvent Φ x := ∏_{Ψ ∈ orbit of Φ} (X − C (Ψ(x)))`, the product over the rename-orbit
  of `Φ`, which is finite of size `[Sₙ : H]`. First theorems: evaluated at the roots of a
  monic `f`, its coefficients are symmetric functions of the roots, so it descends to `F[X]`
  (consume the `MvPolynomial.IsSymmetric` API and the fundamental theorem of symmetric
  polynomials); it does not depend on the numbering, being literally invariant; and its degree
  is `[Sₙ : H]` provided the orbit values stay distinct.
- **The factorization theorem, with its hypothesis.** Assume the specialized resolvent is
  separable. Then the Galois action on the orbit of `Φ` agrees with the action on the coset
  space `Sₙ/H` transported by the numbering, and the monic irreducible factors of
  `galResolvent Φ x` correspond to the orbits of the image of `Gal f` on `Sₙ/H`, with degrees
  equal to orbit sizes. The two corollaries used downstream: the resolvent has a root in `F`
  if and only if the image is conjugate into `H`; and, more finely, the multiset of factor
  degrees equals the multiset of orbit sizes, which is the constraint the databases record.
- **The degenerate case, both directions.** Without the separability hypothesis the two
  implications are not symmetric, and both are stated:

  - if the image is conjugate into `H`, then the specialized resolvent **has** a root in `F`.
    This direction needs no hypothesis and is the easy one;
  - the converse can fail: a root in `F` may come from two distinct cosets whose invariants
    happen to collide at the roots of this particular `f`. It holds under the separation
    hypothesis, and only then.

  So a rational root proves the containment only in the presence of separation evidence. The
  certificate layer is built around this asymmetry.
- **Tschirnhaus transforms, scoped to what is used.** When the specialized resolvent is not
  separated, the classical remedy is to replace `f` by `f_T`, obtained by a polynomial
  substitution in a root, with the same splitting field and the same Galois image up to the
  induced numbering. This roadmap targets the soundness statement only: if a certificate
  supplies a transform and the transformed resolvent is checked to have full orbit degree and
  to be separable, the upper bound follows. The classical claim that such a transform always
  exists over an infinite field, on the ground that the bad coincidences are finitely many
  proper algebraic conditions, is a substantial theorem, and it is **not** a target here.
  Certificate soundness does not need it, and the roadmap does not assert totality of the
  method.
- **The quartic, worked in full.** Throughout this item `ringChar F ≠ 2`, which is what both
  the depressed form and the discriminant test require.

  - *Depressing is valid.* For `ringChar F ≠ 2`, the substitution `X ↦ X − a/4` carries
    `X⁴ + aX³ + bX² + cX + d` to a quartic with no cubic term. It needs `4` invertible in `F`,
    it preserves the splitting field, and it induces a `Gal`-equivariant bijection of root
    sets, hence the same image up to the induced numbering. So working with
    `f = X⁴ + pX² + qX + r` is a normalization, not a restriction.
  - *The specification.* The `D₄`-invariant is `x₀x₂ + x₁x₃`, whose stabilizer in
    `Equiv.Perm (Fin 4)` has order 8 and whose orbit `{x₀x₂+x₁x₃, x₀x₁+x₂x₃, x₀x₃+x₁x₂}` has
    three elements, so the resolvent is a cubic.
  - *The closed form.* `resolventCubic f = X³ − pX² − 4rX + (4pr − q²)`, and this cubic is the
    orbit resolvent of the specification above, which is a theorem to prove, not a definition
    to assume.
  - *Discriminants agree.* `f.discr = (resolventCubic f).discr`.
  - *The decision table*, for `f` irreducible and separable, each row a named theorem:
    resolvent cubic irreducible over `F` and `f.discr` not a square gives `S₄`; resolvent cubic
    irreducible and `f.discr` a square gives `A₄`; resolvent cubic splitting completely over
    `F` gives `V₄`; resolvent cubic with exactly one root in `F` gives `C₄` or `D₄`, and the
    two are separated by behaviour over the field `F(√disc f)` defined in Layer 3: the group is
    `C₄` when `f` becomes reducible over `F(√disc f)`, and `D₄` when `f` stays irreducible
    there. Any row needing a characteristic hypothesis beyond `ringChar F ≠ 2` carries it in
    its own statement.

  Together with Layer 6 these give `HasGaloisLabel` for every quartic.
- **The quintic and its sextic resolvent.** Throughout, `ringChar F ∉ {2, 5}`: depressing a
  quintic needs `5` invertible, and the accompanying discriminant test needs `2`.

  - *The invariant.* Index `Fin 5` by `ℤ/5` and set
    `Φ = Σ_{a ∈ ℤ/5} x_a² (x_{a+1} x_{a−1} + x_{a+2} x_{a−2})`, ten terms of shape
    `x_a² x_b x_c`. Its stabilizer in `Equiv.Perm (Fin 5)` is **exactly** the Frobenius group
    `F₂₀ = AGL(1,5)` of order 20, and its `S₅`-orbit has six elements, so the orbit resolvent
    is a sextic. Both facts are part of the `ResolventSpec` and are proved, not assumed. This
    is the exact invariant behind the classical resolvent sextic; the roadmap defines
    `resolventSextic` as the orbit resolvent of this specification, so the definition is
    self-contained and needs no external table. Dummit's paper writes the same sextic as a
    closed formula in the coefficients of `X⁵ + pX³ + qX² + rX + s`. That formula is a
    computational shortcut for evaluating the resolvent, and this roadmap does not use it: the
    orbit resolvent above is the definition, and every statement below is about it.
  - *The criterion.* For an irreducible separable quintic, `IsSolvable f.Gal` holds if and only
    if the image is conjugate into `F₂₀`, which by Layer 6's degree-5 classification is the
    statement that the label is `5T1`, `5T2` or `5T3`. Combined with the factorization theorem
    and its separation hypothesis: under the separation evidence, `IsSolvable f.Gal` holds if
    and only if `resolventSextic f` has a root in `F`. The criterion is about group
    solvability; it says nothing about `Polynomial.solvableByRad`.
- **Linear resolvents.** Root-sum and root-difference resolvents are instances of the same
  framework, and are the practical toolkit in degrees up to 7 (Soicher–McKay). No separate
  theory is needed, but one worked example is kept, to check that the framework composes: for
  a quintic, the stabilizer of `x₀ + x₁` is `S_{\{0,1\}} × S_{\{2,3,4\}}` of order 12, so the
  orbit has `120/12 = 10` elements, indexed by the ten unordered pairs, and the pair-sum
  resolvent is of **degree 10**. A target proving that the symbolic orbit has exactly ten
  elements is part of this item.

### Layer 5: Frobenius specialization

- **The consumed statement** (Number Field Arithmetic, Layer 3; shape pinned in the
  conventions above and in `Suggested.lean`): for monic `f : ℤ[X]` and a prime `p ∤ f.discr`,
  some `σ ∈ (f/ℚ).Gal` has `fullCycleType (galActionHom σ)` equal to the multiset of degrees of
  the monic irreducible factors of `f mod p`. Its supplier composes Mathlib's `IsArithFrobAt`
  with `KummerDedekind` and `galRestrict`. This roadmap owns only the polynomial-side
  packaging: that `f mod p` is separable (base change of `discr` from Layer 3, plus
  `discr ≠ 0` in `ZMod p`), the factor-degree multiset as computable data
  (`normalizedFactors`, `Multiset.map natDegree`, with decidability over `ZMod p`), and the
  check that the degrees sum to `n`.
- **The membership statement.** The corollary everything downstream uses: the multiset of
  factor degrees of `f mod p` belongs to `{ fullCycleType g ∣ g ∈ image of Gal }`.
  Consequences, each a named theorem, via Layer 1's recognition lemmas: if `f mod p` is
  irreducible then `Gal f` contains an `n`-cycle, hence acts transitively, hence `f` is
  irreducible over `ℚ`, which is the classical mod-`p` irreducibility criterion; factorization
  type `(1,…,1,2)` at prime degree, with transitivity, gives `S_p`; type `(1,…,1,3)` with
  primitivity gives `⊇ Aₙ` by Jordan; and the degree-`≤ 5` order-recognition lemmas lift from
  groups to polynomials.
- **What factorization types cannot do.** Cycle types certify lower bounds only, since they
  exhibit elements. No finite set of factorization types certifies `Gal ≤ H` for a proper `H`;
  upper bounds come from Layer 3 and Layer 4. The `D₅`-versus-`A₅` pair among the worked
  examples below is the standard illustration. The *statistics* of
  cycle types are Chebotarev's, and belong to the LFunctions roadmap; correctness of the
  certificates here does not use them.
- **Index divisors.** All statements are at `p ∤ discr f` only. Dedekind's example
  `x³ + x² − 2x + 8` at `p = 2` is cited from Number Field Arithmetic as the reason the
  hypothesis is placed on `discr f` rather than on ramification.

### Layer 6: transitive subgroups of `Sₙ` for `n ≤ 5`, classified, with the label dictionary

The reference subgroups, pinned by generators inside `Equiv.Perm (Fin n)` and written here in
cycle notation on `1, …, n` as the source tables write them:

| label | reference | name | order | parity | primitive | solvable |
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

Order, parity, primitivity and solvability were checked against the LMFDB `gps_transitive`
data and PARI's `polgalois`; the `T`-numbering is Butler–McKay's, which GAP and the LMFDB
share. In Lean these entries are `referenceSubgroup n j` for
`j : TransitiveGroupIndex n`, with `numTransitiveGroups` equal to `1, 1, 2, 5, 5` in degrees
`1` to `5`, and `j` displaying as `nT(j+1)`.

- **The classification theorems.** For each `n ≤ 5`: every transitive subgroup of
  `Equiv.Perm (Fin n)` is conjugate to exactly one `referenceSubgroup n j`. This splits into
  existence (conjugating an arbitrary transitive subgroup onto a reference) and disjointness
  (no two references are conjugate). Proof route, in the style of Dixon–Mortimer §2: the prime
  degrees 2, 3 and 5 through Cauchy's `p`-cycle and an analysis of the normalizer of
  `⟨p`-cycle`⟩`, which pins the subgroups between `C_p` and `F_{p(p−1)}`, together with the
  recognition lemmas for the cases containing `A_p`; degree 4 through the order together with
  a block analysis, the possible orders being `4, 8, 12, 24` and blocks separating the cases
  of order 4 and 8.
- **Order recognizes the label in low degree.** For `n = 5` a transitive subgroup has order in
  `{5, 10, 20, 60, 120}` and the order determines the label; for `n = 4` the order determines
  it except at order 4, where `IsCyclic` separates `4T1` from `4T2`; for `n = 3` the order
  determines it. A certificate terminates on these theorems: a lower bound from factorization
  types and an upper bound from a resolvent or the discriminant meet in an order count.
- **The label predicates.** `TransitiveGroupLabel j G` as pinned in the conventions;
  transitivity of each reference (so the predicate needs no transitivity clause); invariance
  under conjugation and renumbering; the partition theorem, that for `n ≤ 5` every transitive
  subgroup has exactly one label; each invariant in the table above as a theorem; and
  `HasGaloisLabel f j` for separable degree-`n` polynomials, together with its independence of
  the chosen relabeling.
- **Solvability and the degree-5 labels.** An irreducible quintic has `IsSolvable f.Gal` if and
  only if its label is `5T1`, `5T2` or `5T3`, which ties Layer 4's sextic-resolvent criterion
  to this table. The statement is about the group; it is not an assertion about
  solvability by radicals.

### Layer 7: degrees 6 to 11 as reference data

The same treatment for every degree from 6 to 11, but without a classification theorem: the
reference data is stated, the semantics and the invariants of each named reference are proved,
and the list is not claimed to be exhaustive.

- **Reference data.** For `6 ≤ n ≤ 11`, `numTransitiveGroups` takes the values
  `16, 7, 50, 34, 45, 8` (Butler–McKay 1983; OEIS A002106; matching the LMFDB), and
  `referenceSubgroup n j` is given by the generator lists from the frozen export described in
  the conventions. Nothing here reconstructs the numbering from prose.
- **Invariants, by certificate rather than by enumeration.** Each invariant of an explicit
  finite subgroup is decidable in principle, but decidability is not an implementation plan:
  enumerating `S₁₁` inside kernel reduction will not run, and a roadmap that says the
  computation should be arranged to reduce has specified nothing. Each invariant therefore has
  a named route:

  - *order*: an enumeration or closure certificate for the small groups; a structural order
    theorem for the large standard ones (`Aₙ`, `Sₙ`, and the named primitive groups);
  - *parity*: the signs of the generators together with closure, since the sign character is a
    homomorphism, so no enumeration is needed;
  - *transitivity*: a checked orbit computation showing the orbit of a point is everything;
  - *primitivity*: a structural theorem where one applies (prime degree, or 2-transitivity),
    and otherwise a checked block-system certificate, that is, an exhibited nontrivial block
    for imprimitivity, or a checked exhaustion of candidate block sizes for primitivity;
  - *solvability*: a checked derived series reaching the trivial subgroup, or a standard-group
    theorem for the insolvable cases;
  - *cycle-type data*: fixed as the **set of cycle types that occur**, not a histogram with
    multiplicities, and computed from the conjugacy-class structure where that is available
    rather than by enumerating elements. If a histogram is wanted later it is a separate
    definition with its own name.
- **A build-performance criterion, as an acceptance test.** Each degree's data file must
  compile in ordinary project CI without raising kernel-reduction limits and without a large
  `native_decide` computation concealed inside a theorem. A data file that only compiles with
  raised limits has not met this layer's specification.
- **Certificates conclude by conjugacy, never by elimination.** Because no classification is
  claimed in these degrees, a certificate concludes `HasGaloisLabel f j` only by proving that
  the image is conjugate to `referenceSubgroup n j`. It may not conclude a label by ruling out
  the other listed references, since the list is not known here to be complete.
- **Realizations.** The roadmap does *not* claim a certified polynomial for every label in
  every degree up to 11: that claim needs a manifest of explicit polynomials, and without one
  it is not a specification. In scope are the labels the worked examples and the Modular Forms
  certificate need, with their polynomials written out. A full per-label manifest is outside
  this roadmap; a roadmap that wanted it would freeze one monic integral polynomial and a
  source identifier per label from the Klüners–Malle database or the LMFDB number-field
  tables, under the same discipline as the generator export.
- **Siblings and subfields.** The LMFDB's "siblings" (other transitive actions of the same
  abstract group) and its "resolvents and subfields" column are, mathematically, actions on
  block systems (Layer 1) and on coset spaces of the reference subgroups. This roadmap proves
  the semantics for the named references only; an exhaustive sibling classification is covered
  by the same scope exclusion as classification completeness.

### Layer 8: the certificate checker

This is the interface [Modular Forms](../ModularForms/README.md), Layer 9 asks for, and the
API a downstream computational repository calls. The design keeps three things apart: the
certificate is **pure data**, checking is a **Boolean function**, and the conclusion is a
**soundness theorem** about that function. A caller submits data and never has to construct a
proof-valued field.

- **The data.** Per polynomial `f : ℤ[X]` and target index `j`: a list of prime factorization
  claims, each a prime with a claimed list of factors of `f mod p`; a discriminant claim; a
  list of resolvent claims, each naming a **registered** `ResolventSpec` by identifier, with an
  optional Tschirnhaus transform and the claimed factor data; and a group-deduction
  certificate. Nothing in the data is trusted.
- **What `check` verifies.** Every item below is checked rather than assumed:

  - `f` is monic, of the claimed degree, with `f.discr ≠ 0`;
  - each claimed prime is prime, and `p ∤ f.discr`;
  - the claimed factors of `f mod p` multiply to `f mod p`;
  - each claimed factor is monic and irreducible, and the factors are pairwise distinct;
  - the resulting multiset of factor degrees, with fixed points included;
  - the claimed squareness or non-squareness of `f.discr` over `ℤ`;
  - that each resolvent claim names a registered specification, so the invariant and its exact
    stabilizer come from proved library data;
  - recomputation of the transformed polynomial and of the specialized resolvent from `f`
    itself, and equality with any resolvent polynomial the certificate claims;
  - that the specialized resolvent has the expected full orbit degree `[Sₙ : H]`;
  - that it is separable, equivalently squarefree here;
  - the claimed factorization or rational root of the resolvent, by the same product and
    irreducibility checks;
  - the final group-theoretic deduction.

  Irreducibility over `ZMod p` is checked by a named algorithm, not by an unexplained kernel
  computation: Rabin's test, that a monic `g` of degree `d` is irreducible over `𝔽_p` exactly
  when `X^(p^d) ≡ X (mod g)` and `gcd(X^(p^(d/ℓ)) − X, g) = 1` for every prime `ℓ ∣ d`.
  Its correctness is a target of this layer, and the reflection theorem behind the
  factorization checks rests on it.
- **The group deduction, made explicit.** Cycle types alone give no upper bound and no lower
  bound on the order, so the step from the checked constraints to a label is its own object: a
  `GroupDeductionCertificate n j` witnesses a statement of the form

  > every subgroup `K ≤ Sₙ` that contains elements of the exhibited cycle types, satisfies the
  > exhibited parity constraint, and is contained in the exhibited resolvent subgroups, is
  > conjugate to `referenceSubgroup n j`.

  In degrees at most 5 this is discharged by the order-recognition theorems of Layer 6. In
  degrees 6 to 11 it is discharged by a verified chain in the subgroup lattice, by order
  bounds, or by nested resolvents, and each such deduction is a separate proved statement about
  the reference data. It is never discharged by observing several cycle types.
- **Soundness, and only soundness.** The theorem is: if `check cert = true` then
  `HasGaloisLabel f j`. It is unconditional. That every polynomial admits a certificate, and
  that a search for one terminates, are separate questions, and neither is claimed here.
- **The Modular Forms acceptance test.** State the generic theorem the downstream certificate
  instantiates: a monic quintic over `ℤ` whose reduction is irreducible at one prime not
  dividing the discriminant, and has factor degrees `(2,1,1,1)` at another such prime, has full
  `S₅` Galois group, by transitivity plus a transposition in prime degree (consume
  `Equiv.Perm.subgroup_eq_top_of_swap_mem`). The concrete weight-60 quintic and its two
  factorizations, at `83` and `17`, live in the downstream computational repository; the
  acceptance criterion here is that the checker accepts a certificate of exactly that shape,
  stated schematically rather than by quoting coefficients this roadmap does not fix.

### Layer 9: `Sₙ` as a Galois group over `ℚ`

The one general inverse-Galois theorem: for every `n ≥ 1` there is an explicit monic
`f : ℤ[X]` of degree `n`, irreducible over `ℚ`, whose Galois action on the roots is the full
symmetric group. The construction is classical (van der Waerden §61; Serre, *Topics*, §4.4):
pick reductions at 2, 3 and 5 with prescribed factorization patterns and reassemble the
coefficients by the Chinese remainder theorem. "Pick a suitable polynomial" is not an
instruction an implementation agent can act on, so the prerequisites are listed as targets, in
dependency order:

1. for every `d ≥ 1`, existence of a monic irreducible polynomial of degree `d` over
   `ZMod 2` (name the finite-field existence theorem consumed, or make it a target);
2. for each `n` in range, a squarefree monic polynomial over `ZMod 3` with factor degrees
   `(1, n−1)`, with the small `n` handled separately;
3. for each `n` in range, a squarefree monic polynomial over `ZMod 5` with exactly one
   quadratic factor and all remaining factor degrees odd, again with the small cases explicit;
4. a coefficientwise Chinese remainder theorem producing a monic integral polynomial of degree
   `n` with those three reductions;
5. base change of the discriminant, plus squarefreeness of each of the three reductions,
   proving that 2, 3 and 5 do not divide `disc f` and so are admissible Frobenius primes;
6. the mod-2 irreducibility criterion, giving irreducibility of `f` over `ℚ`;
7. the group-theoretic steps, all from Layer 1: an `n`-cycle gives transitivity; a transitive
   group containing an `(n−1)`-cycle is 2-transitive, hence primitive; an element with exactly
   one 2-cycle and all other cycles of odd length has an odd power equal to a transposition; a
   primitive subgroup containing a transposition is `Sₙ`;
8. separate arguments for `n = 1` and for any other value the three patterns do not cover
   uniformly.

Everything here is Layer 1 plus Layer 5; no new input is needed, and in particular this layer
does not wait on Layers 6 to 8. The classical one-polynomial alternative `xⁿ − x − 1` (Selmer
irreducibility, Osada's theorem) has its own literature and is not the route taken.

Concrete `Aₙ` realizations stay in as certificates: for the degrees in range, explicit
polynomials with square discriminant whose label is the alternating one, `x⁵ + 20x − 16` among
them. The realization of `Aₙ` over `ℚ` for general `n` is outside this roadmap, as recorded in
the scope section; Serre's construction of it runs through Hilbert irreducibility, which is
also outside.

## Worked examples, as acceptance criteria

Every polynomial below was re-verified for this roadmap with PARI (`polgalois`, `nfdisc`) and
against the LMFDB field pages. Each one pins a specific layer.

- **Degree 3** (Layer 3): `x³ − 3x − 1` has discriminant `81 = 9²` and group `C₃ = 3T1` (LMFDB
  field `3.3.81.1`, the cyclic cubic of conductor 9); `x³ − 2` has discriminant `−108` and
  group `S₃ = 3T2` (`3.1.108.1`). For irreducible cubics the discriminant test decides by
  itself.
- **Degree 4** (Layers 4 and 6): `x⁴ + x + 1` has resolvent cubic `X³ − 4X − 1`, irreducible,
  and discriminant `229`, not a square, giving `S₄ = 4T5` (`4.0.229.1`). `x⁴ + 8x + 12` has
  resolvent cubic `X³ − 48X − 64`, irreducible, and discriminant `331776 = 576²`, a square,
  giving `A₄ = 4T4` (`4.0.5184.1`). `x⁴ − 2` gives `D₄ = 4T3` (`4.2.2048.1`). `x⁴ + 1` gives
  `V₄ = 4T2` (`4.0.256.1`, the field `ℚ(ζ₈)`), and carries a Frobenius footnote: `V₄` contains
  no 4-cycle, so `x⁴ + 1` is reducible modulo *every* prime, which is the membership statement
  of Layer 5 read backwards and is an acceptance test for its contrapositive.
  `x⁴ + x³ + x² + x + 1` gives `C₄ = 4T1` (`4.0.125.1`, the field `ℚ(ζ₅)`, through
  `galCyclotomicEquivUnitsZMod`, which identifies the group with `(ZMod 5)ˣ`). Together these
  exercise all five quartic labels and every row of the decision table.
- **Degree 5** (Layers 4 to 6):
  - `x⁵ + x⁴ − 4x³ − 3x² + 3x + 1`, the defining polynomial of `ℚ(ζ₁₁)⁺`, gives `C₅ = 5T1`
    (`5.5.14641.1`, discriminant `11⁴`).
  - `x⁵ − 5x − 12` gives `D₅ = 5T2` (`5.1.1000000.1`; polynomial discriminant `8000²`). This is
    the example showing why upper bounds need more than factorization types: a 5-cycle and an
    element of type `(1,2,2)` occur, and every factorization type of this `f` at a prime not
    dividing the discriminant is a cycle type of `D₅ ⊂ A₅`, so no prime ever excludes `A₅`. The
    certificate needs the discriminant square test, which excludes `S₅` and `F₂₀`, together
    with a rational root of the sextic resolvent, which excludes `A₅`; the order count then
    reads `5T2` off the Layer 6 table.
  - `x⁵ − 2` gives `F₂₀ = 5T3` (`5.1.50000.1`): the Kummer example, with solvable Galois group,
    a positive sextic-resolvent criterion, and discriminant `50000`, not a square.
  - `x⁵ + 20x − 16` gives `A₅ = 5T4` (`5.1.1000000.2`): the discriminant `32000²` is a square;
    a prime with factorization type `(1,1,3)` together with primitivity (automatic in prime
    degree) gives `⊇ A₅` by Jordan's 3-cycle theorem, and the square discriminant caps it at
    `A₅`. It shares the field discriminant `10⁶` with the `D₅` example, a deliberate pairing
    showing the label is not a function of `(n, r₁, |disc|)`.
  - `x⁵ − x − 1` gives `S₅ = 5T5` (`5.1.2869.1`, discriminant `2869 = 19·151`): modulo 2 the
    factorization `(x² + x + 1)(x³ + x² + 1)` exhibits an element of order 6; modulo 5 it is
    the Artin–Schreier polynomial `x⁵ − x − 1`, irreducible, which exhibits a 5-cycle and
    proves irreducibility over `ℚ`. Transitive together with an element of order 6 forces `S₅`
    by the recognition lemmas. Two primes, no discriminant computation: the smallest
    certificate in the collection.
- **The cross-roadmap instance** (Layers 5 and 8): a quintic that is irreducible modulo one
  good prime and factors with type `(1,1,1,2)` modulo another has group `S₅`. That is the
  generic theorem stated in Layer 8, and the acceptance test is that the checker accepts a
  two-item certificate of this shape; the Modular Forms weight-60 instance supplies the
  coefficients and the two primes 83 and 17.
- **Non-examples, which test that the definitions exclude what they should:** `x⁴` and
  `(x² − 2)²` are not separable, so no permutation claim is made about them, and in particular
  they do not satisfy the full-symmetric-group predicate of Layer 9 even though a degree count
  alone might suggest otherwise; `(x² − 2)(x² − 3)` is separable and reducible, with
  `Gal ≅ V₄` acting with two orbits of size 2 (orbits and factors, Layer 0), and
  `TransitiveGroupLabel` correctly declines to apply;
  `x⁵ + x + 1 = (x² + x + 1)(x³ − x² + 1)` is the reducible cousin of `x⁵ − x − 1`,
  kept as a regression test that no `5Tj` label is assigned to a reducible quintic.

## Ordering and parallelism

Layer 1, which is pure group theory, and Layers 0 and 2, the polynomial dictionary, can start
at once and independently of each other. Layer 3 needs Layer 0 and the resultant API, and its
root-product formula is worth doing early, in the shape Mathlib's own resultant TODO takes.
Layer 4 needs Layers 0 to 3 and the symmetric-functions API. Layer 5's polynomial-side lemmas
need Layer 3 for base change of the discriminant, and its main statement comes from Number
Field Arithmetic. Layer 6
needs Layers 1 and 2, and feeds its order-recognition lemmas back into Layer 1. Layer 7 needs
Layers 1 and 6 and can land one degree at a time. Layer 8 needs Layers 3 to 7. Layer 9 needs
only Layers 1 and 5, so it can land before Layers 6 to 8.

Three deliverables are worth front-loading, because other roadmaps are waiting on their shape
rather than on their proofs: the Layer 5 interface statement, the Layer 6 degree-`≤ 5` tables,
and the Layer 8 certificate types.

## References

The roadmap does not rest a target on a source that was not inspected. Where a classical book
is the traditional citation but was not available for this pass, the dependent target is
grounded another way, and the entry below says how. Sources marked *not inspected for this
pass* are historical or contextual citations, not the grounding of any target.

- A. Hulpke, *Constructing transitive permutation groups*, J. Symbolic Comput. 39 (2005)
  1–30. In the project's `references/`. The inflation and base-group method of §3 is the
  construction behind the iterated imprimitivity chain of Layer 1, and the source for the
  degree-by-degree history of the classification in Layer 7.
- J. D. Dixon, B. Mortimer, *Permutation Groups*, GTM 163, Springer, 1996. The traditional
  source of record for Layer 1 (blocks and imprimitivity §1.5, wreath products §2.6, Jordan's
  theorems §7.4) and for the low-degree tables in Appendix B. *Not inspected for this pass.*
  The dependent targets are grounded instead in Mathlib's own `GroupAction/Blocks.lean`,
  `Primitive.lean` and `Jordan.lean`, which state this material in the vocabulary we use, and
  in the proof routes written out in Layers 1 and 6 above.
- H. Wielandt, *Finite Permutation Groups*, Academic Press, 1964. The original of the toolkit;
  Mathlib's `Blocks.lean` and `Jordan.lean` cite it, and Theorems 7.5 and 13.9 are the two
  statements we use by number. *Not inspected for this pass.* Theorem 13.9 is grounded in
  Mathlib's verbatim `proof_wanted` for it; Theorem 7.5 in the lattice statement written out
  in Layer 1.
- LMFDB, *Galois group labels* and the `gps_transitive` table,
  <https://www.lmfdb.org/GaloisGroup/>. The frozen source of the reference generators and of
  the label semantics being formalized, under the export discipline pinned in the conventions.
  Spot-verified 2026-07-30 for the degree-`≤ 5` table above.
- G. Butler, J. McKay, *The transitive groups of degree up to eleven*, Comm. Algebra 11 (1983)
  863–911. The origin of the `T`-numbering and of the class counts used in Layer 7.
  *Not inspected for this pass*; the counts were taken from OEIS A002106 and cross-checked
  against the LMFDB, and the generators come from the LMFDB export rather than from the paper.
- J. H. Conway, A. Hulpke, J. McKay, *On transitive permutation groups*, LMS J. Comput. Math. 1
  (1998) 1–8. Names and properties in degrees up to 15, which is the LMFDB's name column.
  Context only: this roadmap does not own abstract group names.
- B. L. van der Waerden, *Algebra* I, §61, and J.-P. Serre, *Topics in Galois Theory*, 2nd ed.,
  A K Peters, 2008, §4.4. The three-prime construction of Layer 9. *Not inspected for this
  pass*; Layer 9 lists all eight prerequisites explicitly, so the construction is grounded in
  this document rather than in the citation. Serre §§3 and 4.5, on thin sets, Hilbert
  irreducibility and the general `Aₙ` realization, describe material this roadmap places out
  of scope.
- D. S. Dummit, *Solving solvable quintics*, Math. Comp. 57 (1991) 387–401. The explicit
  coefficient formula for the resolvent sextic. *Not inspected for this pass*, and nothing
  depends on it: Layer 4 defines `resolventSextic` as the orbit resolvent of an invariant given
  in full, and the closed formula is a way of evaluating that resolvent, not part of its
  definition.
- H. Cohen, *A Course in Computational Algebraic Number Theory*, GTM 138, Springer, 1993, §6.3.
  Resolvent algorithms and the decision trees in degrees up to 7. *Not inspected for this
  pass*; context for Layer 4, whose quartic and quintic statements are written out above.
- L. Soicher, J. McKay, *Computing Galois groups over the rationals*, J. Number Theory 20
  (1985) 273–281. Linear resolvents, the practical tail of Layer 4. Context.
- R. P. Stauduhar, *The determination of Galois groups*, Math. Comp. 27 (1973) 981–996, and
  K. Geissler, J. Klüners, *Galois group computation for rational polynomials*, J. Symbolic
  Comput. 30 (2000) 653–674. The numerical and the modern algorithmic alternatives; context
  for why the resolvents here are exact and why the interface is a checker.
- Klüners–Malle, number-field database, <https://galoisdb.math.upb.de/>. The source a per-label
  polynomial manifest would be frozen from. Such a manifest is outside this roadmap, as Layer 7
  records.
- E. R. Berlekamp, *An analog of the discriminant over fields of characteristic two*, J. Algebra
  38 (1976) 315–317. Cited only to name what the characteristic-2 exclusion excludes.

## Provenance, coordination, and licensing

- **A. Chambert-Loir's mathlib program** is the substrate of Layer 1 and should not be worked
  around. At the pin his suite comprises `GroupAction/{Blocks, Primitive, Transitive,
  MultipleTransitivity, MultiplePrimitivity, Jordan, Iwasawa}.lean`, the
  `SubMulAction/{OfStabilizer, OfFixingSubgroup, Combination}.lean` machinery, and the
  alternating-group simplicity and `MaximalSubgroups` files, all merged before 2026-06-03
  (among them mathlib4 #33082 and #36524 for simplicity of `Aₙ`, #34307 for `powersetCard`
  primitivity, and #33715 for projectivization 2-transitivity). Rechecked 2026-08-06: still
  open and not overlapping this roadmap are #33916 (`PSL₂` simplicity) and the
  Dieudonné and transvection series #33692, #33560, #33485, #33402. Two of our targets are his
  files' own TODOs, the Jordan prime-cycle theorem in `Jordan.lean` and the imprimitive
  O'Nan–Scott case in `Perm/MaximalSubgroups.lean`, both still open on master on 2026-08-06,
  and the general wreath product borders `RegularWreathProduct.lean`. All three are built here,
  named and shaped as those files name and shape them, so that a Mathlib version would replace
  ours by deletion and an import. Follow his vocabulary (`IsPreprimitive`, `IsBlock`)
  throughout. We found no Zulip thread claiming any of them as of 2026-08-06; the discussion
  trail in this area is his pull-request review threads. Where an upstream API is still open,
  this roadmap states what it needs and does not predict where the upstream design will land.
- **C. Birkbeck's certification line** is the downstream consumer of Layer 8.
  `CBirkbeck/CertifyingInvariantsNF`, which extends `alainchmt/RingOfIntegersProject`,
  certifies rings of integers, discriminants, signatures, class groups and units through
  per-field results files, and has no Galois-group component; the inspected revision is
  `59ae55dbe49840d26d267a86c3e5c8f4a866d169` (2026-06-30). `CBirkbeck/LeanBridge` links LMFDB
  knowls to Lean declarations through its `DEFINES` macro, and the Layer 6 and 7 label
  predicates are the declarations the `gg.*` knowls should point at. The repository declares no
  licence in its GitHub metadata, and no author has been contacted about reuse: inspect the
  mathematics and the interface shape only, and copy or adapt no code or data without explicit
  permission. The certificate structures of Layer 8 are accordingly native and independently
  written, and nothing here depends on that repository's file format.
- **Tau Ceti, already landed.** `TauCeti/NumberTheory/Multiquadratic/Galois/*` and
  `Multiquadratic/Frobenius.lean`, from the merged Multiquadratic roadmap, prove the
  elementary-abelian instance of exactly the Layer 0 and Layer 5 pattern: `signPattern` as an
  explicit `Gal ↪ (ι → ZMod 2)`, with `exists_isArithFrobAt_multiquadratic`,
  `signPattern_frobenius` and `galoisGroupEquiv_frobenius`, consuming Mathlib's `IsArithFrobAt`
  just as Layer 5 will. Cite it as the worked `(ℤ/2)ⁿ` case, and generalize rather than
  duplicate its bespoke lemmas.
- **Siblings.** The
  [Number Field Arithmetic roadmap](https://github.com/roed-math/TauCetiRoadmap/pull/9)
  supplies Layer 5's Dedekind theorem and consumes Layer 0's dictionary, Layer 3's discriminant
  comparison, and the labels. That is the one place the two meet, in each direction.
  [Modular Forms](../ModularForms/README.md), Layer 9 consumes the Layer 8 checker. The planned
  Artin Representations roadmap will consume the labels and the certificates. The
  [representation-theory family](../RepresentationTheory/README.md) owns abstract-group data
  such as character tables. LFunctions owns Chebotarev, which is the one theorem people expect
  to find here and which is deliberately elsewhere.
- **Licensing and migration.** Nothing is ported from GPL sources. The LMFDB generator tables
  are mathematical data, re-exported and re-verified under the discipline pinned in the
  conventions and cited to their publications and to the LMFDB, and PARI and GAP outputs were
  used only as cross-checks, never as code. Register intentions through the repository's claims
  process before substantial pushes.
