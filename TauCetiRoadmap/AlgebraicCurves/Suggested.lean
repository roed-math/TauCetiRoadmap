import Mathlib

/-!
# Algebraic curves — function fields, divisors, and Riemann–Roch: target signatures

**This file is not the roadmap and is not exhaustive.** The definitive document is
`README.md`. The statements here suggest Lean forms for particular milestones, so that
contributors and reviewers converge on names and signatures; discharging all of them
finishes neither a layer nor the roadmap.

The narrative roadmap (Layers 0–12, the pinned conventions, the worked examples, and the
references) is in `README.md`. Mathlib at the pin has the valuation/Dedekind substrate
(`HeightOneSpectrum`, adic valuations, `FractionalIdeal.count`, the different ideal,
Kähler differentials) and **no curve theory at all**: no divisors, no `L(D)`, no genus,
no Riemann–Roch. We build that in `TauCeti/`.

Because the pin's vocabulary (valuations into `ℤᵐ⁰`, `Finsupp`, `Submodule`, `finrank`)
can already *express* the early theory, this file goes further than a bare skeleton: it
prototypes the Layer-0/3 definitions — `Place` (a normalized discrete valuation trivial
on the constants), `Divisor` (`Place k F →₀ ℤ`), degree, `riemannRochSpace`,
`Divisor.dim` (ℓ), `genus` — with real (sorry-free) bodies, and states milestone
targets against them with `sorry`, through Riemann's theorem and the **Riemann–Roch
theorem** itself (existential canonical-divisor form; its honesty is backed by the
README's uniqueness milestone, Stichtenoth Prop. 1.6.1). The prototypes are aids, not
the specification: implementors may repackage them (e.g. bundling places differently)
so long as the pinned conventions in `README.md` are respected.

Per the honest-`sorry` rule, milestones whose *statements* need API that does not exist
at the pin are **not** stated here and live in `README.md` only: the repartition space
and Weil differentials as objects (Layer 4's proof route — statable but bulky; only RR's
finrank consequence is stated here), extensions of function fields with `e`/`f`/conorm,
the different divisor and Riemann–Hurwitz (Layers 6–7), constant-field extensions
(Layer 8), the Kähler comparison (Layer 9), automorphism bounds (Layer 11), and the
scheme dictionary (Layer 12). As those layers make their types expressible in
`TauCeti/`, add their milestones here with `sorry`.
-/

namespace TauCetiRoadmap.AlgebraicCurves

open scoped WithZero

universe u v

variable (k : Type u) (F : Type v) [Field k] [Field F] [Algebra k F]

/-- **Layer 0, the object of study** (Stichtenoth Def. 1.1.1, intrinsic form): `F` is an
algebraic function field of one variable over `k` if some `x : F` is transcendental over
`k` with `F` finite over `k(x)`. No generator is chosen: the comparison with Mathlib's
chosen-generator `FunctionField Fq F` (an `abbrev` for `FiniteDimensional Fq⟮X⟯ F`) and
with `Algebra.trdeg k F = 1` (for finitely generated `F`) are Layer-0 milestones. -/
class IsFunctionField : Prop where
  exists_transcendental_finiteDimensional :
    ∃ x : F, Transcendental k x ∧
      FiniteDimensional (IntermediateField.adjoin k {x}) F

/-- **Layer 0, exactness of the constant field**: every element of `F` algebraic over
`k` is a constant (Stichtenoth's standing "`k` is the full constant field", in force
from §1.4 on). Pinned spelling: Mathlib's `IsIntegrallyClosedIn k F` — integral =
algebraic over a field, so it says exactly this — equivalently
`algebraicClosure k F = ⊥` (the pin's relative algebraic closure, Stacks 09GI); both
faces of the dictionary are the milestones below. A stated hypothesis from Layer 3
onward, never absorbed; the constant field `k̃ := algebraicClosure k F` is always
finite over `k` (Stichtenoth Cor. 1.1.16, in Mathlib as
`FunctionField.finiteDimensional_of_constantExtension`), so one can always pass to
`F/k̃`. -/
example : IsIntegrallyClosedIn k F ↔ ∀ x : F, IsAlgebraic k x → x ∈ (algebraMap k F).range :=
  sorry

/-- **Layer 0, exactness via the relative algebraic closure**: the same condition, as
triviality of `algebraicClosure k F`. -/
example : IsIntegrallyClosedIn k F ↔ algebraicClosure k F = ⊥ :=
  sorry

/-- **Layer 0, places** (pinned convention): a place of `F/k` is a **normalized**
discrete valuation — a `ℤᵐ⁰`-valued valuation, surjective (so the value group is exactly
`ℤ`, killing the equivalence-class quotient: place equality is valuation equality) and
trivial on `k` (Mathlib's `Valuation.IsTrivialOn`). Equivalence with Stichtenoth's
valuation rings `k ⊊ 𝒪 ⊊ F` (Def. 1.1.4, Thm. 1.1.6) and with the
`IsRankOneDiscrete`/`IsTrivialOn` hypotheses of the pin's Ostrowski theorem
`RatFunc.valuation_isEquiv_infty_or_adic` are Layer-0 milestones. -/
structure Place where
  /-- The normalized valuation of the place. Convention (Mathlib-multiplicative):
  integers are `v ≤ 1` and a prime element `t` has `v t = WithZero.exp (−1)`. -/
  valuation : Valuation F ℤᵐ⁰
  surjective : Function.Surjective valuation
  isTrivialOn : valuation.IsTrivialOn k

variable {k F}

namespace Place

variable (P : Place k F)

/-- The valuation ring `𝒪_P` of a place, as a `ValuationSubring` (which carries the
`IsLocalRing`, `ValuationRing`, and `IsDomain` instances from Mathlib). That it is a
**discrete** valuation ring, and Stichtenoth's dictionary places ↔ valuation rings
(Thm. 1.1.13), are Layer-0 targets below. -/
def integers : ValuationSubring F :=
  P.valuation.valuationSubring

/-- **Layer 0, the additive order function** `ord_P : F → ℤ`: `ord_P t = 1` on prime
elements, `ord_P = 0` on `𝒪_Pˣ` (in particular on `kˣ`). ⚠ Junk value: `ord_P 0 = 0`
(via `WithZero.log 0 = 0`); statements about `ord_P f` carry `f ≠ 0` or use the
multiplicative `P.valuation` directly. The mult/additive translation
`P.valuation f = WithZero.exp (−ord_P f)` (for `f ≠ 0`) is the one named lemma of the
convention table. -/
noncomputable def ord (f : F) : ℤ :=
  -WithZero.log (P.valuation f)

theorem algebraMap_mem_integers (c : k) : algebraMap k F c ∈ P.integers := by
  rcases eq_or_ne c 0 with rfl | hc
  · simp only [map_zero]; exact zero_mem _
  · exact le_of_eq (P.isTrivialOn.eq_one c hc)

/-- Constants are integral at every place: the structure map `k → 𝒪_P`. -/
noncomputable instance : Algebra k P.integers :=
  ((algebraMap k F).codRestrict P.integers P.algebraMap_mem_integers).toAlgebra

/-- The residue field `F_P := 𝒪_P / 𝔪_P` of a place (pinned: `IsLocalRing.ResidueField`
of the valuation subring, never a bespoke quotient). -/
noncomputable abbrev ResidueField : Type v :=
  IsLocalRing.ResidueField P.integers

noncomputable instance : Algebra k P.ResidueField :=
  ((IsLocalRing.residue P.integers).comp (algebraMap k P.integers)).toAlgebra

/-- **Layer 0, the degree of a place**: `deg P := [F_P : k]`. Its finiteness and
positivity (Stichtenoth Prop. 1.1.15) are the targets below; `finrank`'s junk value `0`
is guarded by them. -/
noncomputable def degree : ℕ :=
  Module.finrank k P.ResidueField

end Place

variable (k F) in
/-- **Layer 3, divisors** (pinned convention): the divisor group is the `Finsupp`
`Place k F →₀ ℤ` (Stichtenoth Def. 1.4.1), with the pointwise partial order, support,
and `AddCommGroup` structure for free. Effective means `0 ≤ D`. -/
abbrev Divisor : Type v :=
  Place k F →₀ ℤ

namespace Divisor

/-- **Layer 3, the degree of a divisor**: `deg D = ∑_P D(P) · deg P` (Stichtenoth
Def. 1.4.1). ⚠ Weighted by the residue degrees `deg P` — the unweighted sum is correct
only over algebraically closed constants and is never the definition. That `degree` is
additive (a `→+`) and descends to the class group (via `deg ∘ div = 0`, the product
formula below) are milestones. -/
noncomputable def degree (D : Divisor k F) : ℤ :=
  D.sum fun P n => n * P.degree

/-- **Layer 3, principal divisors**: `D` is the divisor of a function if `D = div f :=
∑_P ord_P f · P` for some `f ≠ 0` (Stichtenoth Def. 1.4.2). Stated as a predicate here;
that the map `div` lands in `Divisor` at all — finiteness of zeros and poles
(Stichtenoth Cor. 1.3.4) — is a target below. -/
def IsPrincipal (D : Divisor k F) : Prop :=
  ∃ f : F, f ≠ 0 ∧ ∀ P : Place k F, D P = P.ord f

end Divisor

/-- **Layer 3, the Riemann–Roch space** `L(D)` (Stichtenoth Def. 1.4.4), as a
`k`-submodule of `F`: the functions with `div f + D ≥ 0`, i.e.
`v_P f ≤ exp (D P)` at every place (this multiplicative form is junk-free at `f = 0`,
so no `∪ {0}` is needed). `L(0) = k` iff the constant field is exact. -/
noncomputable def riemannRochSpace (D : Divisor k F) : Submodule k F where
  carrier := {f : F | ∀ P : Place k F, P.valuation f ≤ WithZero.exp (D P)}
  add_mem' {a b} ha hb P := le_trans (P.valuation.map_add a b) (max_le (ha P) (hb P))
  zero_mem' P := by simp
  smul_mem' c f hf P := by
    rcases eq_or_ne c 0 with rfl | hc
    · simp
    · rw [Algebra.smul_def, map_mul, P.isTrivialOn.eq_one c hc, one_mul]
      exact hf P

/-- **Layer 3, `ℓ(D)`** (Stichtenoth Def. 1.4.10): the `k`-dimension of `L(D)`.
Finite-dimensionality (Prop. 1.4.9) is a target below; `finrank`'s junk value is
guarded by it. -/
noncomputable def Divisor.dim (D : Divisor k F) : ℕ :=
  Module.finrank k (riemannRochSpace D)

variable (k F) in
/-- **Layer 3, the genus** (Stichtenoth Def. 1.4.15): `g := max {deg A − ℓ(A) + 1}`.
Junk-guarded: the supremum is finite by Riemann's theorem (Prop. 1.4.14 / Thm. 1.4.17,
a target below), and the defining quantity is `≥ 0` at `A = 0` when the constant field
is exact. Genus is **defined before** Riemann–Roch, never via `H¹` or differentials;
`ℓ(W) = g` and `deg W = 2g − 2` are theorems (Cor. 1.5.16). -/
noncomputable def genus : ℕ :=
  sSup (Set.range fun D : Divisor k F => (Divisor.degree D + 1 - Divisor.dim D).toNat)

/-! ## Layer 0: places -/

/-- **Layer 0, non-vacuity**: the rational function field is a function field. (The pin
provides `Algebra k (RatFunc k)`; `RatFunc.transcendental_X` and
`RatFunc.adjoin_X = ⊤`-style API do the work.) -/
example : IsFunctionField k (RatFunc k) :=
  sorry

/-- **Layer 0, places are DVRs** (Stichtenoth Thm. 1.1.6): the valuation ring of a
place is a discrete valuation ring. (For a surjective `ℤᵐ⁰`-valuation this is direct;
consume the pin's `Valuation.IsRankOneDiscrete` API and
`valuationSubring_isDiscreteValuationRing`.) -/
example [IsFunctionField k F] (P : Place k F) : IsDiscreteValuationRing P.integers :=
  sorry

/-- **Layer 0, degrees are finite** (Stichtenoth Prop. 1.1.15): the residue field of a
place is finite-dimensional over the constants — the Zariski-lemma-shaped statement the
pin lacks. With it, `0 < P.degree`. -/
example [IsFunctionField k F] (P : Place k F) :
    Module.Finite k P.ResidueField ∧ 0 < P.degree :=
  sorry

/-- **Layer 0, weak approximation** (Stichtenoth Thm. 1.3.1, equality form): finitely
many places are independent — any targets `x P` and orders `r P` are simultaneously
approximable, `ord_P (f − x P) = r P`. Stated multiplicatively (junk-free: the value
`exp (−r P)` is nonzero, forcing `f ≠ x P`). -/
example [IsFunctionField k F] (S : Finset (Place k F)) (x : Place k F → F)
    (r : Place k F → ℤ) :
    ∃ f : F, ∀ P ∈ S, P.valuation (f - x P) = WithZero.exp (-(r P)) :=
  sorry

/-! ## Layer 1: the rational function field -/

/-- **Layer 1, the place at infinity of `k(x)`** (Stichtenoth Prop. 1.2.1(c)): a place
with `v_∞ f = exp (intDegree f)` — i.e. `ord_∞ f = −intDegree f`, pole order = degree —
and residue degree `1`. Repackages the pin's `RatFunc.inftyValuation` (same formula) as
a `Place`. -/
example :
    ∃ P : Place k (RatFunc k),
      (∀ f : RatFunc k, f ≠ 0 → P.valuation f = WithZero.exp f.intDegree) ∧
        P.degree = 1 :=
  sorry

/-- **Layer 1, the finite places of `k(x)`** (Stichtenoth Prop. 1.2.1(a)): each monic
irreducible `p ∈ k[X]` gives a place with `ord_{P_p} p = 1` and degree `natDegree p` —
repackaging the pin's `HeightOneSpectrum k[X]` adic valuations. (That these plus `P_∞`
are *all* the places, Thm. 1.2.2, is the classification milestone, consuming the pin's
Ostrowski theorem `RatFunc.valuation_isEquiv_infty_or_adic`.) -/
example (p : Polynomial k) (hp : Irreducible p) (hm : p.Monic) :
    ∃ P : Place k (RatFunc k),
      P.valuation (algebraMap (Polynomial k) (RatFunc k) p) = WithZero.exp (-1) ∧
        P.degree = p.natDegree :=
  sorry

/-! ## Layer 3: divisors, the product formula, Riemann's theorem, the genus -/

/-- **Layer 3, zeros and poles are finite** (Stichtenoth Cor. 1.3.4): a nonzero
function is integral at cofinitely many places with unit value — the statement that
lets `div f` live in the `Finsupp` divisor group. -/
example [IsFunctionField k F] (f : F) (hf : f ≠ 0) :
    {P : Place k F | P.valuation f ≠ 1}.Finite :=
  sorry

/-- **Layer 3, principal divisors exist**: the divisor `div f` of a nonzero function,
with coefficients `ord_P f` (packaging the previous target as a `Finsupp`). -/
example [IsFunctionField k F] (f : F) (hf : f ≠ 0) :
    ∃ D : Divisor k F, ∀ P : Place k F, D P = P.ord f :=
  sorry

/-- **Layer 3, the product formula** (Stichtenoth Thm. 1.4.11): principal divisors have
degree zero — `deg (f)₀ = deg (f)_∞ = [F : k(f)]`, so the degree map descends to the
divisor class group. Absent from Mathlib for function fields (the number-field
`ProductFormula` does not apply). -/
example [IsFunctionField k F] (hex : IsIntegrallyClosedIn k F) (D : Divisor k F)
    (hD : D.IsPrincipal) : Divisor.degree D = 0 :=
  sorry

/-- **Layer 3, `L(0) = k`** (Stichtenoth Lemma 1.4.7, under exact constants): the only
functions with no poles are the constants. The `ℝ ⊂ ℂ(x)` guard example below shows the
hypothesis is load-bearing. -/
example [IsFunctionField k F] (hex : IsIntegrallyClosedIn k F) :
    riemannRochSpace (0 : Divisor k F) = LinearMap.range (Algebra.linearMap k F) :=
  sorry

/-- **Layer 3, finite-dimensionality of `L(D)`** (Stichtenoth Prop. 1.4.9). -/
example [IsFunctionField k F] (hex : IsIntegrallyClosedIn k F) (D : Divisor k F) :
    FiniteDimensional k (riemannRochSpace D) :=
  sorry

/-- **Layer 3, Riemann's theorem** (Stichtenoth Thm. 1.4.17): `ℓ(D) ≥ deg D + 1 − g`
always, with equality once `deg D` is large. (The inequality half is the definition of
`genus` unwound; the content is the boundedness making `genus` well-defined, plus the
eventual equality.) -/
example [IsFunctionField k F] (hex : IsIntegrallyClosedIn k F) :
    (∀ D : Divisor k F, Divisor.degree D + 1 - genus k F ≤ Divisor.dim D) ∧
      ∃ c : ℤ, ∀ D : Divisor k F, c ≤ Divisor.degree D →
        (Divisor.dim D : ℤ) = Divisor.degree D + 1 - genus k F :=
  sorry

/-! ## Layers 4–5: Riemann–Roch and consequences -/

/-- **Layer 4, the Riemann–Roch theorem** (Stichtenoth Thm. 1.5.15, with
Cor. 1.5.16): there is a divisor `W` — the canonical divisor, constructed via Weil
differentials on the repartition space — with `deg W = 2g − 2`, `ℓ(W) = g`, and
`ℓ(D) = deg D + 1 − g + ℓ(W − D)` for every `D`. Stated existentially here; the
uniqueness of the RR data (any `(g₀, W₀)` satisfying the identity has `g₀ = g` and `W₀`
canonical — Stichtenoth Prop. 1.6.1) is the milestone making this form honest, and the
canonical class itself becomes nameable once `Ω_F` exists in `TauCeti/`. Hypotheses:
exact constants only — the constant field is otherwise arbitrary. -/
example [IsFunctionField k F] (hex : IsIntegrallyClosedIn k F) :
    ∃ W : Divisor k F,
      Divisor.degree W = 2 * (genus k F : ℤ) - 2 ∧
        Divisor.dim W = genus k F ∧
          ∀ D : Divisor k F,
            (Divisor.dim D : ℤ) =
              Divisor.degree D + 1 - genus k F + Divisor.dim (W - D) :=
  sorry

/-- **Layer 5, the `deg ≥ 2g − 1` regime** (Stichtenoth Thm. 1.5.17): the sharp
threshold for `ℓ(D) = deg D + 1 − g`. -/
example [IsFunctionField k F] (hex : IsIntegrallyClosedIn k F) (D : Divisor k F)
    (hD : 2 * (genus k F : ℤ) - 1 ≤ Divisor.degree D) :
    (Divisor.dim D : ℤ) = Divisor.degree D + 1 - genus k F :=
  sorry

/-- **Layer 5, Clifford's theorem** (Stichtenoth Thm. 1.6.13): `ℓ(D) ≤ 1 + (deg D)/2`
in the special range `0 ≤ deg D ≤ 2g − 2`. ⚠ Stichtenoth's proof assumes `k` infinite
and completes the finite case only via constant-field extension (Thm. 3.6.3(d), Layer
8) — the README pins how to sequence this. -/
example [IsFunctionField k F] (hex : IsIntegrallyClosedIn k F) (D : Divisor k F)
    (h0 : 0 ≤ Divisor.degree D) (h2g : Divisor.degree D ≤ 2 * (genus k F : ℤ) - 2) :
    2 * (Divisor.dim D : ℤ) ≤ 2 + Divisor.degree D :=
  sorry

/-! ## Layers 1 and 10: worked examples as acceptance criteria -/

/-- **Layers 1/3, `ℓ(n·P_∞) = n + 1` on `ℙ¹`**: `L(n·P_∞)` is the polynomials of degree
`≤ n` — provable by hand before Riemann–Roch, and the sharpness witness for Riemann's
inequality at genus 0. -/
example (P : Place k (RatFunc k))
    (hP : ∀ f : RatFunc k, f ≠ 0 → P.valuation f = WithZero.exp f.intDegree) (n : ℕ) :
    Divisor.dim (Finsupp.single P (n : ℤ)) = n + 1 :=
  sorry

/-- **Layer 3, the rational function field has genus 0** (Stichtenoth Ex. 1.4.18). -/
example : genus k (RatFunc k) = 0 :=
  sorry

/-- **Layer 3, the exact-constants guard**: `ℂ(x)` is a function field over `ℝ` whose
constant field is `ℂ`, so `ℓ(0) = 2 ≠ 1` — the example that keeps
`IsIntegrallyClosedIn` an explicit hypothesis everywhere. -/
example : Divisor.dim (0 : Divisor ℝ (RatFunc ℂ)) = 2 :=
  sorry

/-- **Layer 5 at genus 1 — the fibrewise content of PR #81's assumed Riemann–Roch
interface** ("the space-of-sections dimensions for the divisors `n·[0]`"): on a genus-1
function field with a rational place `[0]`, `ℓ(n·[0]) = n` for `n ≥ 1`. The relative
(base-scheme) upgrade is JacobianChallenge Layer-C territory; see the README's
Layer 12. -/
example [IsFunctionField k F] (hex : IsIntegrallyClosedIn k F) (hg : genus k F = 1)
    (P : Place k F) (hP : P.degree = 1) (n : ℕ) (hn : 1 ≤ n) :
    Divisor.dim (Finsupp.single P (n : ℤ)) = n :=
  sorry

/-- **Layer 10, Mathlib's elliptic curves have genus 1**: for a Weierstrass curve `W`
with unit discriminant (`W.IsElliptic`), a function field generated by an affine
solution of its equation has genus 1 — all characteristics (the general `a₁ … a₆`
form). This is compatibility milestone (i) of Layer 10, stated against the pin's
`WeierstrassCurve` data. -/
example [IsFunctionField k F] (hex : IsIntegrallyClosedIn k F)
    (W : WeierstrassCurve k) [W.IsElliptic] (x y : F) (hx : Transcendental k x)
    (heq : y ^ 2 + algebraMap k F W.a₁ * x * y + algebraMap k F W.a₃ * y =
      x ^ 3 + algebraMap k F W.a₂ * x ^ 2 + algebraMap k F W.a₄ * x +
        algebraMap k F W.a₆)
    (hgen : IntermediateField.adjoin k {x, y} = ⊤) :
    genus k F = 1 :=
  sorry

/-- **Layers 2/10, the Dedekind instance both this roadmap and PR #68 want**: the
affine coordinate ring of an elliptic curve is a Dedekind domain (at the pin it has
only `IsDomain`). Falls out of Layer 2's general "integral closures of `k[x]` in
function fields are Dedekind" applied to `y² + a₁xy + a₃y = x³ + …`. -/
example (W : WeierstrassCurve k) [W.IsElliptic] :
    IsDedekindDomain W.toAffine.CoordinateRing :=
  sorry

/-- **Layer 10, hyperelliptic genus 2** (Stichtenoth Prop. 6.2.3 at `m = 5`): the
function field of `y² = x⁵ − 1` has genus 2 when `char k ∉ {2, 5}` (the hypotheses make
`x⁵ − 1` separable and the cover tame) — the acceptance test for Layer 7's
Riemann–Hurwitz with its explicit different. -/
example [IsFunctionField k F] (hex : IsIntegrallyClosedIn k F) (x y : F)
    (hx : Transcendental k x) (heq : y ^ 2 = x ^ 5 - 1)
    (hgen : IntermediateField.adjoin k {x, y} = ⊤) (h2 : (2 : k) ≠ 0)
    (h5 : (5 : k) ≠ 0) :
    genus k F = 2 :=
  sorry

end TauCetiRoadmap.AlgebraicCurves
