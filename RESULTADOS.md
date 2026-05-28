# RESULTADOS — Experimento Collatz multi-agente (sprints 1–3)

> **Aviso de honestidad (léase antes que cualquier otra línea).**
> Este repositorio documenta una **simulación multi-agente con LLMs**: diez "agentes" interpretados por un modelo de lenguaje (Claude Opus 4.7), coordinados por un agente JEFE también simulado, atacando durante tres sprints la conjetura de Collatz. **No es un equipo real de matemáticos** y nada de lo que sigue debe leerse como tal.
>
> **No se ha demostrado nada nuevo sobre la conjetura de Collatz.** No hay teorema. No hay un avance sobre el resultado de Tao 2019. No hay un fichero Lean compilado por una toolchain.
>
> Lo que sí queda es un **sustrato técnico autónomo** —dataset, una cota numérica con prueba elemental, dos esqueletos Lean parciales con `sorry`s estructurales declarados, cinco callejones cerrados con argumento cuantificado y un cuello de botella analítico localizado—. Cada pieza es evaluable por separado, sin necesidad de creer en la narrativa global del experimento. Este documento existe para que alguien que llega frío al repositorio pueda saber rápidamente qué tomar, qué descartar y por qué.

---

## 1. Resumen ejecutivo

Tres sprints (febrero-mayo de 2026), diez agentes simulados con roles aproximados a matemáticos del estado del arte (Tao, Maynard, Lindenstrauss, Furstenberg, Oliveira e Silva, Granville-Pomerance, Friedman, Hamkins, Shallit, Allouche-Steinerberger), una sola conclusión: **el experimento no produce avance sobre Collatz, pero deja cinco entregables que sostienen notas técnicas autónomas, cinco callejones cerrados con argumento cuantificado y un cuello de botella analítico localizado en la Proposición 1.17 de Tao 2019** (arXiv:1909.03562; numeración a verificar contra el preprint).

Cuatro agentes terminaron con autoevaluación de *Resultado parcial publicable* (04, 05, 07, 10), uno más sostenible aunque condicional (02), uno con propuesta de ataque autónoma (09), y cuatro como *Callejón documentado* con epitafio técnico cuantificado (01, 03, 06, 08). El sprint 3 reclasificó al agente 01 a callejón por veredicto de auditoría interna: la `c(ε) = ε³/80` que entregó es **derivable**, no **derivada**, de Tao 2019. Esa distinción es la que separa "número de trabajo" de "teorema", y el experimento se quedó del lado equivocado de la línea, con el cuello identificado.

Lo que sigue describe cada pieza, dónde encontrarla, qué hacer con ella y qué no pretender.

---

## 2. Entregables que se pueden defender aisladamente

Cada subsección puede leerse y citarse como nota técnica independiente. Se incluyen ruta exacta, posible uso y limitaciones.

### 2.1 Dataset reproducible de `σ(n)` para órbitas de Collatz — agente_05

- **Descripción.** Cómputo determinista de `σ(n)` (función de parada de Collatz) sobre el rango `n ∈ [2, 2³⁰]` consolidado, con intento de extensión a `2³²` documentado. Estadísticos: `C_emp = 22.8347`, `max σ = 616` alcanzado en `n = 670 617 279`. Código JavaScript de menos de 230 líneas, sin dependencias externas.
- **Rutas.**
  - `C:\Users\jjnie\collatz\agente_05\compute_sigma.js` — script reproducible.
  - `C:\Users\jjnie\collatz\agente_05\sigma_data.csv` y `sigma_data_2_30.csv` — muestra estratificada.
  - `C:\Users\jjnie\collatz\agente_05\sigma_outliers.csv`, `sigma_histogram.csv`, `sigma_summary.json` (y variantes `_2_30`) — derivados auditables.
  - `C:\Users\jjnie\collatz\agente_05\run_2_32.log` — bitácora del intento de extensión.
  - `C:\Users\jjnie\collatz\agente_05\README.md` — documentación autocontenida (~1700 palabras).
- **Posible uso.** Cualquier trabajo futuro que necesite la cota empírica `σ(n) ≤ 22.835 · log₂ n` puede citar esta tabla en lugar de rederivarla. Pieza utilizable por sí sola, sin compromiso con el resto del experimento.
- **Limitaciones honestas.** Es evidencia computacional, no prueba; el dataset describe una regularidad observada en un rango finito, no un teorema. Cualquier afirmación que vaya más allá del rango computado debe declararse explícitamente como extrapolación.

### 2.2 Tabla exacta `p*_N(k)` y cota auditable `α₀ = 1.930` — agente_10

- **Descripción.** Tabla exacta con 8 filas (`N ∈ {10⁶, 10⁸}`, `k ∈ {10, 20, 30, 40}`) y cota combinatoria `α₀ = 1.930` con prueba elemental de tres líneas (Lagarias–Terras: `3^j < 2^k` necesaria, más Chernoff–Hoeffding sobre `j < k / log₂ 3`).
- **Rutas.**
  - `C:\Users\jjnie\collatz\agente_10\complexity_table.csv` — tabla.
  - `C:\Users\jjnie\collatz\agente_10\compute_complexity.ps1`, `compute_pstar_large.ps1` — scripts reproducibles en PowerShell.
  - `C:\Users\jjnie\collatz\agente_10\sprint_02.md` — derivación elemental documentada; `sprint_03.md` consolida la cita literal `H(1/log₂3) = 0.94928`.
- **Posible uso.** Quien estudie el techo de la clase Chernoff-Hoeffding sobre la condición necesaria de Lagarias-Terras encuentra aquí la cota exacta, sin hipótesis ocultas. Reusable como referencia numérica de la barrera "fácil" del problema.
- **Limitaciones honestas.** `α₀ = 1.930` es el **techo natural** de un tipo de argumento. No es un avance hacia `α₀ < 1.3066` (el umbral relevante para descartar ciclos no triviales); de hecho, es exactamente la prueba de que ese techo está muy por encima del piso requerido.

### 2.3 Enterramiento técnico cuantificado de la rama "ciclos vía complejidad combinatoria" — agente_06

- **Descripción.** Documento que articula con números la brecha entre lo que la línea combinatoria entrega (`α₀ = 1.930`, convergiendo a `2` por Hoeffding) y lo que necesitaría (`α₀ < 1.3066` de Eliahou). La razón en el espacio de candidatos a ciclos de longitud `K` es `~2.50^K`: tres órdenes de magnitud que no se cierran por refinamientos plausibles de Chernoff-Hoeffding.
- **Ruta.**
  - `C:\Users\jjnie\collatz\agente_06\sprint_03.md` — epitafio técnico final; `sprint_02.md` contiene la auditoría intermedia y el análisis sobre `K₀ ≈ 1.4·10⁹` post-Rhin.
- **Posible uso.** Quien considere atacar ciclos no triviales por esta vía puede leer aquí por qué no se entra. Sirve como aviso documentado, no como prohibición.
- **Limitaciones honestas.** Es producción negativa: cierra una rama, no abre otra.

### 2.4 Esqueleto Lean 4 con doce lemas demostrados — agentes 04 y 07

- **Descripción.** Dos ficheros coordinados (mismo `namespace Collatz`, misma `T` no comprimida, mismo `Titer`) que formalizan, en Lean 4 *core* puro sin Mathlib (decisión arquitectónica deliberada para portabilidad), la reducción de Collatz a una cota logarítmica sobre `σ`.
  - `Collatz_Q.lean`: `T`, `parityBit`, `Titer`, `Q`, `shift` + **7 lemas sin `sorry`** + **1 `sorry` estructural** explícitamente declarado en `Q_conjugates_T_to_shift` (la conjugación de Lagarias).
  - `FriedmanReduction.lean`: `stopsBy`, `sigmaLe`, `LogBoundHyp`, `CollatzConjecture` + **5 lemas sin `sorry`** (`sigmaLe_mono` sustantivo) + **1 `sorry` estructural** en `collatz_of_log_bound` (el contenido E-Friedman-σ).
  - **Total: 12 lemas demostrados sin `sorry`; 2 `sorry`s declarados estructurales; 0 `sorry`s ocultos.**
- **Rutas.**
  - `C:\Users\jjnie\collatz\agente_04\Collatz_Q.lean`
  - `C:\Users\jjnie\collatz\agente_07\FriedmanReduction.lean`
  - `C:\Users\jjnie\collatz\agente_04\sprint_03.md` y `C:\Users\jjnie\collatz\agente_07\sprint_03.md` para contexto y bitácora de la decisión "sin Mathlib".
- **Posible uso.** Punto de partida concreto para una formalización completa: cualquier persona con `elan` + Lean 4.10+ instalado puede ejecutar `lake build` y reportar. El siguiente paso natural del experimento, si se quisiera continuar, es exactamente ese.
- **Limitaciones honestas — esto es la tacha mayor del entregable.** **Los ficheros no han sido compilados.** El entorno de trabajo carecía de toolchain (`lean --version` no reconocido, log literal en ambos sprint_03). Lo que existe es "sintácticamente revisado a mano contra Lean 4 core", no "ejecutado contra un compilador". Las probabilidades subjetivas declaradas por los agentes (>80% bajo Lean 4.10+, ~50% bajo 4.5–4.9) son honestas, falsables en cinco minutos por un tester externo, pero no son certificación.

### 2.5 Postulados con interfaz consumible — agentes 02 y 09

- **Descripción.** Dos reducciones condicionales formuladas como postulados con constantes nombradas y firma explícita, pensados para que un lector externo pueda atacar cada uno como sub-problema autónomo.
  - **Postulado S2 (agente_02):** transferencia densidad-log → norma de Gowers `U²`, con constantes `C_S2`, `δ_S2 = c(ε)/2`, `A_S2`, `N₀(c,ε)`, `X₀(ε)`.
  - **Postulado P-9 (agente_09):** no-regularidad condicional del lenguaje `L_div` (prefijos divergentes), condicional a H-Tao★ y H-Bomb, con cota `p₀(ε*) ≥ exp((1/(c*−1)) · log(C₀/c_{reg,1}))`.
- **Rutas.**
  - `C:\Users\jjnie\collatz\agente_02\sprint_03.md`
  - `C:\Users\jjnie\collatz\agente_09\sprint_03.md`
- **Posible uso.** Sub-problemas autónomos. La conjetura R-9 (canal de rescate combinatorio que combinaría la cota `1.940^k` de 10 con bombeo Myhill–Nerode de 09) está formulada con suficiente detalle para que alguien la tome como ataque de un mes, no de un sprint.
- **Limitaciones honestas.** Son **postulados**, no teoremas. El experimento no demostró ninguno de los dos. Su valor está en el interfaz limpio y las dependencias explícitas, no en el contenido demostrado.

---

## 3. Callejones cerrados con argumento cuantificado

Lista honesta de líneas que se intentaron, se cerraron con argumento y **no se reabren por refinamientos plausibles**. Esta es la cara negativa del experimento: producción de información que ahorra trabajo a quien venga después.

1. **Rigidez ergódica de medidas T-invariantes (agente_03).** Cerrada en sprint 2 tras auditoría interna que detectó: acción de rango 1, soporte numerable, entropía cero trivial. La línea EKL (Einsiedler-Katok-Lindenstrauss) no aplica al objeto que aquí aparece. Cierre formal en `C:\Users\jjnie\collatz\agente_03\sprint_02.md` y nota de cierre en `sprint_03.md`.

2. **Cortes semiregulares vía cota lineal en `log` (agente_08).** Cerrada por prueba de mansedumbre logarítmica: `log` es PR-cerrado y la cota empírica `σ/log` permanece acotada hasta `10¹¹`. Cierre en `C:\Users\jjnie\collatz\agente_08\sprint_02.md`.

3. **Ciclos vía complejidad combinatoria (agentes 06 + 10).** Brecha estructural `1.930` vs `1.3066` de tres órdenes en el espacio de candidatos. Cierre cuantificado en `C:\Users\jjnie\collatz\agente_06\sprint_03.md`. **No reabierta por refinamientos plausibles del esquema Chernoff-Hoeffding**; sólo un cambio cualitativo de modelo combinatorio podría hacerlo.

4. **Mejora cuantitativa de `K₀` sobre Eliahou / Simons–de Weger 2005 (agente_06).** Barrera blanda: sin una medida de irracionalidad post-Rhin con constantes explícitas, los retornos sobre `K₀ ≈ 1.4·10⁹` son sublineales. Cierre documentado en `C:\Users\jjnie\collatz\agente_06\sprint_02.md` y `sprint_03.md`.

5. **Régimen fácil `k ≤ ½ log₂ N` de la cota Gowers (agente_02).** Trivial por Parseval + Terras, sin contenido nuevo. Cierre en `C:\Users\jjnie\collatz\agente_02\sprint_02.md`.

A esto se añade el cierre del sprint 3, formalizado por la síntesis del jefe:

6. **`c(ε) = ε³/80` como número derivado de Tao 2019 (agente_01).** Reclasificado de "resultado parcial publicable" a "callejón documentado" por veredicto de auditoría interna (`C:\Users\jjnie\collatz\agente_07\sprint_03.md`): el número es derivable, no derivado; la cuenta línea a línea contra Prop. 1.17 no se cerró en el sprint. La consecuencia operativa **sí es robusta**: cualquier cuantificación razonable del paso Erdős–Turán + Borel–Cantelli produce `c(ε) ≪ 1` en `ε ∈ (0, 1/2)`, lo que mantiene la grieta de tres órdenes con el `c(ε) > 1` que pediría el canal de 09. Cierre formal en `C:\Users\jjnie\collatz\agente_01\sprint_03.md` (§6, epitafio anticipado por el propio agente).

---

## 4. El cuello de botella analítico identificado

Donde el experimento llegó y donde se detuvo: la **efectivización de la Proposición 1.17 del preprint de Tao** ("Almost all orbits of the Collatz map attain almost bounded values", arXiv:1909.03562; numeración exacta `[verificar]` contra el preprint publicado). Esa proposición es el corazón cuantitativo del resultado de densidad logarítmica de 2019, y su efectivización —obtener constantes explícitas en lugar de cualificadores "para `N` suficientemente grande"— es lo que separa "casi todas las órbitas" de cualquier intento de promoción a "todas".

El experimento no mueve ese cuello. La comunidad matemática tampoco lo ha movido desde 2019. Lo que el experimento sí hace es **localizarlo con precisión**: el agente_01 identifica el paso Erdős–Turán cuantitativo con exponente cúbico como el punto donde la cuenta no se cierra, y el agente_09 documenta por qué la línea analítica-efectiva → no-regularidad de `L_div` queda bloqueada en consecuencia (grieta `1/640` vs `>1`, tres órdenes).

Trasladado a lenguaje útil para un lector externo: **una persona capacitada con un mes de dedicación, conocimiento operativo de Tao 2019 y acceso a una biblioteca de análisis armónico cuantitativo, podría continuar exactamente en el punto donde el experimento se detuvo.** No antes, no después. El mapa está; la fuerza analítica no la tuvimos.

---

## 5. Lo que el experimento NO es

Sé contundente con esto, porque el riesgo de malinterpretación es alto y el riesgo es asimétrico (más daño hay en exagerar que en quedarse corto):

- **No es una demostración de la conjetura de Collatz.** Ni parcial, ni condicional a hipótesis razonables, ni nada equivalente.
- **No es un avance sobre Tao 2019.** La densidad logarítmica de "casi todas" no se promueve aquí, ni se efectiviza Prop. 1.17. El cuello se localiza; no se mueve.
- **No es un fichero Lean que compile en CI.** Los `.lean` en `agente_04` y `agente_07` son esqueletos sintácticamente revisados, no ejecutados. La compilación queda como tarea explícita para un tester externo.
- **No es una colaboración entre matemáticos reales.** Son diez instancias de un LLM (Claude Opus 4.7) interpretando roles bajo coordinación de un agente JEFE también simulado. Las "autoevaluaciones" de los agentes son outputs del modelo, sometidas a auditoría interna (también del modelo) y, finalmente, al juicio del agente JEFE. No hay revisión por pares externa.
- **No es un resultado citable como "se demostró que X".** Las piezas concretas (dataset, cota numérica, esqueleto Lean) son citables como objetos técnicos; las pretensiones interpretativas no.

---

## 6. Lo que el experimento SÍ es

Con la misma contundencia:

- **Un caso de estudio sobre coordinación multi-agente con LLMs en un problema abierto.** Diez roles diferenciados, tres sprints, reglas de auditoría interna explícitas (R-N2: abogado del diablo rotativo; R-N5: epitafio técnico cuantificado como entrega aceptable). El registro de qué funcionó y qué no está completo en `C:\Users\jjnie\collatz\JEFE\sprint_01_sintesis.md`, `sprint_02_sintesis.md` y `sprint_03_sintesis.md`.
- **Un sustrato técnico utilizable.** Los cinco entregables de la §2 sostienen notas técnicas autónomas. Especialmente robustos: el dataset de `σ(n)` (utilizable hoy) y la cota `α₀ = 1.930` con prueba elemental (utilizable hoy).
- **Una demostración de que la disciplina de auditoría interna mejora la calidad del output.** El sprint 2 cerró cinco ramas con argumento cuantificado en lugar de dejarlas como "no progresé". El sprint 3 cerró una sexta (agente_01) por auditoría explícita del propio equipo (agente_07 como abogado del diablo). Sin la regla R-N5 los callejones se habrían etiquetado como "líneas no concluidas" y la información negativa se habría perdido. La disciplina explícita evitó eso.

---

## 7. Cómo navegar el repositorio

Para alguien que llega frío, este es el orden de lectura recomendado:

1. **`C:\Users\jjnie\collatz\README.md`** — Planteamiento original del experimento: composición del equipo simulado, células, ritmo, reglas no negociables. Es el documento que define el marco.
2. **`C:\Users\jjnie\collatz\RESULTADOS.md`** (este documento) — Consolidado público con la cara honesta de qué quedó.
3. **`C:\Users\jjnie\collatz\CONVERSATION.md`** — Histórico literal de la conversación entre Javier Nieto y Claude que generó el experimento. Útil si se quiere entender el contexto y la motivación.
4. **`C:\Users\jjnie\collatz\JEFE\sprint_0N_briefing.md` y `sprint_0N_sintesis.md`** (`N ∈ {1, 2, 3}`) — Visión del coordinador en cada sprint: qué se pidió, qué se entregó, cómo se reclasificó. Especialmente recomendado: `sprint_03_sintesis.md`, que contiene el juicio final del JEFE con disensos formales declarados.
5. **`C:\Users\jjnie\collatz\agente_NN\sprint_0N.md`** (`NN ∈ {01..10}`, `N ∈ {1, 2, 3}`) — Entregables individuales por agente y sprint. Lectura selectiva según lo que interese:
   - Para el dataset: empezar por `agente_05\README.md` y `agente_05\sprint_03.md`.
   - Para la cota combinatoria: `agente_10\sprint_02.md` (donde aparece la prueba elemental) y `complexity_table.csv`.
   - Para Lean: `agente_04\Collatz_Q.lean` y `agente_07\FriedmanReduction.lean`, con `sprint_03.md` de ambos como guía de lectura.
   - Para los callejones: `agente_06\sprint_03.md`, `agente_03\sprint_02.md`, `agente_08\sprint_02.md`.
   - Para el cuello analítico: `agente_01\sprint_03.md` y `agente_07\sprint_03.md` (veredicto de auditoría).

---

## 8. Cierre honesto

Tres sprints de un equipo simulado han producido: un dataset reproducible de `σ(n)` con código auditable bajo 230 líneas; una cota combinatoria elemental con prueba de tres líneas; dos esqueletos Lean parciales con doce lemas demostrados sin `sorry` y dos `sorry`s estructurales declarados en los sitios correctos; dos postulados con interfaz consumible; cinco callejones cerrados con argumento cuantificado; y un cuello de botella analítico localizado con precisión en la efectivización de Prop. 1.17 de Tao 2019. Eso es algo. No es Collatz. Tampoco es un avance sobre Tao 2019, ni un Lean ejecutado, ni un teorema. Pero el repositorio queda como pieza autónoma de archivo: alguien puede aterrizar, leer, valorar, descartar lo que sea paja —y aquí hay paja, declarada como tal— y aprovechar lo que no. La parte aprovechable se cita por ruta exacta arriba; la paja se cita también, para que nadie la confunda con producto.

— *Jefe del equipo (coordinación científica), 28 de mayo de 2026*
