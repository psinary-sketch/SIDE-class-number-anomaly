# SIDE-class-number-anomaly v0.1

Kernel verification of the **three-way distinction at the diagonal** of the cubit substrate (ℤ/2)³, backing the finding doc *The Class-Number Anomaly of the Trivium Quadratic Fields*.

## Status

| | |
|---|---|
| Toolchain | `leanprover/lean4:v4.29.0-rc8` |
| Mathlib | not required |
| Theorems | 16 |
| sorry | 0 |
| axioms | 0 |
| Author | J. York Seale (NaturalScience) |
| Programme | A PLACE TO STAND, Phase 2, May 2026 |

Companion finding: `FINDING_CLASS_NUMBER_DIAGONAL_ANOMALY_v0_2.md`.

## Build

```bash
lake build
```

Self-contained — no Mathlib, no external dependencies.

## What's verified

### §1 — Trivium discriminants
- `trivium_count` — 7 Trivium discriminants

### §2 — Class numbers
- `six_principal` — ℚ(d) has h = 1 for d ∈ {−1, 2, 3, −2, −3, 6}
- `anomaly_field` — ℚ(√−6) has h = 2
- `unique_non_principal` — Only −6 has class number > 1

### §3 — Hamming weights
- `three_weight_1` — d ∈ {−1, 2, 3} are weight 1
- `three_weight_2` — d ∈ {−2, −3, 6} are weight 2
- `unique_diagonal` — Only d = −6 is weight 3
- `hamming_decomposition` — (3, 3, 1) sums to 7

### §4 — Discriminant magnitudes
- `all_divide_24` — All seven |disc| divide 24
- `disc_24_pair` — Both 6 and −6 have |disc| = 24
- `disc_24_only_d_eq_pm_6` — No other Trivium field has |disc| = 24

### §5 — The three-way distinction (the main theorem)
- `three_way_distinction` — At d = −6: class number > 1 ∧ Hamming weight 3 ∧ disc magnitude 24
- `other_six_lack_all_three` — None of the other six Trivium fields has all three properties

### §6 — Symmetry break
- `symmetry_break` — ℚ(√6) and ℚ(√−6) share |disc| but differ in h and Hamming weight

### §7 — Programme connection
- `anomaly_eq_modulus` — disc magnitude at the diagonal = natural modulus 24
- `modulus_factorization` — 24 = 8 · 3 = cubit cardinality × odd prime base

## What's NOT verified

- The class numbers themselves are **programme-side input** (taken from standard tables; computable in PARI/GP as `quadclassunit(D).no`). The kernel verifies the structural PATTERN that arises from those class numbers, not the class numbers from first principles.
- Class field theory background (the structural argument from §3 of the finding doc) lives in the manuscript, not the kernel.

## Federation context

This is the 13th PLACE TO STAND kernel. It backs the Wonder-1 finding directly: the kernel-verified pattern is what makes "the diagonal is distinguished three ways" a structural statement rather than a casual observation.

Cross-references:
- (ℤ/2)³ Hamming structure: verified independently in SIDE-spinor-calibration and SIDE-steane-arithmetic
- Discriminants dividing 24: verified in SIDE-dirichlet-mod-24
- {2,3}-tower level 3 = 24: verified in SIDE-spinor-calibration
- Cubit cardinality 8: verified across the cubit triple (spinor / steane / dirichlet)

## License

CC-BY 4.0. Cite as:

> Seale, J. Y. (2026). *SIDE-class-number-anomaly v0.1: The three-way distinction at the cubit diagonal.* A PLACE TO STAND Research Programme.

---

`:: → · ← ::`

*The diagonal carries the obstruction; the obstruction is identified three ways.*
