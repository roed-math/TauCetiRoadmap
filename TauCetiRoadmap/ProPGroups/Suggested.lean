import Mathlib

/-!
# Pro-p and Demushkin groups: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap. `sorry` is allowed in this human-owned roadmap
library: these are goals, not proofs.

Pinned Mathlib (`9caeba1000`, 2026-06-03) has the `ProfiniteGrp` category with limits, the
finite-quotient limit description, and the profinite completion adjunction, but **no**
continuous cohomology (master grew `RepresentationTheory/Homological/ContCohomology/` in
June–July 2026, still without explicit `H¹`/`H²` or cup products). Consequently the
milestones whose statements are inherently cohomological (the presentation rank
interpretations (Layer 5), cohomological dimension (Layer 6), the Demushkin predicate and
the canonical character (Layer 7), the classification (Layer 9), and the arithmetic
statements of Layer 11) cannot be written as Lean declarations here. They are specified in
`README.md`, and the intended declaration headers are reproduced in the pseudocode block at
the end of this file so that their hypotheses are unambiguous; we do not fake their
conditions with stand-in predicates or empty `Prop` fields.

What *is* statable at the pin is below: the profinite foundations, the supernatural order
and index, Sylow theory, the pro-`p`/Frattini/generation layers, the free pro-`C` class
formalism and free pro-`p` groups with their universal property, the finite-quotient
determinacy (reconstruction) theorem, the lower `p`-series, the closed-subgroup theory of
`ℤ₂ˣ`, and the presentation-level worked examples, including the group
`D₀ = ⟨A, S, Y ∣ A²S⁴(S,Y)⟩` of the dyadic acceptance instance.

The `def`s in the Prototypes section pin suggested *forms* for the objects the examples
mention (each is also a design decision recorded in `README.md`); they are prototypes, not
proved-out API.
-/

namespace TauCetiRoadmap.ProPGroups

open CategoryTheory

universe u v w

/-! ## Prototypes: suggested forms for the basic objects -/

section Prototypes

variable (p : ℕ)

/-- **Pro-`p`, in quotient form** (the pinned definition; the inverse-limit description is a
derived milestone, Layer 3). A topological group is pro-`p` when each of its continuous finite
quotients, that is each quotient by an open normal subgroup, is a `p`-group. For a profinite
group this is the usual notion. -/
def IsProP (G : Type u) [Group G] [TopologicalSpace G] : Prop :=
  ∀ U : OpenNormalSubgroup G, IsPGroup p (G ⧸ U.toSubgroup)

/-- **Topological finite generation**: some finite subset generates a dense subgroup. This is
the predicate the local-fields roadmap's finite-generation theorem (its `B1` layer) produces
and the reconstruction theorem (Layer 8) consumes; keep this exact shape. -/
def IsTopologicallyFinitelyGenerated (G : Type u) [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] : Prop :=
  ∃ s : Finset G, (Subgroup.closure (s : Set G)).topologicalClosure = ⊤

/-- A subset **converges to `1`**: every open normal subgroup omits only finitely many of its
elements. Finite sets converge to `1`, and for a profinite group this is the condition under
which a generating set has a well-behaved cardinality (Layer 3). -/
def ConvergesToOne {G : Type u} [Group G] [TopologicalSpace G] (s : Set G) : Prop :=
  ∀ U : OpenNormalSubgroup G, {x ∈ s | x ∉ U.toSubgroup}.Finite

/-- **Topological generator rank, cardinal-valued**: the least cardinality of a subset
converging to `1` and generating a dense subgroup. This is the form all general rank theorems
take (bases, rank invariance, monotonicity, the infinite-rank theory of Layer 10). Every
profinite group has a generating set converging to `1` (RZ Prop. 2.6.2, a Layer 3 milestone),
so the infimum is over a nonempty family.

⚠ Dropping `ConvergesToOne` changes the invariant: a product of continuum many copies of
`ℤ/p` has a countable dense subgroup but needs `2 ^ ℵ₀` generators converging to `1`. -/
noncomputable def topologicalGeneratorRank (G : Type u) [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] : Cardinal.{u} :=
  ⨅ s : {s : Set G // ConvergesToOne s ∧ (Subgroup.closure s).topologicalClosure = ⊤},
    Cardinal.mk ↥s.1

/-- **Topological generator rank, natural-number accessor**, available exactly when the group
is topologically finitely generated. Every numerical rank statement (finite presentations,
deficiency, the Schreier and Euler formulas, anything involving subtraction) is about this
declaration, never about `topologicalGeneratorRank`. The two are tied together by the theorem
`(topologicalGeneratorRankNat G h : Cardinal) = topologicalGeneratorRank G` below. -/
noncomputable def topologicalGeneratorRankNat (G : Type u) [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] (_h : IsTopologicallyFinitelyGenerated G) : ℕ :=
  sInf {n : ℕ | ∃ s : Finset G,
    s.card = n ∧ (Subgroup.closure (s : Set G)).topologicalClosure = ⊤}

/-- The **pro-`p` kernel**: the intersection of the open normal subgroups with `p`-group
quotient. The **maximal pro-`p` quotient** is `maximalProPQuotient p G`, below; `G(p)` is
prose for it, and no other name for either object appears in this roadmap. -/
def proPKernel (G : Type u) [Group G] [TopologicalSpace G] : Subgroup G :=
  ⨅ U : {U : OpenNormalSubgroup G // IsPGroup p (G ⧸ U.toSubgroup)}, U.1.toSubgroup

instance proPKernel_normal (G : Type u) [Group G] [TopologicalSpace G] :
    (proPKernel p G).Normal :=
  Subgroup.normal_iInf_normal fun U ↦ U.1.isNormal'

/-- The **maximal pro-`p` quotient** `G(p) = G ⧸ proPKernel p G`. -/
abbrev maximalProPQuotient (G : Type u) [Group G] [TopologicalSpace G] : Type u :=
  G ⧸ proPKernel p G

/-- **`p`-Sylow subgroup of a profinite group**: a closed pro-`p` subgroup whose image in
every continuous finite quotient has index prime to `p` (equivalently: whose supernatural
index is prime to `p`, Layer 1). -/
def IsProPSylow {G : Type u} [Group G] [TopologicalSpace G] (P : Subgroup G) : Prop :=
  IsClosed (P : Set G) ∧ IsProP p P ∧
    ∀ U : OpenNormalSubgroup G, ¬ p ∣ (P.map (QuotientGroup.mk' U.toSubgroup)).index

/-- **Supernatural numbers** (Steinitz orders): formal products `∏_p p^(n_p)` with
`n_p ∈ ℕ∞`, recorded as their exponent functions. Divisibility, product, gcd/lcm, and the
finite-embedding API are Layer 1. This is the only use of `ℕ∞` in the roadmap; generator
counts are cardinals or naturals, never `ℕ∞`. -/
abbrev Supernatural : Type := Nat.Primes → ℕ∞

/-- The **order** of a profinite group as a supernatural number: at each prime, the supremum
of the `p`-valuations of its continuous finite quotients. -/
noncomputable def profiniteOrder (G : Type u) [Group G] [TopologicalSpace G] : Supernatural :=
  fun p ↦ ⨆ U : OpenNormalSubgroup G, (padicValNat p (Nat.card (G ⧸ U.toSubgroup)) : ℕ∞)

/-- The **index of a closed subgroup**, in the pinned primewise form: at each prime `ℓ`, the
supremum over open normal `N` of `v_ℓ [G/N : HN/N]`. The definition is written for arbitrary
`H`; closedness of `H` is a hypothesis of the theorems about it, in particular of the
equivalence with `lcm {[G : U] | U open, H ≤ U}` (Layer 1), which fails without it. -/
noncomputable def profiniteIndex {G : Type u} [Group G] [TopologicalSpace G]
    (H : Subgroup G) : Supernatural :=
  fun ℓ ↦ ⨆ N : OpenNormalSubgroup G,
    (padicValNat ℓ ((H.map (QuotientGroup.mk' N.toSubgroup)).index) : ℕ∞)

/-- The **Frattini subgroup of a pro-`p` group**, in index-`p` form: the intersection of the
open normal subgroups of index `p`. (For pro-`p` `G` these are exactly the maximal open
subgroups, and this agrees with `closure (Gᵖ[G,G])`, the Layer 3 milestones; the definition
is stated so that it makes sense for any topological group.) -/
def proPFrattini (G : Type u) [Group G] [TopologicalSpace G] : Subgroup G :=
  ⨅ U : {U : OpenNormalSubgroup G // U.toSubgroup.index = p}, U.1.toSubgroup

instance proPFrattini_normal (G : Type u) [Group G] [TopologicalSpace G] :
    (proPFrattini p G).Normal :=
  Subgroup.normal_iInf_normal fun U ↦ U.1.isNormal'

/-- The topological closure of a normal subgroup is normal, wrapping Mathlib's
`Subgroup.is_normal_topologicalClosure`, which is deliberately not an instance there. We make
it a **scoped** instance rather than a global one: it fires on every `topologicalClosure`
goal, and a global instance would compete with more specific ones in downstream files. Anyone
who wants the convenience writes `open scoped TauCetiRoadmap.ProPGroups`. -/
scoped instance normal_topologicalClosure {G : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] (N : Subgroup G) [N.Normal] : N.topologicalClosure.Normal :=
  Subgroup.is_normal_topologicalClosure N

/-- One step of the **lower `p`-series**: `H ↦ closure (Hᵖ ⬝ [H, G])`, the topological
closure of the subgroup generated by the `p`-th powers from `H` and the commutators
`[H, G]`. -/
def pLowerCentralStep {G : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    (H : Subgroup G) : Subgroup G :=
  (Subgroup.closure ((· ^ p) '' (H : Set G)) ⊔ ⁅H, (⊤ : Subgroup G)⁆).topologicalClosure

/-- The **lower `p`-series** (descending `p`-central series), 0-based to match Mathlib's
`lowerCentralSeries`: `λ₀ = G`, `λ_{k+1} = closure (λ_kᵖ [λ_k, G])`. Labute's `F_i`
(1-based) is `pLowerCentralSeries p F (i - 1)`; his `F₃` is our `λ₂`. -/
def pLowerCentralSeries (G : Type u) [Group G] [TopologicalSpace G] [IsTopologicalGroup G] :
    ℕ → Subgroup G
  | 0 => ⊤
  | k + 1 => pLowerCentralStep p (pLowerCentralSeries G k)

end Prototypes

/-! ### The class `C` of finite groups, as a structure

Not a loose predicate: the completion, the `C`-kernel, and the free pro-`C` group are all
defined from this data, and `finiteGroupClassP` instantiates it at finite `p`-groups. Closure
under finite products is a consequence of `mem_trivial` and `mem_extension`, so it is a
theorem rather than a field. -/

/-- A **class of finite groups** closed under isomorphism, subgroups, quotients, and
extensions: the data a pro-`C` completion needs. Universe-polymorphic in the groups it
speaks about; the resizing policy of `README.md` (transport a higher-universe finite group
through `Shrink`, which is harmless by `mem_congr`) is what relates the instantiations at
different universes. -/
structure FiniteGroupClass where
  /-- Membership of a finite group in the class. -/
  mem : ∀ (H : Type w) [Group H] [Finite H], Prop
  /-- Membership depends only on the isomorphism class. -/
  mem_congr : ∀ {H K : Type w} [Group H] [Finite H] [Group K] [Finite K],
    (H ≃* K) → (mem H ↔ mem K)
  /-- The trivial group is in the class. -/
  mem_trivial : mem PUnit
  /-- The class is closed under subgroups. -/
  mem_subgroup : ∀ {H : Type w} [Group H] [Finite H], mem H → ∀ K : Subgroup H, mem K
  /-- The class is closed under quotients. -/
  mem_quotient : ∀ {H : Type w} [Group H] [Finite H], mem H →
    ∀ (N : Subgroup H) [N.Normal], mem (H ⧸ N)
  /-- The class is closed under extensions. -/
  mem_extension : ∀ {H : Type w} [Group H] [Finite H] (N : Subgroup H) [N.Normal],
    mem N → mem (H ⧸ N) → mem H

/-- Finite `p`-groups, the instantiation everything in Layers 4–9 uses. -/
noncomputable def finiteGroupClassP (p : ℕ) : FiniteGroupClass.{u} where
  mem H := IsPGroup p H
  mem_congr := sorry
  mem_trivial := sorry
  mem_subgroup := sorry
  mem_quotient := sorry
  mem_extension := sorry

/-- The **`C`-kernel**: the intersection of the open normal subgroups whose quotient lies in
the class. `proCKernel (finiteGroupClassP p) G = proPKernel p G` is a Layer 4 milestone. -/
def proCKernel (C : FiniteGroupClass.{u}) (G : Type u) [Group G] [TopologicalSpace G] :
    Subgroup G :=
  ⨅ U : {U : OpenNormalSubgroup G //
    ∃ _ : Finite (G ⧸ U.toSubgroup), C.mem (G ⧸ U.toSubgroup)}, U.1.toSubgroup

instance proCKernel_normal (C : FiniteGroupClass.{u}) (G : Type u) [Group G]
    [TopologicalSpace G] : (proCKernel C G).Normal :=
  Subgroup.normal_iInf_normal fun U ↦ U.1.isNormal'

/-! ## Prototypes: free objects, presentations, and the dyadic instance -/

section FreeObjects

variable (p : ℕ)

/-- The **free profinite group** on `X`: the profinite completion of the discrete free group
(pinned construction; the universal property is what pins it down). -/
noncomputable abbrev freeProfiniteGroup (X : Type u) : ProfiniteGrp.{u} :=
  ProfiniteGrp.profiniteCompletion.obj (GrpCat.of (FreeGroup X))

/-- The generators of the free profinite group. -/
noncomputable def freeProfiniteGroup.of {X : Type u} (x : X) : freeProfiniteGroup X :=
  ProfiniteGrp.ProfiniteCompletion.etaFn (GrpCat.of (FreeGroup X)) (FreeGroup.of x)

/-- The **free pro-`C` group** on `X`: the `C`-completion of the free profinite group. -/
noncomputable abbrev freeProC (C : FiniteGroupClass.{u}) (X : Type u) : Type u :=
  freeProfiniteGroup X ⧸ proCKernel C (freeProfiniteGroup X)

/-- The **free pro-`p` group** on `X`: the maximal pro-`p` quotient of the free profinite
group (equivalently, the pro-`p` completion of the discrete free group). That this agrees
with `freeProC (finiteGroupClassP p) X` is a Layer 4 milestone, not a coincidence. -/
noncomputable abbrev freeProP (X : Type u) : Type u :=
  maximalProPQuotient p (freeProfiniteGroup X)

/-- The generators of the free pro-`p` group. -/
noncomputable def freeProP.of {X : Type u} (x : X) : freeProP p X :=
  QuotientGroup.mk (freeProfiniteGroup.of x)

/-- The pro-`p` group **presented** by generators `X` and relators `rels`: the free pro-`p`
group modulo the *closed* normal closure of the relators (closedness is what keeps the
quotient profinite; the algebraic normal closure need not be closed). -/
noncomputable abbrev presentedProP (X : Type u) (rels : Set (freeProP p X)) : Type u :=
  freeProP p X ⧸ (Subgroup.normalClosure rels).topologicalClosure

/-- The dyadic Demushkin relator `A²S⁴(S,Y)` in the free pro-`2` group on `A, S, Y`
(`= of 0, of 1, of 2`), written out in Labute's commutator convention
`(x, y) = x⁻¹y⁻¹xy` (see the conventions in `README.md`). -/
noncomputable def d0Relator : freeProP 2 (Fin 3) :=
  freeProP.of 2 0 ^ 2 * freeProP.of 2 1 ^ 4 *
    ((freeProP.of 2 1)⁻¹ * (freeProP.of 2 2)⁻¹ * freeProP.of 2 1 * freeProP.of 2 2)

/-- **`D₀ = ⟨A, S, Y ∣ A²S⁴(S,Y) = 1⟩`**, the rank-3, `q = 2` dyadic Demushkin group, the
Layer 11 acceptance instance (`G_{ℚ₂}(2) ≅ D₀`), defined intrinsically as a presented
pro-`2` group. -/
noncomputable abbrev demushkinD0 : Type := presentedProP 2 (Fin 3) {d0Relator}

/-- The **topological abelianization** `G^{ab} = G ⧸ closure [G,G]`, the profinite
abelianization when `G` is profinite and the home of the `q`-invariant. -/
abbrev topAbelianization (G : Type u) [Group G] [TopologicalSpace G] [IsTopologicalGroup G] :
    Type u :=
  G ⧸ (commutator G).topologicalClosure

open Classical in
/-- **Labute's `q`-invariant, interim prototype.** `0` if the topological abelianization is
torsion-free (Labute's `q = p^∞ = 0` convention), and otherwise the number of its torsion
elements, which for a Demushkin group `G`, where `G^{ab} ≅ ℤ_p^{n-1} × ℤ/q`, is exactly `q`.

⚠ **The finiteness argument is temporary and must disappear.** The final API takes the
Demushkin hypothesis and derives finiteness and cyclicity of the torsion internally, from the
Layer 4 structure theorem for finitely generated abelian pro-`p` groups:

```
noncomputable def demushkinQ (p : ℕ) (G : Type u) [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G]
    (hG : IsDemushkin p G) : ℕ
```

with `demushkinQ_eq_zero_iff`, `demushkinQ_isPrimePow_or_zero`, and invariance under
topological isomorphism as its API. No downstream statement may expose a proof witness in the
*value* of the invariant, which is exactly what the version below does; it exists only so
that the `D₀` computation is expressible before `IsDemushkin` is. -/
noncomputable def demushkinQ (G : Type u) [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G]
    (_hfinite : Finite {x : topAbelianization G // IsOfFinOrder x}) : ℕ := by
  letI := _hfinite
  exact if ∀ x : topAbelianization G, IsOfFinOrder x → x = 1 then 0
    else Nat.card {x : topAbelianization G // IsOfFinOrder x}

/-- `ℤ̂`, the profinite completion of `ℤ` (a stress-test object for Layers 0–2). -/
noncomputable abbrev zHat : Type :=
  ProfiniteGrp.profiniteCompletion.obj (GrpCat.of (Multiplicative ℤ))

end FreeObjects

/-! ### The closed subgroups of `ℤ₂ˣ` (Layer 7)

Named forms for the three families of Labute's trichotomy. `U^(f) = 1 + 2^f ℤ₂` is the
kernel of reduction mod `2^f`; the convention `f = ∞`, meaning `{1}`, is the subgroup `⊥` and
is not a value of these `ℕ`-indexed definitions. -/

/-- `U^(f) = 1 + 2^f ℤ₂`, the principal unit subgroup of level `f`. -/
noncomputable def unitsPrincipal (f : ℕ) : Subgroup ℤ_[2]ˣ :=
  MonoidHom.ker (Units.map (PadicInt.toZModPow (p := 2) f).toMonoidHom)

/-- `{±1} × U^(f)`, the subgroup generated by `-1` together with `U^(f)`. At `f = ∞` this
degenerates to `{±1} = Subgroup.closure {-1}`, which the trichotomy lists separately. -/
noncomputable def unitsPlusMinus (f : ℕ) : Subgroup ℤ_[2]ˣ :=
  unitsPrincipal f ⊔ Subgroup.closure {(-1 : ℤ_[2]ˣ)}

/-- The closed subgroup topologically generated by a single unit. Labute's
`U^[f] = closure ⟨-1 + 2^f⟩` (`2 ≤ f < ∞`) is `procyclicClosure u` for the unit `u` with
`(u : ℤ_[2]) = -1 + 2 ^ f`; naming the generator rather than building it keeps the definition
free of an `IsUnit` side condition. -/
noncomputable def procyclicClosure (u : ℤ_[2]ˣ) : Subgroup ℤ_[2]ˣ :=
  (Subgroup.closure {u}).topologicalClosure

/-! ### Occurring as a continuous finite quotient (Layer 8)

Phrased through the kernel rather than through a topology on `Q`: a homomorphism to a finite
*discrete* group is continuous exactly when its kernel is open. That keeps the predicate
manifestly invariant under isomorphism of `Q` and lets the reconstruction theorem quantify
over bundled finite groups instead of over arbitrary topology-bearing types. -/

/-- `Q` occurs as a continuous finite quotient of `G`. -/
def IsFiniteContinuousQuotient (G : Type u) [Group G] [TopologicalSpace G]
    (Q : FiniteGrp.{v}) : Prop :=
  ∃ f : G →* Q, Function.Surjective f ∧ IsOpen ((f.ker : Subgroup G) : Set G)

/-! ## Layer 0: profinite foundations -/

/-- **Layer 0, quotients by closed normal subgroups are profinite.** Compactness and the
topological-group property are already instances; the missing ingredient is total
disconnectedness of `G ⧸ N` for `N` closed. (Migrated mathematics: the clopen-basis
argument.) -/
example {G : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] (N : Subgroup G) [N.Normal] (hN : IsClosed (N : Set G)) :
    TotallyDisconnectedSpace (G ⧸ N) :=
  sorry

/-- **Layer 0, the completion of a finite group is itself.** The unit of the profinite
completion adjunction is bijective on a finite (discrete) group: the non-vacuity check for
the completion layer. -/
example {G : Type u} [Group G] [Finite G] :
    Function.Bijective (ProfiniteGrp.ProfiniteCompletion.etaFn (GrpCat.of G)) :=
  sorry

/-! ## Layer 1: the supernatural order and index -/

/-- **Layer 1, the order of a finite group.** On a finite discrete group the supernatural
order is the prime factorization of `Nat.card G`, the compatibility that keeps
`profiniteOrder` honest. -/
example {G : Type u} [Group G] [TopologicalSpace G] [DiscreteTopology G] [Finite G]
    (p : Nat.Primes) : profiniteOrder G p = (padicValNat p (Nat.card G) : ℕ∞) :=
  sorry

/-- **Layer 1, the index of an open subgroup.** The supernatural index of an open subgroup is
the factorization of Mathlib's `Nat.card`-valued `Subgroup.index`, the compatibility that
pins `profiniteIndex` against the existing API. -/
example {G : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] (U : OpenSubgroup G) (ℓ : Nat.Primes) :
    profiniteIndex U.toSubgroup ℓ = (padicValNat ℓ U.toSubgroup.index : ℕ∞) :=
  sorry

/-- **Layer 1, the index of a closed subgroup as an lcm.** For closed `H`, the primewise
definition agrees with the supremum, over open subgroups above `H`, of their indices. This is
the description the literature uses; it fails for non-closed `H`, which is why closedness is
a hypothesis here and not decoration. -/
example {G : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] (H : Subgroup G) (hH : IsClosed (H : Set G))
    (ℓ : Nat.Primes) :
    profiniteIndex H ℓ = ⨆ U : {U : OpenSubgroup G // H ≤ U.toSubgroup},
      (padicValNat ℓ U.1.toSubgroup.index : ℕ∞) :=
  sorry

/-- **Layer 1, Lagrange.** The supernatural order of a profinite group is the product of the
order of a closed subgroup and its index (Ribes–Zalesskii §2.3). -/
example {G : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] (H : Subgroup G) (hH : IsClosed (H : Set G))
    (ℓ : Nat.Primes) :
    profiniteOrder G ℓ = profiniteOrder H ℓ + profiniteIndex H ℓ :=
  sorry

/-- **Layer 1 ↔ 3, pro-`p` means order a power of `p`.** A profinite group is pro-`p` iff its
supernatural order is supported at `p` alone. -/
example {p : ℕ} [Fact p.Prime] {G : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G] :
    IsProP p G ↔ ∀ q : Nat.Primes, (q : ℕ) ≠ p → profiniteOrder G q = 0 :=
  sorry

/-! ## Layer 2: profinite Sylow theory -/

/-- **Layer 2, existence of `p`-Sylow subgroups.** Every profinite group has a `p`-Sylow
subgroup (inverse limit of Sylow subgroups at the finite levels; compactness supplies the
limit point). -/
example (p : ℕ) [Fact p.Prime] {G : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G] :
    ∃ P : Subgroup G, IsProPSylow p P :=
  sorry

/-- **Layer 2, conjugacy of `p`-Sylow subgroups.** Any two `p`-Sylow subgroups of a profinite
group are conjugate. -/
example {p : ℕ} [Fact p.Prime] {G : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G] {P Q : Subgroup G}
    (hP : IsProPSylow p P) (hQ : IsProPSylow p Q) :
    ∃ g : G, Q = P.map (MulAut.conj g).toMonoidHom :=
  sorry

/-- **Layer 2, Galois instance.** The Galois group of any Galois extension, in its Krull
topology, has a `p`-Sylow subgroup (the group-theoretic half of "maximal prime-to-`p`
subextensions exist"; the fixed-field dictionary belongs to the Galois-correspondence API). -/
example (p : ℕ) [Fact p.Prime] {k K : Type u} [Field k] [Field K] [Algebra k K]
    [IsGalois k K] : ∃ P : Subgroup (K ≃ₐ[k] K), IsProPSylow p P :=
  sorry

/-- **Layer 2, the `p`-Sylow subgroup of `ℤ̂`.** Every `p`-Sylow subgroup of the profinite
completion of `ℤ` is isomorphic, as a topological group, to `ℤ_p`. Stated here, proved in
Layer 4 through the chain of universal properties; in particular **not** through a product
decomposition `ℤ̂ ≅ ∏_ℓ ℤ_ℓ`, which is not a target of this roadmap. -/
example (p : ℕ) [Fact p.Prime] (P : Subgroup zHat) (hP : IsProPSylow p P) :
    Nonempty (P ≃ₜ* Multiplicative ℤ_[p]) :=
  sorry

/-! ## Layer 3: pro-`p` groups, the maximal pro-`p` quotient, Frattini theory, generation -/

/-- **Layer 3, the maximal pro-`p` quotient is pro-`p`.** (Compactness argument: an open
normal subgroup containing the pro-`p` kernel already contains a member of the defining
family.) -/
example {p : ℕ} {G : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    [CompactSpace G] [TotallyDisconnectedSpace G] : IsProP p (maximalProPQuotient p G) :=
  sorry

/-- **Layer 3, universal property of the maximal pro-`p` quotient.** Continuous homomorphisms
from `G` to a pro-`p` profinite group factor uniquely through `G(p)`. -/
example {p : ℕ} {G : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    [CompactSpace G] [TotallyDisconnectedSpace G] {P : Type v} [Group P] [TopologicalSpace P]
    [IsTopologicalGroup P] [CompactSpace P] [TotallyDisconnectedSpace P] (hP : IsProP p P)
    (f : G →* P) (hf : Continuous f) :
    ∃! g : maximalProPQuotient p G →* P,
      Continuous g ∧ ∀ x : G, g (QuotientGroup.mk x) = f x :=
  sorry

/-- **Layer 3, the pro-`p` kernel is closed.** -/
example {p : ℕ} {G : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    [CompactSpace G] [TotallyDisconnectedSpace G] :
    IsClosed ((proPKernel p G : Subgroup G) : Set G) :=
  sorry

/-- **Layer 3, the pro-`p` kernel is topologically characteristic.** Invariance under
*continuous* automorphisms is the right statement: the subgroup is defined through open normal
subgroups, and an abstract automorphism of a profinite group need not be continuous. The same
statement is wanted for `proPFrattini` and for every `pLowerCentralSeries` term. -/
example {p : ℕ} {G : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    [CompactSpace G] [TotallyDisconnectedSpace G] (f : G ≃ₜ* G) :
    (proPKernel p G).map f.toMulEquiv.toMonoidHom = proPKernel p G :=
  sorry

/-- **Layer 3, the Frattini subgroup is closed and normal.** Its characteristicity is the
`ContinuousMulEquiv`-invariance statement above with `proPFrattini` in place of
`proPKernel`. -/
example {p : ℕ} [Fact p.Prime] {G : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G] (hG : IsProP p G) :
    IsClosed ((proPFrattini p G : Subgroup G) : Set G) ∧ (proPFrattini p G).Normal :=
  sorry

/-- **Layer 3, the Frattini subgroup of a pro-`p` group is `closure (Gᵖ[G,G])`.** The
index-`p` form and the verbal form agree: for pro-`p` `G` the open normal subgroups of index
`p` are exactly the maximal open subgroups, and their intersection is the closure of the
subgroup generated by `p`-th powers and commutators. -/
example {p : ℕ} [Fact p.Prime] {G : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G] (hG : IsProP p G) :
    proPFrattini p G
      = (Subgroup.closure (Set.range fun g : G ↦ g ^ p) ⊔ commutator G).topologicalClosure :=
  sorry

/-- **Layer 3, index-`p` detection (the Frattini generation criterion, subgroup form).** A
closed subgroup of a pro-`p` group contained in no open normal subgroup of index `p` is the
whole group. This is `H · Φ(G) = G → H = G`. -/
example {p : ℕ} [Fact p.Prime] {G : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G] (hG : IsProP p G)
    {H : Subgroup G} (hH : IsClosed (H : Set G))
    (h : ∀ U : OpenNormalSubgroup G, U.toSubgroup.index = p → ¬ H ≤ U.toSubgroup) :
    H = ⊤ :=
  sorry

/-- **Layer 3, the Burnside basis surjectivity criterion (hom form).** A continuous
homomorphism between pro-`p` profinite groups whose composites to all index-`p` quotients of
the target are surjective is surjective: the criterion used everywhere for checking
surjectivity on generators mod Frattini. -/
example {p : ℕ} [Fact p.Prime] {G : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G] {H : Type v}
    [Group H] [TopologicalSpace H] [IsTopologicalGroup H] [CompactSpace H]
    [TotallyDisconnectedSpace H] (hH : IsProP p H) (f : G →* H) (hf : Continuous f)
    (hsurj : ∀ U : OpenNormalSubgroup H, U.toSubgroup.index = p →
      Function.Surjective ((QuotientGroup.mk' U.toSubgroup).comp f)) :
    Function.Surjective f :=
  sorry

/-- **Layer 3, the topological finite generation criterion.** A pro-`p` group is
topologically finitely generated iff its Frattini quotient is finite (`index ≠ 0` is
Mathlib's idiom for finiteness of the quotient), the Burnside basis theorem's counting
half, and the criterion the local-fields roadmap applies to `G_K`. -/
example {p : ℕ} [Fact p.Prime] {G : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G] (hG : IsProP p G) :
    IsTopologicallyFinitelyGenerated G ↔ (proPFrattini p G).index ≠ 0 :=
  sorry

/-- **Layer 3, the two rank notions agree.** The natural-number accessor computes the
cardinal rank whenever it is available. Every theorem that subtracts ranks is stated with the
accessor and this equality is how it connects to the general theory. -/
example {G : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    (h : IsTopologicallyFinitelyGenerated G) :
    (topologicalGeneratorRankNat G h : Cardinal.{u}) = topologicalGeneratorRank G :=
  sorry

/-- **Layer 3, Burnside basis theorem, generation form.** A subset generates a pro-`p` group
topologically iff its image generates the Frattini quotient topologically. The closure on the
quotient side is not decoration: at infinite rank the images of a generating set span only a
dense subspace of `G/Φ(G)`. This is the statement every later layer uses, and it needs no
finiteness hypothesis and no vector-space structure. The cardinal form, against the discrete
dual `Hom_cont(G, 𝔽_p)`, is the companion statement; it is *not* an identity with
`Module.rank (ZMod p) (G/Φ(G))`, which is strictly larger at infinite rank. -/
example {p : ℕ} [Fact p.Prime] {G : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G] (hG : IsProP p G)
    (s : Set G) :
    (Subgroup.closure s).topologicalClosure = ⊤ ↔
      (Subgroup.closure ((QuotientGroup.mk' (proPFrattini p G)) '' s)).topologicalClosure
        = ⊤ :=
  sorry

/-- **Layer 3, every profinite group has a generating set converging to `1`**
(RZ Prop. 2.6.2). This is what makes `topologicalGeneratorRank` an infimum over a nonempty
family, so it comes before any theorem that computes a rank. -/
example {G : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] :
    ∃ s : Set G, ConvergesToOne s ∧ (Subgroup.closure s).topologicalClosure = ⊤ :=
  sorry

/-- **Layer 3, Burnside basis theorem, numerical form.** For a topologically finitely
generated pro-`p` group the Frattini quotient has order `p^{d(G)}`: the count that turns the
generation statement into the rank formula `d(G) = dim_{𝔽_p} G/Φ(G)`. -/
example {p : ℕ} [Fact p.Prime] {G : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G] (hG : IsProP p G)
    (hfg : IsTopologicallyFinitelyGenerated G) :
    Nat.card (G ⧸ proPFrattini p G) = p ^ topologicalGeneratorRankNat G hfg :=
  sorry

/-- **Layer 3, the Gaschütz lifting lemma.** Along a continuous surjection of profinite
groups, a topological generating tuple of the target lifts to a topological generating tuple
of the source, provided the source is generated by that many elements. (Nakayama-style
generator lifting; the mechanism behind minimal presentations.) -/
example {G : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] {H : Type v} [Group H] [TopologicalSpace H]
    [IsTopologicalGroup H] [CompactSpace H] [TotallyDisconnectedSpace H] (f : G →* H)
    (hf : Continuous f) (hfs : Function.Surjective f) {n : ℕ} (g : Fin n → G)
    (hg : (Subgroup.closure (Set.range g)).topologicalClosure = ⊤) (h : Fin n → H)
    (hh : (Subgroup.closure (Set.range h)).topologicalClosure = ⊤) :
    ∃ g' : Fin n → G, (∀ i, f (g' i) = h i) ∧
      (Subgroup.closure (Set.range g')).topologicalClosure = ⊤ :=
  sorry

/-- **Layer 3, finitely generated profinite groups are Hopfian.** A continuous surjective
endomorphism of a topologically finitely generated profinite group is an isomorphism, the
last step of every two-sided comparison argument (Layer 8). -/
example {G : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] (hfg : IsTopologicallyFinitelyGenerated G) (f : G →* G)
    (hc : Continuous f) (hs : Function.Surjective f) : Function.Bijective f :=
  sorry

/-- **Layer 3, countably many open normal subgroups.** A topologically finitely generated
profinite group has finitely many open subgroups of each index, hence countably many open
normal subgroups. This is the hypothesis later layers carry explicitly; it is **not** a
Layer 0 statement, because its proof needs the finiteness count proved here. -/
example {G : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] (hfg : IsTopologicallyFinitelyGenerated G) :
    Countable (OpenNormalSubgroup G) :=
  sorry

/-- **Layer 3, a descending cofinal sequence of open normal subgroups.** The sequential form
that Layer 8's assembly arguments use, obtained from countability by intersecting finite
initial segments. -/
example {G : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] (hfg : IsTopologicallyFinitelyGenerated G) :
    ∃ N : ℕ → OpenNormalSubgroup G, (∀ k, (N (k + 1)).toSubgroup ≤ (N k).toSubgroup) ∧
      ∀ U : OpenNormalSubgroup G, ∃ k, (N k).toSubgroup ≤ U.toSubgroup :=
  sorry

/-- **Layer 3, rank sanity check.** The minimal number of generators of the finite `2`-group
`ℤ/4 × ℤ/2` is `2`, the Burnside-basis numerology (`G/Φ(G) ≅ (ℤ/2)²`) in its abstract
finite instance. -/
example : Group.rank (Multiplicative (ZMod 4) × Multiplicative (ZMod 2)) = 2 :=
  sorry

/-! ## Layer 4: free pro-`p` groups on finite sets, and abelian pro-`p` structure -/

/-- **Layer 4, `freeProP` is the free pro-`C` object at `C = ` finite `p`-groups.** The two
constructions agree, so that no statement has to choose between them. -/
example {p : ℕ} [Fact p.Prime] {X : Type u} :
    Nonempty (freeProC (finiteGroupClassP p) X ≃ₜ* freeProP p X) :=
  sorry

/-- **Layer 4, universal property of the free pro-`p` group.** Maps from `X` into a pro-`p`
profinite group extend uniquely to continuous homomorphisms from `freeProP p X`. -/
example {p : ℕ} {X : Type u} {P : Type v} [Group P] [TopologicalSpace P]
    [IsTopologicalGroup P] [CompactSpace P] [TotallyDisconnectedSpace P] (hP : IsProP p P)
    (m : X → P) :
    ∃! f : freeProP p X →* P, Continuous f ∧ ∀ x : X, f (freeProP.of p x) = m x :=
  sorry

/-- **Layer 4, topological finite generation of free pro-`p` groups.** The free pro-`p`
group on a finite set is topologically finitely generated (by the images of the free
generators, which are dense-generating by construction). -/
example {p : ℕ} {X : Type u} [Finite X] : IsTopologicallyFinitelyGenerated (freeProP p X) :=
  sorry

/-- **Layer 4, the rank of a free pro-`p` group on a finite set.** The natural-number form
for `Fin n` is a corollary through the accessor. Finiteness of `X` is a hypothesis, not a
convenience: `freeProP p S` for infinite discrete `S` has rank `p ^ #S`, not `#S`, which is
why the infinite-rank free objects are built on a profinite space in Layer 10. -/
example {p : ℕ} [Fact p.Prime] {X : Type u} [Finite X] :
    topologicalGeneratorRank (freeProP p X) = Cardinal.mk X :=
  sorry

/-- **Layer 4, free groups are residually `p`.** The canonical map from the discrete free
group to the free pro-`p` group is injective: the classical residual `p`-finiteness of free
groups, and the reason the generators of `freeProP` behave like free generators. -/
example {p : ℕ} [Fact p.Prime] {X : Type u} :
    Function.Injective ((QuotientGroup.mk' (proPKernel p (freeProfiniteGroup X))).comp
      (ProfiniteGrp.ProfiniteCompletion.eta (GrpCat.of (FreeGroup X))).hom) :=
  sorry

/-- **Layer 4, the maximal pro-`p` quotient of `ℤ̂` is `ℤ_p`.** Step (1)–(2) of the
identification chain, and the statement the Layer 2 `ℤ̂`-Sylow example rests on. -/
example (p : ℕ) [Fact p.Prime] :
    Nonempty (maximalProPQuotient p zHat ≃ₜ* Multiplicative ℤ_[p]) :=
  sorry

/-- **Layer 4, the rank-one free pro-`p` group is `ℤ_p`.** Step (3): both objects represent
the same functor on pro-`p` profinite groups, so the free object's uniqueness gives the
isomorphism. This is what every later `ℤ_p`-coefficient argument cites. -/
example (p : ℕ) [Fact p.Prime] :
    Nonempty (freeProP p (Fin 1) ≃ₜ* Multiplicative ℤ_[p]) :=
  sorry

/-- **Layer 4, exponentiation by `ℤ_p` in an abelian pro-`p` group.** The continuous action
obtained as the inverse limit of exponentiation in the finite abelian `p`-quotients; it is
what makes an abelian pro-`p` group a topological `ℤ_p`-module. -/
example (p : ℕ) [Fact p.Prime] {A : Type u} [CommGroup A] [TopologicalSpace A]
    [IsTopologicalGroup A] [CompactSpace A] [TotallyDisconnectedSpace A] (hA : IsProP p A) :
    ∃ e : ℤ_[p] → A → A, Continuous (fun x : ℤ_[p] × A ↦ e x.1 x.2) ∧
      (∀ a, e 1 a = a) ∧ (∀ (l m : ℤ_[p]) (a : A), e (l * m) a = e l (e m a)) ∧
      (∀ (l m : ℤ_[p]) (a : A), e (l + m) a = e l a * e m a) ∧
      ∀ (n : ℕ) (a : A), e (n : ℤ_[p]) a = a ^ n :=
  sorry

/-- **Layer 4, the structure theorem for finitely generated abelian pro-`p` groups.**
`A ≅ ℤ_p^r × T` with `T` a finite abelian `p`-group; uniqueness of `r` and of the elementary
divisors of `T` are separate statements. Layer 7's `q`-invariant is defined from `T`, so this
theorem is what makes `demushkinQ` well defined from `IsDemushkin` alone. -/
example (p : ℕ) [Fact p.Prime] {A : Type} [CommGroup A] [TopologicalSpace A]
    [IsTopologicalGroup A] [CompactSpace A] [TotallyDisconnectedSpace A] (hA : IsProP p A)
    (hfg : IsTopologicallyFinitelyGenerated A) :
    ∃ (r m : ℕ) (e : Fin m → ℕ),
      Nonempty (A ≃ₜ*
        Multiplicative ((Fin r → ℤ_[p]) × ((i : Fin m) → ZMod (p ^ e i)))) :=
  sorry

/-! ## Layer 5: presentations (rank interpretations are cohomological; see the pseudocode) -/

/-- **Layer 5, a continuous section along a finite kernel.** The lemma the cocycle side of
the extension dictionary runs on, in the only case it is used: `N` finite, `E ⧸ N` possibly
infinite. Proof: an open normal `U ≤ E` with `U ⊓ N = ⊥` maps isomorphically onto an open
subgroup of `E ⧸ N`, and finitely many coset translates of that section give a section over a
clopen partition. ⚠ The corresponding statement for an arbitrary surjection of profinite
*spaces* is false, so nothing here appeals to one. -/
example {E : Type u} [Group E] [TopologicalSpace E] [IsTopologicalGroup E] [CompactSpace E]
    [TotallyDisconnectedSpace E] (N : Subgroup E) [N.Normal] (hN : Finite N) :
    ∃ s : E ⧸ N → E, Continuous s ∧ (∀ x, (QuotientGroup.mk (s x) : E ⧸ N) = x) ∧ s 1 = 1 :=
  sorry

/-- **Layer 5, the map that proves `D₀` is nontrivial.** Not "map onto some finite
`2`-group": the map is the one sending `A ↦ 1`, `S ↦` the generator of `ℤ/2`, `Y ↦ 1`. The
relator `A²S⁴(S,Y)` maps to `2·0 + 4·1 = 0`, so it factors through `D₀`, and the induced map
is surjective because `S` already hits the generator. -/
example : ∃ φ : freeProP 2 (Fin 3) →* Multiplicative (ZMod 2),
    Continuous φ ∧ φ (freeProP.of 2 0) = 1 ∧
      φ (freeProP.of 2 1) = Multiplicative.ofAdd 1 ∧ φ (freeProP.of 2 2) = 1 ∧
      φ d0Relator = 1 ∧ Function.Surjective φ :=
  sorry

/-- **Layer 5, the induced surjection `D₀ ↠ ℤ/2`.** -/
example : ∃ f : demushkinD0 →* Multiplicative (ZMod 2),
    Continuous f ∧ Function.Surjective f :=
  sorry

/-- **Layer 5, non-vacuity of the presentation machinery.** `D₀` is nontrivial, a corollary
of the surjection above. A collapse here would make the dyadic acceptance instance vacuous. -/
example : Nontrivial demushkinD0 :=
  sorry

/-- **Layer 5, presented groups are pro-`p`.** The presentation construction lands in
pro-`2` groups: `D₀` is pro-`2`, and topologically finitely generated. -/
example : IsProP 2 demushkinD0 ∧ IsTopologicallyFinitelyGenerated demushkinD0 :=
  sorry

/-! ## Layer 6: cohomological dimension (cohomological; see the pseudocode), except its
Nielsen–Schreier consequence, whose statement is presentation-level -/

/-- **Layer 6, pro-`p` Nielsen–Schreier for open subgroups, with the index-rank formula.**
An open subgroup of index `m` in the free pro-`p` group of rank `n ≥ 1` is free pro-`p` of
rank `1 + m(n - 1)`. (Route pinned in `README.md`: via `cd ≤ 1` and the two-term Euler
formula, not a transversal argument. The natural-number subtraction `n - 1` is harmless under
`n ≠ 0`; the Euler formula itself is stated in `ℤ`.) -/
example {p : ℕ} [Fact p.Prime] {n : ℕ} (hn : n ≠ 0) (U : OpenSubgroup (freeProP p (Fin n))) :
    Nonempty (U ≃ₜ* freeProP p (Fin (1 + U.toSubgroup.index * (n - 1)))) :=
  sorry

/-! ## Layer 7: the closed subgroups of `ℤ₂ˣ`, and the abelianization-level invariants -/

/-- **Layer 7, the closed subgroups of `ℤ₂ˣ`: exhaustiveness.** Every nontrivial closed
subgroup is one of `U^(f)`, `{±1} × U^(f)`, `{±1}`, or Labute's `U^[f]`. Uniqueness of the
case and of `f` is the companion statement; the indices and the values of `(A : A²)` are the
numbers Layer 9's existence theorem quotes. -/
example (A : Subgroup ℤ_[2]ˣ) (hA : IsClosed (A : Set ℤ_[2]ˣ)) (hA1 : A ≠ ⊥) :
    (∃ f : ℕ, 2 ≤ f ∧ A = unitsPrincipal f) ∨
      (∃ f : ℕ, 2 ≤ f ∧ A = unitsPlusMinus f) ∨
      A = Subgroup.closure {(-1 : ℤ_[2]ˣ)} ∨
      (∃ (f : ℕ) (u : ℤ_[2]ˣ),
        2 ≤ f ∧ (u : ℤ_[2]) = -1 + 2 ^ f ∧ A = procyclicClosure u) :=
  sorry

/-- **Layer 7, the even part of `U^[f]`.** For `u = -1 + 2^f` with `f ≥ 2`, the square
`u² = 1 - 2^{f+1}(1 - 2^{f-1})` has principal-unit depth exactly `f + 1`, so
`U^[f] ∩ (1 + 4ℤ₂) = U^(f+1)` and hence `[ℤ₂ˣ : U^[f]] = 2^{f-1}`. Stated separately from
the trichotomy because a shift of one in this exponent reparametrizes the whole `q = 2`
classification; check it by hand at `f = 2, 3, 4`. -/
example (f : ℕ) (hf : 2 ≤ f) (u : ℤ_[2]ˣ) (hu : (u : ℤ_[2]) = -1 + 2 ^ f) :
    procyclicClosure u ⊓ unitsPrincipal 2 = unitsPrincipal (f + 1) :=
  sorry

/-- **Layer 7, procyclicity.** The closed subgroups of `ℤ₂ˣ` not containing `-1`, namely
the families `U^(f)` and `U^[f]`, are topologically generated by one element. `{±1} × U^(f)` is
not, for `f < ∞`: its Frattini quotient is `(ℤ/2)²`. -/
example (A : Subgroup ℤ_[2]ˣ) (hA : IsClosed (A : Set ℤ_[2]ˣ)) (h1 : (-1 : ℤ_[2]ˣ) ∉ A) :
    ∃ u : ℤ_[2]ˣ, procyclicClosure u = A :=
  sorry

/-- **Layer 7, the abelianization of `D₀`.** `D₀^{ab} ≅ ℤ₂ × ℤ₂ × ℤ/2` as topological
groups, so the relator `A²S⁴(S,Y)` abelianizes to `2A + 4S`, so the topological abelianization
is `ℤ₂³/⟨(2,4,0)⟩`. This is the computation behind `n = 3`, `q = 2`. -/
example :
    Nonempty (topAbelianization demushkinD0 ≃ₜ*
      Multiplicative (ℤ_[2] × ℤ_[2] × ZMod 2)) :=
  sorry

/-- **Layer 7, finiteness needed by the interim `q`-invariant API.** The torsion subgroup of
`D₀^{ab} ≅ ℤ₂² × ℤ/2` is finite. In the final API this is a consequence of the Layer 4
structure theorem rather than an argument to `demushkinQ`. -/
example : Finite {x : topAbelianization demushkinD0 // IsOfFinOrder x} :=
  sorry

/-- **Layer 7, the `q`-invariant of `D₀`.** `q(D₀) = 2`: the torsion subgroup of
`D₀^{ab} ≅ ℤ₂² × ℤ/2` has two elements. -/
example (hfinite : Finite {x : topAbelianization demushkinD0 // IsOfFinOrder x}) :
    demushkinQ demushkinD0 hfinite = 2 :=
  sorry

/-! ## Layer 8: the lower `p`-series and finite-quotient determinacy -/

/-- **Layer 8, the lower `p`-series is closed, normal, and descending.** The basic API every
tower argument needs before it can quotient by a term. -/
example {p : ℕ} [Fact p.Prime] {G : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G] (k : ℕ) :
    IsClosed ((pLowerCentralSeries p G k : Subgroup G) : Set G) ∧
      (pLowerCentralSeries p G k).Normal ∧
      pLowerCentralSeries p G (k + 1) ≤ pLowerCentralSeries p G k :=
  sorry

/-- **Layer 8, functoriality of the lower `p`-series.** Continuous homomorphisms respect it,
and continuous surjections map each term *onto* the corresponding term. -/
example {p : ℕ} [Fact p.Prime] {G : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G] {H : Type u}
    [Group H] [TopologicalSpace H] [IsTopologicalGroup H] [CompactSpace H]
    [TotallyDisconnectedSpace H] (f : G →* H) (hf : Continuous f) (k : ℕ) :
    (pLowerCentralSeries p G k).map f ≤ pLowerCentralSeries p H k ∧
      (Function.Surjective f → (pLowerCentralSeries p G k).map f
        = pLowerCentralSeries p H k) :=
  sorry

/-- **Layer 8, openness of the lower `p`-series.** In a topologically finitely generated
pro-`p` group every term of the lower `p`-series is open. (With cofinality below, the series
is then a neighborhood basis of `1` by finite `p`-quotients: the tower the comparison
method runs on.) -/
example {p : ℕ} [Fact p.Prime] {G : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G] (hG : IsProP p G)
    (hfg : IsTopologicallyFinitelyGenerated G) (k : ℕ) :
    IsOpen ((pLowerCentralSeries p G k : Subgroup G) : Set G) :=
  sorry

/-- **Layer 8, cofinality of the lower `p`-series.** In a topologically finitely generated
pro-`p` group the lower `p`-series is cofinal among open normal subgroups. -/
example {p : ℕ} [Fact p.Prime] {G : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G] (hG : IsProP p G)
    (hfg : IsTopologicallyFinitelyGenerated G) (U : OpenNormalSubgroup G) :
    ∃ k : ℕ, pLowerCentralSeries p G k ≤ U.toSubgroup :=
  sorry

/-- **Layer 8, occurring as a continuous quotient is an isomorphism invariant.** Both in the
finite group and in the profinite group: the two statements that let the reconstruction
theorem quantify over bundled finite groups. -/
example {G : Type u} [Group G] [TopologicalSpace G] {Q Q' : FiniteGrp.{v}} (e : Q ≃* Q') :
    IsFiniteContinuousQuotient G Q ↔ IsFiniteContinuousQuotient G Q' :=
  sorry

/-- **Layer 8, two epimorphisms.** If `G` is topologically finitely generated and `G` and `H`
have the same continuous finite quotients, there are continuous surjections in both
directions. This is the step where the finite-generation hypotheses are used; the theorem
below removes the one on `H`. -/
example {G H : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] [Group H] [TopologicalSpace H] [IsTopologicalGroup H]
    [CompactSpace H] [TotallyDisconnectedSpace H]
    (hG : IsTopologicallyFinitelyGenerated G)
    (h : ∀ Q : FiniteGrp.{u},
      IsFiniteContinuousQuotient G Q ↔ IsFiniteContinuousQuotient H Q) :
    (∃ f : G →* H, Continuous f ∧ Function.Surjective f) ∧
      ∃ g : H →* G, Continuous g ∧ Function.Surjective g :=
  sorry

/-- **Layer 8, finite-quotient determinacy, sharp form** (Fried–Jarden; RZ Thm. 3.2.9). Two
profinite groups with the same continuous finite quotients are topologically isomorphic as
soon as **one** of them is topologically finitely generated. Route: the two epimorphisms
above, then `ψ ∘ φ : G ↠ G` is an isomorphism by the Hopf property of Layer 3, so `φ` is a
continuous bijection of compact Hausdorff groups. Finite generation of `H` is a conclusion,
not a hypothesis. -/
example {G H : Type u} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [TotallyDisconnectedSpace G] [Group H] [TopologicalSpace H] [IsTopologicalGroup H]
    [CompactSpace H] [TotallyDisconnectedSpace H]
    (hG : IsTopologicallyFinitelyGenerated G)
    (h : ∀ Q : FiniteGrp.{u},
      IsFiniteContinuousQuotient G Q ↔ IsFiniteContinuousQuotient H Q) :
    Nonempty (G ≃ₜ* H) :=
  sorry

/-!
## Pseudocode: the declaration headers that cannot be written at this pin

The following are the intended shapes of the cohomological declarations. They do not compile
here (`H`, `cup`, `trivialModule`, and `cd` are
[Profinite Cohomology PR #1](https://github.com/roed-math/TauCetiRoadmap/pull/1)'s, and their
final names are that roadmap's to fix), but their hypotheses are settled, and this block is
what a contributor should reproduce once those names exist. Nothing here is faked with an
empty `Prop` field or a stand-in predicate.

```
/-- Layer 7: the Demushkin predicate. Carries `IsProP` as a field, so that no downstream
theorem can be applied to a non-pro-`p` group satisfying only the cohomological clauses.
`cupRight` becomes a theorem, and the field disappears, if PR #1 delivers graded
commutativity of the cup product in this bidegree. -/
structure IsDemushkin (p : ℕ) (G : Type u) [Fact p.Prime]
    [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    [CompactSpace G] [TotallyDisconnectedSpace G] : Prop where
  proP     : IsProP p G
  h1_fin   : Module.Finite (ZMod p) (H 1 G (trivialModule (ZMod p)))
  h2_rank  : Module.finrank (ZMod p) (H 2 G (trivialModule (ZMod p))) = 1
  cupLeft  : ∀ a ≠ 0, ∃ b, cup a b ≠ 0
  cupRight : ∀ b ≠ 0, ∃ a, cup a b ≠ 0

/-- Layer 7: the `q`-invariant, final API. Finiteness and cyclicity of the torsion of
`topAbelianization G` are derived from `hG` through the Layer 4 structure theorem; no proof
witness appears in the value. -/
noncomputable def demushkinQ (p : ℕ) (G : Type u) [Fact p.Prime] [Group G]
    [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G]
    (hG : IsDemushkin p G) : ℕ

theorem demushkinQ_eq_zero_iff (hG : IsDemushkin p G) :
    demushkinQ p G hG = 0 ↔ ∀ x : topAbelianization G, IsOfFinOrder x → x = 1

theorem demushkinQ_congr (hG : IsDemushkin p G) (hH : IsDemushkin p H) (e : G ≃ₜ* H) :
    demushkinQ p G hG = demushkinQ p H hH

/-- Layer 7: the prescription property of a continuous character, in the finite-quotient
form. `I p χ i` is `ZMod (p^i)` with `G` acting through `χ mod p^i`. -/
def HasPrescriptionProperty (χ : G →* ℤ_[p]ˣ) (hχ : Continuous χ) : Prop :=
  ∀ i : ℕ, 1 ≤ i → Function.Surjective (coeffMap (I p χ i) (I p χ 1) :
    H 1 G (I p χ i) → H 1 G (I p χ 1))

/-- Layer 7: the canonical character exists and is unique (Serre; Labute Thm 4). -/
theorem exists_unique_demushkinCharacter (hG : IsDemushkin p G) :
    ∃! χ : G →* ℤ_[p]ˣ, Continuous χ ∧ HasPrescriptionProperty χ ‹_›

noncomputable def demushkinCharacter (hG : IsDemushkin p G) : G →* ℤ_[p]ˣ

/-- Layer 7: a Demushkin group is topologically finitely generated (`h1_fin` plus the
Burnside basis theorem), and `n(G)` is its rank as a natural number. Every numerical
statement below is about this accessor; no declaration takes a bare `rank`. -/
theorem IsDemushkin.topFG (hG : IsDemushkin p G) : IsTopologicallyFinitelyGenerated G

noncomputable def demushkinRank (hG : IsDemushkin p G) : ℕ :=
  topologicalGeneratorRankNat G hG.topFG

/-- Layer 7: dimension two, the trace isomorphism, and the perfect pairing on the finite
coefficient system of the canonical character: the concrete duality package that replaces
any appeal to a general theory of duality groups. -/
theorem cd_eq_two (hG : IsDemushkin p G) (hinf : Infinite G) : cd p G = 2

noncomputable def demushkinTrace (hG : IsDemushkin p G) :
    H 2 G (trivialModule (ZMod p)) ≃ₗ[ZMod p] ZMod p

theorem demushkinPairing_perfect (hG : IsDemushkin p G) (hinf : Infinite G) (i j : ℕ)
    (hj : j ≤ 2) : ... -- perfect pairing H^j(G, M) × H^(2-j)(G, Mᵛ) → ZMod (p^i)

/-- Layer 7: open subgroups, from that package plus the three-term Euler formula. -/
theorem isDemushkin_of_open (hG : IsDemushkin p G) (hinf : Infinite G) (U : OpenSubgroup G) :
    IsDemushkin p U

theorem demushkinRank_of_open (hG : IsDemushkin p G) (hinf : Infinite G)
    (U : OpenSubgroup G) :
    (demushkinRank (isDemushkin_of_open hG hinf U) : ℤ) - 2
      = U.toSubgroup.index * ((demushkinRank hG : ℤ) - 2)

theorem demushkinCharacter_of_open (hG : IsDemushkin p G) (hinf : Infinite G)
    (U : OpenSubgroup G) :
    demushkinCharacter (isDemushkin_of_open hG hinf U)
      = (demushkinCharacter hG).comp U.subtype

/-- Layer 9: the classification. Uniqueness first, then existence. -/
theorem demushkin_iso_of_invariants (hG : IsDemushkin p G) (hH : IsDemushkin p H)
    (hrank : demushkinRank hG = demushkinRank hH)
    (himage : (demushkinCharacter hG).range = (demushkinCharacter hH).range) :
    Nonempty (G ≃ₜ* H)

theorem exists_demushkin_of_invariants (n : ℕ) (A : Subgroup ℤ_[p]ˣ)
    (hA : IsClosed (A : Set ℤ_[p]ˣ)) (h : RealizableInvariants p n A) :
    ∃ (G : Type u) (hG : IsDemushkin p G),
      demushkinRank hG = n ∧ (demushkinCharacter hG).range = A

/-- Layer 11: the two inflation theorems and the arithmetic instances. -/
theorem inflation_h1_bijective (K : Type u) [Field K] [IsLocalField K] ... :
    Function.Bijective (inf : H 1 (maximalProPQuotient p (G K)) 𝔽ₚ → H 1 (G K) 𝔽ₚ)

theorem inflation_h2_bijective_of_not_mu (hmu : ¬ HasEnoughRootsOfUnity K p) : ...
theorem inflation_h2_bijective_of_mu (hmu : HasEnoughRootsOfUnity K p) : ...

theorem demushkinCharacter_eq_cyclotomic (hmu : HasEnoughRootsOfUnity K p) :
    demushkinCharacter ‹IsDemushkin p (maximalProPQuotient p (G K))› = χ_cyc.descend
```
-/

end TauCetiRoadmap.ProPGroups
