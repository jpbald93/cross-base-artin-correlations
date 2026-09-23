# Paper 3 — "Cross-base correlations of Artin primes" (DRAFT 2026-08-17)

First full draft (7pp). NOT yet reviewed by Josh. Same-prime, cross-base axis:
- Theorem (triple exclusion): no prime is Artin for all of a, b, c when sqf(c)=sqf(ab)
  (e.g. never all of 2,5,10). Three-line proof via chi_a*chi_b=chi_c.
- 66 pairs x 50.8M primes at 1e9: phi>0 for 64/66 (mean +0.035); ONLY negative pairs
  are the entangled ones (2,10) and (3,15).
- Conditioning: omega(p-1) removes 55%; fine signature (v2, primes<=13 dividing p-1,
  large-factor count) removes 95% -> correlation is common-cause p-1 structure.
- Residual localized on dependent pairs; killed by QR-vector conditioning (3e8 run)
  -> identified as quadratic entanglement.

- paper/    — .tex + PDF
- code/     — crossbase*.c one-pass programs + analyze_*.py
- results/  — summaries + logs (full 1e9 JSONs too big for copy; live in
              consecutive/multibase/crossbase_fine_1e9.json etc.)

Refs verified: Matthews Acta Arith 29 (1976) 113-146; Lenstra Invent Math 42 (1977) 201-224.
