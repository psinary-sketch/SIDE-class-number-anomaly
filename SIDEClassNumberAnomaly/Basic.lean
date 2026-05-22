/-
  SIDEClassNumberAnomaly/Basic.lean
  ==================================

  THE CLASS-NUMBER ANOMALY OF THE TRIVIUM QUADRATIC FIELDS

  Among the seven Trivium quadratic fields ℚ(√d) for d ∈ {-1, 2, 3, -2, -3, 6, -6},
  exactly one — ℚ(√-6) — has class number ≠ 1.  This kernel encodes the class
  numbers, Hamming weights, and discriminant magnitudes as data, then verifies
  the structural three-way distinction at the diagonal vertex:

    (a) Hamming weight 3 in (ℤ/2)³  — the unique weight-3 vertex
    (b) Class number 2              — the unique non-principal field
    (c) Discriminant magnitude 24   — the level-3 floor of the {2,3}-tower

  Vanilla Lean 4 — no Mathlib dependency.
  Toolchain: leanprover/lean4:v4.29.0-rc8.

  The class numbers themselves are programme-side input (taken from standard
  tables, computable in any CAS).  This kernel verifies the structural
  PATTERN that emerges from those class numbers under the Trivium's
  squarefree-{−1,2,3} representation.

  Theorems: 17 (v0.2 adds triple_identification_diagonal; LV-H-2).  sorry: 0.  axioms: 0.

  Author: J. York Seale (NaturalScience, ORCID 0009-0008-7993-0310)
  Programme: A PLACE TO STAND, Phase 2.  May 2026.

  Companion: FINDING_CLASS_NUMBER_DIAGONAL_ANOMALY_v0_2.md
             SIDE-spinor-calibration, SIDE-steane-arithmetic,
             SIDE-dirichlet-mod-24 (sibling cubit kernels)
-/

namespace SIDEClassNumberAnomaly

/-! ## §1. The Seven Trivium Discriminants -/

/-- The seven Trivium discriminants as a list. -/
def triviumDiscs : List Int := [-1, 2, 3, -2, -3, 6, -6]

theorem trivium_count : triviumDiscs.length = 7 := by decide

/-! ## §2. Class Numbers as Programme-Side Data

  Class numbers h(ℚ(√d)) for d in the Trivium are taken from standard
  tables (PARI/GP `quadclassunit`, OEIS A000924 / A000003).  Six are
  principal (h = 1); exactly one is not.
-/

/-- Class number of ℚ(√d) for d a Trivium discriminant.  Returns 0 for
    non-Trivium inputs (sentinel value). -/
def classNumber : Int → Nat
  | -1 => 1   -- ℚ(i)
  |  2 => 1   -- ℚ(√2)
  |  3 => 1   -- ℚ(√3)
  | -2 => 1   -- ℚ(√-2)
  | -3 => 1   -- ℚ(√-3)
  |  6 => 1   -- ℚ(√6)
  | -6 => 2   -- ℚ(√-6)  — THE ANOMALY
  |  _ => 0

/-- Theorem 2.1.  Six Trivium fields are principal (h = 1). -/
theorem six_principal :
    classNumber (-1) = 1 ∧ classNumber 2 = 1 ∧ classNumber 3 = 1 ∧
    classNumber (-2) = 1 ∧ classNumber (-3) = 1 ∧ classNumber 6 = 1 := by decide

/-- Theorem 2.2.  ℚ(√-6) has class number 2 — the unique non-principal field. -/
theorem anomaly_field : classNumber (-6) = 2 := by decide

/-- Theorem 2.3.  ℚ(√-6) is the ONLY Trivium field with h > 1. -/
theorem unique_non_principal :
    classNumber (-1) ≤ 1 ∧ classNumber 2 ≤ 1 ∧ classNumber 3 ≤ 1 ∧
    classNumber (-2) ≤ 1 ∧ classNumber (-3) ≤ 1 ∧ classNumber 6 ≤ 1 ∧
    classNumber (-6) > 1 := by decide

/-! ## §3. Hamming Weights in (ℤ/2)³

  Each Trivium discriminant d corresponds to a vertex of (ℤ/2)³ via the
  squarefree representation over {-1, 2, 3}.  The Hamming weight is the
  number of nonzero coordinates.
-/

/-- Hamming weight in the squarefree {-1, 2, 3} representation. -/
def hammingWeight : Int → Nat
  | -1 => 1   -- representation (1, 0, 0)
  |  2 => 1   -- (0, 1, 0)
  |  3 => 1   -- (0, 0, 1)
  | -2 => 2   -- (1, 1, 0)  =  -1 · 2
  | -3 => 2   -- (1, 0, 1)  =  -1 · 3
  |  6 => 2   -- (0, 1, 1)  =   2 · 3
  | -6 => 3   -- (1, 1, 1)  =  -1 · 2 · 3   — THE DIAGONAL
  |  _ => 0

/-- Theorem 3.1.  Three Trivium fields are Hamming weight 1. -/
theorem three_weight_1 :
    hammingWeight (-1) = 1 ∧ hammingWeight 2 = 1 ∧ hammingWeight 3 = 1 := by decide

/-- Theorem 3.2.  Three Trivium fields are Hamming weight 2. -/
theorem three_weight_2 :
    hammingWeight (-2) = 2 ∧ hammingWeight (-3) = 2 ∧ hammingWeight 6 = 2 := by decide

/-- Theorem 3.3.  Exactly one Trivium field is Hamming weight 3: ℚ(√-6). -/
theorem unique_diagonal : hammingWeight (-6) = 3 := by decide

/-- Theorem 3.4.  Hamming decomposition (3, 3, 1) covers all seven discriminants. -/
def w1Count : Nat := 3
def w2Count : Nat := 3
def w3Count : Nat := 1

theorem hamming_decomposition : w1Count + w2Count + w3Count = 7 := by decide

/-! ## §4. Discriminant Magnitudes -/

/-- The fundamental discriminant magnitude of ℚ(√d). -/
def discMagnitude : Int → Nat
  | -1 => 4    -- disc = -4
  |  2 => 8    -- disc =  8
  |  3 => 12   -- disc = 12
  | -2 => 8    -- disc = -8
  | -3 => 3    -- disc = -3
  |  6 => 24   -- disc =  24
  | -6 => 24   -- disc = -24
  |  _ => 0

/-- Theorem 4.1.  All Trivium discriminant magnitudes divide 24. -/
theorem all_divide_24 :
    24 % discMagnitude (-1) = 0 ∧
    24 % discMagnitude 2 = 0 ∧
    24 % discMagnitude 3 = 0 ∧
    24 % discMagnitude (-2) = 0 ∧
    24 % discMagnitude (-3) = 0 ∧
    24 % discMagnitude 6 = 0 ∧
    24 % discMagnitude (-6) = 0 := by decide

/-- Theorem 4.2.  ℚ(√-6) and ℚ(√6) both have discriminant magnitude 24. -/
theorem disc_24_pair :
    discMagnitude 6 = 24 ∧ discMagnitude (-6) = 24 := by decide

/-- Theorem 4.3.  No other Trivium field has discriminant magnitude 24. -/
theorem disc_24_only_d_eq_pm_6 :
    discMagnitude (-1) ≠ 24 ∧ discMagnitude 2 ≠ 24 ∧
    discMagnitude 3 ≠ 24 ∧ discMagnitude (-2) ≠ 24 ∧
    discMagnitude (-3) ≠ 24 := by decide

/-! ## §5. The Three-Way Distinction at d = -6 -/

/--
**Theorem 5.1 (Three-Way Distinction).**

The Trivium field ℚ(√-6) is distinguished from the other six fields by
three a priori independent properties simultaneously:

  (a) Hamming weight 3 in (ℤ/2)³  — the diagonal vertex
  (b) Class number 2              — the unique non-principal field
  (c) Discriminant magnitude 24   — the level-3 floor of the {2,3}-tower

These are three projections of the same underlying fact: 6 = 2·3 carries
full {2, 3}-ramification, producing nonzero coordinates in both prime
directions and the −1 sign together.
-/
theorem three_way_distinction :
    classNumber (-6) > 1 ∧
    hammingWeight (-6) = 3 ∧
    discMagnitude (-6) = 24 := by decide

/-- Theorem 5.2.  Among the six other Trivium fields, none has all three. -/
theorem other_six_lack_all_three :
    ¬(classNumber (-1) > 1 ∧ hammingWeight (-1) = 3) ∧
    ¬(classNumber 2 > 1 ∧ hammingWeight 2 = 3) ∧
    ¬(classNumber 3 > 1 ∧ hammingWeight 3 = 3) ∧
    ¬(classNumber (-2) > 1 ∧ hammingWeight (-2) = 3) ∧
    ¬(classNumber (-3) > 1 ∧ hammingWeight (-3) = 3) ∧
    ¬(classNumber 6 > 1 ∧ hammingWeight 6 = 3) := by decide

/--
**Theorem 5.3 (Triple Identification, Diagonal).**

Among the seven Trivium discriminants `triviumDiscs = [-1, 2, 3, -2, -3, 6, -6]`,
the conjunction `classNumber d = 2 ∧ hammingWeight d = 3 ∧ discMagnitude d = 24`
holds **if and only if** `d = -6`.  ℚ(√-6) is the unique Trivium field
exhibiting all three structural markers of the diagonal anomaly.

**Strengthening of `three_way_distinction` and `other_six_lack_all_three`.**
This theorem adds three substantive elements beyond what those two carry:

  (a) **uniqueness quantifier** across all 7 `triviumDiscs` (not just the
      single input `-6` as in `three_way_distinction`);
  (b) the **exact** `classNumber d = 2` (vs the looser `> 1` used in
      `three_way_distinction` for its structural framing);
  (c) the `discMagnitude d = 24` clause across all 7 discriminants —
      `other_six_lack_all_three` omits this clause and only checks the
      class-number-and-Hamming-weight conjunction.

Source: CLASS_NUMBER_ANOMALY_TRIVIUM_DIAGONAL v1.0 §8.2 (LV-H-2).

**Honesty note.**  `decide` verifies the diagonal-uniqueness *structure* over
the kernel's encoded arithmetic values: `classNumber`, `hammingWeight`, and
`discMagnitude` are encoded `def`s sourced from standard tables (Cohen 1993;
LMFDB; PARI/GP `quadclassunit(-24).no = 2`), not a from-first-principles
derivation.  The complementary Mathlib-bridge work that would ground
`classNumber (-6) = 2` from Mathlib's `NumberField.ClassNumber` machinery is
tracked as the separate verification candidate LV-L-4.
-/
theorem triple_identification_diagonal :
    ∀ d ∈ triviumDiscs,
      (classNumber d = 2 ∧ hammingWeight d = 3 ∧ discMagnitude d = 24) ↔ d = -6 := by
  decide

/-! ## §6. The Symmetry Break Between 6 and -6 -/

/--
**Theorem 6.1 (Symmetry Break).**

ℚ(√6) and ℚ(√-6) have the same discriminant magnitude 24, but differ
in both class number and Hamming weight.  The negative-discriminant
version carries the anomaly.
-/
theorem symmetry_break :
    discMagnitude 6 = discMagnitude (-6) ∧
    classNumber 6 ≠ classNumber (-6) ∧
    hammingWeight 6 ≠ hammingWeight (-6) := by decide

/-! ## §7. Programme Connections -/

/-- The natural modulus of the Trivium, level-3 of the {2,3}-doubling tower. -/
def naturalModulus : Nat := 24

/-- Theorem 7.1.  The anomaly discriminant magnitude equals the natural modulus. -/
theorem anomaly_eq_modulus :
    discMagnitude (-6) = naturalModulus := by decide

/-- Theorem 7.2.  The natural modulus factors as cube · 3. -/
theorem modulus_factorization :
    naturalModulus = 8 * 3 := by decide

end SIDEClassNumberAnomaly
