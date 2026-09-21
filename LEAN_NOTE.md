# Machine-checked Theorem 2 (triple exclusion) — `lean/`

Added 2026-09-10. Paper 3's deterministic exclusion law is now formalized in
Lean 4 against Mathlib, stated with Mathlib's genuine `legendreSym`.

`lean/gate.sh` => **PASS (28 theorems, standard axioms only)** — build clean, no
`sorry`/`admit`/`axiom`/`native_decide`, every theorem depending only on
`propext`, `Classical.choice`, `Quot.sound`. Build instructions: `lean/BUILD.md`
(source only, ~50 KB; the ~7.5 GB Mathlib build tree is reconstructed with
`lake exe cache get`). Updated 2026-09-11: added `Artin/PrimitiveRootBridge.lean`
and composed it into `TripleExclusion.lean` (see finding 2 below — now fully
closed end-to-end, not just proved separately).

## Theorems for this paper (`lean/Artin/TripleExclusion.lean`)

| theorem | content |
|---|---|
| `not_all_three_nonresidue` | `c*s² = a*b*t²` with `s,t ≢ 0 (mod p)` ⇒ `(a\|p),(b\|p),(c\|p)` cannot all be `-1` |
| `legendreSym_third_eq_one` | same relation: `(a\|p) = (b\|p) = -1` ⇒ `(c\|p) = +1` |
| `not_all_three_nonresidue_two_five_ten` | headline case `(2,5,10)`, no side conditions needed |

`sqf(c) = sqf(ab)` is encoded as `c * s ^ 2 = a * b * t ^ 2`; witnesses are
immediate, e.g. `40 * 1² = 2 * 5 * 2²` and `90 * 1² = 2 * 5 * 3²`.

The file also contains the Paper 1 exclusion law (`Exclusion.lean`, `Bridge.lean`)
because both papers share the same parity mechanism and one Lean package covers
both.

## Two findings worth folding into the manuscript

1. **The hypotheses are stronger than needed.** Lean reported that the
   `a ≢ 0` and `b ≢ 0 (mod p)` assumptions are never used: `legendreSym p a = -1`
   already forces `a ≢ 0 (mod p)`, since a vanishing base gives symbol `0`.
   Theorem 2's `p ∤ 2abc` is therefore more than the parity argument requires,
   and the `(2,5,10)` case holds for **every** prime with no side condition.
   Consider stating the sharper hypothesis.
2. **Scope of what is checked — UPDATED 2026-09-11, gap fully closed end-to-end.**
   The step "Artin base `a` ⇒ `(a|p) = -1`" (criterion (1) in the paper) was a
   *hypothesis* in `TripleExclusion.lean`, not derived from Mathlib's
   primitive-root machinery. It is now proved in
   `lean/Artin/PrimitiveRootBridge.lean`:
   `isPrimitiveRoot_imp_legendreSym_eq_neg_one` — a primitive root generator of
   `(ZMod p)ˣ` is a quadratic non-residue — machine-checked, 0 `sorry`,
   standard axioms only. Drafted by a local model (qwen3:32b, GMKtec/Ollama)
   across 6 supervised rounds, human-closed on the two steps it correctly
   flagged as uncertain rather than guessed; see the file's docstring for the
   full provenance. **It is now also composed into `TripleExclusion.lean`**:
   `not_all_three_nonresidue_of_primitiveRoot` and
   `legendreSym_third_eq_one_of_primitiveRoot` take actual `IsPrimitiveRoot`
   facts for `a` and `b` instead of assumed `legendreSym = -1` hypotheses,
   discharging them via the bridge lemma. The original
   `legendreSym`-hypothesis theorems are kept as the character-parity core
   (they hold independent of *how* the `-1` arose). All 28 theorems in the
   package pass `#print axioms` with only `propext`, `Classical.choice`,
   `Quot.sound`.

   **UPDATED again 2026-09-11 (later): the paper's headline Theorem 3 (pair
   exclusion) is now formalized too**, in `lean/Artin/PairExclusion.lean`.
   After §2 of the manuscript was reorganised so that the density-1/2 pair law
   leads and triple exclusion follows as a corollary, the Lean was brought into
   the same shape: `not_both_nonresidue_of_barring_character` is the parity
   core, `not_both_primitiveRoot_of_barring_character` takes genuine
   `IsPrimitiveRoot` hypotheses, and `not_all_three_nonresidue_of_pair`
   re-derives triple exclusion from the pair law in three lines (the direct
   proof in `TripleExclusion.lean` is kept as well, so the dependence is
   exhibited rather than assumed).

   The strongest item is `not_both_primitiveRoot_five_ten`: bases `5` and `10`
   are never both primitive roots for `p ≡ 3, 5 (mod 8)`, with the barring
   condition `(2|p) = -1` discharged from `p mod 8` via Mathlib's
   `legendreSym.at_two` and the explicit character `χ₈`. Its hypotheses are a
   congruence and two `IsPrimitiveRoot` facts — **no Legendre symbol is assumed
   anywhere**. That is the exact form asserted in the paper's §2 display.

   Caveat, stated plainly: the general reciprocity step "`(d|p) = -1` iff `p`
   lies in explicit classes mod `4d`" is **not** packaged as a generic lemma.
   It is done by hand per instance (base `2` via `χ₈`; the `(2,6)` case at base
   `3` still takes `(3|p) = -1` as a hypothesis rather than deriving it from
   `p mod 12`). A generic version would need the full reciprocity machinery
   wired to residue-class arithmetic, which we have not attempted.

## Numerical corroboration (independent of the proofs)

Primes `3 ≤ p < 100000` across six triples including `(2,5,40)` and `(2,5,90)`:
**0 violations** of `not_all_three_nonresidue`; **14,436 / 14,436** cases with
`(a|p) = (b|p) = -1` gave `(c|p) = +1`.

## Reminder: the rest of Paper 3 is still BLOCK

`../review_2026-09-10/REPORT_B.md` blocks this paper on issues the Lean work does
not touch — the Kummer degree/F₂-rank implementation bug (§7), the impossible
Euler-tail explanation (Remark 9), the false "only negative pairs are exactly the
dependent ones" biconditional, and the "removed completely" claim. Theorem 2 was
never the problem; it is now machine-checked, but the empirical sections still
need repair.
