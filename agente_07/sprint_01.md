# Sprint 01 — agente_07 (rol Friedman, Célula 4, lógica)

**Ángulo:** fuerza de prueba. ¿Qué sistema formal necesita demostrar Collatz? ¿Es Collatz independiente de PA, de ARI primitiva-recursiva, o demostrable en algo aún más débil?

---

## 1. Estado del arte (lo que sabemos, lo que rumoreamos)

### 1.1 Conway y la generalización indecidible

Conway (1972, *Unpredictable iterations*) mostró que la clase de funciones de Collatz **generalizadas** — funciones lineales por trozos con coeficientes racionales, definidas por residuos módulo `d` — es Turing-completa. La iteración FRACTRAN (Conway, 1987) lo formaliza: cualquier máquina de Turing se simula con una lista finita de fracciones aplicadas a un entero. Corolario: **el problema de parada para Collatz generalizado es indecidible** (Σ⁰₁-completo, equivalentemente Π⁰₁-completo para la parada universal). Kurtz & Simon (2007) `[verificar]` afilaron esto a niveles superiores de la jerarquía aritmética para variantes naturales.

**Cuidado con el salto.** Esto no dice nada directo sobre el Collatz concreto `T(n) = n/2` si par, `(3n+1)/2` si impar. El Collatz específico es un único enunciado Π⁰₂ ("para todo n existe k tal que T^k(n)=1"). Un enunciado individual no hereda automáticamente la indecidibilidad de su familia: la familia es indecidible porque codifica TM, pero cada miembro fijo es o bien verdadero o bien falso, y puede ser demostrable en cualquier sistema suficientemente fuerte.

### 1.2 Forma lógica de Collatz

Collatz es **Π⁰₂**: `∀n ∃k (T^k(n)=1)`. La función `k(n)` (tiempo total de parada) no se sabe que sea recursivamente acotada. Si Collatz es cierto pero `k(n)` crece más rápido que cualquier función demostrablemente total en PA (al estilo Goodstein, Paris-Harrington, Kirby-Paris), entonces Collatz sería **demostrable en ZFC pero no en PA**. Este es el escenario "Friedman puro".

Sin embargo, los datos numéricos (Barina 2020, hasta ~2⁶⁸ `[verificar]`) sugieren que el tiempo de parada empírico crece como `O(log n)` — comportamiento mansísimo, no Ackermann. Eso es **evidencia heurística fuerte** de que `k(n)` está acotada por algo elemental (probablemente PR, quizá incluso `O(log n)`-tiempo en una codificación razonable), y por tanto contra independencia de PA por la ruta Friedman.

### 1.3 Lo que se ha intentado y huele a muerto

- **"Collatz como Goodstein."** Tentativo, sin instancia concreta de una función-jerarquía que controle el tiempo de parada. Matiyasevich y otros lo han considerado y descartado por falta de mecanismo. `[verificar]`
- **Reducción a un Π⁰₁ vía contra-ejemplo mínimo.** Si Collatz falla, el contraejemplo mínimo tiene órbita divergente o cíclica no trivial. La existencia de ciclo no trivial es Σ⁰₁; la existencia de órbita divergente es Σ⁰₂. Esto sí cambia la forma lógica pero **no** la fuerza de prueba.
- **Programas Lean / mathlib.** Hay formalización parcial de propiedades elementales de la función Collatz `[verificar]`. Nadie ha formalizado nada cercano a un resultado profundo. Esto es infraestructura, no avance.

---

## 2. Diferenciación frente a agente_08

agente_08 trabaja teoría de modelos (modelos no-estándar de PA, transferencia). Yo trabajo **fuerza de prueba**: sistemas formales, jerarquía aritmética, calibración por ordinales y por funciones demostrablemente totales. Solapamiento natural en el enunciado "¿es Collatz independiente de PA?", pero el ángulo es complementario: él pregunta *cómo se ve* un fallo no-estándar; yo pregunto *cuántos axiomas* hacen falta.

---

## 3. Posición honesta (obligada por el briefing)

**Creo que Collatz, si es cierto, es probablemente demostrable en PA, y posiblemente en una aritmética mucho más débil (RCA₀ o WKL₀ vía reverse mathematics).** Razones:

1. El tiempo total de parada empírico es `O(log n)`. Independencia tipo Goodstein requiere funciones de crecimiento monstruoso.
2. La estructura combinatoria (paridad-vectores de Terras) es finitaria y aritmética básica.
3. Los obstáculos conocidos (Eliahou para ciclos, Krasikov–Lagarias para densidad) son argumentos demostrables en PA o menos.

**Pero** — y aquí está la grieta — la **dificultad** de la demostración no es la fuerza axiomática; es encontrar el argumento. La pregunta análoga "¿es FLT demostrable en PA?" sigue abierta formalmente (McLarty argumentó que sí `[verificar]`), pese a que el teorema está demostrado en ZFC + universos. Collatz podría estar en la misma situación: cierto y demostrable en PA, pero nadie sabe cómo. Mi sub-problema apunta a *calibrar el techo y el suelo*.

---

## 4. Mapa de sistemas formales relevantes

| Sistema | Funciones totales demostrables | Plausible para Collatz |
|---|---|---|
| Q (Robinson) | muy poco | inviable |
| I∆₀ + exp | recursivas elementales | plausible si `k(n)` polinomial |
| PRA | primitivas recursivas | plausible |
| RCA₀ | recursivas | objetivo razonable |
| PA | < ε₀ (Gentzen) | suelo seguro |
| ZFC | enorme | trivialmente suficiente |

Pregunta calibrada: ¿el menor sistema que demuestra Collatz, condicional a que Collatz sea cierto y a que tengamos *alguna* demostración, vive en `I∆₀+exp` o sube a PA?

---

### Sub-problema para sprint 2

**Enunciado:** Formular y formalizar (en Lean 4 / mathlib) el enunciado preciso "Collatz ∈ Π⁰₂" junto con tres reducciones equivalentes: (a) Π⁰₁ vía no-existencia de ciclo no trivial *condicional* a no-divergencia, (b) Π⁰₂ canónico, (c) Σ⁰₂ negado. Identificar **una** instancia concreta de un fragmento aritmético `T` (candidatos: `I∆₀+exp`, `PRA`, `RCA₀`) y un sub-enunciado `C_T` (por ejemplo: "para todo n < 2^k la órbita termina en ≤ f(k) pasos", con `f` PR explícita) tal que `T ⊢ C_T` sea **decidible meta-matemáticamente** y produzca cota explícita.

**Criterio de éxito medible:**
1. Archivo Lean `Collatz/ProofTheory.lean` con definiciones `collatz_pi02`, `collatz_pi01_conditional`, y un lema `equiv_forms : collatz ↔ (no_divergent_orbit ∧ no_nontrivial_cycle)` cerrado.
2. Una tabla, con referencias verificadas, asignando a cada uno de `{Q, I∆₀, I∆₀+exp, PRA, RCA₀, PA}` un veredicto **fundamentado** entre `{insuficiente por crecimiento de testigo, plausible, demostrablemente suficiente si Collatz es cierto, no se sabe}`.
3. Cota explícita: si el tiempo total de parada es `≤ C·log₂(n)` para alguna constante `C` (empíricamente `C ≈ 6.95` `[verificar]`), demostrar formalmente que esa hipótesis acotante implica Collatz en `I∆₀+exp`. Es decir: separar el problema en (i) la cota empírica logarítmica y (ii) la traducción a fuerza de prueba.

### Autoevaluación

**Improbable.** El ángulo de fuerza de prueba pura para Collatz tiene un problema estructural: si la conjetura es cierta y mansa (mi apuesta), la fuerza de prueba es baja y aportaríamos un resultado meta sin resolver el problema; si fuera independiente de PA, demostrarlo requiere construir un modelo o una reducción tipo Paris-Harrington, y no hay ningún candidato visible. Seguir aún así porque el sub-problema 3 (reducción de cota empírica logarítmica a `I∆₀+exp`) sí es factible, publicable como nota técnica, y delimita honestamente qué parte del problema es analítica y qué parte es lógica — sirve al equipo como deslinde, no como avance.
