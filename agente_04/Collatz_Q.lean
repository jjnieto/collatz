/-
  Collatz_Q.lean
  agente_04 (rol Furstenberg) — sprint 3, núcleo de formalización Lean.

  Objetivo del fichero:
    - Definir T (Collatz acelerada) sobre ℕ, sin `sorry`.
    - Declarar Q (conjugación de Lagarias) como función ℕ → (ℕ → Fin 2),
      con su tipo explícito, sin `sorry` en la definición.
    - Enunciar `Q_conjugates_T_to_shift` como `theorem ... := sorry`
      (sorry estructural, intencional).
    - Demostrar SIN `sorry` al menos un lema auxiliar elemental.

  Diseño:
    Para maximizar la probabilidad de compilación se usa Lean 4 *core*,
    sin `import Mathlib`. Esto evita toda fricción con nombres de
    Mathlib (PadicInt, etc.) que cambian entre versiones. Los tipos
    usados (`Nat`, `Fin`, `if-then-else`) están en el preludio.

  Convención de T:
    Aquí se usa la versión "no comprimida" de Collatz sobre ℕ:
       T(n) = n/2          si n par,
       T(n) = 3*n + 1      si n impar.
    Esta variante es la que aparece en la mayor parte de la literatura
    didáctica (Lagarias 1985, §2). La variante comprimida T(n)=(3n+1)/2
    usada en sprint 02 es equivalente bajo composición con `n/2` en
    pasos impares. Se documenta la diferencia en `sprint_03.md`.
-/

namespace Collatz

/-- Función de Collatz (no comprimida) sobre ℕ. -/
def T (n : Nat) : Nat :=
  if n % 2 = 0 then n / 2 else 3 * n + 1

/-- Bit de paridad: 0 si par, 1 si impar. -/
def parityBit (n : Nat) : Fin 2 :=
  if n % 2 = 0 then ⟨0, by decide⟩ else ⟨1, by decide⟩

/-- Iterado k-ésimo de T. Definido por recursión sobre k. -/
def Titer : Nat → Nat → Nat
  | 0,     n => n
  | k+1,   n => T (Titer k n)

/-- Función Q de Lagarias: a cada n ∈ ℕ le asocia su paridad-vector
    `k ↦ parityBit(T^k n)`. Tipo explícito. -/
def Q (n : Nat) : Nat → Fin 2 :=
  fun k => parityBit (Titer k n)

/-- Shift de Bernoulli en `Nat → Fin 2`. -/
def shift (w : Nat → Fin 2) : Nat → Fin 2 :=
  fun k => w (k + 1)

/-- Conjugación de Lagarias: Q ∘ T = shift ∘ Q.
    Demostración aplazada (sorry estructural intencional). -/
theorem Q_conjugates_T_to_shift (n : Nat) :
    Q (T n) = shift (Q n) := by
  sorry

/-! ## Lemas auxiliares demostrados (sin `sorry`) -/

/-- T(0) = 0. Demostración por evaluación. -/
theorem T_zero : T 0 = 0 := by decide

/-- T sobre pequeños pares: T(2)=1. Demostrable por `decide` /`rfl`. -/
theorem T_two : T 2 = 1 := by decide

/-- T(4) = 2. -/
theorem T_four : T 4 = 2 := by decide

/-- T en un número par genérico es la mitad: T(2n) = n.
    Prueba elemental por análisis de casos sobre `(2*n) % 2`. -/
theorem T_even (n : Nat) : T (2 * n) = n := by
  unfold T
  have hmod : (2 * n) % 2 = 0 := by omega
  rw [if_pos hmod]
  omega

/-- T(1) = 4 (caso impar). -/
theorem T_one : T 1 = 4 := by decide

/-- Titer en 0 iteraciones es la identidad. -/
theorem Titer_zero (n : Nat) : Titer 0 n = n := by
  rfl

/-- Titer descompone un paso: T^(k+1)(n) = T(T^k(n)). -/
theorem Titer_succ (k n : Nat) : Titer (k+1) n = T (Titer k n) := by
  rfl

/-- parityBit de un par es 0. -/
theorem parityBit_even (n : Nat) : parityBit (2 * n) = ⟨0, by decide⟩ := by
  unfold parityBit
  have h : (2 * n) % 2 = 0 := by omega
  rw [if_pos h]

end Collatz
