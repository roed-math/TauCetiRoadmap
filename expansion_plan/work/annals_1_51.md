# Annals definitions #1–#51 (algebra, geometry and number theory): who owns them

Demand: `/Users/roed/claude/handoffs/definitions_100_tauceti.md`, entries #1–#51. Supply was read at
these points: Tau Ceti roadmaps on `upstream/main` (`b4f1970`), open TauCetiRoadmap PR heads
(`upstream-pr/<N>`), and Birkbeck's campaign (Sept 2026 explorer edition, sparse clone). Machine
version: `needs_annals_1_51.jsonl` (60 lines; #5, #8, #10, #15, #16, #19, #22 and #41 split into
parts with different owners).

Abbreviations: **TC** = Tau Ceti roadmap on main; **PR#n** = open TauCetiRoadmap PR; **CB** =
Birkbeck campaign roadmap (stage ids as in its README). *Coverage* says how much of the entry
(definition plus sample API) the named owners target: **full**, **partial** (and which part), or
**none**. A campaign stage counts as an owner only if it targets the object in the generality the
entry asks for. A passing mention does not count.

Changes to Mathlib since the entries were written (local Mathlib `6b7abb3c`):
`Mathlib/AlgebraicGeometry/Sites/` now has `Fpqc.lean` and `ElladicCohomology.lean`, with a
pro-étale `Scheme.EllAdicCohomology` (bare definition) relevant to #3 and #35. `AlgebraicCycle`
(cycles with coefficients in any ring, plus Weil divisors) and `OrderOfVanishing` provide
ingredients for #7 and #33.

## 1. Ownership table

| # | Definition | Owner(s), with layer or stage | Coverage | Proposed roadmap |
|---:|---|---|---|---|
| 1 | Abelian variety, polarization, dual | TC JacobianChallenge L-E (over a field: cube, dual, polarizations, [n]); CB AbelianSchemesAndArithmeticModuli A1–A3, A6 (over a base, Weil pairing, Rosati) | full (Albert classification not named) | — |
| 2 | VHS and period maps | TC Completed/HodgeStructures (pure/polarized HS, period-domain points); CB ShimuraData D3 (homogeneous VHS on Hermitian domains) | partial: VHS over arbitrary bases, period maps, monodromy theorems missing | VariationsOfHodgeStructure |
| 3 | Étale cohomology | PR#196 CohomologicalPointCounting (ConstructibleEtale L6 Kummer/Tate twists, L9 cohomology; EtaleBaseChange; CompactSupport; EllAdicRealization; TraceFormula L11–12); CB EDC.3 cycle classes | full (on merge of PR#196) | — |
| 4 | Automorphic representation, cuspidal/discrete spectrum | CB AdelicAlgebraicGroups AA.2–3 (finite volume); AutomorphicFormsOnReductiveGroups AF.2–3 (constant terms, cusp forms); AutomorphicSpectralTheory AS.4; GL2AutomorphicRepresentations R16.4 | full except GL_n multiplicity one | — |
| 5 | Constructible sheaf, microsupport | PR#196 ConstructibleEtale L4–5 (étale constructibility, stratifications of Noetherian schemes) | partial: Whitney/subanalytic constructibility and microsupport have no owner | TopologicalSixOperations, MicrolocalSheafTheory |
| 6 | Algebraic stack | CB AlgebraicModuliForArithmeticGeometry R09.3–R09.4; SchemeAndStackFoundations SF.1 | partial: stacks "in the required class" only; residual gerbes, DM-via-stabilizers, stacky point counts missing | AlgebraicStacks (promotion) |
| 7 | Q-divisor, canonical class | PR#545 AbundanceStatement L1 (normal Weil/Cartier/Q-Cartier, unique extension, pullback), L2 (K_X from top forms), L4B (numerical equivalence) | nearly full: R-boundaries, adjunction and the blowup formula K_Y = f*K_X + E missing | SingularitiesOfPairs |
| 8 | Reductive group scheme, root datum | TC ReductiveGroups L6–L7 (field), L9 (split over Z); PR#447/#697 ChevalleyGroups | full over a field; partial over a base (L8 is labelled "long horizon") | ReductiveGroupSchemes |
| 9 | Stable curve, Mbar_{g,n} | TC StableReduction L3 (stable pointed families, clutching), L7–L9, valuative interface | partial: the roadmap stops before the moduli stack | ModuliOfStableCurves |
| 10 | Coherent sheaf | Mathlib `isFinitePresentation`; TC code `FinitelyPresentedSheaf`; TC JacobianChallenge L-B/C; TC StableReduction L2 (proper pushforward, base change); CB SchemeKTheoryOperations S.1 (Perf) | partial: D^b_coh and "Perf = D^b_coh iff regular" missing | CoherentDuality |
| 11 | Hodge–Tate weights, de Rham/crystalline reps | CB PadicHodgeTheory R06.1–R06.2, R06.6 | full | — |
| 12 | Intersection numbers | TC StableReduction L4 (regular arithmetic surfaces); PR#545 L4A (curve degrees), L4D (Hilbert-polynomial intersection numbers for Nakai–Moishezon); CB SF.5 | partial: scattered; general proper varieties and the projection formula have no owner | IntersectionTheory |
| 13 | Maass forms, spectral decomposition | CB AutomorphicSpectralTheory AS.1–AS.4 (adelic, general G) | partial: the classical Γ\ℍ theory with the hyperbolic Laplacian is not targeted | MaassFormsAndSpectralTheory |
| 14 | Motives | CB MotivesAndAlgebraicCycles MC.0–MC.4; MotivicEtaleKTheory M.4 | full (rests on #33) | — |
| 15 | D-modules | none | none | AlgebraicDModules, BeilinsonBernsteinLocalization |
| 16 | Six operations, duality | étale: PR#196 CompactSupport (Rf_!) + CB EtaleDualityAndPerverseSheaves EDC.1–2 (f^!, Verdier, Poincaré); coherent: TC code curve Serre duality, JacobianChallenge L-B, StableReduction L2 (nodal ω) | full étale; partial coherent (curves only); none topological | CoherentDuality, TopologicalSixOperations |
| 17 | Jacobian, Abel–Jacobi | TC JacobianChallenge L-D–F (Pic⁰ scheme, theta polarization, universal property, base change) | full (Torelli not targeted) | — |
| 18 | klt / lc pairs | PR#545 L3 (klt for (X,0), all-models definition, smooth ⇒ klt) | partial: no boundary Δ; no lc/dlt/plt; no log-resolution criterion; no klt ⇒ rational singularities | SingularitiesOfPairs (+KodairaVanishingTheorems) |
| 19 | Orbital integral, trace formula | CB EndoscopicTransfer ET.0 (stable conjugacy), ET.1 (orbital integrals, transfer), ET.3 (fundamental lemma); AutomorphicSpectralTheory AS.6 (Arthur's trace formula) | partial: relative trace formula and Jacquet–Rallis missing | RelativeTraceFormulas |
| 20 | Shimura variety, canonical model | CB ShimuraData D0–D5; ShimuraVarieties V0–V8 | full | — |
| 21 | p-divisible group, Dieudonné module | CB FiniteFlatGroupsAndIntegralPadicHodgeTheory R07.1–R07.2 | full | — |
| 22 | Ample/nef/big/semiample | PR#545 L4C (nef cone), L4D (Kleiman, Nakai–Moishezon), L5 (semiample) | partial: big, volume, pseudo-effective cone, base loci missing | PositivityOfLineBundles |
| 23 | Bruhat–Tits building | CB ReductiveGroupsPartII RG2.1–RG2.4 | full except Moy–Prasad filtrations | — (amend RG2.3) |
| 24 | Canonical height, adelic metrics | TC EllipticCurves L6 (Néron–Tate on elliptic curves); PR#287 ArithmeticHeights (P^n, Arakelov height of tuples); CB RP.0, TB.6, R35.1 | partial: adelic metrized line bundles on higher-dimensional varieties, arithmetic intersection and arithmetic nef/big missing | ArakelovIntersectionTheory |
| 25 | Good/coarse moduli space | CB R09.5 (coarse spaces for the specific finite-inertia presentations) | partial: good moduli spaces, GIT quotients and general Keel–Mori missing | GoodModuliSpaces (+AlgebraicStacks) |
| 26 | Langlands dual group | CB ReductiveGroupsPartII RG2.5 | full | — |
| 27 | Perfectoid ring | CB PerfectoidSpaces P0–P3; PerfectoidQuotients Q0 | full | — |
| 28 | Toric variety from a fan | TC AnalyticToricGeometry (finite regular fans, over ℂ) | partial: singular fans, arbitrary bases and toric divisors missing | ToricVarieties |
| 29 | Weil–Deligne reps, LLC for GL_n | TC ClassFieldTheory L9 (Weil group); CB ArithmeticGaloisRepresentations R01.2; EndoscopicTransfer ET.6; AutomorphicLFunctionsAndLocalFactors | full (LLC sits inside a distance-10 roadmap) | — |
| 30 | p-adic L-function as a measure | CB PadicMeasuresIwasawaAlgebras L2–L3; DirichletPadicLFunctions L1–L3; IntegralIwasawaTheory I.3–I.5; AutomorphicPadicLFunctions | full | — |
| 31 | Arthur parameter, A-packet | none (no campaign hits; ET covers unitary endoscopy only) | none | ArthurParameters |
| 32 | Bloch–Kato Selmer, Ш | TC EllipticCurves L7; CB SelmerIwasawaCohomology L2; ArithmeticGaloisDuality | full | — |
| 33 | Chow group | CB SF.5 (one paragraph: Chow groups, Gysin, Chern classes, GRR); MC.0 consumes it; TC AlgebraicVectorBundles names it as a successor | thin: stated as a target, not specified | IntersectionTheory (promotion) |
| 34 | Formal scheme, completion | CB AdicSpacesPartII F0 (Spf, completion, formal functions, formal GAGA), R2; R09.6 | full except coherent completeness of [Spec A/G] | — (that part: GoodModuliSpaces) |
| 35 | Descent, fppf/flat site | TC ModularCurves L0E (effective fpqc descent); TC ReductiveGroups fppf lane; Mathlib `Sites/Fpqc`; CB SF.1–SF.2 | mostly full; arc/v topologies on schemes and H¹_fppf vs étale lack a definite owner | AlgebraicSpaces (layer 0) |
| 36 | Higgs bundle, Hitchin map | CB EndoscopicTransfer ET.2b (G-Higgs fields, Hitchin base and map, spectral covers, built as fundamental-lemma machinery) | partial: stability, moduli, properness, BNR, NAH missing | HiggsBundlesAndHitchinFibration |
| 37 | Iwasawa algebra, Λ-modules | TC code `completedGroupAlgebra` (Λ ≅ Z_p⟦T⟧); CB PadicMeasuresIwasawaAlgebras L1, L4 | full | — |
| 38 | Rigid/adic space | TC AdicSpaces L0–L5 (and code); CB AdicSpacesPartII R1–R2 (analytification, generic fibre) | full | — |
| 39 | K-semistability (β, δ) | none | none | KStabilityOfFanoVarieties |
| 40 | Mumford–Tate group | none (ShimuraData D1 builds the Deligne torus, never MT) | none | MumfordTateGroups |
| 41 | Perverse sheaf, perverse filtration | CB EDC.5 (ℓ-adic perverse t-structure, j_{!*}), EDC.7 (decomposition theorem), LPV.6 | full ℓ-adic; none over ℂ with the classical topology; perverse filtration missing | PerverseSheavesOnComplexVarieties |
| 42 | Resolution, blowups | TC StableReduction L4 (Rees-algebra blowups of quasi-coherent ideals, surface resolution); CB R09.7 (Bierstone–Milman embedded resolution, char 0) | full | — (promote R09.7) |
| 43 | Satake isomorphism | CB SmoothRepresentationsOfLocalGroups SR.4; RG2.5 | full | — |
| 44 | Slope stability, HN filtration | none (CB VectorBundlesAndIsocrystals and GlobalShtukas use HN filtrations only in their own settings) | none | SlopeStabilityAndHarderNarasimhan |
| 45 | Étale fundamental group | PR#196 ConstructibleEtale L3; ComplexComparison L8 (Riemann existence); CB InverseGalois IG.0–IG.1 (fundamental exact sequence) | full (on merge of PR#196) | — |
| 46 | Algebraic de Rham, comparisons | CB ComplexComparisonPartII C5; DerivedDeRhamCohomology DD.2; CrystallineCohomology CR.1–3; CohomologyComparisons CP.3 | full but deep (distance 6–10) | — |
| 47 | Berkovich analytification | CB TropicalAndBerkovichArithmetic TB.0–TB.1; AdicSpacesPartII R1 | full | — |
| 48 | lct, log discrepancy | PR#545 L3 (discrepancies over (X,0)) | partial: no lct, no pairs | SingularitiesOfPairs (+ValuationSpacesOfVarieties) |
| 49 | Néron–Severi, Picard scheme | TC JacobianChallenge L-D (curves); PR#545 L4B (numerical NS finiteness); CB A0-extension, A2 (abelian schemes); SF.5 (Hodge index) | partial: Pic_{X/S} for projective X/S and NS(X) under algebraic equivalence missing | PicardSchemes |
| 50 | Val_{X,x}, quasi-monomial valuations | TC code `ValuationSpectrum`, scheme places | none beyond ingredients | ValuationSpacesOfVarieties |
| 51 | δ-ring, prism, prismatic cohomology | CB PrismaticCohomology PR.0–PR.4 | full | — |

Tally: 23 full (15 only through the campaign; #3 and #45 only once PR#196 merges), 22 partial
(#35 nearly full), 6 none (#15, #31, #39, #40, #44, #50). The birational-geometry and sheaf-theory gaps the brief
expected are real. The arithmetic definitions are almost all campaign-owned.

## 2. Proposed roadmaps

Waves give the dependency order: wave 1 can start on today's supply, and wave *k* consumes only
waves < *k*, Tau Ceti/PR suppliers, and the campaign stages named. Sizes follow the entries' own
scale: L = a small project, XL = multi-file.

### Birational geometry (#7, #18, #22, #39, #48, #50)

**SingularitiesOfPairs** — math.AG — XL — wave 1 (log-resolution layers wave 2)
> This roadmap develops the singularities of the minimal model program for pairs `(X, Δ)`, with `X`
> normal over a field of characteristic zero and `Δ` an effective ℝ-Weil divisor with `K_X + Δ`
> ℝ-Cartier. It extends the divisor and discrepancy API of AbundanceStatement rather than
> redefining it. Discrepancies `a(E; X, Δ)` over every divisor on every proper birational model;
> terminal, canonical, klt, plt, dlt and lc; the criterion on a single log resolution and its
> independence of the resolution; adjunction `K_D = (K_X + D)|_D` for a normal prime divisor;
> the blowup formula; log canonical thresholds of ideals and divisors, with a computing divisor
> and rationality. Examples: snc pairs, `(A², c·{xy=0})`, quotient singularities, cones over curves
> of genus 0, 1 and ≥ 2, `lct(y² − x³) = 5/6`, `lct(x² + y²) = 1`, and toric pairs from
> ToricVarieties.

Delivers #18, #48, and the rest of #7. Prerequisites: PR#545 L0–L3; ResolutionOfSingularities
(promoted CB R09.7); TC StableReduction L4 (blowups); ToricVarieties (examples only).

**ValuationSpacesOfVarieties** — math.AG (math.AC) — L — wave 2
> Real valuations on the function field of a variety and their centres; the spaces `Val_X` and
> `Val_{X,x}` with the weak topology; divisorial, quasi-monomial and Abhyankar valuations, with
> rational rank and transcendence degree (Abhyankar's inequality); monomial valuations on log
> smooth models and the retraction of `Val_X` onto dual complexes of snc models; the log
> discrepancy `A_{X,Δ}` extended to `Val_X` (Jonsson–Mustață); log canonical thresholds of
> ideals and graded sequences computed by valuations; associated graded rings, with finite
> generation for divisorial valuations and its failure for some quasi-monomial ones.

Delivers #50, the valuative half of #48, and `A_X(v)` for #39. Prerequisites:
SingularitiesOfPairs; TC AdicSpaces L1 (`Spv`, kept as the carrier); PR#545 L0 (`Scheme.ord`);
ResolutionOfSingularities.

**PositivityOfLineBundles** — math.AG — L — wave 2
> Asymptotic positivity of line bundles and ℝ-divisors on projective varieties (Lazarsfeld vol. I),
> building on the nef/ample/semiample layer of AbundanceStatement: Iitaka dimension, big divisors
> and Kodaira's lemma, the volume function (homogeneity, continuity on `N¹(X)_ℝ`, `vol = D^n` for
> nef `D`), the pseudo-effective and big cones with `Big = int(Psef)`, stable and augmented base
> loci with `B₊(f*A)` equal to the exceptional locus of a blowup, Zariski decomposition on
> surfaces, and filtrations of section rings by a valuation together with the expected vanishing
> order `S(v)`.

Delivers the rest of #22 and the S-invariant of #39; base for #24's arithmetic analogues.
Prerequisites: PR#545 L4–L5; IntersectionTheory.

**KStabilityOfFanoVarieties** — math.AG (math.DG) — XL — wave 3
> Log Fano pairs and their K-stability, in both the valuative and the test-configuration forms:
> `β = A − S` on divisors over `X`, the stability threshold `δ = inf A/S`, K-(semi/poly)stability
> and uniform K-stability; test configurations, their Donaldson–Futaki invariants via the
> Knudsen–Mumford expansion, and the equivalence of the two definitions (Fujita, Li) as the
> coherence theorem. Examples: `δ(Pⁿ) = 1`; `Bl_p P²` is not K-semistable; the barycentre
> criterion for toric Fano varieties. K-semistable Fano varieties are klt.

Delivers #39. Prerequisites: SingularitiesOfPairs, ValuationSpacesOfVarieties,
PositivityOfLineBundles, ToricVarieties; cohomology and base change from TC StableReduction L2 and
CB A0-extension.

**KodairaVanishingTheorems** — math.AG — L — wave 2
> Kodaira–Akizuki–Nakano vanishing through Deligne–Illusie decomposition of the de Rham complex
> for varieties liftable modulo `p²`, spread out to characteristic zero; Kawamata–Viehweg via
> cyclic covers; Grauert–Riemenschneider; rational singularities, with "klt implies rational and
> Cohen–Macaulay"; and Mumford's example of non-degeneration in characteristic `p`.

Delivers item 5 of #18. It also gives a short route to the degeneration in #46. Prerequisites: CB
DerivedDeRhamCohomology DD.3 (Cartier isomorphism); CoherentDuality; SingularitiesOfPairs.

### Intersection theory, Picard schemes, toric varieties (#12, #28, #33, #49)

**IntersectionTheory** — math.AG — XL — wave 1. Promotes CB SF.5 and the AlgebraicVectorBundles successor sketch.
> Fulton chapters 1–8 over a field: cycles (on Mathlib's `AlgebraicCycle`), rational
> equivalence and `CH_k`, proper pushforward, flat pullback, intersection with Cartier divisors,
> Chern and Segre classes of vector bundles via projective bundles, the splitting principle and
> Whitney formula, deformation to the normal cone, refined Gysin maps and the intersection ring
> of a smooth variety. Also: `CH*(Pⁿ)`, the projective-bundle formula, `CH₀` of a curve
> (= ℤ ⊕ Jac(k), consuming JacobianChallenge), intersection numbers of line bundles on proper
> varieties identified with the Snapper polynomial, the projection formula for generically
> finite maps, and Mumford's infinite-dimensionality of `CH₀` as a counter-test.

Delivers #33 and #12; supplies #14, #22, #24, #49 and the cycle classes of #3. Prerequisites: TC
AlgebraicVectorBundles; projective bundles (CB R09.1); PR#545 L1, L4A; TC StableReduction L4
(surface case reused).

**PicardSchemes** — math.AG — L — wave 2
> Grothendieck's representability of `Pic_{X/S}` for projective flat `X/S` with geometrically
> integral fibres, via Hilbert schemes of divisors; `Pic⁰`, `Pic^τ`; the tangent space `H¹(O_X)`
> and smoothness in characteristic zero; the Néron–Severi group under algebraic equivalence and
> the theorem of the base (finite generation), compared with the numerical group of
> AbundanceStatement; the intersection form on NS of a surface and the Hodge index theorem.
> Examples: NS(Pⁿ), NS(P¹×P¹), elliptic curves (`Pic⁰ ≠ 0`) and Enriques surfaces (2-torsion in NS).

Delivers #49. Prerequisites: TC JacobianChallenge L-C/D; CB R09.2 (Hilbert/Quot); IntersectionTheory;
PR#545 L4B.

**ToricVarieties** — math.AG (math.CO) — L — wave 1
> Normal toric varieties `X_Σ` over an arbitrary base ring from arbitrary rational polyhedral fans,
> generalizing AnalyticToricGeometry's regular algebraic supplier. Covers the orbit–cone
> correspondence; smooth ⇔ unimodular, complete ⇔ `|Σ| = N_ℝ`, simplicial ⇔ ℚ-factorial;
> T-invariant Weil and Cartier divisors, support functions, `Cl` and `Pic`; ampleness and nefness
> by convexity; toric resolution by subdivision; and the intersection ring of a smooth complete
> toric variety. Examples: `Pⁿ`, the `A₁` cone, and the Nash blowup of an explicit affine toric
> variety.

Delivers #28; gives examples for #18, #22, #39. Prerequisites: TC AnalyticToricGeometry L0; PR#545
L1; IntersectionTheory (last layer only).

### Stacks and moduli (#6, #9, #25, #35, #44, #36)

**AlgebraicSpaces** — math.AG — L — wave 1. Promotes CB SF.1 and R09.3.
> Grothendieck topologies on schemes (Zariski, étale, fppf, fpqc, and the v- and arc-topologies),
> effective fpqc descent for quasi-coherent sheaves and affine morphisms, Čech and flat
> cohomology, with `H¹_fppf(Spec k, μ_n) = k*/k*ⁿ` and Grothendieck's fppf = étale comparison for
> smooth commutative group schemes. Then algebraic spaces as quotients of étale equivalence
> relations: properties of morphisms, fibre products, quotients by free finite group actions,
> and Weil restriction.

Delivers the rest of #35; base for #6. Prerequisites: Mathlib `Sites/Fpqc`, `Sites/Etale`; TC
ModularCurves L0E and the ReductiveGroups fppf lane (consumed, not rebuilt); PR#196
ConstructibleEtale.

**AlgebraicStacks** — math.AG — XL — wave 2. Promotes CB R09.4–R09.5.
> Fibred categories and stacks over `(Sch)_fppf`; algebraic (Artin) and Deligne–Mumford stacks with
> representable diagonal and smooth or étale atlas; quotient stacks `[U/G]` and `BG`; inertia,
> stabilizer group schemes and residual gerbes; "DM ⇔ unramified diagonal ⇔ finite unramified
> stabilizers"; separatedness and properness by valuative criteria; coarse moduli spaces of stacks
> with finite inertia (Keel–Mori); groupoid point counts over `F_q`, with
> `#[X/G](F_q) = #X(F_q)/#G(F_q)` for connected `G`. Counterexamples: `[A¹/G_m]` is not DM;
> quotients by non-flat groupoids are not algebraic.

Delivers #6 and the coarse half of #25. Prerequisites: AlgebraicSpaces; TC ReductiveGroups
(group schemes); CB R09.2 for Hilbert-scheme atlases.

**GoodModuliSpaces** — math.AG (math.RT) — L — wave 3
> Linearly reductive group schemes and Reynolds operators; affine GIT quotients and finite
> generation of invariants; projective GIT with the Hilbert–Mumford criterion; cohomologically
> affine morphisms and Alper's good moduli spaces (universality, closed points ↔ S-equivalence
> classes, uniqueness). Examples: `[U/G] → Spec O(U)^G`; `BG` with `G` linearly reductive versus
> `BZ/p` over `F_p`; `[A¹/G_m] → pt`. Also coherent completeness of `[Spec A/G]` at a closed point
> and the comparison with Keel–Mori coarse spaces.

Delivers #25 and the remainder of #34; GIT input for #44 and #36. Prerequisites: AlgebraicStacks;
TC ReductiveGroups L6 (linear reductivity); CB AdicSpacesPartII F0, R09.6.

**ModuliOfStableCurves** — math.AG — XL — wave 3
> The moduli stack `M̄_{g,n}` of stable `n`-pointed curves: algebraicity via tri-canonical
> embeddings and Hilbert schemes, DM-ness from finiteness of automorphisms, properness from
> StableReduction's valuative interface, smoothness and dimension `3g − 3 + n` from deformation
> theory, the boundary as a normal-crossings divisor with strata indexed by stable graphs, and the
> clutching and forgetful morphisms. Small cases: `M̄_{0,3} = pt`, `M̄_{0,4} ≅ P¹`, `M̄_{1,1}`.
> Counterexample: the non-separated moduli of all nodal curves.

Delivers #9. Prerequisites: TC StableReduction; AlgebraicStacks; CB R09.2, R09.6.

**SlopeStabilityAndHarderNarasimhan** — math.AG — L — wave 3 (HN layers wave 2)
> An abstract slope formalism on exact categories, with HN and Jordan–Hölder filtrations that the
> campaign's isocrystal and Bun_G HN strata consume. μ- and Gieseker stability for torsion-free
> coherent sheaves on polarized projective varieties: stability under tensoring with line bundles
> and finite étale pullback; stable ⇒ simple; Grothendieck's splitting on P¹; parabolic bundles.
> Moduli of semistable bundles on a curve of genus ≥ 2 by GIT, of dimension `r²(g − 1) + 1`.

Delivers #44. Prerequisites: Tau Ceti coherent sheaves; IntersectionTheory (degrees); TC
JacobianChallenge L-B (Riemann–Roch); GoodModuliSpaces (moduli layer).

**HiggsBundlesAndHitchinFibration** — math.AG (math.DG) — L — wave 4
> Higgs bundles `(E, θ: E → E ⊗ Ω¹)` and G-Higgs bundles on smooth projective curves; stability
> through θ-invariant subsheaves; moduli of semistable Higgs bundles; the Hitchin map to
> `⊕ H⁰(K^i)` and its properness; spectral curves and the BNR correspondence, so that a generic
> fibre is the Jacobian of the spectral curve; the dimension formula. Character varieties by GIT,
> and a statement (not a proof) of nonabelian Hodge.

Delivers #36. Prerequisites: SlopeStabilityAndHarderNarasimhan; GoodModuliSpaces; TC
JacobianChallenge; CB ET.2b (it should import the Hitchin base and map from here).

### Sheaf theory and D-modules (#5, #10, #15, #16, #41)

**CoherentDuality** — math.AG — XL — wave 1
> Derived categories of quasi-coherent sheaves on schemes: `D_qc`, `D^b_coh`, `Perf`, with
> `Perf ⊆ D^b_coh` and equality exactly for regular schemes. Also Grothendieck coherence of
> `R f_*` for proper maps; the right adjoint `f^×` and `f^!` via compactification; dualizing
> complexes; Grothendieck duality for proper morphisms and its base change; `f^! = f* ω_f[n]` for
> smooth `f`; Serre duality on projective Cohen–Macaulay schemes, recovering JacobianChallenge's
> curve case. `f_! ≠ f_*` for `A¹ ⊂ P¹` is a test.

Delivers the rest of #10 and the coherent part of #16. Prerequisites: Mathlib derived categories;
Tau Ceti `QuasicoherentSheaf`; TC JacobianChallenge L-B, StableReduction L2; PR#196
CompactSupport L1 (Nagata compactification, consumed).

**TopologicalSixOperations** — math.AT (math.AG) — XL — wave 1
> Sheaves on locally compact Hausdorff spaces: `Rf_*`, `f⁻¹`, `Rf_!` with proper base change and
> the projection formula, `f^!` and Verdier duality, Poincaré–Verdier duality on topological
> manifolds with orientation sheaves, locally constant sheaves as local systems. Constructible
> complexes for semialgebraic and complex-algebraic stratifications, and stability of `D^b_c` of
> complex varieties under the six operations (Verdier's generic base change).

Delivers the topological part of #16 and the stratified part of #5; base for #41 over ℂ and the
target of #15's de Rham functor. Prerequisites: PR#196 ComplexComparison L5–L7; TC local systems
(code for #67); TC RealAlgebraicGeometry (semialgebraic stratification, CAD).

**PerverseSheavesOnComplexVarieties** — math.AG (math.RT) — XL — wave 3
> The middle-perversity t-structure on `D^b_c(X^an, ℚ)` for complex varieties, by gluing along
> stratifications. Covers the abelian heart and its simple objects `IC(L)`, intermediate
> extension, Verdier self-duality and Artin vanishing; the decomposition theorem for proper maps
> by BBD §6 (spreading out to finite fields, consuming the ℓ-adic theorem and Artin comparison);
> relative hard Lefschetz and the perverse filtration on `H*(X)`. Tests: the nodal curve, the two
> small resolutions of `xy = zw`, and the failure of tensor closure.

Delivers #41 over ℂ. Prerequisites: TopologicalSixOperations; CB EDC.5, EDC.7; PR#196
ComplexComparison L10–L12.

**MicrolocalSheafTheory** — math.AG (math.SG, math.AT) — XL — wave 2
> Kashiwara–Schapira on real manifolds: the microsupport `SS(F) ⊆ T*M` of `F ∈ D^b(k_M)`, the
> non-characteristic deformation lemma, the microlocal Morse lemma, functorial bounds under proper
> pushforward and non-characteristic pullback, the triangle inequality, `SS(F) ⊆ 0_M ⇔ F` locally
> constant, `SS(k_Z) = T*_Z M`, and involutivity. ℝ-constructible sheaves in the semialgebraic
> (Nash) setting have conic Lagrangian microsupport.

Delivers the microsupport part of #5. Prerequisites: TopologicalSixOperations; TC
DifferentialGeometry (cotangent bundles); TC RealAlgebraicGeometry. A subanalytic extension
would need a subanalytic-geometry supplier; none exists anywhere.

**AlgebraicDModules** — math.AG (math.RT) — XL — wave 2
> Rings of differential operators `D_X` on smooth varieties in characteristic zero; coherent
> D-modules, good filtrations and characteristic varieties; Bernstein's inequality; holonomic
> modules (finite length, stability under direct and inverse image); Kashiwara's equivalence; the
> de Rham and solution functors to `D^b_c(X^an)`; Bernstein–Sato polynomials; regular holonomic
> modules and the Riemann–Hilbert correspondence. Tests: `D/D∂ = O`, `D/Dx = δ₀`,
> `D/D(x∂ − λ)` with monodromy `e^{2πiλ}`.

Delivers #15 except Beilinson–Bernstein. Prerequisites: CoherentDuality; TC
AlgebraicVectorBundles; TopologicalSixOperations; CB ComplexComparisonPartII C5 (analytic de Rham).

**BeilinsonBernsteinLocalization** — math.RT (math.AG) — L — wave 3
> Flag varieties `G/B`, twisted differential operators `D_λ`, the Harish-Chandra description
> `Γ(G/B, D_λ) = U(g)/ker χ_λ`, and Beilinson–Bernstein: global sections are an equivalence
> `D_λ-mod ≃ g-mod_χ` for regular dominant `λ`. Worked fully for `SL₂` on P¹.

Delivers the rest of #15. Prerequisites: AlgebraicDModules; TC ReductiveGroups L7 (Borel
subgroups, flag variety); TC RepresentationTheory/LieHighestWeight.

### Hodge theory (#2, #40)

**VariationsOfHodgeStructure** — math.AG (math.CV) — XL — wave 2. Already sketched as TauCetiRoadmap issue #167.
> Period domains as complex manifolds (open in flag varieties); the VHS datum: a local system, a
> holomorphic Hodge filtration and Griffiths transversality, polarized; period maps from the
> universal cover, horizontal and holomorphic; monodromy into `Aut(V, Q)(ℤ)`; the theorem of the
> fixed part and semisimplicity of monodromy. Geometric VHS of families of complex tori, abelian
> varieties and smooth projective families via the Gauss–Manin connection. Tests: the weight-one
> case recovering ℍ and modular curves; a filtered local system that is not transversal.

Delivers #2. Prerequisites: TC Completed/HodgeStructures; PR#279 ComplexManifolds; PR#280
ComplexTori; TC local systems/UniversalCovers; CB ComplexComparisonPartII C5; the Kähler/Hodge
decomposition roadmap that the geometry share proposes for #64.

**MumfordTateGroups** — math.AG (math.NT) — L — wave 1 (families layer wave 3)
> Hodge tensors, and the Mumford–Tate group of a ℚ-Hodge structure as the smallest ℚ-subgroup of
> `GL(V) × G_m` containing `h(S)`, with its Tannakian and stabilizer-of-Hodge-tensors
> descriptions; reductivity for polarizable structures; CM ⇔ MT is a torus ⇔ special point;
> elliptic curves (GL₂ versus a CM torus); Mumford–Tate domains; generic Mumford–Tate groups in a
> VHS.

Delivers #40. Prerequisites: TC Completed/HodgeStructures; TC ReductiveGroups L4–L6; Tau Ceti
Tannakian reconstruction (code); CB RG2.0a (Deligne torus via Weil restriction), shared with
ShimuraData D1; VariationsOfHodgeStructure for the last layer.

### Automorphic and arithmetic (#8, #13, #19, #24, #31)

**MaassFormsAndSpectralTheory** — math.NT (math.SP) — L — wave 2
> For Fuchsian groups of the first kind: the hyperbolic Laplacian on `Γ\ℍ`; real-analytic
> Eisenstein series `E(z, s)` with continuation and functional equation; Maass cusp forms and
> their K-Bessel Fourier expansions; Hecke operators and Hecke–Maass eigenforms; Selberg's
> spectral decomposition of `L²(Γ\ℍ)` (constants, cusp forms, continuous spectrum), with
> `λ₁ > 0` and the statement of Selberg's eigenvalue conjecture.

Delivers #13. Prerequisites: TC FuchsianOrbifolds; TC ModularForms; the Laplace-eigenvalue and
locally-symmetric-space roadmaps proposed for #86/#77 by the analysis and geometry shares.
Classical companion to CB AutomorphicSpectralTheory.

**RelativeTraceFormulas** — math.NT (math.RT) — XL — wave 4
> Symmetric pairs and spherical subgroups; relative orbital integrals and their convergence for
> relatively regular semisimple elements; the Jacquet–Rallis relative trace formulas for
> `U(n) × U(n+1)` versus `GL_n × GL_{n+1}`, the Jacquet–Rallis fundamental lemma as a statement,
> with small-rank cases proved.

Delivers the rest of #19. Prerequisites: CB AutomorphicSpectralTheory AS.6; EndoscopicTransfer
ET.1; SmoothRepresentationsOfLocalGroups SR.1.

**ArthurParameters** — math.NT (math.RT) — XL (statements) — wave 4
> Local and global Arthur parameters for quasi-split classical groups via twisted `GL_N`: formal
> sums `⊞ π_i ⊠ ν_{n_i}` of self-dual cuspidal representations with orthogonal/symplectic type
> (from symmetric- and exterior-square L-functions); the associated L-parameters `φ_ψ`; component
> groups `S_ψ` and the sign character; local and global A-packets and the multiplicity formula, as
> statements. Tests: `SL₂`/`PGL₂`, with `1 ⊞ ν₂` as the residual spectrum.

Delivers #31. Prerequisites: CB AutomorphicSpectralTheory AS.4; ET.6 (LLC for GL_n);
AutomorphicLFunctionsAndLocalFactors; RG2.5.

**ArakelovIntersectionTheory** — math.NT (math.AG) — L — wave 3
> Adelically metrized line bundles on projective varieties over number fields (Zhang): model,
> semipositive and integrable metrics; local and global heights of points and subvarieties; the
> Weil height machine; canonical heights for polarized dynamical systems and abelian varieties;
> arithmetic intersection numbers by Deligne pairing or local heights; arithmetic nef and big;
> Northcott for arithmetically ample bundles.

Delivers the rest of #24. Prerequisites: PR#287 ArithmeticHeights; TC EllipticCurves L6; CB TB.6,
R35.1, RP.0; IntersectionTheory; PositivityOfLineBundles.

**ReductiveGroupSchemes** — math.AG (math.GR) — XL — wave 2
> SGA 3 XIX–XXVI: reductive group schemes over an arbitrary base; maximal tori étale-locally;
> the étale-local root datum and its type; split forms; Demazure's isomorphism and existence
> theorems over any base; automorphism schemes and the classification of forms by
> `Out`-torsors.

Turns ReductiveGroups L8 ("long horizon") into a definite target; delivers the base part of #8.
Prerequisites: TC ReductiveGroups L6–L7; PR#447 ChevalleyGroups; AlgebraicSpaces (fppf torsors).

### Dependency order (waves)

1. IntersectionTheory, ToricVarieties, AlgebraicSpaces, CoherentDuality, TopologicalSixOperations,
   SingularitiesOfPairs (all-models layers), MumfordTateGroups (field layers).
2. PositivityOfLineBundles, PicardSchemes, ValuationSpacesOfVarieties, AlgebraicStacks,
   MicrolocalSheafTheory, AlgebraicDModules, VariationsOfHodgeStructure, KodairaVanishingTheorems,
   MaassFormsAndSpectralTheory, ReductiveGroupSchemes, SlopeStability (HN layers).
3. GoodModuliSpaces, ModuliOfStableCurves, SlopeStability (moduli), PerverseSheavesOnComplexVarieties,
   BeilinsonBernsteinLocalization, ArakelovIntersectionTheory, KStabilityOfFanoVarieties.
4. HiggsBundlesAndHitchinFibration, RelativeTraceFormulas, ArthurParameters (the last two wait
   on the campaign's automorphic stack).

## 3. Early promotions

Each item below lies on the critical path of several Annals definitions and is currently either
a stage buried in an arithmetic campaign roadmap or an unmerged PR.

1. **PR#196 CohomologicalPointCounting** (open since September; 7 child roadmaps). It is the
   étale owner for #3 and #45 and the base for #5, #16, #41, #14 (realizations) and #32, and the
   campaign's EDC, LPV, WeilConjectures, MotivicEtaleKTheory and SchemeKTheoryOperations all cite
   it as "PR196". Merging it unblocks more of this list than any other single action.
2. **CB AlgebraicModuliForArithmeticGeometry R09.7**: promote as a standalone math.AG roadmap,
   **ResolutionOfSingularities** (Bierstone–Milman, characteristic zero, embedded and log
   resolution). It consumes TC StableReduction L4 blowups. It is needed by #18, #48, #50 and #39
   (and by CB ShimuraVarieties V3). AbundanceStatement deliberately avoids it.
3. **CB SchemeAndStackFoundations SF.5** → IntersectionTheory, together with **R09.1**
   (projective, Grassmann and flag bundles; also AlgebraicVectorBundles' successor #1). Needed by
   #12, #33, #14, #22, #24, #49, and by CB WeilConjectures WC.5's surface route.
4. **CB R09.2–R09.5 and SF.1** (Hilbert/Quot, algebraic spaces, stacks, coarse spaces) →
   AlgebraicSpaces, AlgebraicStacks and a math.AG home for Hilbert/Quot schemes. Needed by #6,
   #9, #25, #49, and by the moduli layers of #44 and #36.
5. **CB ReductiveGroupsPartII** (distance 7), especially RG2.0a (Weil restriction, Deligne torus),
   RG2.2–RG2.3 and RG2.5. Needed by #23, #26, #43, #29, #31, #40 and #20.
6. **CB SmoothRepresentationsOfLocalGroups SR.0–SR.4** and **AdelicAlgebraicGroups /
   AutomorphicFormsOnReductiveGroups** (distance 5–8). Needed by #4, #13, #19, #29, #31, #43.
7. Cheap campaign wins that are worth taking early:
   - **PadicMeasuresIwasawaAlgebras** (distance 4), for #30 and #37; it must consume Tau Ceti's
     existing `completedGroupAlgebra`.
   - **PrismaticCohomology PR.0** (δ-rings and prisms; no heavy prerequisites), for #51.
   - **PerfectoidSpaces P0–P1**, for #27.

## 4. Duplication risks (two sources building the same object)

- **Blowups**: TC StableReduction L4 already owns Rees-algebra blowups of quasi-coherent ideals,
  with the universal property and charts. CB R09.7a re-specifies them; Tau Ceti code has
  `affineBlowup`. R09.7a should import from StableReduction.
- **Étale fundamental group**: PR#196 ConstructibleEtale L3 and CB InverseGalois IG.0 both
  construct the Galois category of finite étale covers with its fibre functor. IG.0 should consume
  PR#196.
- **Chow groups and Chern classes**: CB SF.5, MotivesAndAlgebraicCycles MC.0, SchemeKTheoryOperations
  S.7 (Chern classes, Chern character), the AlgebraicVectorBundles successor sketch, and
  Mathlib's `AlgebraicCycle`. One owner is needed (IntersectionTheory); the others should consume it.
- **Intersection numbers**: PR#545 L4D (Hilbert-polynomial intersection numbers for
  Nakai–Moishezon), TC StableReduction L4 (arithmetic surfaces) and CB SF.5. IntersectionTheory
  should absorb the general statement; PR#545 can keep its curve-testing layer.
- **Projective/Grassmann bundles**: AlgebraicVectorBundles successor #1 and CB R09.1.
- **Picard functor**: TC JacobianChallenge L-D (curves; Tau Ceti code `rigidifiedPicardFunctor`),
  CB A0-extension/A2 (abelian schemes), PR#545 L4B (numerical NS finiteness), and proposed
  PicardSchemes. Assign the general projective case to PicardSchemes and keep the others as
  specializations.
- **Abelian varieties over a field and over a base**: JacobianChallenge L-E (dual, polarizations)
  against CB AbelianSchemes A1–A3. A6 already says it extends JacobianChallenge. The dual and the
  polarization should be built once, over a base.
- **Coherent cohomology and base change**: JacobianChallenge L-B/C, StableReduction L2 and CB
  A0-extension all claim pushforward, semicontinuity and base change. StableReduction already has
  contracts with JacobianChallenge; A0-extension should extend those, not restart.
- **Relative dualizing sheaf / Serre duality**: JacobianChallenge (smooth curves), StableReduction L2
  (nodal curves), and proposed CoherentDuality (general). CoherentDuality must specialize to the
  existing curve constructions.
- **Nagata compactification**: PR#196 CompactSupport L1; CB AdicCoefficients L2 (qcqs extension);
  needed again by CoherentDuality. Single owner: PR#196.
- **Hitchin geometry**: CB ET.2b builds G-Higgs fields, the Hitchin base and spectral covers for
  the fundamental lemma, against proposed HiggsBundlesAndHitchinFibration.
- **HN filtrations**: CB VectorBundlesAndIsocrystals (Fargues–Fontaine curve) and GlobalShtukas
  (Bun_G HN strata) each build an HN formalism. Proposed SlopeStabilityAndHarderNarasimhan should
  own the abstract one.
- **Perverse t-structures and Verdier duality**: CB EDC.1/EDC.5 (ℓ-adic), CB ALS.5 (manifolds with
  corners), and proposed TopologicalSixOperations/PerverseSheavesOnComplexVarieties. The abstract
  recollement and gluing of t-structures should have one owner.
- **VHS**: CB ShimuraData D3 defines homogeneous VHS. It should consume VariationsOfHodgeStructure
  (issue #167) rather than define VHS a second time.
- **Deligne torus and Weil restriction**: CB RG2.0a (designated owner), ShimuraData D1, AbelianSchemes
  A6 and R09.3 (Weil restriction as an algebraic space); MumfordTateGroups must consume RG2.0a.
- **Klt**: PR#545 defines klt for `(X, 0)` through discrepancies over all models. SingularitiesOfPairs
  must extend that predicate to pairs, not introduce a parallel one.
- **Iwasawa algebra**: CB PadicMeasuresIwasawaAlgebras L1 ("completed group rings") against the
  existing Tau Ceti `completedGroupAlgebra` and `powerSeriesCoordinate`.
- **Satake**: CB SR.4, Tau Ceti code (GL_n Hecke rings) and TC ModularForms (LMFDB Satake
  parameters) should share SR.4's normalization dictionary.

## 5. Notes for the planner

- The arithmetic half of this list (#4, #11, #14, #20, #21, #23, #26, #27, #29, #30, #32, #43,
  #46, #47, #51) needs no new roadmaps. What it needs is for the campaign's foundational stages to
  be promoted ahead of their arithmetic consumers. Most of them sit at campaign distance 7–10.
- The campaign's thin "curriculum extension" roadmaps (SchemeAndStackFoundations,
  MotivesAndAlgebraicCycles, InverseGalois, HeightsRationalPoints, TropicalAndBerkovich) state
  targets in one paragraph per stage. I counted them as owners, but each needs a real roadmap
  before workers can use it. The IntersectionTheory proposal is that rewrite for SF.5.
- I did not find a definite owner for: the Albert classification (#1), GL_n multiplicity one
  (#4), Moy–Prasad filtrations (#23), Torelli (#17), arc topology (#35). Each is small enough to
  add to its natural owner (AbelianSchemes A6, AutomorphicSpectralTheory, ReductiveGroupsPartII
  RG2.3, JacobianChallenge, AlgebraicSpaces).
