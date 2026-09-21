# Cross-base correlations of Artin primes

Reproduction package for *Cross-base correlations of Artin primes: entanglement,
exclusion, and the structure of p−1* (J. Bald, 2026).

The paper asks what happens to the Artin (primitive root) property when you fix
a single prime and vary the **base**. Two results are deterministic and proved;
the rest is an exact census over all primes below 10⁹ for twelve bases and all
66 pairs.

## The exclusion laws

Write `sqf(n)` for the squarefree part of `n`, and let `d = sqf(ab)`.

**Pair exclusion.** For every odd prime `p` with `(d/p) = −1`, `p` cannot be a
primitive root base `a` *and* base `b`. Since `(d/p) = −1` on half the primes,
every pair of bases with distinct squarefree parts is barred on an explicit half
of all primes.

**Triple exclusion.** If `sqf(c) = sqf(ab)`, no odd prime is simultaneously
Artin for all of `a`, `b`, `c`.

Both hold with no hypothesis on the bases beyond positivity — square bases and
`1` included — and the restriction to odd `p` is necessary, not cosmetic: every
odd integer is vacuously a primitive root mod 2.

Neither is new as an obstruction. The underlying criterion is classical, due to
Matthews, and appears in Moree–Stevenhagen §5 as the condition for the local
quadratic admissibility set to be empty. What this package adds is an
elementary pointwise formulation, a machine-checked proof, and the measurement.

## Layout

```
paper/        LaTeX source, compiled PDF, figure script
code/         census programs (C) and analysis (Python)
results/      exact contingency tables and run logs (JSON)
lean/         Lean 4 formalisation + axiom-dependency gate
submission/   manuscript, anonymised copy, source and reproduction zips
audit_2026-09-20/   three independent referee-style audit reports
```

## Reproducing the census

The programs are deterministic integer tallies. A correct re-run is
**byte-identical** to the stored JSON — any difference is a finding, not
rounding.

```bash
cd code
gcc -O3 -o crossbase      crossbase.c      -lm
gcc -O3 -o crossbase_qr   crossbase_qr.c   -lm
gcc -O3 -o crossbase_fine crossbase_fine.c -lm
gcc -O3 -o crossbase_om   crossbase_om.c   -lm

./crossbase    1000000000 ../results/crossbase_1e9.json
./crossbase_qr 1000000000 ../results/crossbase_qr_1e9.json
```

`crossbase_qr` at 10⁹ takes roughly 20 minutes on one core.

The analysis scripts take the JSON path as an argument, and write their summary
output into the current directory:

```bash
cd code
python3 analyze_crossbase.py ../results/crossbase_2e8.json      # 66-pair correlations
python3 analyze_qr.py        ../results/crossbase_qr_1e9.json   # character-conditioned residuals
python3 analyze_fine.py      ../results/crossbase_fine_1e9.json # fine-signature conditioning
python3 analyze_om.py        ../results/crossbase_om_1e9.json   # omega(p-1) conditioning
python3 kummer_model.py                                         # heuristic vs measurement
```

`kummer_model.py` needs no argument and reproduces the marginal Hooley densities
as an implementation check, including the base-5 correction factor
`C·20/19 = 0.393638` against a measured `0.393642`. Run from a fresh clone it
reports a mean relative error of 0.012% and a maximum of 0.040% on the joint
densities, matching the paper.

## Lean

```bash
cd lean
lake exe cache get     # do this first; building Mathlib from source is slow
./gate.sh
```

The gate requires a successful build, rejects `sorry`/`admit`/`axiom`/
`native_decide`, requires the number of audited theorems to meet a pinned
count so a silently deleted audit line fails, and rejects any axiom outside
`propext`, `Classical.choice`, `Quot.sound`.

**Scope, stated plainly.** The pair and triple theorems are formalised,
including the `(5,10)` instance whose barring condition is discharged from
`p mod 8` — that instance assumes no character hypothesis at all. The general
translation of `(d/p) = −1` into residue classes mod `4d` is **not** formalised
generically; it is carried out by hand per instance. See `LEAN_NOTE.md`. Do not
describe this paper as "verified in Lean" without that qualification.

## Audits

Three independent referee-style audits were run on 2026-09-20 by models from
different vendors, all with computation explicitly out of scope. Reports are in
`audit_2026-09-20/` and are published unedited, including the findings against
the paper.

The first returned **major revision**. Its central finding was that an earlier
version identified the paper's pair classification with Kummer degree collapse
"exactly", which is false in both directions: for `(7,11)` the product class 77
has conductor 77 dividing `L = 154` while the individual conductors 28 and 44 do
not, and for `(2,6)` every nontrivial class of `V` has conductor divisible by 4,
which no squarefree `L` is. Both counterexamples are now in the text and the
identification is withdrawn.

The two later passes returned **minor revision, no blockers**, and between them
caught four places where pre-revision language had survived the first round of
fixes, plus a citation to a numbered example in a paywalled source that could
not be obtained.

## Companion papers

- Paper 1, *Correlations between primitive root statuses of consecutive primes* —
  [doi:10.5281/zenodo.22863946](https://doi.org/10.5281/zenodo.22863946) ·
  [repo](https://github.com/jpbald93/consecutive-primitive-roots)
- Paper 2, *Quadratic exclusion laws for consecutive Artin primes in arbitrary bases* —
  [doi:10.5281/zenodo.22865343](https://doi.org/10.5281/zenodo.22865343) ·
  [repo](https://github.com/jpbald93/quadratic-exclusion-laws)

Those concern a different axis: two primes in one base. This paper is one prime,
two bases.

## Licence

Manuscript, figures and prose: CC BY 4.0 (`LICENSE-CC-BY-4.0.txt`).
Code and Lean: MIT (`LICENSE`).

## Status

Unrefereed preprint. Not submitted to a journal; no arXiv posting yet (a math.NT
endorsement is outstanding). The density comparisons rest on the
Matthews–Moree–Stevenhagen framework and are conditional on GRH, as the text
states.
