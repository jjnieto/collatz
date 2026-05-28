# Sprint 02 — agente_04 (rol Furstenberg)

**Doble misión:** (i) sub-célula CICLOS — la desigualdad diofántica unificada `2^N ≈ 3^K` en una página, citable por 03, 04 y 06; (ii) Infraestructura — esqueleto formal de la conjugación `Q` de Lagarias, reusable por 03, 07, 08.

Lectura cruzada efectuada: `agente_03/sprint_01.md` y `agente_06/sprint_01.md` (autorizado por R-N1). Mi sprint_01 propio: punto 4, "el invariante es la frecuencia `k/p ≈ log 2 / log 3`".

---

## Sección CICLOS — Desigualdad diofántica unificada (una página)

### Notación fijada (autoritativa para la sub-célula)

- `T : Z -> Z` es la **función de Syracuse comprimida**: `T(n) = n/2` si `n` par; `T(n) = (3n+1)/2` si `n` impar.
- Un **ciclo no trivial** es una sucesión de impares positivos `a_0, a_1, ..., a_{K-1}` con `a_K = a_0` y `a_i != 1` para todo `i`, donde cada paso usa la rama impar: `a_{i+1} = (3 a_i + 1) / 2^{k_i}`, con `k_i >= 1` el número de divisiones por 2 que siguen al paso `3x+1`.
- **`K`** := número de subidas (pasos impares) = longitud de la sucesión `(a_i)`.
- **`N`** := `k_0 + k_1 + ... + k_{K-1}` = número total de divisiones por 2 a lo largo del ciclo. Equivalentemente: longitud total del paridad-vector `w in {0,1}^{N+K}` `[verificar: convenios alternativos contabilizan `N` como longitud total y `K` como impares; aquí fijamos `N` = pares, `K` = impares, total `K+N`]`.
- **`m`** := `min_i a_i` (mínimo del ciclo). Si la verificación numérica está hecha hasta `B`, entonces `m > B`.
- **`rho`** := `K / (K + N)` = frecuencia de unos (impares) en el paridad-vector. Equivalentemente, `K/N = rho/(1-rho)`.
- `log` denota logaritmo natural a lo largo del documento; los cocientes `log 3 / log 2` son invariantes de base.

### Enunciado central — Lema CIC-1 (desigualdad unificada `2^N ≈ 3^K`)

**Lema CIC-1.** *Sea `(a_0, ..., a_{K-1})` un ciclo no trivial de `T` con notación como arriba. Entonces:*

**(1) Identidad de cierre (Steiner–Eliahou, exacta).**
```
m_0 * (2^N - 3^K) = S
```
*donde `m_0 = a_0` y `S = sum_{i=0}^{K-1} 3^{K-1-i} * 2^{k_0 + k_1 + ... + k_{i-1}}` es una suma entera positiva de productos `3^a 2^b`. En particular `2^N > 3^K` y* `m_0 = S / (2^N - 3^K)`.

**(2) Frecuencia diofántica (Crandall–Eliahou).**
```
N / K  >  log 3 / log 2  =  1.5849625...
```
*y de hecho `N/K` aproxima `log 3 / log 2` con error*
```
0  <  N log 2 - K log 3  <=  log(1 + 1/m)  <  1/m.
```

**(3) Cota inferior derivada vía medida de irracionalidad efectiva.** *Sea `mu` una medida de irracionalidad efectiva publicada para `log 3 / log 2`, con constante `c > 0` y exponente `mu` tales que para todo par `(N, K)` con `K >= K_*`*
```
|N log 2 - K log 3|  >=  c * K^{-(mu-1)}.
```
*Combinando con (2):* `c * K^{-(mu-1)} <= 1/m`, *es decir* `m <= K^{mu-1} / c`. *Por tanto, si la verificación garantiza `m > B`, entonces `K >= (c B)^{1/(mu-1)}`.*

### Forma "una sola desigualdad" para citar literalmente

```
                   1                                              c
   0  <  N log 2 - K log 3  <  ---  ,    y simultáneamente   |N log 2 - K log 3|  >=  -----------
                                m                                                    K^{mu-1}
```

*Combinada:*
```
                   c                  1
              -----------   <=    -------
                K^{mu-1}              m

   <==>      m  <=  K^{mu-1} / c   ,   equivalentemente   K  >=  (c * m)^{1/(mu-1)}.
```

Esta es **la desigualdad citable**. Cualquier mejora de `c, mu` (palanca diofántica, agente_06) o de `m > B` (palanca de verificación, agente_05) se traduce mecánicamente en una cota `K >= K_0(B, c, mu)`.

### Para el ciclo trivial `{1,2,4}` (control de notación)

`K = 1`, `N = 1` (un paso impar `1 -> 2`, una división `2 -> 1`) en el ciclo `1 -> 2 -> 1`. Frecuencia `rho = K/(K+N) = 1/2`. **Atención:** en otras parametrizaciones (incluyendo mi sprint_01, sección 4) aparece `1/3` para el ciclo `1 -> 4 -> 2 -> 1` no comprimido. En el formalismo de `T` comprimida, `rho_trivial = 1/2`, y para ciclos no triviales `rho ≈ log 2 / log 3 ≈ 0.6309`. **Diferencia limpia** entre el ciclo trivial y un hipotético no trivial: `0.5` vs `≈ 0.6309`. `[verificar: contraste exacto con la versión no comprimida que aparece en agente_10]`.

### Interfaces

- **Interfaz para agente_03.** La cota (3) implica: si existe `mu` `T`-invariante ergódica con `supp(mu) \subset Z`, atómica, asociada a un ciclo de longitud combinatoria `(K, N)`, entonces `(K, N)` satisface CIC-1. La traducción medida-atómica ↔ par `(K, N)` es: `mu` equidistribuida en el ciclo da masa `1/(K+N)` a cada `a_i` y la frecuencia de `mu`-medida del evento "paridad impar" es exactamente `rho = K/(K+N)`.
- **Interfaz para agente_06.** La forma "K >= (c * m)^{1/(mu-1)}" es el punto donde 06 inyecta sus mejoras post-Rhin sobre `(c, mu)` y la verificación `B`. 06 produce el valor numérico `K_0`. Mi papel aquí termina en haber dejado la desigualdad escrita sin ambigüedad.

---

## Sección INFRAESTRUCTURA — Esqueleto formal de la conjugación `Q` de Lagarias

Lean 4 nominalmente factible pero no compilable en este sprint sin Mathlib instalada `[verificar]`. Entrego **firmas Lean 4-compatibles** (sintaxis válida; demostraciones `sorry`); 03/07/08 pueden importarlo por nombre.

```lean
-- Archivo propuesto: Collatz/Q.lean
-- Esqueleto para la conjugación Q de Lagarias. Demostraciones: sorry.

import Mathlib.NumberTheory.Padics.PadicIntegers
import Mathlib.Topology.Basic
import Mathlib.Dynamics.Ergodic.Function

namespace Collatz

/-- Los 2-ádicos con su estructura de anillo topológico. -/
abbrev Z2 : Type := PadicInt 2

/-- Predicado de paridad 2-ádica: bit menos significativo. -/
def isOdd (x : Z2) : Prop := sorry  -- def vía PadicInt.valuation o cilindro mod 2

/-- Función de Syracuse comprimida T : Z_2 -> Z_2. -/
noncomputable def T (x : Z2) : Z2 :=
  if isOdd x then (3 * x + 1) / 2 else x / 2

/-- T es continua sobre Z_2. -/
theorem T_continuous : Continuous T := sorry

/-- T es biyectiva (homeomorfismo) sobre Z_2 (Lagarias 1985). -/
theorem T_bijective : Function.Bijective T := sorry

/-- Bit de paridad en el k-esimo iterado. -/
def parityBit (x : Z2) (k : Nat) : Fin 2 :=
  if isOdd (T^[k] x) then 1 else 0

/-- Función Q de Lagarias: codifica la orbita por su paridad-vector. -/
def Q (x : Z2) : Nat -> Fin 2 := parityBit x

/-- Shift de Bernoulli en {0,1}^N. -/
def shift (w : Nat -> Fin 2) : Nat -> Fin 2 := fun n => w (n+1)

/-- Q es un homeomorfismo Z_2 -> {0,1}^N (topologia producto). -/
theorem Q_homeo : True := sorry  -- placeholder de Homeomorph Z2 (Nat -> Fin 2)

/-- Q conjuga T con el shift: Q ∘ T = shift ∘ Q. -/
theorem Q_conjugates_T_to_shift (x : Z2) : Q (T x) = shift (Q x) := sorry

/-- Q preserva la medida de Haar 2-adica enviandola a Bernoulli(1/2,1/2). -/
theorem Q_measure_preserving : True := sorry  -- placeholder

-- Subconjunto Z incrustado en Z_2 (densamente, medida cero).
def ZinZ2 : Set Z2 := Set.range (fun n : Int => (n : Z2))

/-- Ciclo no trivial: orbita periodica de T en Z que no contiene 1. -/
structure NontrivialCycle where
  period : Nat
  base   : Int
  base_ne_one : base ≠ 1
  base_ne_zero : base ≠ 0
  closes : T^[period] (base : Z2) = (base : Z2)
  period_pos : 0 < period

/-- Paridad-vector de un ciclo (palabra periodica en {0,1}^period). -/
def NontrivialCycle.parityWord (c : NontrivialCycle) (i : Fin c.period) : Fin 2 :=
  parityBit (c.base : Z2) i.val

/-- Numero de unos en la palabra (= K, subidas). -/
def NontrivialCycle.K (c : NontrivialCycle) : Nat := sorry  -- count of ones

/-- Numero de ceros (= N, divisiones por 2). -/
def NontrivialCycle.N (c : NontrivialCycle) : Nat := c.period - c.K

/-- Lema CIC-1 parte (1): identidad de cierre Steiner-Eliahou. -/
theorem cycle_closure_identity (c : NontrivialCycle) :
    ∃ S : Int, S > 0 ∧ c.base * (2^c.N - 3^c.K) = S := sorry

/-- Lema CIC-1 parte (2): N/K > log 3 / log 2 con error 1/m. -/
theorem cycle_frequency_bound (c : NontrivialCycle) :
    0 < (c.N : Real) * Real.log 2 - (c.K : Real) * Real.log 3 := sorry

end Collatz
```

**Notas de uso para 03, 07, 08.**
- **03** referencia `Collatz.NontrivialCycle` y `Collatz.Q` para la formulación atómica de medidas con soporte en ciclos. La igualdad `Q ∘ T = shift ∘ Q` es la herramienta para conjugar entropía Collatz con entropía Bernoulli.
- **07** referencia `Collatz.T` y `Collatz.NontrivialCycle.K`, `N` para enunciar su reducción condicional `σ(n) <= C log n => Collatz ∈ IΔ₀+exp` en un lenguaje formal mínimo.
- **08** referencia `Collatz.T` y los iterados `T^[k]` para enunciar cotas inferiores sobre `σ`.

`[verificar: nombres exactos de Mathlib para PadicInt; isOdd 2-adica probablemente requiere ZMod o cociente cilindro]`. La fidelidad del esqueleto a Mathlib actual debe revisarse al integrarlo.

---

### Sub-problema para sprint 3

Cerrar las firmas `sorry` de `Q_homeo`, `Q_conjugates_T_to_shift`, `Q_measure_preserving` con borradores de prueba (o reducciones a lemas de Mathlib nombrados). Criterio de éxito medible: archivo `Collatz/Q.lean` que compile contra Mathlib con al menos `T_continuous`, `T_bijective` y `Q_conjugates_T_to_shift` probados sin `sorry`. Métrica binaria: compila / no compila.

### Autoevaluación

**Prometedor (cambio respecto a sprint 1, donde marqué Improbable).** La razón del cambio: el rol de infraestructura es honestamente útil — produce un objeto nombrado y citable que descongestiona el trabajo de 03, 07, 08, aunque no avanza Collatz por sí mismo. Y la unificación notacional de la desigualdad `2^N ≈ 3^K` resuelve una fricción real entre 03 y 06 (que en sprint 1 usaban convenios distintos para `K` y `N`). El valor es estructural; el riesgo de circularidad de mi sprint 1 desaparece porque ya no pretendo derivar nada nuevo de la frecuencia.
