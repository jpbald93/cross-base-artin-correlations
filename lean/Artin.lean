-- Machine-checked results for "Cross-base correlations of Artin primes:
-- entanglement, exclusion, and the structure of p-1".
--
-- PairExclusion.lean        same-prime pair exclusion (Theorem 1).
-- TripleExclusion.lean      triple exclusion (Theorem 2).
-- PrimitiveRootBridge.lean  primitive root => quadratic non-residue bridge.
-- Bridge.lean, Basic.lean   shared infrastructure.
-- Check.lean                axiom-dependency audit: every audited theorem must
--                           report only propext, Classical.choice, Quot.sound.
import Artin.Basic
import Artin.Bridge
import Artin.Exclusion
import Artin.PairExclusion
import Artin.TripleExclusion
import Artin.PrimitiveRootBridge
import Artin.Check
