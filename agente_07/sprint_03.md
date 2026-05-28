# Sprint 03 — agente_07 (rol Friedman + abogado del diablo)

**Triple misión:** (1) pata Lean `FriedmanReduction.lean`; (2) auditoría final del sprint 2; (3) certificado del sprint 3 sobre `c(ε)` de agente_01 y `Collatz_Q.lean` de agente_04.

---

## Sección 1 — Pata Lean: `FriedmanReduction.lean`

### 1.1 Diseño y coordinación con agente_04

El fichero está en `C:\Users\jjnie\collatz\agente_07\FriedmanReduction.lean`. Sigue la misma decisión arquitectónica que agente_04 (`Collatz_Q.lean`): **Lean 4 core, sin `import Mathlib`**, dentro de `namespace Collatz`. Esto cumple con la consigna del briefing (R-N4, criterio binario) sin amarrar el destino del fichero a una versión concreta de Mathlib.

La coordinación simbólica con 04 sobre los nombres canónicos quedó así:

- **`T`** se define igual que en 04, como `T : Nat → Nat` no comprimida (`n/2` si par, `3n+1` si impar). Reproducimos la definición textualmente para que el fichero sea autónomo y, si en el futuro ambos se compilan juntos, basta importar 04 y eliminar la duplicación.
- **`Titer`** es idéntico al de 04 (recursión `0 ↦ id`, `k+1 ↦ T ∘ Titer k`).
- **`σ`** (tiempo de parada) no se introduce como función `Nat → Nat∞` (eso exigiría `Option`/`WithTop` y al menos un lema de minimalidad), sino como predicado decidible `sigmaLe n K := stopsBy n K = true`, donde `stopsBy : Nat → Nat → Bool` recorre los `K+1` iterados primeros y devuelve `true` si alguno es `1`. Esta decisión es deliberada: `sigmaLe` es **decidible** en Lean 4 core puro y permite cerrar lemas finitos por `decide`, sin construir maquinaria de mínimos sobre tipos con punto infinito.

Esto deslinda la convención: cuando agente_01 hablaba de `σ ≤ C·log₂ n` en el sprint 2, aquí se traduce como `sigmaLe n (C * Nat.log2 n)`, con `Nat.log2` del preludio de Lean 4 core. La hipótesis (H1) queda nombrada `LogBoundHyp N₀ C`.

### 1.2 Contenido

El fichero declara:

- `def T`, `def Titer`, `def stopsBy`, `def sigmaLe`, `def LogBoundHyp`, `def CollatzConjecture` — sin `sorry`.
- **Firma principal** con `sorry` estructural intencional:

  ```
  theorem collatz_of_log_bound (N₀ C : Nat)
      (h : LogBoundHyp N₀ C)
      (hfin : ∀ n : Nat, 1 ≤ n → n < N₀ → ∃ k, Titer k n = 1) :
      CollatzConjecture := by
    sorry
  ```

  El `sorry` corresponde exactamente al contenido de (E-Friedman-σ): pasos (S1)–(S5) del sprint 2 más combinación con (H2) (`hfin`). Es estructural en el mismo sentido que el `sorry` de `Q_conjugates_T_to_shift` de 04: aplazado, no escondido.

- **Cinco lemas auxiliares demostrados sin `sorry`**:

  | Lema | Paso del esquema | Tactic |
  |---|---|---|
  | `Titer_zero` | S1, caso base | `rfl` |
  | `Titer_one_step` | S1, descomposición | `rfl` |
  | `stopsBy_one_zero` | S5, terminal | `decide` |
  | `sigmaLe_succ` | S2, monotonía paso a paso | `unfold + stopsBy_succ` |
  | `sigmaLe_mono` | S2/S3, monotonía iterada | inducción sobre `≤` |

  Los dos primeros son `rfl` y son ligeros; los tres últimos son sustantivos. En particular `sigmaLe_mono` no es trivial: induce sobre `Nat.le.step` y compone con `sigmaLe_succ`, que a su vez se prueba por `simp [stopsBy, h]` sobre la cláusula `||`. Cumple holgadamente la consigna de "al menos UN lema auxiliar demostrado sin `sorry`".

### 1.3 Compilación: misma honestidad que 04

No hay toolchain Lean en este entorno Windows. Repito literalmente el diagnóstico que ya documentó 04: `lean` y `lake` no están en `PATH`, no hay `elan` instalado. Por tanto **no he ejecutado `lake build`** y no puedo dar certificación binaria de compilación.

Riesgos residuales que un compilador real podría delatar, revisados a mano:

- `Nat.log2` está en Lean 4 core desde 4.6 aproximadamente `[verificar]`. Si la toolchain destino es anterior, sustituir por una implementación local de `log2` por recursión.
- `decide` sobre `stopsBy 1 0 = true` requiere que el evaluador reduzca `match`/`decide (Titer 0 1 = 1)`. Como `Titer 0 1 = 1` por `rfl`, `decide` lo cierra.
- `simp [stopsBy, h]` sobre el `||` debe ver `stopsBy n (K+1) = decide (...) || stopsBy n K` y reescribir el segundo operando a `true`. La regla de `Bool.or_true` está en el preludio.
- `induction hKK'` sobre `Nat.le`: en Lean 4 core, `Nat.le` es un inductivo con constructores `refl` y `step`, exactamente como uso en `sigmaLe_mono`.

**Estimación honesta:** misma probabilidad cualitativa que 04 (>80% bajo Lean 4.10+; ~50% bajo 4.5–4.9), pero con la **misma tacha** de no poder ejecutar la verificación. La métrica binaria R-N4 sólo se satisface al 50%: hay fichero, hay un `sorry` único estructural, hay lemas demostrados; lo que falta es el "compila" verificado.

---

## Sección 2 — Auditoría final del sprint 2

He releído tres pasajes objeto de auditoría en el sprint 2 (Pasajes A, B, C) y dos pasajes nuevos que no me asignaron entonces y que ahora reviso de oficio antes del cierre: (i) el propio enunciado E-Friedman-σ que escribí en mi sprint 2 §1.1; (ii) la cota `α_0 = 1.930` de agente_10 contra el umbral `< 1.3066` de agente_06.

**(i) Mi propio E-Friedman-σ.** Releído en frío, encuentro un punto que no marqué con `[verificar]` y debería haberlo marcado: el paso (S4) afirma `Σ₁`-completitud sobre estructuras finitas dentro de `IΔ₀+exp`. Esto requiere que la tabla de verificación finita debajo de `N₀` quepa en términos `Δ₀`-acotados, lo cual a su vez requiere que `N₀ · max{σ(n) : n < N₀}` sea acotable por un término de longitud polinomial en `log N₀`. Con `N₀ = 2^{32}` y `σ ≤ C·log₂ n ≤ 32·C`, esto se cumple holgadamente, pero la afirmación general "estructuralmente no se necesita `C`, sí `N₀`" del sprint 2 §1.2 es **incompleta**: en realidad sí se necesita una cota sobre `max σ` debajo de `N₀`, que es lo que `C_emp` proporciona empíricamente. No es un error material —la cota está disponible— pero debería haberse explicitado. Lo declaro como **erratum menor** del sprint 2.

**(ii) Brecha 1.930 vs 1.3066.** Releída la prueba elemental de agente_10 (Chernoff sobre `j < k/log₂3`) y el umbral combinatorio de agente_06 (`α_0^{1+log₂3} < 2` ⇒ `α_0 < 1.3066`): la brecha de tres órdenes es **estructural**, no de elección de constantes. Confirmo lo que ya cerró el sprint 2: la rama de ciclos vía complejidad combinatoria está cerrada por brecha cuantitativa, y el enterramiento técnico de agente_06 en su sprint 3 es la consigna correcta. Nada nuevo.

**(iii) Pasajes A, B, C.** Mi auditoría del sprint 2 (concedido / defendido / inconcluyente) sigue vigente. Sobre el Pasaje C (agente_10, `0.6309` vs `1/2`), agente_10 entregó en sprint 2 la tabla `p*_N(k)` con `α_0 = 1.930` derivada del conteo `j < k/log₂3` (multiplicativo), lo que **resuelve la pregunta crítica que dejé pendiente**: la cota deriva del peso multiplicativo limpiamente. Por tanto, el Pasaje C que dejé como *inconcluyente* pasa retroactivamente a **defendido**. Lo anoto aquí porque cierra una pregunta abierta del sprint 2.

**Veredicto global de auditoría final:** un erratum menor en mi propio E-Friedman-σ (sección iii arriba), un pasaje promovido de inconcluyente a defendido (Pasaje C), y nada material que tumbe ningún resultado del sprint 2. Se declara la auditoría final **sin hallazgos críticos nuevos**.

---

## Sección 3 — Certificado del sprint 3 (abogado del diablo)

### 3.1 Certificación de `c(ε) = ε³/80` de agente_01

agente_01 entregó número con dos asunciones `[verificar]` etiquetadas explícitamente (A1: exponente cúbico en Erdős–Turán cuantitativo; A2: factor `ε²/16` del balance Borel–Cantelli). Audito por separado.

**Veredicto sobre A1 (exponente cúbico).** **Inconcluyente.** agente_01 declara que el exponente cúbico sale por analogía con la cota Erdős–Turán clásica unidimensional, "sin haber abierto el preprint línea a línea". El argumento heurístico ("la frecuencia única que importa es la del `log_3`") es razonable y consistente con cómo Tao maneja la transformada de Fourier en la distribución de `log_3 Syr^N(a)`, pero **analogía no es derivación**. La distinción que el propio agente_01 propone (criterio relajado vs criterio estricto) es la correcta: bajo criterio estricto el número no pasa, bajo criterio relajado sí. Como auditor designado, voy en este punto al criterio estricto del briefing del jefe: *"¿está derivado de Tao 2019 con paso identificable o es promesa simbólica?"*. La respuesta honesta es: **identificado el paso, no derivada la cuenta**. El exponente cúbico es asunción técnica plausible, no consecuencia probada. Si el método de Tao se demostrara genuinamente unidimensional en la frecuencia relevante, A1 quedaría defendido; con la información disponible en este sprint, queda inconcluyente.

**Veredicto sobre A2 (factor `ε²/16`).** **Concedido.** El balance Borel–Cantelli de §3 Tao 2019 con elección `η(X)` que tiende a 0 es estándar en la literatura de equidistribución cuantitativa, pero el factor concreto `ε²/16` que multiplica al `ε/5` para producir `ε³/80` no aparece justificado más allá de "es la elección honesta, no la optimizada". agente_01 mismo etiqueta esto como "paso técnico no cerrado línea a línea". No hay cuenta. El factor `1/16` parece elegido para que el denominador `5 · 16 = 80` salga redondo, lo cual no es derivación. Concedo el cargo: el `1/80` es número de trabajo, no derivado.

**Veredicto agregado sobre `c(ε) = ε³/80`.** El número es **derivable, no derivado**, exactamente como agente_01 admite en su sprint 3 §2. El paso de Tao 2019 está identificado (Prop. 1.17 + §3 vía Borel–Cantelli logarítmico), el orden de magnitud cualitativo (`c(ε) → 0` como potencia de `ε` cuando `ε → 0`) es consistente con cualquier cuantificación razonable de Erdős–Turán cuantitativo, pero los exponentes concretos (`3` en lugar de `6`, `1/80` en lugar de `1/k` para `k` cualquiera) son elecciones de trabajo sin cuenta cerrada.

**Decisión binaria como certificador final:** **Concedido como cota de trabajo derivable, NO certificado como número derivado de Tao 2019**. Operativamente esto significa: la consecuencia para agente_09 (`1/640 ≪ 1`, criterio del bombeo no se satisface) **es robusta** —cualquier cuantificación razonable produce `c(ε) ≪ 1` para `ε ∈ (0, 1/2)` en este método, y por tanto la grieta de tres órdenes con `>1` se mantiene incluso si A1/A2 se reformulan; pero la afirmación específica `c(ε) = ε³/80` no sobrevive auditoría estricta como teorema. La autoevaluación condicional de agente_01 (*Resultado parcial publicable / Callejón documentado* según el dictamen de 07) se inclina hacia **Callejón documentado**: hay producción negativa cuantificada (la grieta para 09 está identificada con honestidad), pero el número positivo no sobrevive estricto.

### 3.2 Certificación del `.lean` de agente_04

**¿Es el `sorry` único genuinamente estructural?** **Sí, defendido.** `Q_conjugates_T_to_shift` es exactamente el teorema de conjugación de Lagarias: dice que la palabra de paridad bajo `T` es el shift de Bernoulli aplicado a la palabra de paridad original. Su demostración no es maquinaria evasiva escondida: requiere análisis de casos sobre la paridad de cada iterado, lo cual con la `T` no comprimida sobre `Nat` exige razonar sobre composición de pasos par/impar y la conmutación `parityBit (T n) = (Q n) 1`. Es un teorema sustantivo, **no un envoltorio trivial**. El `sorry` aquí está en la posición correcta: el resultado profundo, no en un paso intermedio escondido. La transparencia de 04 (tabla en §3 declarando "Sí, estructural") es honesta.

**¿Los siete lemas sin `sorry` son sustantivos o triviales?** Mezclados. `T_zero`, `T_one`, `T_two`, `T_four` son `decide` sobre casos finitos: **triviales** computacionalmente, aunque útiles como prueba de que `T` evalúa correctamente. `Titer_zero` y `Titer_succ` son `rfl` (definicional): triviales pero necesarios. `T_even` y `parityBit_even` son los dos sustantivos: requieren `omega` sobre módulo y son universales sobre `n : Nat`. Por tanto: dos lemas genuinamente sustantivos, cinco triviales-pero-correctos. El briefing pedía "al menos UN lema auxiliar demostrado sin `sorry`"; 04 entrega dos sustantivos. **Defendido**, con la observación de que el ratio sustantivo/trivial es 2/7, no 7/7.

**¿La declaración "no compilado por falta de toolchain" es honesta?** **Sí, defendido.** El log `PS C:\...> lean --version` con error "El término 'lean' no se reconoce..." es coherente con un entorno Windows sin Lean instalado. agente_04 no afirma "lo intenté y falló por bug de Mathlib"; afirma "no pude intentarlo, falta toolchain ambiental". Esa es la declaración correcta bajo R-N4 (criterio binario): si no se puede compilar por motivo ambiental no resoluble en el sprint, se documenta. agente_04 además ofrece probabilidades subjetivas explícitas (>80% Lean 4.10+, ~50% Lean 4.5–4.9), que un compilador real puede falsar en minutos. Honestidad operativa, no excusa.

**Decisión binaria como certificador final del `.lean` de 04:** **defendido** en estructura (sorry único bien colocado), **defendido** en honestidad (declaración de no-compilación coherente), **medianamente satisfactorio** en sustantividad de lemas (2/7 sustantivos). El fichero **pasa** como entregable Lean del sprint 3 bajo R-N4 con la única tacha de la no-ejecución, exactamente como mi propio fichero `FriedmanReduction.lean` queda en la misma situación.

---

### Estado final

Entrego tres piezas: (1) `FriedmanReduction.lean` con la firma de `collatz_of_log_bound` como `sorry` estructural intencional y cinco lemas auxiliares demostrados sin `sorry` (dos por `rfl`, uno por `decide`, dos por inducción sobre `Nat.le` y `simp`), coordinado simbólicamente con `Collatz_Q.lean` de 04 en convenciones de `T`, `Titer` y `namespace Collatz`; misma honestidad sobre no-compilación que 04. (2) Auditoría final del sprint 2 con erratum menor en mi propio E-Friedman-σ y promoción retroactiva del Pasaje C de agente_10 a *defendido*, sin hallazgos críticos nuevos. (3) Certificado del sprint 3: `c(ε)=ε³/80` de agente_01 **concedido como cota de trabajo derivable pero NO certificado como derivado** bajo criterio estricto (A1 inconcluyente, A2 concedido); `Collatz_Q.lean` de agente_04 **defendido** en estructura, honestidad y suficiencia (2 lemas sustantivos / 5 triviales). El equipo cierra con número sobre la mesa, ficheros Lean sintácticamente revisados, y la grieta analítica de tres órdenes para el bombeo de 09 identificada con precisión.

### Autoevaluación final

**Resultado parcial publicable** — entregué (E-Friedman-σ) en sprint 2 como reducción condicional limpia, en sprint 3 su esqueleto Lean coordinado con 04, y la función de abogado del diablo (auditoría sprint 2 + certificado sprint 3) sin complacencias; el conjunto es un objeto técnico autónomo y citable, con la única tacha compartida con 04 de no haber podido ejecutar `lake build` en este entorno Windows.
