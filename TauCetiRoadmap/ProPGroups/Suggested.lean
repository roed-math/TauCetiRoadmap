import Mathlib

/-!
# Pro-p and Demushkin groups: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap. `sorry` is allowed in this human-owned roadmap
library: these are goals, not proofs.

This file carries the carrier types, so that the central interface of the roadmap is Lean
code and not pseudocode. The cohomology of Layer 5 is defined here by continuous cochains,
in degrees `0`, `1` and `2`, with its cup product in bidegree `(1,1)`. The Demushkin
predicate, the rank and `q` invariants, the prescription property that pins the canonical
character, and the arithmetic inputs of Layer 11 are all stated against that carrier. When
the Profinite Cohomology roadmap or Mathlib supplies a carrier, the comparison isomorphism
of Layer 5 transports the statements and the local definitions are deleted.

Everything else that the pin supports is here too: the profinite foundations, the
supernatural order and index, Sylow theory, the pro-`p`, Frattini and generation layers, the
free pro-`C` class formalism, free pro-`p` groups with their universal property, the
finite-quotient determinacy theorem, the lower `p`-series, the closed-subgroup theory of
`ℤ₂ˣ`, and the presentation-level worked examples, including the group
`D₀ = ⟨A, S, Y ∣ A²S⁴(S,Y)⟩` of the dyadic acceptance instance. A short block at the end
holds the few headers that still need vocabulary this pin does not have.

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

/-- **`G_K(p)`**, the Galois group of the maximal `p`-extension of `K`, as the maximal
pro-`p` quotient of the absolute Galois group. This is the carrier the shared layer-DAG table
fixes for Layer 11: the LocalFields roadmap's Layer 9 cites this name rather than re-forming
the quotient, so that the two roadmaps' rank statements are about one object. -/
abbrev absoluteGaloisGroupProP (K : Type u) [Field K] : Type u :=
  maximalProPQuotient p (Field.absoluteGaloisGroup K)

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

/-- The profinite group **presented** by generators `X` and relators `rels`: the free
profinite group modulo the *closed* normal closure of the relators. This is the object the
LocalFields roadmap's Layer 4 states the Iwasawa presentation
`G_K^t = ⟨σ, τ ∣ στσ⁻¹τ^(−q)⟩` against, and it is a row of the shared layer-DAG table; ⚠ it
is not `presentedProP` below, whose pro-`p` quotient forgets the prime-to-`p` tame inertia
that presentation is about. -/
noncomputable abbrev presentedProfiniteGroup (X : Type u)
    (rels : Set (freeProfiniteGroup X)) : Type u :=
  freeProfiniteGroup X ⧸ (Subgroup.normalClosure rels).topologicalClosure

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

/-! ## Layer 5: the continuous cochain carrier

This roadmap owns its cohomology in low degrees, so that no milestone waits for another
roadmap. Coefficients are a finite discrete module `M` over a commutative ring `R`, with a
continuous `G`-action that commutes with the `R`-action.

Two comparison milestones connect the carrier to its neighbours, and neither is a
prerequisite of anything here: `contH n` agrees with Mathlib's `continuousCohomology n` in
degrees `n ≤ 2`, and with the object of the Profinite Cohomology roadmap when that roadmap
supplies one. Mathlib's `continuousCohomology` is not available at this pin, so the first
comparison is stated in `README.md` and not here. -/

section Carrier

variable (R : Type) [CommRing R]
variable (G : Type u) [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
variable (M : Type v) [AddCommGroup M] [Module R M] [TopologicalSpace M] [DiscreteTopology M]
  [DistribMulAction G M] [SMulCommClass G R M] [ContinuousSMul G M]

/-- **`H⁰`**: the invariants of `M`, as an `R`-submodule. -/
def contH0 : Submodule R M where
  carrier := {m | ∀ g : G, g • m = m}
  add_mem' {a b} ha hb := by intro g; simp [smul_add, ha g, hb g]
  zero_mem' := by intro g; simp
  smul_mem' r m hm := by intro g; rw [smul_comm g r m, hm g]

/-- Continuous `1`-cocycles: locally constant crossed homomorphisms. Local constancy is
continuity, because the coefficients are discrete. -/
def cocycle₁ : Submodule R (LocallyConstant G M) where
  carrier := {f | ∀ g h : G, f (g * h) = g • f h + f g}
  add_mem' {f₁ f₂} h₁ h₂ := by
    intro g h
    simp only [LocallyConstant.add_apply, h₁ g h, h₂ g h, smul_add]
    abel
  zero_mem' := by intro g h; simp
  smul_mem' r f hf := by
    haveI := SMulCommClass.symm G R M
    intro g h
    simp only [LocallyConstant.smul_apply, hf g h, smul_add, smul_comm r g]

/-- The principal crossed homomorphism attached to `m`. -/
def principalCocycle (m : M) : LocallyConstant G M :=
  ⟨fun g => g • m - m, by
    rw [IsLocallyConstant.iff_continuous]
    exact (continuous_id.smul continuous_const).sub continuous_const⟩

/-- Principal crossed homomorphisms, as a linear map from the coefficients. -/
def principalHom : M →ₗ[R] LocallyConstant G M where
  toFun := principalCocycle G M
  map_add' m m' := by ext g; simp [principalCocycle, smul_add]; abel
  map_smul' r m := by
    haveI := SMulCommClass.symm G R M
    ext g; simp [principalCocycle, smul_sub, smul_comm r g]

/-- Continuous `1`-coboundaries. -/
def coboundary₁ : Submodule R (LocallyConstant G M) :=
  LinearMap.range (principalHom R G M)

omit [IsTopologicalGroup G] in
theorem coboundary₁_le_cocycle₁ : coboundary₁ R G M ≤ cocycle₁ R G M := by
  rintro _ ⟨m, rfl⟩ g h
  simp [principalHom, principalCocycle, mul_smul, smul_sub]

/-- **`H¹`** of `G` with coefficients in `M`, by continuous cochains. -/
abbrev contH1 : Type _ :=
  (cocycle₁ R G M) ⧸ ((coboundary₁ R G M).comap (cocycle₁ R G M).subtype)

/-- The class of a continuous `1`-cocycle. -/
def cocycle₁.mk (a : cocycle₁ R G M) : contH1 R G M := Submodule.Quotient.mk a

/-- Continuous `2`-cocycles. -/
def cocycle₂ : Submodule R (LocallyConstant (G × G) M) where
  carrier := {c | ∀ g h k : G, g • c (h, k) - c (g * h, k) + c (g, h * k) - c (g, h) = 0}
  add_mem' {c₁ c₂} h₁ h₂ := by
    intro g h k
    have e₁ := h₁ g h k
    have e₂ := h₂ g h k
    simp only [LocallyConstant.add_apply, smul_add]
    rw [show ∀ a b c d e f g' h' : M,
        (a + b) - (c + d) + (e + f) - (g' + h') = (a - c + e - g') + (b - d + f - h') from
      by intros; abel, e₁, e₂, add_zero]
  zero_mem' := by intro g h k; simp
  smul_mem' r c hc := by
    intro g h k
    have h₀ := hc g h k
    simp only [LocallyConstant.smul_apply]
    rw [smul_comm g r]
    simp only [← smul_sub, ← smul_add]
    rw [h₀, smul_zero]

/-- The coboundary of a continuous `1`-cochain. -/
def d₁ (f : LocallyConstant G M) : LocallyConstant (G × G) M :=
  ⟨fun x => x.1 • f x.2 - f (x.1 * x.2) + f x.1, by
    rw [IsLocallyConstant.iff_continuous]
    exact (((continuous_fst.smul (f.continuous.comp continuous_snd)).sub
      (f.continuous.comp (continuous_fst.mul continuous_snd))).add
      (f.continuous.comp continuous_fst))⟩

/-- Continuous `2`-coboundaries. -/
def coboundary₂ : Submodule R (LocallyConstant (G × G) M) :=
  LinearMap.range
    ({ toFun := d₁ G M
       map_add' := by intro f f'; ext x; simp [d₁, smul_add]; abel
       map_smul' := by
        haveI := SMulCommClass.symm G R M
        intro r f; ext x; simp [d₁, smul_sub, smul_add, smul_comm r] } :
      LocallyConstant G M →ₗ[R] LocallyConstant (G × G) M)

theorem coboundary₂_le_cocycle₂ : coboundary₂ R G M ≤ cocycle₂ R G M := by
  rintro _ ⟨f, rfl⟩ g h k
  simp only [LinearMap.coe_mk, AddHom.coe_mk, d₁, LocallyConstant.coe_mk]
  simp [mul_smul, smul_sub, smul_add, mul_assoc]
  abel

/-- **`H²`** of `G` with coefficients in `M`, by continuous cochains. -/
abbrev contH2 : Type _ :=
  (cocycle₂ R G M) ⧸ ((coboundary₂ R G M).comap (cocycle₂ R G M).subtype)

/-- The class of a continuous `2`-cocycle. -/
def cocycle₂.mk (c : cocycle₂ R G M) : contH2 R G M := Submodule.Quotient.mk c

end Carrier

/-! ### Trivial coefficients, and the cup product in bidegree `(1,1)`

`TrivMod G A` is a type synonym for `A`, so that the trivial action is never an instance on
`A` itself. The Demushkin predicate uses `A = ZMod p`. -/

/-- `A` with the trivial `G`-action. -/
def TrivMod (_G : Type u) (A : Type) := A

section Trivial

variable (A : Type) [CommRing A]
variable (G : Type u) [Group G] [TopologicalSpace G] [IsTopologicalGroup G]

instance : CommRing (TrivMod G A) := inferInstanceAs (CommRing A)
instance : Module A (TrivMod G A) := inferInstanceAs (Module A A)
instance : TopologicalSpace (TrivMod G A) := ⊥
instance : DiscreteTopology (TrivMod G A) := ⟨rfl⟩

instance : DistribMulAction G (TrivMod G A) where
  smul _ a := a
  one_smul _ := rfl
  mul_smul _ _ _ := rfl
  smul_zero _ := rfl
  smul_add _ _ _ := rfl

instance : SMulCommClass G A (TrivMod G A) := ⟨fun _ _ _ => rfl⟩
instance : ContinuousSMul G (TrivMod G A) := ⟨continuous_snd⟩

omit [TopologicalSpace G] [IsTopologicalGroup G] in
@[simp] theorem trivMod_smul (g : G) (a : TrivMod G A) : g • a = a := rfl

/-- **The cup product in bidegree `(1,1)`, at the level of cocycles**:
`(a ∪ b)(g, h) = a g * b h`. That it descends to a bilinear map
`contH1 × contH1 → contH2` is a Layer 5 milestone; every statement below that needs only
nondegeneracy is phrased through `cupCocycle`, so it does not wait for the descent. -/
def cupCocycle (a b : cocycle₁ A G (TrivMod G A)) : cocycle₂ A G (TrivMod G A) :=
  ⟨⟨fun x => (a : LocallyConstant G (TrivMod G A)) x.1 *
      (b : LocallyConstant G (TrivMod G A)) x.2, by
      rw [IsLocallyConstant.iff_continuous]
      exact ((a : LocallyConstant G (TrivMod G A)).continuous.comp continuous_fst).mul
        ((b : LocallyConstant G (TrivMod G A)).continuous.comp continuous_snd)⟩, by
    intro g h k
    have ha := a.2 g h
    have hb := b.2 h k
    simp only [trivMod_smul, LocallyConstant.coe_mk] at *
    rw [ha, hb]
    ring⟩

end Trivial

/-! ### Twisted coefficients, and the prescription property

The coefficients `I(χ)/p^i` are `ZMod (p ^ i)` with `G` acting through `χ`. The cocycle and
coboundary conditions for that action are written out here, rather than through a second
module structure on `ZMod (p ^ i)`, so that no instance has to be installed on a Mathlib type
and no statement below depends on one. -/

section Prescription

variable {p : ℕ} [Fact p.Prime] {G : Type u} [Group G] [TopologicalSpace G]

/-- The scalar by which `g` acts on `I(χ)/p^i`. -/
noncomputable def charScalar (χ : G →* ℤ_[p]ˣ) (i : ℕ) (g : G) : ZMod (p ^ i) :=
  PadicInt.toZModPow i ((χ g : ℤ_[p]ˣ) : ℤ_[p])

/-- The scalar by which `g` acts on `I(χ)/p`. -/
noncomputable def charScalarBase (χ : G →* ℤ_[p]ˣ) (g : G) : ZMod p :=
  PadicInt.toZMod ((χ g : ℤ_[p]ˣ) : ℤ_[p])

/-- A continuous crossed homomorphism with values in `I(χ)/p^i`. -/
def IsCharCocycle (χ : G →* ℤ_[p]ˣ) (i : ℕ) (f : LocallyConstant G (ZMod (p ^ i))) : Prop :=
  ∀ g h : G, f (g * h) = charScalar χ i g * f h + f g

/-- A continuous crossed homomorphism with values in `I(χ)/p`. -/
def IsCharCocycleBase (χ : G →* ℤ_[p]ˣ) (f : LocallyConstant G (ZMod p)) : Prop :=
  ∀ g h : G, f (g * h) = charScalarBase χ g * f h + f g

/-- A principal crossed homomorphism with values in `I(χ)/p`. -/
def IsCharCoboundaryBase (χ : G →* ℤ_[p]ˣ) (f : LocallyConstant G (ZMod p)) : Prop :=
  ∃ m : ZMod p, ∀ g : G, f g = charScalarBase χ g * m - m

/-- **The prescription property, in lifting form** (condition 1 of the conventions). Every
continuous crossed homomorphism with values in `I(χ)/p` is, modulo principal ones, the
reduction of a continuous crossed homomorphism with values in `I(χ)/p^i`. This says exactly
that `H¹(G, I(χ)/p^i) → H¹(G, I(χ)/p)` is surjective for every `i ≥ 1`. It is the property
that pins Serre's canonical character: a Demushkin group has exactly one continuous `χ` with
it (Labute Thm 4). -/
def HasPrescriptionProperty (χ : G →* ℤ_[p]ˣ) : Prop :=
  ∀ i : ℕ, ∀ hi : 1 ≤ i, ∀ c : LocallyConstant G (ZMod p), IsCharCocycleBase χ c →
    ∃ c' : LocallyConstant G (ZMod (p ^ i)), IsCharCocycle χ i c' ∧
      IsCharCoboundaryBase χ
        (LocallyConstant.map (ZMod.castHom (dvd_pow_self p (by omega : i ≠ 0)) (ZMod p)) c'
          - c)

end Prescription

/-! ## Layer 7: the Demushkin predicate, its rank, and its invariants

These declarations were pseudocode while the cohomology had no carrier. They are statements
now, against the Layer 5 carrier. -/

section Demushkin

variable (p : ℕ) [Fact p.Prime]
variable (G : Type u) [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
  [TotallyDisconnectedSpace G]

/-- **The Demushkin predicate** (Labute p. 106). The pro-`p` hypothesis is a field, so that
no downstream theorem applies to a group that satisfies only the cohomological clauses. Both
nondegeneracy clauses are fields; if the cup product is proved graded-commutative in this
bidegree, the second becomes a theorem and the field is dropped. Nondegeneracy is stated
through `cupCocycle`, so it does not wait for the descent of the cup product to cohomology.
Finite generation is derived from `h1_fin` and the Burnside basis theorem, and is never
assumed. -/
structure IsDemushkin : Prop where
  /-- `G` is a pro-`p` group. -/
  proP : IsProP p G
  /-- `H¹(G, 𝔽_p)` is finite-dimensional. -/
  h1_fin : Module.Finite (ZMod p) (contH1 (ZMod p) G (TrivMod G (ZMod p)))
  /-- `H²(G, 𝔽_p)` is one-dimensional. -/
  h2_rank : Module.finrank (ZMod p) (contH2 (ZMod p) G (TrivMod G (ZMod p))) = 1
  /-- The cup pairing is nondegenerate on the left. -/
  cupLeft : ∀ a : cocycle₁ (ZMod p) G (TrivMod G (ZMod p)),
    cocycle₁.mk (ZMod p) G (TrivMod G (ZMod p)) a ≠ 0 →
    ∃ b : cocycle₁ (ZMod p) G (TrivMod G (ZMod p)),
      cocycle₂.mk (ZMod p) G (TrivMod G (ZMod p)) (cupCocycle (ZMod p) G a b) ≠ 0
  /-- The cup pairing is nondegenerate on the right. -/
  cupRight : ∀ b : cocycle₁ (ZMod p) G (TrivMod G (ZMod p)),
    cocycle₁.mk (ZMod p) G (TrivMod G (ZMod p)) b ≠ 0 →
    ∃ a : cocycle₁ (ZMod p) G (TrivMod G (ZMod p)),
      cocycle₂.mk (ZMod p) G (TrivMod G (ZMod p)) (cupCocycle (ZMod p) G a b) ≠ 0

/-- **Layer 7, a Demushkin group is topologically finitely generated.** From `h1_fin`, the
`H¹` interpretation of Layer 5, and the Burnside basis theorem of Layer 3. -/
theorem IsDemushkin.isTopologicallyFinitelyGenerated {p G} [Fact p.Prime] [Group G]
    [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G]
    (_hG : IsDemushkin p G) : IsTopologicallyFinitelyGenerated G :=
  sorry

/-- **The rank of a Demushkin group**, as a natural number. Every numerical statement about
Demushkin groups is about this accessor, and never about an unqualified rank. -/
noncomputable def demushkinRank {p G} [Fact p.Prime] [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G]
    (hG : IsDemushkin p G) : ℕ :=
  topologicalGeneratorRankNat G hG.isTopologicallyFinitelyGenerated

open scoped Classical in
/-- **Labute's `q`-invariant.** It is `0` when the topological abelianization is
torsion-free, which is Labute's `q = p^∞` convention, and the number of torsion elements
otherwise. For a Demushkin group the torsion subgroup is finite and cyclic by Layer 7, so
this is the `q` of `G^{ab} ≅ ℤ_p^{n-1} × ℤ/q`. `Nat.card` is `0` on an infinite type, so no
finiteness hypothesis is needed to make the definition total; the Layer 7 theorem is what
makes it correct. -/
noncomputable def demushkinQ {p G} [Fact p.Prime] [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [TotallyDisconnectedSpace G]
    (_hG : IsDemushkin p G) : ℕ :=
  if ∀ x : topAbelianization G, IsOfFinOrder x → x = 1 then 0
  else Nat.card {x : topAbelianization G // IsOfFinOrder x}

/-- **Layer 7, the `q`-invariant is an isomorphism invariant.** -/
example {p G H} [Fact p.Prime] [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    [CompactSpace G] [TotallyDisconnectedSpace G] [Group H] [TopologicalSpace H]
    [IsTopologicalGroup H] [CompactSpace H] [TotallyDisconnectedSpace H]
    (hG : IsDemushkin p G) (hH : IsDemushkin p H) (_e : G ≃ₜ* H) :
    demushkinQ hG = demushkinQ hH :=
  sorry

/-- **Layer 7, the canonical character.** The prescription property is stated in the
lifting form: every continuous cocycle with values in `ℤ/p`, twisted by `χ`, lifts modulo
coboundaries to one with values in `ℤ/p^i`. The twisted coefficients are `CharMod` below.
The theorem is that a Demushkin group has exactly one continuous `χ` with that property
(Serre; Labute Thm 4). -/
example {p G} [Fact p.Prime] [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    [CompactSpace G] [TotallyDisconnectedSpace G] (_hG : IsDemushkin p G) :
    ∃! χ : G →* ℤ_[p]ˣ, Continuous χ ∧ HasPrescriptionProperty χ :=
  sorry

end Demushkin

/-! ## Layer 11: the arithmetic inputs, as a local interface

The five inputs of Layer 11 are theorems about `G_K` that the Local Fields roadmap proves.
They are bundled here as one structure over an abstract profinite group `Γ`, which stands
for `G_K`, so that every theorem of Layer 11 is a statement of this roadmap with the inputs
as a hypothesis. Nothing waits for another roadmap: the Local Fields roadmap supplies an
instance of this structure, and the shared table names the object behind each field. -/

/-- **The arithmetic inputs of Layer 11.** `N` is the degree `[K : ℚ_p]`, and `hasMu` says
that `μ_p ⊆ K`. The fields are the parts of inputs 1, 3, 4 and 5 that Layer 11 uses. -/
structure LocalFieldInputs (p : ℕ) [Fact p.Prime] (Γ : Type u) [Group Γ] [TopologicalSpace Γ]
    [IsTopologicalGroup Γ] [CompactSpace Γ] [TotallyDisconnectedSpace Γ] (N : ℕ)
    (hasMu : Prop) where
  /-- Input 1: `dim H⁰(G_K, 𝔽_p) = 1`. -/
  h0_rank : Module.finrank (ZMod p) (contH0 (ZMod p) Γ (TrivMod Γ (ZMod p))) = 1
  /-- Input 1: `dim H²(G_K, 𝔽_p) = 1` when `μ_p ⊆ K`. -/
  h2_rank_of_mu : hasMu → Module.finrank (ZMod p) (contH2 (ZMod p) Γ (TrivMod Γ (ZMod p))) = 1
  /-- Input 1: `H²(G_K, 𝔽_p) = 0` when `μ_p ⊄ K`. -/
  h2_rank_of_not_mu :
    ¬ hasMu → Module.finrank (ZMod p) (contH2 (ZMod p) Γ (TrivMod Γ (ZMod p))) = 0
  /-- Input 1: the Euler-characteristic count `dim H¹ = 1 + dim H² + N`. -/
  h1_rank : Module.finrank (ZMod p) (contH1 (ZMod p) Γ (TrivMod Γ (ZMod p)))
    = 1 + Module.finrank (ZMod p) (contH2 (ZMod p) Γ (TrivMod Γ (ZMod p))) + N
  /-- Input 3: the cup pairing on `H¹(G_K, 𝔽_p)` is nondegenerate when `μ_p ⊆ K`. This is
  local Tate duality at `n = p`, transported along inputs 2 and 4. -/
  cup_nondegenerate : hasMu → ∀ a : cocycle₁ (ZMod p) Γ (TrivMod Γ (ZMod p)),
    cocycle₁.mk (ZMod p) Γ (TrivMod Γ (ZMod p)) a ≠ 0 →
    ∃ b : cocycle₁ (ZMod p) Γ (TrivMod Γ (ZMod p)),
      cocycle₂.mk (ZMod p) Γ (TrivMod Γ (ZMod p)) (cupCocycle (ZMod p) Γ a b) ≠ 0
  /-- Input 5: the cyclotomic character. -/
  cyclotomic : Γ →* ℤ_[p]ˣ
  /-- Input 5: it is continuous. -/
  cyclotomic_continuous : Continuous cyclotomic
  /-- Input 4: its finite quotients satisfy the prescription property of Layer 7, which is
  what the Kummer compatibility square gives. -/
  cyclotomic_prescription : hasMu → HasPrescriptionProperty cyclotomic

section LocalFields

variable {p : ℕ} [Fact p.Prime] {Γ : Type u} [Group Γ] [TopologicalSpace Γ]
  [IsTopologicalGroup Γ] [CompactSpace Γ] [TotallyDisconnectedSpace Γ] {N : ℕ} {hasMu : Prop}

-- `G_K(p)` is a quotient of a profinite group by a closed normal subgroup, so it is
-- profinite. That instance is the Layer 0 milestone `TotallyDisconnectedSpace (G ⧸ N)`
-- together with closedness of `proPKernel` (Layer 3); it is an argument here, because this
-- file states milestones and does not prove them.
variable [TotallyDisconnectedSpace (maximalProPQuotient p Γ)]

/-- **Layer 11, `G_K(p)` is topologically finitely generated.** From the `H¹` count and the
degree-one inflation isomorphism, and not from finite generation of `G_K`, which this
roadmap never assumes. -/
example (_inp : LocalFieldInputs p Γ N hasMu) :
    IsTopologicallyFinitelyGenerated (maximalProPQuotient p Γ) :=
  sorry

/-- **Layer 11, the free case (Shafarevich).** If `μ_p ⊄ K` then `G_K(p)` is free pro-`p` of
rank `N + 1`. -/
example (_inp : LocalFieldInputs p Γ N hasMu) (_h : ¬ hasMu) :
    Nonempty (maximalProPQuotient p Γ ≃ₜ* freeProP p (Fin (N + 1))) :=
  sorry

/-- **Layer 11, the Demushkin case.** If `μ_p ⊆ K` then `G_K(p)` is Demushkin of rank
`N + 2`. -/
example (_inp : LocalFieldInputs p Γ N hasMu) (_h : hasMu)
    (hD : IsDemushkin p (maximalProPQuotient p Γ)) :
    demushkinRank hD = N + 2 :=
  sorry

/-- **Layer 11, the orientation is cyclotomic.** The cyclotomic character is trivial on the
kernel of `G_K ↠ G_K(p)`, so it descends, and the descent has the prescription property.
With the uniqueness half of Labute Thm 4, the descent is the canonical character of
`G_K(p)`. -/
example (inp : LocalFieldInputs p Γ N hasMu) (_h : hasMu) :
    ∃ ψ : maximalProPQuotient p Γ →* ℤ_[p]ˣ, Continuous ψ ∧
      ψ.comp (QuotientGroup.mk' (proPKernel p Γ)) = inp.cyclotomic ∧
      HasPrescriptionProperty ψ :=
  sorry

end LocalFields

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

/-- **Layer 7, the `q`-invariant of `D₀`.** The torsion subgroup of `D₀^{ab} ≅ ℤ₂² × ℤ/2`
has two elements, so `q(D₀) = 2`. This is a computation with the presentation, and it does
not use the classification. -/
example : Nat.card {x : topAbelianization demushkinD0 // IsOfFinOrder x} = 2 :=
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
## The few headers that still need vocabulary this pin does not have

Everything cohomological in low degrees is Lean code above, against the Layer 5 carrier.
What is left needs cohomology in every degree, which means `continuousCohomology` from
Mathlib `v4.32.2`, a release later than this repository's pin. The shapes are recorded here,
and nothing in them is faked with an empty `Prop` field or a stand-in predicate.

```
/-- Layer 6: cohomological dimension, against Mathlib's all-degree object. -/
def cdLE (p n : ℕ) (G : Type u) [Group G] [TopologicalSpace G] : Prop :=
  ∀ m > n, ∀ A : TopRep (ZMod p) G, IsFiniteDiscrete A → continuousCohomology m A = 0

/-- Layer 5: the comparison with Mathlib's carrier, in degrees at most two. -/
theorem contH_eq_continuousCohomology (n : ℕ) (hn : n ≤ 2) : ...

/-- Layer 7: dimension two for an infinite Demushkin group (Tate). -/
theorem cd_eq_two (hG : IsDemushkin p G) (hinf : Infinite G) : cdLE p 2 G ∧ ¬ cdLE p 1 G

/-- Layer 9: the classification. Uniqueness first, then existence. `demushkinCharacter` is
the character whose existence and uniqueness Layer 7 states above. -/
theorem demushkin_iso_of_invariants (hG : IsDemushkin p G) (hH : IsDemushkin p H)
    (hrank : demushkinRank hG = demushkinRank hH)
    (himage : (demushkinCharacter hG).range = (demushkinCharacter hH).range) :
    Nonempty (G ≃ₜ* H)

theorem exists_demushkin_of_invariants (n : ℕ) (A : Subgroup ℤ_[p]ˣ)
    (hA : IsClosed (A : Set ℤ_[p]ˣ)) (h : RealizableInvariants p n A) :
    ∃ (G : Type u) (hG : IsDemushkin p G),
      demushkinRank hG = n ∧ (demushkinCharacter hG).range = A
```
-/

end TauCetiRoadmap.ProPGroups
