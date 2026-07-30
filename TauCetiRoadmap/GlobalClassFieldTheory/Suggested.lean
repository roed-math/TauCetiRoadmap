import Mathlib

/-!
# Global class field theory: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap.

The narrative roadmap (Layers 0–11, the pinned conventions, the route decision, the worked
examples, and the references) is in `README.md`. Mathlib has the adele ring of a number
field and the classical class group, but none of global class field theory's own objects:
no ray class groups or moduli, no narrow class group, no idele class group (in flight as
mathlib PR #40735 — align, don't fork), no Hecke characters, no reciprocity law, no
existence theorem, no Hilbert class field, no Kronecker–Weber. We build that in `TauCeti/`.

This file holds targets from the **pin-expressible layers**: Layers 0–4 (moduli
ingredients, the moving lemma, adelic discreteness/cocompactness, the class group as an
idele-class quotient, the finite-order Hecke-character dichotomy, the cyclotomic anchor)
and pin-expressible acceptance shapes of Layers 8–9. Per the honest-`sorry` rule, milestones
whose *statements* need vocabulary that does not exist at the pin are **not** stated here
and live in `README.md` only: everything mentioning ray class groups or Hecke characters as
objects (the objects are Layer 1/3 constructions in `TauCeti/`), the norm-index machinery of
Layer 5 (its S-idele statements want the Layer 2 objects), the global Artin map and
reciprocity law of Layers 6–7 (they compile the local Artin maps of the LocalFields sibling
roadmap, in preparation), and the class-formation and Hilbert-reciprocity layer 11 (it
consumes the ProfiniteCohomology sibling and the LocalFields Hilbert symbols). As those
layers make their types expressible in `TauCeti/`, add their milestones here with `sorry`.
-/

namespace TauCetiRoadmap.GlobalClassFieldTheory

open NumberField IsDedekindDomain

open scoped nonZeroDivisors

universe u

/-! ## Layer 0: moduli and multiplicative congruences -/

/-- **Layer 0, sign surjectivity at the real places.** Every pattern of signs at the real
places is realized by a global element: the total sign map `Kˣ → Π_{w real} {±1}` is
surjective. This is the infinite-place face of weak approximation (derivable at the pin
from `InfiniteAdeleRing.denseRange_algebraMap`), the enabling lemma for every
narrow-versus-wide class group comparison, and the reason real places can sit in a modulus
at all. ⚠ The corresponding map on *units* `(𝓞 K)ˣ` is not surjective in general (`ℚ(√3)`);
that failure is measured by `Cl⁺ ≠ Cl` in Layer 1. -/
example (K : Type u) [Field K] [NumberField K]
    (ε : {w : InfinitePlace K // w.IsReal} → Bool) :
    ∃ x : Kˣ, ∀ w : {w : InfinitePlace K // w.IsReal},
      (0 < InfinitePlace.embedding_of_isReal w.2 (x : K) ↔ ε w = true) :=
  sorry

/-! ## Layer 1: ray class groups -/

/-- **Layer 1, the moving lemma.** Every ideal class of a Dedekind domain contains an
integral ideal coprime to a fixed nonzero ideal `𝔪`. Absent from Mathlib (only
`ClassGroup.mk0_surjective` exists); this is the pivot for the surjectivity of
`Cl_{𝔪'} ↠ Cl_𝔪`, for the ray class exact sequence, and for the ideal↔idele dictionary.
Route: CRT/approximation in the Dedekind domain, not geometry of numbers; prove it at this
generality (the ray-class-group versions specialize). -/
example (R : Type u) [CommRing R] [IsDedekindDomain R] (𝔪 : Ideal R) (h𝔪 : 𝔪 ≠ ⊥)
    (C : ClassGroup R) :
    ∃ I : (Ideal R)⁰, ClassGroup.mk0 I = C ∧ IsCoprime (I : Ideal R) 𝔪 :=
  sorry

/-! ## Layer 2: the idele class group -/

/-- **Layer 2, `K` is discrete in its adeles.** The principal adeles form a discrete
subgroup of `AdeleRing (𝓞 K) K` — one half of the fundamental local-global finiteness
package. Proved sorry-free in FLT (`NumberField.AdeleRing.discrete`); per the roadmap's
provenance section, coordinate with the FLT maintainers (preferred outcome: their statement
upstreams and this milestone becomes consume-and-cite). -/
example (K : Type u) [Field K] [NumberField K] :
    DiscreteTopology (AdeleRing.principalSubgroup (𝓞 K) K) :=
  sorry

/-- **Layer 2, cocompactness.** The quotient `𝔸_K/K` is compact — the other half of the
package, the adelic form of Minkowski finiteness. Also sorry-free in FLT
(`NumberField.AdeleRing.cocompact`, via base change from `ℚ`); same coordination note. The
multiplicative sequel — compactness of the norm-one idele class group `C_K^1`, Fujisaki's
lemma — is stated in `README.md` Layer 2 and becomes expressible here once the idele norm
exists (mathlib PR #36275 in flight). -/
example (K : Type u) [Field K] [NumberField K] :
    CompactSpace (AdeleRing (𝓞 K) K ⧸ AdeleRing.principalSubgroup (𝓞 K) K) :=
  sorry

/-- **Layer 2, the class group is an idele-class quotient.** The quotient of the finite
ideles by the everywhere-integral-unit ideles and the principal ideles is the ideal class
group (the map is `x ↦ ∏_v v^{v(x_v)}`; kernel analysis via the moving lemma). This is de
Frutos-Fernández's Lean 3 theorem (ITP 2022) restated in the pin's vocabulary, and the
prototype of the Layer 2 dictionary `C_K ⧸ (U_𝔪-image) ≃* Cl_𝔪` for every modulus. -/
example (K : Type u) [Field K] [NumberField K] :
    ∃ S : Subgroup (FiniteAdeleRing (𝓞 K) K)ˣ,
      (∀ u : (FiniteAdeleRing (𝓞 K) K)ˣ,
        u ∈ S ↔ ∀ v : HeightOneSpectrum (𝓞 K),
          Valued.v ((u : FiniteAdeleRing (𝓞 K) K) v) = (1 : WithZero (Multiplicative ℤ))) ∧
      Nonempty
        (((FiniteAdeleRing (𝓞 K) K)ˣ ⧸
            (S ⊔ (FiniteAdeleRing.unitEmbedding (𝓞 K) K).range)) ≃* ClassGroup (𝓞 K)) :=
  sorry

/-- **Layer 2, the global↔local bridge.** The completion of a number field at a finite
place is a nonarchimedean local field — the statement through which every consumption of
the LocalFields sibling roadmap (local Artin maps, local conductors, local norms) crosses
into this roadmap. The compatible `ValuativeRel`/`IsValuativeTopology` instances are
hypothesized here because *producing* them (from the pin's `Valued` instance on
`adicCompletion`, ⚠ without stating anything against `Valued` — see the deprecation note
inherited from the LocalFields provenance) is part of the milestone. Coordinate with the
NumberFieldArithmetic sibling roadmap, which owns the global↔local dictionary: stated in
both, proved once. -/
example (K : Type u) [Field K] [NumberField K] (v : HeightOneSpectrum (𝓞 K))
    [ValuativeRel (v.adicCompletion K)] [IsValuativeTopology (v.adicCompletion K)] :
    IsNonarchimedeanLocalField (v.adicCompletion K) :=
  sorry

/-! ## Layer 3: Hecke characters -/

/-- **Layer 3, the finite-order dichotomy.** A continuous character of the idele class
group (the quotient here is the pin-vocabulary spelling of `IdeleClassGroup` from mathlib
PR #40735 — keep the shapes aligned) has finite order if and only if its kernel is open.
With the Layer 2 neighborhood-basis lemma this becomes: finite-order Hecke characters are
exactly the ray class characters, and over `ℚ` exactly the Dirichlet characters — the
dictionary that keeps `DirichletCharacter` and the new theory glued together. ⚠ The
backward direction uses compactness of `π₀(C_K)` (Fujisaki, Layer 2); it is not formal. -/
example (K : Type u) [Field K] [NumberField K]
    (χ : ContinuousMonoidHom
      ((AdeleRing (𝓞 K) K)ˣ ⧸
        (Units.map (algebraMap K (AdeleRing (𝓞 K) K)).toMonoidHom).range) ℂˣ) :
    (∃ n : ℕ, 0 < n ∧ ∀ y, χ y ^ n = 1) ↔ IsOpen {y | χ y = 1} :=
  sorry

/-! ## Layer 4: the cyclotomic anchor -/

/-- **Layer 4, the splitting law in `ℚ(ζₙ)`.** A prime `p ∤ n` splits completely in the
`n`-th cyclotomic field iff `p ≡ 1 (mod n)` — the composite of the pin's
`IsCyclotomicExtension.Rat.galEquivZMod_stabilizer` (the decomposition group at `p` is
`⟨[p]⟩`) with the splitting-completely dictionary. This is the Galois-side avatar of the
Layer 1/4 worked example `Cl_{(n)∞}(ℚ) ≃* (ZMod n)ˣ`, and the arithmetic anchor of the
whole reciprocity development. -/
example (n p : ℕ) [NeZero n] [Fact p.Prime] (hpn : ¬ p ∣ n) :
    Nat.card (Ideal.primesOver (Ideal.span {(p : ℤ)}) (𝓞 (CyclotomicField n ℚ)))
        = Module.finrank ℚ (CyclotomicField n ℚ) ↔ p ≡ 1 [MOD n] :=
  sorry

/-- **Layer 4, the Frobenius at `p` is `[p]` — with the arithmetic orientation.** An
automorphism `σ` of `ℚ(ζₙ)` is an arithmetic Frobenius at a prime `P` above `p ∤ n` (the
congruence `σ x ≡ x^p mod P` on integers, which is the pin's `IsArithFrobAt` unfolded
through `galRestrict`) iff `σ = σ_p : ζ ↦ ζ^p`, i.e. `galEquivZMod σ = [p]`. ⚠ This is the
milestone that pins the direction convention: the *geometric* convention would put `[p]⁻¹`
on the right, and an error here is invisible to degree-counting tests — which is exactly
why this statement, not the splitting law, is the normalization anchor. -/
example (n p : ℕ) [NeZero n] [Fact p.Prime] (hpn : p.Coprime n) (K : Type u) [Field K]
    [NumberField K] [IsCyclotomicExtension {n} ℚ K]
    (P : Ideal (𝓞 K)) [P.IsPrime] (hP : (p : 𝓞 K) ∈ P) (σ : Gal(K/ℚ)) :
    (∀ x : 𝓞 K, galRestrict ℤ ℚ K (𝓞 K) σ x - x ^ p ∈ P) ↔
      IsCyclotomicExtension.Rat.galEquivZMod n K σ = ZMod.unitOfCoprime p hpn :=
  sorry

/-! ## Layers 8–9: acceptance shapes (pin-expressible worked examples)

The Hilbert class field, the principal ideal theorem, the existence theorem, and the
conductor–discriminant formula are README-only until the Layer 1–7 objects exist in
`TauCeti/`. Three of their concrete consequences are stateable today and serve as
end-to-end acceptance targets. -/

/-- **Layer 8 acceptance, `x² + 5y²`.** For a prime `p ∉ {2, 5}`: `p = x² + 5y²` iff
`p ≡ 1, 9 (mod 20)`. The modern proof *is* the Hilbert class field `H = ℚ(√−5, i)` of
`K = ℚ(√−5)` (class number 2) plus genus theory: `p` is represented iff `p` splits
completely in `H`. Doubles as the Multiquadratic-interface instance (`H` is the genus
field of `K`) — the two roadmaps must prove *compatible* statements here. -/
example (p : ℕ) (hp : p.Prime) (h2 : p ≠ 2) (h5 : p ≠ 5) :
    (∃ x y : ℤ, (p : ℤ) = x ^ 2 + 5 * y ^ 2) ↔ (p % 20 = 1 ∨ p % 20 = 9) :=
  sorry

/-- **Layer 9 acceptance, Kronecker–Weber.** Every abelian extension of `ℚ` embeds in a
cyclotomic field. Statement form aligned with mathlib PR #40661's `theorem_wanted`
(`IsAbelianGalois.le_cyclotomicField`); the sharp form — the least such `n` is the finite
part of the conductor — is the Layer 9 milestone proper. Route: this is a *corollary* of
the Layer 7 computation "the ray class field of `ℚ` mod `(n)∞` is `ℚ(ζₙ)`"; do not build
the elementary ramification-theoretic proof as a prerequisite. -/
example (L : Type u) [Field L] [NumberField L] [IsAbelianGalois ℚ L] :
    ∃ n : ℕ, n ≠ 0 ∧ Nonempty (L →ₐ[ℚ] CyclotomicField n ℚ) :=
  sorry

/-- **Layer 9 acceptance, the smallest conductor computation.** `√5 ∈ ℚ(ζ₅)`: the
quadratic field of discriminant 5 lies in the fifth cyclotomic field — the least cyclotomic
level of `ℚ(√5)` equals its conductor 5 (`ℚ(√5) = ℚ_{(5)∞}`-part of the conductor–
discriminant bookkeeping, in its smallest instance; the companion inclusions
`ℚ(i) ⊆ ℚ(ζ₄)` and `ℚ(√2) ⊆ ℚ(ζ₈)` pin the levels 4 and 8). -/
example : ∃ x : CyclotomicField 5 ℚ, x ^ 2 = 5 :=
  sorry

end TauCetiRoadmap.GlobalClassFieldTheory
