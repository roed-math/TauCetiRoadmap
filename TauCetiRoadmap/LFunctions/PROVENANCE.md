# L-functions: provenance, ecosystem audit, and coordination

Supporting material for [`README.md`](README.md), which is the specification. Nothing here
is a completion criterion. This file records what the surrounding Lean ecosystem contained
when the roadmap was written, whose work the roadmap sits next to, and what has to be
discussed with whom. All of it goes stale; the README does not depend on any of it.

Audit date **2026-08-06**, against the project pin
`9caeba1000ef8f302920981f4a08651d325abc81` (Mathlib, 2026-06-03).

## What is in motion elsewhere

Coordinate and cite; do not fork.

- **Chebotarev is already proved in Lean, outside Mathlib.** `CBirkbeck/AINTLIB`
  (`projects/Chebotarev/CebotarevDensity/`, 15 files, sorry-free) proves
  `Chebotarev.chebotarev_density`: for finite Galois `L/K` and a conjugacy class `C`, the
  unramified primes with Frobenius class `C` have Dirichlet density `#C/#G`, with
  corollaries `dirichlet_primes_in_AP` and `density_split_completely`. Its route, documented
  in-repo after Sharifi Thm 7.2.2 and Lenstra–Stevenhagen, is the one the README's Layer 8
  follows: cyclotomic case by Dirichlet L-functions, abelian case by crossing with auxiliary
  cyclotomic extensions, general case through the fixed field `L^⟨σ⟩`. AINTLIB is
  AI-authored and AI-reviewed by design ("deliberately relaxed" standards), so it is a
  source of proof structure rather than of code. The files worth reading before writing
  Layer 8 are `CebotarevDensity/{Cyclotomic,Abelian,FixedFieldDensity,Main}.lean`: between
  them they name most of the leaves the README's 8B–8D ask for.
  The human-reviewed rebuild is `CBirkbeck/chebotarev-density`, whose `Main.lean` states
  `chebotarev_density` with the proof still `sorry` while the `ForMathlib` infrastructure
  lands through internal pull requests reviewed by **Xavier Roblot and Riccardo Brasca**.
  Mathlib **#41765** (riccardobrasca) starts the upstreaming with
  `Mathlib/NumberTheory/NumberField/DirichletDensity.lean`.
- **Hecke characters and their L-functions have open Mathlib pull requests** (Thomas
  Browning): **#40735** defines the idele class group (`IdeleGroup`, `IdeleClassGroup` in
  `AdeleRing.lean`), and **#40736** defines
  `HeckeCharacter R K := MulChar (IdeleClassGroup R K) ℂ` with `IsUnramifiedAt`, `localValue`
  at a uniformizer, `localPolynomial = 1 − χᵥ(ϖᵥ)X`, and `LFunction` as a formal
  `ArithmeticFunction.eulerProduct`, in `NumberTheory/NumberField/HeckeLFunction.lean`.
  There is no continuity condition on the character yet. Both are *formal* Dirichlet series:
  no convergence, no continuation, no functional equation. That complementarity is worth
  preserving — the global class field theory roadmap owns the character vocabulary and
  should align it with these two, and Layers 5–6 here supply exactly the analysis those pull
  requests omit. Layer 5's Euler factor `(1 − χ(𝔭)𝔑𝔭^{-s})⁻¹` already agrees with Browning's
  `localPolynomial`.
- **PrimeNumberTheoremAnd** (AlexKontorovich/PrimeNumberTheoremAnd; Zulip channel
  `#PrimeNumberTheorem+`) has, sorry-free in-repo: **Wiener–Ikehara**
  (`WienerIkeharaTheorem'` in `Wiener.lean`), `WeakPNT` (`ψ(x)/x → 1`),
  `WeakPNT_AP`/`WeakPNT_character`, `MediumPNT`
  (`ψ(x) = x + O(x·exp(−c (log x)^{1/10}))`), and the `Consequences.lean` package
  (`chebyshev_asymptotic`, `pi_asymp`, `mu_pnt`, `dirichlet_thm`). The classical-error
  `StrongPNT` is an in-progress port of `math-inc/strongpnt`, an AI-generated strong-PNT
  formalization frozen in 2025-09; it is cited as provenance of that port and never consumed.
  Upstreamed from this project so far: `Chebyshev.lean` (#32281), `ZetaZeros.lean` (#37328),
  logarithms of L-function Euler products (#41097, merged post-pin), Costa–Pereira (#40569);
  Mertens' three theorems are **#41394** (teorth). Chebotarev appears there only as an
  informal blueprint (`blueprint_comment` sections in `Wiener.lean`), on the same route.
- **Mathlib master since the pin, L-series line.** **#41329** (Loeffler, merged 2026-07-04)
  refactored `AbstractFuncEq` around an `IsStrongFEPair` predicate; Layer 2's level extension
  is specified against that post-refactor shape, not against the pin's. #41097 (Tao)
  Dirichlet series for `log` of an L-function; #40127 (Meiburg) zeta through
  `completedRiemannZeta₀`; #41133 (merged) and #42101 conjugation symmetry of the completed
  `riemannZeta`, which support Layer 0's `Λ^∨ = conj ∘ Λ ∘ conj` convention; #41251
  (Birkbeck, merged) the abstract `HeckeRing` of double cosets, with the #41253–#41328 stack
  open; #40540 the Riemann xi function. Nothing on Dedekind zeta continuation or functional
  equation, and nothing on Tate's thesis, has landed or is open. Post-pin commits to
  `dedekindZeta` are refactors. Roblot's open decomposition/inertia-field stack (#35808,
  #35991, #36733, #36843, #37031, #41591, …) is the groundwork Layer 8 and the number field
  arithmetic roadmap will sit on.
- **Sibling roadmaps.** The [modular forms roadmap](../ModularForms/README.md) merged on
  2026-08-02; its Layer 7 delivers convergence with abscissa `≤ k/2 + 1` for cusp forms, the
  Euler product `∏_p (1 − aₚp^{-s} + χ(p)p^{k−1−2s})⁻¹`, the completed `Λ_N` by Mellin
  transform, the two-form equation `Λ_N(k − s, f) = i^k Λ_N(s, g)` with entirety and
  continuation, the sign through Atkin–Lehner, and the analytic conductor pinned as
  Iwaniec–Kowalski (5.7). The elliptic curves roadmap
  ([PR #68](https://github.com/roed-math/TauCetiRoadmap/pull/68)) deliberately has no
  L-function layer; its Hasse-bound and conductor material could later supply raw series
  data, but supplies no continuation or functional equation. Modular curves
  ([#81](https://github.com/roed-math/TauCetiRoadmap/pull/81)) and adic spaces
  ([#80](https://github.com/roed-math/TauCetiRoadmap/pull/80)) are disjoint neighbors.
- **FLT** (ImperialCollegeLondon/FLT) has no L-functions and no classical modularity
  statement: its modularity notion is `GaloisRep.IsAutomorphicOfLevel`, quaternionic over
  totally real fields of even degree, and self-described as far more restrictive than the
  literature's. FLT therefore supplies no elliptic-curve continuation or functional equation,
  which is why the README's instance ledger has no elliptic-curve row. FLT's adele and Haar
  infrastructure is being upstreamed (#40535, adele-ring notation, merged 2026-07-29); that
  is the substrate an adelic treatment of the functional equation would need, and the README
  puts such a treatment out of scope.
- **MichaelStollBayreuth/EulerProducts** is in maintenance mode, content frozen since early
  2025 with Mathlib bumps only ("Most of the results developed here have by now made it into
  Mathlib"). Still unlanded: the `PNT.lean` reduction of asymptotic Dirichlet to
  Wiener–Ikehara. It is the historical provenance of `LSeries/`, `EulerProduct/`,
  `Nonvanishing.lean`, and `PrimesInAP.lean`.

## Coordination ledger

No outreach had been performed when this was written, so every contact status is honestly
*uncontacted* and every ownership statement is a proposal rather than an agreement.

| Project | Revision or pull request at audit | Licence | Overlap | Contact status |
|---|---|---|---|---|
| Mathlib L-series, Dedekind zeta, Hecke work (Loeffler, Stoll, Roblot, Browning) | pin `9caeba1000ef8f302920981f4a08651d325abc81`; #40735 at `ba5cc46884`; #40736 at `0355daa48a`; #41765 at `7478e24828` | Apache-2.0 | completed-L conventions, Hecke-character and formal Euler-product vocabulary, Dedekind zeta continuation, Dirichlet density | not contacted |
| CBirkbeck/AINTLIB and CBirkbeck/chebotarev-density (Birkbeck; rebuild reviewed by Brasca and Roblot) | AINTLIB `1c1c74664e`; rebuild `c64095e6cc` | Apache-2.0 | class-field-theory-free Chebotarev and its density calculus | not contacted |
| thefundamentaltheor3m/Sphere-Packing-Lean and math-inc/Sphere-Packing-Lean | `bad3de9160`; math-inc `1e98fb4930`; sphere-packing PR #341 at `a604233089` | Apache-2.0 | the general `ZLattice` Poisson theorem and the Gaussian theta transformation | not contacted |
| AlexKontorovich/PrimeNumberTheoremAnd (Kontorovich, Tao, Irving, and others) | `21998bb619`; Mathlib Mertens #41394 at `a4221cb335` | Apache-2.0 | Wiener–Ikehara, prime counting, natural-density upgrades | not contacted |
| ImperialCollegeLondon/FLT (Buzzard and others) | `d18b563029` | Apache-2.0 | adelic and Haar substrate; no elliptic-curve modularity or L-function theorem | not contacted |

Proposed division of labour, to be confirmed with each project:

- Mathlib keeps the core vocabulary and the formal series; Tau Ceti builds the analytic
  continuation, functional equations, and density theory. Where a Mathlib pull request fixes
  a spelling, Tau Ceti adopts that spelling; when one merges, the corresponding Tau Ceti
  declaration is deleted and the Mathlib one imported.
- The Chebotarev line keeps its own development. Tau Ceti's Layer 8 is independent work on
  the same route, cites both repositories, and copies no code without the authors' agreement.
  If the rebuild reaches Mathlib first, Layer 8 becomes a comparison-and-adopt task and the
  value of this roadmap concentrates in the prime ideal theorem, the natural-density upgrade,
  and the reciprocity consistency theorem.
- Poisson summation for a general `ZLattice` should have one home serving this roadmap, the
  integral lattices roadmap, and the sphere-packing project. Seek that shared home before
  building; do not port the sphere-packing Gaussian proof without permission.
- PrimeNumberTheoremAnd keeps the Tauberian theorems and the rational prime number theorem.
  Layer 9's Wiener–Ikehara statement is written to match `WienerIkeharaTheorem'` so that an
  agreed integration is an import rather than a rewrite.

## Lines of work this roadmap continues

- **The Loeffler–Stoll line** (`Mathlib/NumberTheory/LSeries/`, `EulerProduct/`,
  `Gamma/Deligne.lean`, `AddCircleMulti.lean`; design paper arXiv:2503.00959, Annals of
  Formalized Mathematics 1 (2025) 43–56). Layers 2–3 extend their functional-equation frame
  along the `AbstractFuncEq` level TODO, using the multivariate Fourier step their
  `AddCircleMulti` staged; Layer 7 generalizes their `Nonvanishing.lean`. Layer 0's
  completed-L convention must stay translatable to their `completedLFunction` normalization,
  which is what the `N^{s/2}` dictionary lemma is for. Layer 3's Dedekind functional equation
  is the natural next chapter of their programme, and is worth telling them about.
- **The Roblot line** (`DedekindZeta.lean`, `Ideal/Asymptotics.lean`,
  `CanonicalEmbedding/FundamentalCone.lean` from PR #17914, merged 2025-05-18; the cyclotomic
  Galois file `Cyclotomic/Galois.lean`; the open decomposition and inertia-field stack; and
  the review of the chebotarev-density rebuild). Layers 1 and 3 sit directly on this
  machinery and discharge the `DedekindZeta.lean` TODO. Layer 1's counting estimate with
  error term `O(x^{1−1/d})` strengthens his limit-only asymptotics and is worth designing
  with him. Talk to him before Layers 1, 3, and 8.
- **The Browning line** (`ArithmeticFunction/LFunction.lean` and
  `EllipticCurve/LFunction.lean` at the pin; #40735, #40736; `RingTheory/Invariant`).
  Layers 5–6 supply the analysis over his formal Hecke L-functions. His
  `ArithmeticFunction.eulerProduct`/`Northcott` formalism and Layer 1's analytic Euler
  products are related by a comparison lemma rather than duplicated. The existing
  `WeierstrassCurve.LSeries` is recorded as prior art only.
- **PrimeNumberTheoremAnd.** Layer 9's Tauberian input and every `K = ℚ` prime-counting
  statement are matched against that project. Track #41394 for Layer 9's Mertens support.
- **Sibling Tau Ceti roadmaps.** The [modular forms roadmap](../ModularForms/README.md)
  owns modular L-functions; the ledger card here consumes them and supplies nothing modular,
  adopting its analytic-conductor convention unchanged. Global class field theory supplies
  ray-class and Hecke-character algebra; the interface conversation — character vocabulary
  aligned with #40735/#40736, the conductor API, the character-at-infinity data — happens
  before Layer 5. Local fields owns the arithmetic-Frobenius and uniformizer-to-Frobenius
  conventions adopted here. Number field arithmetic owns the Frobenius and Artin-symbol API
  Layer 8's statements use. Profinite cohomology is not consumed; it is listed to record the
  boundary.
- **Zulip.** Direct search was unavailable at audit time (API unauthorized, and the archive
  is not search-indexed). Threads known from cross-references: the `#PrimeNumberTheorem+`
  channel, including the "Merging with Morph" thread on the strongpnt upstreaming, and the
  Mathlib pull request streams for #40735, #40736, #41765, and #41394. Announce intentions
  before Layers 5, 8, and 9, and confirm the state of those pull requests then.
