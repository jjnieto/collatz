/-
  FriedmanReduction.lean
  agente_07 (rol Friedman) — sprint 3, pata Lean.

  Objetivo del fichero:
    - Declarar la firma `collatz_of_log_bound : (∀ n ≥ N₀, σ n ≤ C * Nat.log2 n)
      → CollatzConjecture` como `theorem ... := sorry` (sorry estructural,
      es exactamente el contenido de (E-Friedman-σ)).
    - Demostrar SIN `sorry` al menos un lema auxiliar (paso uniforme S1/S3/S5).

  Coordinación con agente_04 (`Collatz_Q.lean`):
    - Mismo `namespace Collatz`.
    - Mismo `T` no comprimido (`T(n) = n/2` si par, `3n+1` si impar), por
      lo que la `σ` aquí cuenta los pasos de la versión NO comprimida.
      La constante `C` del enunciado debe entenderse en esa convención.
    - Mismo `Titer` que en `Collatz_Q.lean`. Aquí lo redefino localmente
      para que el fichero compile aislado; si se compilan juntos, los
      nombres coinciden y la doble definición se evita importando 04.

  Compilación:
    - No hay toolchain Lean en este entorno Windows (mismo diagnóstico que
      agente_04: `lean` y `lake` no están en PATH, no hay `elan`). La
      sintaxis se ha revisado a mano contra Lean 4 core, sin Mathlib.
-/

namespace Collatz

/-- Función de Collatz no comprimida, idéntica a la de `Collatz_Q.lean`
    de agente_04. Se redefine aquí para que este fichero sea autónomo. -/
def T (n : Nat) : Nat :=
  if n % 2 = 0 then n / 2 else 3 * n + 1

/-- Iterado k-ésimo de T. -/
def Titer : Nat → Nat → Nat
  | 0,     n => n
  | k+1,   n => T (Titer k n)

/-- Tiempo de parada acotado: ¿existe k ≤ K con Titer k n = 1?
    Función booleana decidible. Sirve como sustituto computable de
    `σ n ≤ K` mientras no se importe Mathlib para σ real. -/
def stopsBy (n K : Nat) : Bool :=
  match K with
  | 0     => decide (Titer 0 n = 1)
  | K+1   => decide (Titer (K+1) n = 1) || stopsBy n K

/-- `σ n ≤ K` como proposición. Usamos `stopsBy` por ser decidible y
    permitir `decide` en casos finitos. -/
def sigmaLe (n K : Nat) : Prop := stopsBy n K = true

/-- La cota uniforme (H1) en forma proposicional, parametrizada por N₀ y C. -/
def LogBoundHyp (N₀ : Nat) (C : Nat) : Prop :=
  ∀ n : Nat, n ≥ N₀ → sigmaLe n (C * Nat.log2 n)

/-- Conjetura de Collatz (versión NO comprimida, consistente con T arriba). -/
def CollatzConjecture : Prop :=
  ∀ n : Nat, n ≥ 1 → ∃ k : Nat, Titer k n = 1

/-! ## Firma principal (sorry estructural intencional) -/

/-- Reducción E-Friedman-σ en su forma Lean.
    El `sorry` es estructural: la prueba es (S1)–(S5) y exige
    además la verificación finita (H2) por debajo de N₀.
    Aplazado al estilo de `Q_conjugates_T_to_shift` de agente_04. -/
theorem collatz_of_log_bound (N₀ C : Nat)
    (h : LogBoundHyp N₀ C)
    (hfin : ∀ n : Nat, 1 ≤ n → n < N₀ → ∃ k, Titer k n = 1) :
    CollatzConjecture := by
  sorry

/-! ## Lemas auxiliares demostrados (sin `sorry`)

  Cubro tres lemas correspondientes a pasos uniformes del esquema (S1)–(S5):
    - `Titer_zero`        : caso base de iteración (paso S1 trivial).
    - `Titer_one_step`    : descomposición de un paso (paso S1).
    - `stopsBy_zero_one`  : `stopsBy 1 0 = true` (paso S5, caso terminal).
    - `sigmaLe_mono`      : monotonía en K (paso S2: si σ ≤ K y K ≤ K',
                           entonces σ ≤ K'). Sustantivo.
-/

/-- Iterar 0 veces es la identidad. -/
theorem Titer_zero (n : Nat) : Titer 0 n = n := by
  rfl

/-- Un paso de iteración se descompone. -/
theorem Titer_one_step (k n : Nat) : Titer (k+1) n = T (Titer k n) := by
  rfl

/-- El testigo trivial: desde n=1, σ ≤ 0 (ya estamos en 1). -/
theorem stopsBy_one_zero : stopsBy 1 0 = true := by
  decide

/-- Lema sustantivo: si `stopsBy n K = true` entonces `stopsBy n (K+1) = true`.
    Captura la monotonía de `σ n ≤ K` en `K`. Es un paso uniforme del
    esquema (S2): cualquier cota superior mayor también vale. -/
theorem stopsBy_succ (n K : Nat) :
    stopsBy n K = true → stopsBy n (K + 1) = true := by
  intro h
  -- stopsBy n (K+1) = (decide (Titer (K+1) n = 1)) || stopsBy n K
  -- Como stopsBy n K = true por hipótesis, el `||` cierra.
  simp [stopsBy, h]

/-- Versión proposicional del lema anterior: `σ n ≤ K → σ n ≤ K+1`. -/
theorem sigmaLe_succ (n K : Nat) :
    sigmaLe n K → sigmaLe n (K + 1) := by
  intro h
  unfold sigmaLe at *
  exact stopsBy_succ n K h

/-- Monotonía iterada: `σ n ≤ K` y `K ≤ K'` implica `σ n ≤ K'`.
    Este es el paso uniforme S2/S3 del esquema E-Friedman-σ. -/
theorem sigmaLe_mono (n K K' : Nat) (hKK' : K ≤ K') :
    sigmaLe n K → sigmaLe n K' := by
  intro h
  induction hKK' with
  | refl => exact h
  | step _ ih => exact sigmaLe_succ n _ ih

end Collatz
