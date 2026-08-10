# L-functions: provenance, ecosystem audit, and coordination

Supporting material for [`README.md`](README.md), which is the specification. **Nothing here
is normative.** No milestone of the roadmap depends on anything in this file. It records three
things: what the surrounding Lean ecosystem contained when the roadmap was written, whose work
the roadmap sits next to, and what has to be discussed with whom. All of it goes stale.

Audit date **2026-08-07**. The project pin is `9caeba1000` (Mathlib, 2026-06-03). Statements
about Mathlib master are dated 2026-08-07.

**The ecosystem gaps the README opens with also held on Mathlib master on 2026-08-07**, except
where that list marks otherwise: no L-function data model, no Dedekind continuation or functional
equation, no Hecke L-functions, no Landau or Tauberian theorem, no Chebotarev, and no L-series
connection for modular forms. That is dated status, so it lives here and not in the
specification.

## Prior art, and why none of it is a prerequisite

The roadmap's rule is in [`README.md`](README.md#how-prerequisites-are-recorded). A prerequisite
must be a Mathlib declaration, a Tau Ceti declaration, an earlier milestone, or a named layer of
another roadmap. An external repository is none of those. Three pieces of external work are
close to material in this roadmap, and each is treated the same way: cite it, coordinate with
its authors, and make the corresponding statement a milestone here.

- **Wiener–Ikehara.** Proved sorry-free in PrimeNumberTheoremAnd as `WienerIkeharaTheorem'`, in
  `Wiener.lean`. It is Layer 9.1 of this roadmap. Either integrate that proof with the authors'
  agreement, or prove the theorem here in the same shape. Layer 9.1 fixes the hypotheses, so a
  later swap is an import.
- **Chebotarev.** Proved sorry-free in `CBirkbeck/AINTLIB`, and being rebuilt under human review
  in `CBirkbeck/chebotarev-density`. It is Layer 8D.5 of this roadmap.
- **The Dirichlet density predicate.** Now in Mathlib master, so it is a Mathlib declaration and
  not external. The pin does not have it, so Layer 8A.1 builds it in Mathlib's shape.

## Migration: what a later supplier would replace, and how

**None of this is normative.** This section records the dated state of the ecosystem around the
roadmap, and the migrations it has already made.

**The three carrier migrations are DONE, 2026-08-09**, from the group review of the open
roadmaps, which ruled that constructing the carriers here was duplicate ownership rather than
independence. The README's contract sections are the normative record; this is the dated context.

- **Layers 1.7 and 5.1.** The prediction below was right, and the migration cost what it
  predicted. `Modulus`, `RayClassGroup`, `idealClass`, `classMap`, `finiteUnitsMap`,
  `finite_rayClassGroup` and `RayClassCharacter` with `induced`, `IsPrimitive` and
  `not_isPrimitive_one` are Global Class Field Theory's, and the aliases here are reducible
  abbreviations of them. Every statement of 5.2 to 5.9 stood unchanged, because they are stated
  in terms of the derived `weight` and of `→*` operations — which is why aligning the two
  vocabularies early was worth doing. The supplier gained the names in one commit; none of its
  statements moved. The character vocabulary should still be aligned with Mathlib #40735 and
  #40736.
  ⚠ One adapter was genuinely needed and is owned here: the supplier types the infinite part of a
  modulus by **real places**, as a subtype, and the archimedean data of Layers 5 and 6 is indexed
  by all infinite places. `Modulus.realPlaces` is the image, defined from the supplier's field.
- **Layer 6.1.** Migrated differently from the prediction, and better. The carrier here is not an
  adapter to `HeckeCharacter`: it is a **presentation** of one, in the sense of Neukirch VII
  (6.9), with `toHeckeCharacter` to the object presented, `toHeckeCharacter_shift` against the
  supplier's 3.5 decomposition, `exists_presentation` for the surjectivity half of (6.9), and
  `toHeckeCharacter_ofRayClassCharacter` tying it to Layer 5. The warning below held: the
  presentation keeps the unitary weight and the full weight apart and carries the finite
  character, and every correction recorded further down survives in its fields. The idele-side
  dictionary in the shape of Mathlib #40736 is (6.11) to (6.14).
- **Layer 8.0.** `chosenPrimeOver` and `mem_frobeniusClass_iff` are **deleted**. `frobeniusClass`
  is defined as Number Field Arithmetic's `artinSymbol`, and `frobeniusClass_restrictNormalHom`
  and `isArithFrobAt_pow_inertiaDeg` are closed proofs of that roadmap's
  `artinSymbol_map_restrictNormalHom` and `exists_isArithFrobAt_pow_inertiaDeg`, which its Layer
  2.4 had promised in prose and now names. Everything in 8A to 8E is stated against
  `frobeniusClass` and takes no interface parameter, so the only other change is that the
  unramifiedness proof became an argument of the definition and the density sets became
  dependent existentials — a total class would need a junk value at ramified primes, and every
  density set would have silently contained it.
- **Layer 8A.1.** `primeIdealZetaSum` and `HasDirichletDensity` are built in the exact shape of
  Mathlib's `NumberTheory/NumberField/DirichletDensity.lean`, namespace `NumberField.Set`. When
  the project pin advances past that file, delete the two definitions here and import Mathlib's.
- **Layer 9.1.** Wiener–Ikehara is written to match PrimeNumberTheoremAnd's
  `WienerIkeharaTheorem'`, so an agreed integration is an import and not a rewrite.
- **Merge order.** This roadmap is executable on its own. Where a merge order matters for the
  adapters above, it is recorded in the pull request description and not here.

## Coordination the specification does not carry

The README states mathematics and nothing else. These are the conversations that should happen
around it, and none of them is a prerequisite of any milestone.

- **Before Layer 5**, the ray-class character vocabulary is settled: it is Global Class Field
  Theory's, consumed by name, and the README's contract section is the list.
- **Before Layer 6**, the same for milestone 6.1: the Hecke character is that roadmap's, and what
  is built here is a presentation of one.
- **Before Layer 8**, contact the people working on Chebotarev in Lean, listed below.
- **Before Layer 9**, contact PrimeNumberTheoremAnd about Wiener–Ikehara, milestone 9.1.
- **Milestone 8E has one proof**, the analytic one. The classical second proof runs through Artin
  reciprocity, and therefore through class field theory, which is not a prerequisite of this
  roadmap. Once the global class field theory roadmap is accepted, proving 8E both ways and
  comparing them is the one place where this roadmap's arithmetic-Frobenius convention and that
  roadmap's reciprocity normalization could be caught disagreeing. That comparison is worth
  doing, and it is not a milestone here.
- **The shared table with the integral lattices roadmap** fixed six names. An earlier copy
  disagreed with that roadmap's `GaussianThetaInterface` on two rows. Settled 2026-08-07 in a
  coordinated edit of both roadmaps: the table carries a biduality row, milestone 2.2 here,
  and no Poisson-summation row, because that roadmap does not consume Poisson summation;
  milestone 2.6 stays a target of this roadmap with no row. The carrier of the crossing is
  that roadmap's bundled analytic lattice. The same settlement fixes the theta division: this
  roadmap owns the real-parameter Gaussian theta, its transformation, and Poisson summation; the
  holomorphic theta on the upper half-plane and its modular transformation law are that
  roadmap's Layer 8. Neither roadmap states the other's half.

  ⚠ **History of the block, and the open coordination.** It carried six rows and was
  byte-identical in both `README.md` files. The corrected milestone 2.11 compares the analytic
  dual of an ideal lattice with the **trace** dual, through `traceToEuclidean` and
  `FractionalIdeal.dual`, and no dual of an integral bilinear form appears anywhere in Layers
  2.10 to 2.13, so these two reverse rows recorded a dependency this roadmap does not have:

  | L-functions Layer 2, items 10 to 13 | Integral Lattices 1B | the dual lattice of an integral bilinear form, and the vocabulary for it | `IntegralLattice.dual` |
  | L-functions Layer 2, items 10 to 13 | Integral Lattices 8D | the analytic dual of the realization of `L` equals `IntegralLattice.dual` | `IntegralLattice.analyticDual_eq_dual` |

  They are deleted, together with the clause "and L-functions items 10 to 13 use 1B and 8D" of
  the closing paragraph, and the normative README now states only the durable fact that the
  dependency is one-way, with the four exported names. `IntegralLatticeInterface`, the
  compatibility structure that carried those two rows in `Suggested.lean`, is deleted with them.
  The crossing that roadmap consumes — items 1, 2, 3, and 8 — is untouched.

  **Open with the integral lattices roadmap**, and not resolvable from this branch: its copy
  still advertises the six-row byte-identical block. Either it deletes the same two rows and the
  same clause, or the two roadmaps agree that this table is an export list owned here and drop
  the byte-identity convention. Until then, treat this copy as authoritative for what crosses,
  because the reverse rows are the ones that are mathematically wrong.
- **A downstream consumer cites this roadmap by declaration name**, which is why the targets in
  `Suggested.lean` that a growth-theoretic development would consume are named `sorry`-definitions
  with their characterizing theorems beside them, and not anonymous `example`s stating an `∃`:
  the record and its dual (`AnalyticLFunctionData`, `.dual`, and the transport theorems),
  `NormalizationTranslation` with `degree_eq`, `existsUnique`, `hasFunctionalEquation_iff` and
  the two tests, `dedekindZetaC` and `completedDedekindZeta` (Layers 3.6 and 3.7) with
  `analyticAt_dedekindZetaC`, `analyticOnNhd_dedekindZetaC`, `analyticAt_completedDedekindZeta`
  and `analyticOnNhd_completedDedekindZeta`, the Hecke family `heckeLFunctionC`,
  `completedHeckeLFunction` and `heckeRootNumber` (Layers 5.3, 5.7 and 5.8), the two
  factorizations at the continued level (`dedekindZetaC_quadratic`, `dedekindZetaC_cyclotomic`),
  `frobeniusClass` with its restriction and tower theorems (Layer 8.0), and the smaller crossings
  `abscissaOfAbsConv_idealCoeff`, `eq_of_meromorphic_of_eqOn_halfPlane`, `three_four_one_nonneg`,
  `idealVonMangoldt_nonneg`, `LSeries_idealVonMangoldt_eq`, and the three nonvanishing statements
  of 7.4. ⚠ An anonymous `example` is not a declaration contract: a consumer cannot cite it,
  import it, or check against it, so anything another development consumes is named here.

  ⚠ Regularity away from the recorded poles is exported as `AnalyticAt` and `AnalyticOnNhd`. The
  earlier contracts `meromorphicOrderAt_dedekindZetaC_nonneg` and
  `meromorphicOrderAt_completedDedekindZeta_nonneg` asserted only `0 ≤ meromorphicOrderAt`, which
  depends solely on the punctured germ and therefore constrains no value; they survive as
  corollaries, and a consumer must not read them as regularity.
- **The dual record is owned here**, as `AnalyticLFunctionData.dual`, with `dual_gammaFactor`,
  `dual_dual`, `dual_degree`, `dual_eq_self`, the three predicate-transport theorems, and
  `hasFunctionalEquation_dual`. ⚠ It belongs here rather than downstream: the functional equation
  of a **non-self-dual** record names a second *record* on its right-hand side, so the roadmap
  that owns the record owns its dual. The zeros roadmap built its own `dualData` so that nothing
  waited; it now consumes this one.

## What is in motion elsewhere

Coordinate and cite. Do not fork.

**Chebotarev is already proved in Lean, outside Mathlib.**

- `CBirkbeck/AINTLIB` proves `Chebotarev.chebotarev_density` in
  `projects/Chebotarev/CebotarevDensity/`, in 15 files, sorry-free. For finite Galois `L/K` and
  a conjugacy class `C`, the unramified primes with Frobenius class `C` have Dirichlet density
  `#C/#G`. The corollaries are `dirichlet_primes_in_AP` and `density_split_completely`.
- Its route is documented in-repo, after Sharifi Thm 7.2.2 and Lenstra–Stevenhagen. It is the
  route of the README's Layer 8: the cyclotomic case by Dirichlet L-functions, then the abelian
  case by crossing with auxiliary cyclotomic extensions, then the general case through the fixed
  field `L^⟨σ⟩`.
- AINTLIB is AI-authored and AI-reviewed by design, with deliberately relaxed standards. It is
  therefore a source of proof structure and not of code. Read
  `CebotarevDensity/{Cyclotomic,Abelian,FixedFieldDensity,Main}.lean` before writing Layer 8.
  Between them they name most of the leaves that 8B to 8D ask for.
- The human-reviewed rebuild is `CBirkbeck/chebotarev-density`. Its `Main.lean` states
  `chebotarev_density` with the proof still `sorry`, while the `ForMathlib` infrastructure lands
  through internal pull requests. **Xavier Roblot and Riccardo Brasca** review those.
- Mathlib **#41765** (riccardobrasca) started the upstreaming with
  `Mathlib/NumberTheory/NumberField/DirichletDensity.lean`. That file is on master now. It has
  the density predicate, and no density theorem.

**Hecke characters and their L-functions have open Mathlib pull requests** (Thomas Browning).

- **#40735** defines the idele class group: `IdeleGroup` and `IdeleClassGroup`, in
  `AdeleRing.lean`.
- **#40736** defines `HeckeCharacter R K := MulChar (IdeleClassGroup R K) ℂ`, in
  `NumberTheory/NumberField/HeckeLFunction.lean`. It also has `IsUnramifiedAt`, `localValue` at
  a uniformizer, `localPolynomial = 1 − χᵥ(ϖᵥ)X`, and `LFunction` as a formal
  `ArithmeticFunction.eulerProduct`. There is no continuity condition on the character yet.
- Both are *formal* Dirichlet series. There is no convergence, no continuation, and no
  functional equation.
- That complementarity is worth preserving. The global class field theory roadmap owns the
  character vocabulary and should align it with these two. Layers 5 and 6 here supply exactly
  the analysis those pull requests omit. Layer 5.2's Euler factor `(1 − χ(𝔭)𝔑𝔭^{-s})⁻¹` already
  agrees with Browning's `localPolynomial`.

**PrimeNumberTheoremAnd** (AlexKontorovich/PrimeNumberTheoremAnd; Zulip channel
`#PrimeNumberTheorem+`) has these results sorry-free in-repo:

- **Wiener–Ikehara**, as `WienerIkeharaTheorem'` in `Wiener.lean`;
- `WeakPNT`, that is `ψ(x)/x → 1`, and `WeakPNT_AP`, `WeakPNT_character`;
- `MediumPNT`, that is `ψ(x) = x + O(x·exp(−c (log x)^{1/10}))`;
- the `Consequences.lean` package: `chebyshev_asymptotic`, `pi_asymp`, `mu_pnt`, `dirichlet_thm`.

The classical-error `StrongPNT` there is an in-progress port of `math-inc/strongpnt`, an
AI-generated formalization frozen in 2025-09. It is cited as provenance of that port and never
consumed. Upstreamed from the project so far: `Chebyshev.lean` (#32281), `ZetaZeros.lean`
(#37328), logarithms of L-function Euler products (#41097, merged after the pin), and
Costa–Pereira (#40569). Mertens' three theorems are **#41394** (teorth). Chebotarev appears
there only as an informal blueprint, in `blueprint_comment` sections of `Wiener.lean`, on the
same route as Layer 8.

**Mathlib master since the pin, on the L-series line.**

- **#41329** (Loeffler, merged 2026-07-04) reworked `AbstractFuncEq` around a predicate
  `IsStrongFEPair`. Layer 2.14 is specified against that shape.
- #41097 (Tao) added Dirichlet series for the logarithm of an L-function.
- #40127 (Meiburg) gave zeta through `completedRiemannZeta₀`.
- #41133 (merged) and #42101 give conjugation symmetry of the completed `riemannZeta`. They
  support Layer 0.1's convention `Λ^∨ = conj ∘ Λ ∘ conj`.
- #41251 (Birkbeck, merged) added the abstract `HeckeRing` of double cosets. The #41253 to
  #41328 stack is open.
- #40540 adds the Riemann xi function.
- Nothing on Dedekind zeta continuation, and nothing on Tate's thesis, has landed or is open.
  Post-pin commits to `dedekindZeta` are refactors, and its TODO is unchanged.
- Roblot's open decomposition and inertia-field stack (#35808, #35991, #36733, #36843, #37031,
  #41591) is the groundwork that Layer 8 and the number field arithmetic roadmap sit on.

**Sibling roadmaps.**

- The [modular forms roadmap](../ModularForms/README.md) merged on 2026-08-02. Its Layer 7
  delivers convergence with abscissa `≤ k/2 + 1` for cusp forms, the Euler product
  `∏_p (1 − aₚp^{-s} + χ(p)p^{k−1−2s})⁻¹`, the completed `Λ_N` by Mellin transform, the two-form
  equation `Λ_N(k − s, f) = i^k Λ_N(s, g)` with entirety and continuation, the sign through
  Atkin–Lehner, and the analytic conductor of Iwaniec–Kowalski (5.7).
- The elliptic curves roadmap ([PR #68](https://github.com/roed-math/TauCetiRoadmap/pull/68))
  has no L-function layer, by choice. Its Hasse-bound and conductor material could later supply
  raw series data. It supplies no continuation and no functional equation.
- Modular curves ([#81](https://github.com/roed-math/TauCetiRoadmap/pull/81)) and adic spaces
  ([#80](https://github.com/roed-math/TauCetiRoadmap/pull/80)) are disjoint neighbours.

**FLT** (ImperialCollegeLondon/FLT) has no L-functions and no classical modularity statement.
Its modularity notion is `GaloisRep.IsAutomorphicOfLevel`: quaternionic, over totally real
fields of even degree, and self-described as far more restrictive than the literature's. FLT
therefore supplies no elliptic-curve continuation and no functional equation. That is why the
instance ledger of Layer 0.7 has no elliptic-curve row. FLT's adele and Haar infrastructure is
being upstreamed, for example #40535, merged 2026-07-29. An adelic treatment of the functional
equation would need it, and the README puts such a treatment out of scope.

**MichaelStollBayreuth/EulerProducts** is in maintenance mode. Its content has been frozen since
early 2025, with Mathlib bumps only. Its README says most results have reached Mathlib. Still
unlanded: the `PNT.lean` reduction of asymptotic Dirichlet to Wiener–Ikehara. It is the
historical provenance of `LSeries/`, `EulerProduct/`, `Nonvanishing.lean`, and `PrimesInAP.lean`.

### Corrections worth passing on

**The dual of an ideal lattice.** Milestone 2.11 of the README used to assert that the analytic
dual of `mixedEmbedding K '' I` is `mixedEmbedding K '' (I𝔡)⁻¹`. That is false: the trace pairing
and the Euclidean inner product on the mixed space differ at the complex places. For `K = ℚ(i)`
and `I = 𝓞_K` the mixed lattice is `ℤ[i] ⊂ ℂ`, which is Euclidean self-dual, while the trace dual
is `(1/2)ℤ[i]`. The two are related by the map `traceToEuclidean` that is the identity on real
coordinates and `z ↦ 2 conj z` on complex ones. Milestone 2.11 now owns that map.

Any roadmap that realizes an ideal lattice in Euclidean space and compares its dual with a
bilinear dual meets the same factor. It is worth telling the integral lattices roadmap, whose
milestone 8D compares an analytic dual with `IntegralLattice.dual`.

**The determinant of that map.** The README used to record it as `2^{r₂}`. That is wrong. Over
`ℝ`, one complex coordinate contributes `(a, b) ↦ (2a, −2b)`, of determinant `−4`, so the
determinant is `(−4)^{r₂}` and its absolute value is `4^{r₂} = 2^{2r₂}`. The covolume identity is
the check: with `covolume (σI) = 2^{-r₂}√|d_K| 𝔑I` and `𝔑𝔡 = |d_K|`, the product
`covolume(σI) · covolume(dual(σI))` equals `|det| · 2^{-2r₂}`, and biduality forces
`|det| = 4^{r₂}`. At `K = ℚ(i)`, `(1/2)ℤ[i]` has covolume `1/4` and its image `ℤ[i]` has covolume
`1`. Milestones 2.11, 2.12, 2.13, and 3.1 thread the corrected power.

**The Mertens product constant carries the Dedekind-zeta residue.** The README used to assert
`∏_{𝔑𝔭 ≤ x}(1 − 𝔑𝔭^{-1})^{-1} ∼ e^{γ} log x`. Over a general number field the constant is
`e^{γ} κ_K` with `κ_K = Res_{s=1} ζ_K(s)`; the familiar form is the case `K = ℚ`, where
`κ_ℚ = 1`, so the error is invisible to every rational check. Rosen, and Garcia–Lee Theorem 1,
are the sources. Any roadmap that states Mertens over a number field meets the same factor.

**The Frobenius fibre coefficient filters by `Frob_𝔭^m = σ`, not `Frob_𝔭 = σ`.** The logarithmic
derivative of the Euler factor at `𝔭` is `∑_{m ≥ 1} χ(Frob_𝔭)^m log 𝔑𝔭 · 𝔑𝔭^{-ms}`, so character
orthogonality isolates the `m`-th power. The witness is a quadratic cyclotomic extension: at an
inert `𝔭` the Frobenius is the nontrivial `g` while `g² = 1`, so the `𝔭²` term belongs to the
identity fibre. The version filtered on `Frob_𝔭 = σ` is nonnegative, but it is not the sequence
the logarithmic derivatives produce, so the orthogonality identity is not provable for it.

**The `3-4-1` argument needs the trivial-square branch, not cancellation of the square.** A
nonvanishing package that demands `HasCancellation (χ²)` excludes every quadratic character, whose
square is trivial on the good ideals, and also `η 𝔑^{iu}` with `η` quadratic and `u ≠ 0`, which
is unitary of infinite order and whose square is trivial after the twist by `−2u`. The condition
is a dichotomy at each boundary twist: trivial-on-good, or cancelling. The trivial branch is
Landau's argument on `ζ_K(s)L(χ_t,s)`, which is why Landau's theorem is a milestone at all.

**A nonunitary Grossencharacter reflects against its inverse, not its conjugate.** With
`χ = χ_unit·𝔑^σ` the conjugate keeps the real shift `σ` while the reflection at `1 − s` needs
`−σ`. The pure norm character `χ = 𝔑^σ` is the witness: `Λ_χ(s) = Λ_K(s−σ)` has poles at `σ` and
`1+σ`, and `Λ_χ(1−s)` has poles at `−σ` and `1−σ`. The correct forms are
`Λ(χ,s) = W Λ(χ⁻¹, 1−s)` and `Λ(χ,s) = W Λ(χ̄, 1+2σ−s)`, equivalent because `χ⁻¹ = χ̄·𝔑^{−2σ}`.
The same shift is why the full quasicharacter is not an analytic-normalized data record: its
coefficients converge only for `Re s > 1+σ`, and conjugating them does not move the shift.

**A compatibility law must not mix unitary and non-unitary factors.** A Grossencharacter carrier
whose finite factor carries `𝔑^{σ}` while its archimedean factors have absolute value `1` forces
`σ = 0`, so it contains no character with a nonzero real shift. Witness: `K = ℚ`, modulus `1`,
`χ = 𝔑^{σ}`, where the law reads `χ_unit((n))·n^{σ}·n^{it} = 1` with two unit-modulus factors.
The fix is to store *unitary* archimedean data — parity `ε_v`, angular exponent `m_v`, parameter
`t_v` — and state compatibility on the unitary components alone, making the algebraic pair
`(p_v,p̄_v)` a derived predicate via `σ = (p+p̄)/2`, `m = p̄−p`. Any roadmap that carries an
infinity type alongside a norm shift meets the same trap, and the test that catches it is simply
constructing `𝔑^{σ}`.

**A shifted completion has to be defined by recentering.** With `A` the conductor,
`Λ_unit(s) = A^{s/2}γ(s)L_unit(s)` and `L_full(s) = L_unit(s−σ)` together force
`Λ_full(s) = Λ_unit(s−σ)`, whose conductor power is `A^{(s−σ)/2}`. Writing `Λ_full(s) = A^{s/2}γ(s)L_full(s)`
as well is inconsistent by a factor `A^{σ/2}` and a gamma shift, and the Layer 0 card built from
it satisfies no Dirichlet agreement.

**The root-number involution is `W(χ⁻¹) = W(χ)⁻¹`.** Applying the functional equation twice gives
`Λ_χ(s) = W(χ)W(χ⁻¹)Λ_χ(s)`. The plausible `conj(W(χ))⁻¹` equals `W(χ)` and would force
`W² = 1`, which general Hecke root numbers do not satisfy.

**The square of a boundary twist has three cases, not two.** For `χ = η·𝔑^{iu}` with `η`
quadratic, `(χ𝔑^{it})² = 𝔑^{2i(u+t)}` is trivial only at `t = −u` and is a *nontrivial* norm twist
elsewhere — and those do not cancel: `∑_{𝔑𝔞≤X} 𝔑𝔞^{iv} = ρ_K X^{1+iv}/(1+iv) + O(X^{1−1/d})`, of
magnitude `≍ X`. So a trivial-or-cancelling dichotomy is still too weak; the condition is
norm-twist-or-cancelling, with the `v ≠ 0` branch handled by nonvanishing of a vertically shifted
`ζ_K`. The character to exclude from such a package is a pure norm twist, not merely a trivial
one: `𝔑^{iu}` is nontrivial on good ideals but its twist by `−u` is trivial.

**Inversion and conjugation act differently on the infinity type, and neither negates real
parity.** At a real place the unitary local character `sgn(x)^{ε}‖x‖_v^{-iq}` has
`sgn(x)^{-1} = sgn(x)`, so the parity `ε` is fixed by both, and negating it would leave
`ε = −1`, outside `{0,1}` — the inverse of every odd real character would be uninhabitable; what
inversion negates at a real place is the shift. At a complex place inversion sends
`(p,p̄) ↦ (−p,−p̄)` while conjugation **swaps**, `(p,p̄) ↦ (p̄,p)`, since
`conj(z^{-p}z̄^{-p̄}) = z^{-p̄}z̄^{-p}`; both send `q ↦ −q`. The two agree only when `p = p̄`.

**A Hecke functional equation is a primitive-character statement, and the polar exception is the
norm quasicharacters.** The principal character modulo a prime `p` over `ℚ` inhabits an
unrestricted Grossencharacter carrier with trivial infinite data and shift `0`, and has
`L(s) = ζ(s)(1−p^{-s})`, still with a pole — so an entirety claim for every term is false, and an
exception keyed on the modulus misses it. Separately, `𝔑^{iu}` with `u ≠ 0` is nontrivial on good
ideals and has a pole at `1+iu`, so an exception keyed on real powers misses it too.

**`HasDirichletAgreement` does not determine the degree.** It leaves `gammaR`, `gammaC` and
`completed` free: for one coefficient function, choose extra gamma factors and define `completed`
by the displayed agreement on `Re s > 1`, and the record has any positive degree. A card's degree
has to be computed from its gamma multisets, so the card must be constructed with them.

**A finite character family cannot contain a Grossencharacter.** A package indexed by a
`Fintype` forces every good value of every member to satisfy `x^{#G} = 1`, hence to be a root of
unity, because some positive power of each index element is `1`. A unitary Grossencharacter with a
nonzero archimedean parameter, and every norm twist `𝔑^{it}` with `t ≠ 0`, has infinite order.
Any roadmap that packages nonvanishing hypotheses over a finite character group has to state a
second package for the infinite-order case, or its Grossencharacter export is empty.

**The Grossencharacter boundary is `Re s = 1 + shift`.** From `χ = χ_unit · 𝔑^{σ}` the two
Dirichlet series satisfy `L(χ, s) = L(χ_unit, s − σ)`, so the edge of the critical strip moves.
A nonvanishing statement at `Re s = 1` for the full quasicharacter is correct only when `σ = 0`.

**One-dimensional characters separate only the abelianization.** An orthogonality identity that
isolates `Frob_𝔭^m = σ` needs the Galois group abelian. Over `S₃` every one-dimensional character
agrees at the identity and at a three-cycle, so the character sum returns `1` where the indicator
returns `0`. The same statement also needs the character's ideal weight to *vanish* at the primes
excluded from the coefficient, which is why the weight is constructed rather than specified only
at the unramified primes.

**A Grossencharacter whose full weight is an `IdealWeight` forces `shift = 0`.** The Layer 6.1
structure used to carry the full weight `χ` as an `IdealWeight` *and* assert
`χ = χ_unit · 𝔑^{shift}` with `χ_unit` unitary. `IdealWeight.norm_eq_one` gives `‖χ(𝔭)‖ = 1` at
every prime off the finite bad set, so the decomposition forces `𝔑𝔭^{shift} = 1` at cofinitely
many primes and hence `shift = 0`. The structure could therefore be inhabited only by the
finite-order characters of Layer 5, which is exactly the case Layer 6 exists to go beyond. The
unitary part is now the `IdealWeight`, and the full quasicharacter is defined from it and the
shift. Any sibling roadmap that stores an infinity-type carrier meets the same trap.

**A compatibility law without the finite character empties the carrier of ramified characters,
and restricting it to the ray admits non-characters.** The law
`χ_unit((α)) · ∏_v χ_v(α) = 1` over all coprime `α` forces, for a nontrivial even Dirichlet
character mod `5` at `α = 2`, the false `χ(2) = 1` — so only finitely-unramified characters
inhabit the carrier and every finite-order comparison quantifies over nothing. Weakening the
quantifier to `α ≡ 1 mod^× 𝔪` instead admits the pair (trivial weight, parity `1`) over `ℚ` mod
`∞`, which is no idele-class character and whose would-be completion `Γ_ℝ(s+1)ζ(s)` has no clean
functional equation. Neukirch VII (6.9) is the resolution: carry the finite character `χ_f` of
`(𝓞_K/𝔪₀)ˣ` as a field and state the law with it over **every** coprime `α`. Admissibility on
the units then stops being a field (it is the unit case of the law), and the witness that the
law is satisfiable in the ramified case is the embedding of every ray-class character. Any
carrier that glues an ideal weight to archimedean data meets the same two-sided trap, and only
constructing a ramified example detects the first side.

**The archimedean radial sign, the compatibility law, and the gamma shifts are one convention
with three visible ends, and the absolute value must be normalized.** With the law
`χ_unit((α)) · χ_f(α) · ∏_v χ_v(α) = 1` and gamma shifts `ε_v − it_v`, `|m_v|/2 − it_v`, the
radial part of the local character must be `‖x‖_v^{-it_v}` with the **negative** sign and
`‖x‖_v = (v x)^{mult v}` the **normalized** absolute value. Witnesses: over `ℚ`, the unitary
norm twist `𝔑^{iu}` gets `t = u` and gamma shift `−iu`, as `Γ_ℝ(s − iu)ζ(s − iu)` requires —
with the positive sign the factor `Γ_ℝ(s + iu)` puts no pole at `iu` and infinitely many on
`Re s < 0`, so the card's polar divisor and continuation predicate fail; over `ℚ(i)`, the
un-normalized `v x` forces `t = 2u` and shift `−2iu` against the `ζ_{ℚ(i)}(s − iu)` the series
is. A card equality can be green in one convention and false in the other, and only the two
small fields see it.

**The infinity type relates to the shift, not the parity.** At a real place the dictionary is
`σ = p_v` (with `p̄_v = 0`); a clause `p_v = ε_v` confines the pair to `{0,1}` and rejects `𝔑²`,
and the repaired `ε_v ≡ p_v (mod 2)` still rejects `𝔑³`, the cube of the Tate character, whose
parity is `0`: the full local character agrees with `x^{-3}` on the positive reals, where the
infinity type lives, and the `sgn(x)` discrepancy on the negatives is finite-part data. The `A₀`
predicate needs both clauses — vanishing parameters **and** an integral pair — or `𝔑^{√2}`
passes. At a complex place the dictionary `2σ = p_v + p̄_v`, `m_v = p̄_v − p_v` is exact, with no
sign subtlety, because `ℂ^×` is connected.

**Primitive uniqueness is an equality of bundles, and the canonical card must be built from the
primitive character.** A uniqueness statement whose conclusion repeats a field of one bundle and
never mentions the other proves only conductor uniqueness, and two primitive characters of one
conductor could both claim the reduction. And pairing the primitive conductor with the presented
imprimitive coefficients in one record asserts a functional equation the removed Euler factors
falsify: the principal character mod `p` presents `ζ(s)(1 − p^{-s})`, whose canonical card is
the ζ card and whose presented series gets no card. The dual-card comparison
`(χ⁻¹)`-card `=` dual of `χ`-card is a theorem of the layer, not a caller-supplied hypothesis,
or the Layer 0 functional-equation bridge is conditional everywhere downstream.

**A vertically shifted zeta card carries two `|d_K|`-constants.** Including the conductor power
`A^{s/2}` in the completion forces the `𝔑^{iu}` card to complete to
`|d_K|^{iu/2} · Λ_K(s − iu)` and to carry root number `|d_K|^{iu}` — not `1`. Both constants are
invisible over `ℚ`, so only a field with `|d_K| ≠ 1` tests them.

**A modulus datum no structure field reads is not part of the structure, and primitivity is
where it shows.** A Grossencharacter carrier over a modulus with an infinite part, none of whose
fields mention that infinite part, makes every term induced from the modulus with the same
finite part and empty infinite part: nothing with `𝔪_∞ ≠ ∅` is primitive, the primitive odd
character modulo `4` over `ℚ` satisfies no primitivity hypothesis at its Layer 5 modulus
`(4)∞`, and the Layer 6 conductor silently drops the real place whose `Γ_ℝ(s+1)` it owns. The
law that repairs it is parity support — `ε_v = 1` only at `v ∈ 𝔪_∞` — with the converse
statement (the infinite part of a *primitive* modulus is exactly the parity support) as the
theorem. Any carrier indexed by a modulus should be audited for fields that never read a
component of the index.

**A finite character off its units is either the canonical zero or junk, and only `MulChar`
makes it the former.** A bare `→* ℂ` carries nonunit values no law observes, so bundle equality
compares junk; Gauss sums range over the residue ring and need the zero extension, since any
other extension changes the sum; and inflation along a divisor is a **units-pullback re-extended
by zero**, not composition with the residue projection — the projection carries nonunits to
units (`3 mod 6 ↦ 1 mod 2`), so composing inflates the conductor-one character to the all-one
map where the inflated character vanishes. The induction relation must carry the exact
finite-character square along the named residue-units map, or it transports every datum the
Gauss sum reads except the one it evaluates.

**Primitive scope belongs in the types, not the prose.** A completion or card whose formula
pairs the conductor with the presented series names one L-function exactly for a primitive
character; taking the primitivity proof as an argument of the definitions makes the imprimitive
hybrid — `|d_K|^{s/2} γ(s) ζ_K(s)(1 − 𝔑𝔭^{-s})` for the principal character modulo `p` —
inexpressible rather than deprecated. The finite-order root-number comparison needs **both**
sides primitive: the presented Gauss sum of an imprimitive character vanishes under the usual
definition while the primitive-conductor root number does not, so an unrestricted comparison
equates two different objects.

**A multiplicative weight must be forced to vanish at the zero ideal, or primitive reduction
is not unique.** Multiplicativity admits the constant-one function on ideals, which differs
from the trivial weight **only at `⊥`** — and every coprimality-guarded law is blind there,
since coprimality predicates exclude `⊥`. Two weights differing only at `⊥` give two unequal
primitive bundles both inducing the same character, so a bundle-equality uniqueness theorem is
false however carefully the rest of the carrier is normalized. The fix is a carrier law
`toFun ⊥ = 0`, discharged by every constructor, with the constant-one rejection as a
closed-proof test; the residual `n = 0` mismatch against `idealCoeff`, which counts the zero
ideal, remains and is why the card-agreement predicate compares coefficients off `0`. This
closes the junk-slot family: `MulChar` forces the finite character's nonunit values, and the
zero-ideal law forces the weight's value at `⊥`.

**A card's conductor field is an arithmetic invariant, not a presentation level.** Unlike
continuation or the functional equation, the conductor has no separate predicate that later
certifies it, so a card constructor accepting imprimitive characters records the wrong
invariant silently — the principal character at `𝔪₀ = (p)` gets level `|d_K| 𝔑𝔭` where its
arithmetic conductor is `|d_K|`. Any named instance card must take the primitivity proof as an
argument (or be defined through canonical primitive reduction); the imprimitive character keeps
its presented L-function and Euler-factor correction, and no card.

**A conditional instance theorem tests nothing about existence.** "For every primitive
character of this modulus, its card is …" is true when the carrier accidentally trivializes the
quotient or empties primitivity, so it cannot serve as a non-vacuity acceptance test. The
regression instances must be **constructed by name** — modulus, character, value specification
against an independently constructed object (here Layer 4's `χ₄` and the quadratic residue
symbol mod `5`), and primitivity as named theorems — so that an accidental collapse breaks a
named declaration rather than emptying a quantifier.

## Coordination ledger

No outreach had been performed when this was written. Every contact status below is therefore
*uncontacted*, and every ownership statement is a proposal and not an agreement.

| Project | Revision or pull request at audit | Licence | Overlap | Contact status |
|---|---|---|---|---|
| Mathlib L-series, Dedekind zeta, Hecke work (Loeffler, Stoll, Roblot, Browning) | pin `9caeba1000ef8f302920981f4a08651d325abc81`; #40735 at `ba5cc46884`; #40736 at `0355daa48a`; #41765 at `7478e24828` | Apache-2.0 | completed-L conventions, Hecke-character and formal Euler-product vocabulary, Dedekind zeta continuation, Dirichlet density | not contacted |
| CBirkbeck/AINTLIB and CBirkbeck/chebotarev-density (Birkbeck; rebuild reviewed by Brasca and Roblot) | AINTLIB `1c1c74664e`; rebuild `c64095e6cc` | Apache-2.0 | Chebotarev without class field theory, and its density calculus | not contacted |
| thefundamentaltheor3m/Sphere-Packing-Lean and math-inc/Sphere-Packing-Lean | `bad3de9160`; math-inc `1e98fb4930`; sphere-packing PR #341 at `a604233089` | Apache-2.0 | the general `ZLattice` Poisson theorem, and the Gaussian theta transformation | not contacted |
| AlexKontorovich/PrimeNumberTheoremAnd (Kontorovich, Tao, Irving, and others) | `21998bb619`; Mathlib Mertens #41394 at `a4221cb335` | Apache-2.0 | Wiener–Ikehara, prime counting, natural-density upgrades | not contacted |
| ImperialCollegeLondon/FLT (Buzzard and others) | `d18b563029` | Apache-2.0 | adelic and Haar substrate; no elliptic-curve modularity and no L-function theorem | not contacted |

Proposed division of labour, to be confirmed with each project:

- Mathlib keeps the core vocabulary and the formal series. Tau Ceti builds the continuation, the
  functional equations, and the density theory. Where a Mathlib pull request fixes a spelling,
  Tau Ceti adopts that spelling. When one merges, the Tau Ceti declaration is deleted and
  Mathlib's is imported.
- The Chebotarev line keeps its own development. Layer 8 is independent work on the same route.
  It cites both repositories, and copies no code without the authors' agreement. If the rebuild
  reaches Mathlib first, Layer 8 becomes a comparison-and-adopt task. The value of this roadmap
  then concentrates in Layer 9 and in the consistency theorem of 8E.
- Poisson summation for a general `ZLattice` should have one home. It serves this roadmap, the
  integral lattices roadmap, and the sphere-packing project. Seek that shared home before
  building. Do not port the sphere-packing Gaussian proof without permission.
- PrimeNumberTheoremAnd keeps the Tauberian theorems and the rational prime number theorem.
  Layer 9.1 is written to match `WienerIkeharaTheorem'`, so that an agreed integration is an
  import and not a rewrite.

## Lines of work this roadmap continues

**The Loeffler–Stoll line**: `Mathlib/NumberTheory/LSeries/`, `EulerProduct/`,
`Gamma/Deligne.lean`, and `AddCircleMulti.lean`. The design paper is arXiv:2503.00959, Annals of
Formalized Mathematics 1 (2025) 43–56. Layers 2 and 3 extend their functional-equation frame
along the `AbstractFuncEq` TODO, using the multivariate Fourier step their `AddCircleMulti`
staged. Layer 7 generalizes their `Nonvanishing.lean`. Layer 0.6 keeps the completed-L
convention translatable to their `completedLFunction` normalization. Layer 3's Dedekind
functional equation is the next chapter of their programme, and is worth telling them about.

**The Roblot line**: `DedekindZeta.lean`, `Ideal/Asymptotics.lean`, and
`CanonicalEmbedding/FundamentalCone.lean`, from PR #17914, merged 2025-05-18; the cyclotomic
Galois file `Cyclotomic/Galois.lean`; the open decomposition and inertia-field stack; and the
review of the chebotarev-density rebuild. Layers 1 and 3 sit on this machinery and discharge the
`DedekindZeta.lean` TODO. Layer 1.6's counting estimate with error term `O(x^{1−1/d})`
strengthens his limit-only asymptotics, and is worth designing with him. Contact him before
Layers 1, 3, and 8.

**The Browning line**: `ArithmeticFunction/LFunction.lean` and `EllipticCurve/LFunction.lean` at
the pin; #40735 and #40736; and `RingTheory/Invariant`. Layers 5 and 6 supply the analysis over
his formal Hecke L-functions. His `ArithmeticFunction.eulerProduct` and `Northcott` formalism
and Layer 1.4's analytic Euler products are related by a comparison lemma, and not duplicated.
The existing `WeierstrassCurve.LSeries` is recorded as prior art only.

**PrimeNumberTheoremAnd.** Layer 9.1 matches their Wiener–Ikehara, and Layer 9.6 is checked
against `pi_asymp`. Track #41394 for the Mertens support of Layer 9.11.

**Sibling Tau Ceti roadmaps.** The [modular forms roadmap](../ModularForms/README.md) owns
modular L-functions. Layer 0.7's card consumes them, supplies nothing modular, and adopts their
analytic-conductor convention unchanged. Global class field theory supplies the ray-class and
Hecke-character algebra of Layers 5.1 and 6.1. Have the interface conversation before Layer 5:
the character vocabulary should be aligned with #40735 and #40736, and the conductor API and the
character-at-infinity data have to match. Local fields owns the arithmetic-Frobenius convention.
Number field arithmetic owns the Frobenius API of Layer 8.0. Profinite cohomology is not
consumed, and is listed only to record the boundary.

**Zulip.** Direct search was unavailable at audit time. The API returned unauthorized, and the
archive is not search-indexed. These threads are known from cross-references: the
`#PrimeNumberTheorem+` channel, including the "Merging with Morph" thread on the strongpnt
upstreaming; and the Mathlib pull request streams for #40735, #40736, #41765, and #41394.
Announce intentions before Layers 5, 8, and 9. Confirm the state of those pull requests then.
