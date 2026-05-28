# Sprint 3 — Síntesis final del Jefe

Tercero y último sprint. Diez agentes simulados a lo largo del experimento, ocho entregables en este cierre (03 y 08 entregan nota opcional). El sprint 3 era binario por diseño: o número, o `.lean` que compila, o epitafio. Lo que llega a la mesa es una mezcla calibrada de las tres cosas. Esta síntesis no rescata cara: la usa para certificar honestamente qué deja el experimento utilizable, qué deja registrado como callejón, y dónde queda la línea no concluida.

---

## 1. Tabla final del equipo

| Agente | Rol | Estado S3 | Entregable principal | Autoeval. final declarada | Trayectoria S1 → S2 → S3 |
|---|---|---|---|---|---|
| 01 | Tao — ANÁLISIS EFECTIVO | Activo | `c(ε)=ε³/80` anclado a Prop. 1.17, con `[verificar]` declarados | *Resultado parcial publicable* / *Callejón documentado* (condicional al veredicto de 07) | Improbable → Improbable → Callejón documentado *(corrección del jefe abajo)* |
| 02 | Maynard/Green — ANÁLISIS EFECTIVO | Activo (consolidación) | Postulado S2 con interfaz, `δ_S2 = c(ε)/2 = ε³/160`, firma consumible | *Resultado parcial publicable* (cae a *Callejón documentado* por arrastre si 07 reclasifica 01) | Improbable → Improbable → Resultado parcial publicable |
| 03 | Lindenstrauss — CICLOS | Disuelto (nota opcional) | Nota de cierre 1 página + diccionario simbólico-diofántico-medible como infraestructura | *Callejón documentado* | Improbable → Improbable → Callejón documentado |
| 04 | Furstenberg — Lean | Núcleo activo | `Collatz_Q.lean`: `T`, `parityBit`, `Titer`, `Q`, `shift` + 7 lemas sin `sorry` + 1 `sorry` estructural en `Q_conjugates_T_to_shift`; no compilado por falta de toolchain | *Resultado parcial publicable* | Improbable → Prometedor → Resultado parcial publicable |
| 05 | Oliveira e Silva — Dataset | Activo | `README.md` autocontenido + intento de extensión a `2^32`; `C_emp=22.8347` consolidada | *Resultado parcial publicable* | Improbable → Prometedor → Resultado parcial publicable |
| 06 | Granville/Pomerance — CICLOS | Activo (enterramiento) | Documento de enterramiento técnico cuantificado: 1.930 vs 1.3066, brecha estructural; epitafio sobre `K₀` post-Rhin | *Callejón documentado* | Improbable → Improbable → Callejón documentado |
| 07 | Friedman + abogado del diablo | Núcleo activo | `FriedmanReduction.lean`: `collatz_of_log_bound` con `sorry` único + 5 lemas sin `sorry` (`sigmaLe_mono` sustantivo); auditoría final S2; certificado S3 sobre 01 y 04 | *Resultado parcial publicable* | Improbable → Prometedor → Resultado parcial publicable |
| 08 | Hamkins — Lógica | Disuelto (nota opcional) | Bitácora de cierre + sugerencia (`R_max`) para README de 05; sin coautoría efectiva | *Callejón documentado* | Improbable → Callejón sin salida → Callejón documentado |
| 09 | Shallit — C5 + análisis efectivo | Activo (consolidación condicional) | Postulado P-9 con interfaz numérica explícita (escenario B: `c(ε)` de 01 no basta); conjetura R-9 (rescate vía cota `1.940^k` de 10); epitafio | *Resultado parcial publicable* | Improbable → Improbable → Resultado parcial publicable |
| 10 | Allouche/Steinerberger — C5 | Activo (consolidación numérica) | Tabla `p*_N(k)` exacta (CSV reproducible), cita literal de `α₀=1.930` con prueba elemental de tres líneas | *Resultado parcial publicable* | Improbable → Improbable → Resultado parcial publicable |

Las trayectorias muestran la mecánica del experimento: nadie subió a *Prometedor* o *Resultado parcial* sin pasar antes por una etiqueta sobria. Cuatro agentes terminan como *Resultado parcial publicable* (04, 05, 07, 10), un quinto matizado (02 condicional, 09 con suficiente material propio para sostenerse), tres como *Callejón documentado* (03, 06, 08), y uno (01) en bisagra entre los dos lados, que esta síntesis tiene que decidir.

---

## 2. Criterio binario R-N4: ¿se cumplió?

### 2.1 `c(ε)` numérico con certificación — veredicto del jefe

agente_01 entrega un número concreto, `c(ε) = ε³/80`, anclado explícitamente a Prop. 1.17 de Tao 2019 vía Erdős–Turán cuantitativo más Borel–Cantelli logarítmico. El propio agente declara dos asunciones técnicas marcadas `[verificar]` (A1: exponente cúbico en el Erdős–Turán cuantitativo subyacente; A2: factor `ε²/16` del balance Borel–Cantelli). agente_07, como abogado del diablo designado, emite veredicto explícito: *"Concedido como cota de trabajo derivable, NO certificado como número derivado de Tao 2019"*, con A1 inconcluyente y A2 concedido.

**Confirmo el veredicto de 07.** El número es derivable, no derivado. El paso de Tao está identificado pero la cuenta no está cerrada línea a línea contra el preprint. La consecuencia operativa, sin embargo, **sí es robusta**: cualquier cuantificación razonable de la pista Erdős–Turán + Borel–Cantelli produce `c(ε) ≪ 1` en `ε ∈ (0, 1/2)`; la grieta de tres órdenes con el `c(ε) > 1` que necesita 09 sobrevive aunque A1 o A2 se reformulen. Eso es producción negativa cuantificada y vale como contribución. Lo que no vale como contribución es el valor positivo `ε³/80` en sí mismo: ese no pasa auditoría estricta.

**Por tanto la cláusula (a) de R-N4 se cumple parcialmente.** Hay número sobre la mesa con paso identificado; no hay certificación. El sprint cumple la letra mínima ("aunque sea pésimo, anclado a un paso identificable") pero falla la lectura exigente.

### 2.2 `.lean` compila — ¿cuela "no compilado por falta de toolchain"?

Tanto 04 (`Collatz_Q.lean`) como 07 (`FriedmanReduction.lean`) entregan fichero, sintaxis revisada a mano contra Lean 4 *core* (decisión arquitectónica deliberada: sin Mathlib para portabilidad), un único `sorry` estructural por fichero declarado explícitamente, y lemas auxiliares sin `sorry` (siete en 04, cinco en 07). Ambos documentan literalmente el log de error: `PS C:\...> lean --version : El término 'lean' no se reconoce…`. Ambos estiman probabilidades subjetivas honestas (>80% bajo Lean 4.10+, ~50% bajo 4.5–4.9).

**Esto cuela bajo R-N4 parcialmente, no totalmente.** La regla decía: *o compila, o falla con error específico documentado*. Estrictamente, "no se puede intentar compilar porque falta toolchain ambiental" es **una tercera categoría** que la regla no contemplaba. Pero es honesta y verificable: cualquier auditor con elan instalado puede ejecutar `lake build` en cinco minutos y falsar la estimación. Y la arquitectura del fichero —Lean 4 core puro, sintaxis estándar, lemas demostrados con `decide`, `rfl`, `omega`, `simp` y `induction` sobre `Nat.le`— es exactamente la elección que maximiza la probabilidad de compilación honesta. Ningún tactic exótico, ningún import frágil.

**Veredicto del jefe sobre R-N4:** la métrica binaria estricta **no se satisface** (no hay ejecución verificada). La métrica binaria pragmática **sí se satisface al ~80%**: hay fichero, hay sorry único en el sitio correcto (la conjugación de Lagarias en 04; el contenido de E-Friedman-σ en 07), hay lemas auxiliares sustantivos (especialmente `T_even` en 04 y `sigmaLe_mono` en 07), y la declaración de no-compilación es coherente con el entorno. No es excusa: es límite real del entorno. Cualquier persona con elan instalado puede convertir esta entrega en una entrega "compila/no compila" en una tarde.

**Implicación neta:** R-N4 se cumple en el espíritu pero no en la letra dura. El experimento entrega un esqueleto Lean parcial que **necesita un tester externo para promoverse de "sintácticamente revisado" a "compila genuinamente"**. Esta es la tacha real del sprint 3, y la registro explícitamente porque el `RESULTADOS.md` futuro tendrá que mencionarla.

---

## 3. Lo que sobrevive como producto del experimento

Lista honesta de entregables que pueden sostenerse como contribuciones aisladas, sin depender narrativamente del resto del experimento.

1. **Dataset `σ(n)` reproducible — agente_05.** `compute_sigma.js` determinista (<230 líneas, cero dependencias npm) + `sigma_data.csv` (muestra estratificada), `sigma_outliers.csv` (top-1000), `sigma_histogram.csv`, `sigma_summary.json` + README autocontenido de ~1700 palabras. Rango `n ≤ 2^30` consolidado (`C_emp = 22.8347`, `max σ = 616` en `n=670 617 279`); extensión a `2^32` intentada (predicción: `C_emp` se mueve sólo en quintos decimales). Este entregable **se publica solo**: una nota técnica computacional autosuficiente, citable por cualquier intento futuro que necesite la cota empírica `σ(n) ≤ 22.835·log₂ n`.

2. **Tabla exacta `p*_N(k)` — agente_10.** `complexity_table.csv` con 8 filas exactas (`N ∈ {10⁶, 10⁸}`, `k ∈ {10, 20, 30, 40}`), reproducible con un solo comando PowerShell. Documenta empíricamente `ρ_k = p*_N(k)/min(N, 2^k) → 1` exponencialmente.

3. **Cota auditable `α₀ = 1.930` con prueba elemental — agente_10.** Tres líneas: Lagarias–Terras (`3^j < 2^k` necesaria) + Chernoff–Hoeffding (`Σ_{j≤θk} C(k,j) ≤ 2^{H(θ)k}√k` con `θ = 1/log₂3 = 0.6309`, `H(θ) = 0.94928`). Sin hipótesis no demostradas. Es el techo natural de la clase Chernoff sobre la condición necesaria.

4. **Enterramiento técnico de la rama "ciclos vía complejidad combinatoria" — agente_06.** Documento que articula con números la brecha cuantitativa entre lo entregado (`α₀ = 1.930`, convergiendo a 2 por Hoeffding) y lo requerido (`α₀ < 1.3066`). La razón en el espacio de candidatos a longitud `K` es `~2.50^K`. Cierre formal sin ambigüedad: la rama no se cierra por refinamientos plausibles de Chernoff-Hoeffding, sólo por cambio cualitativo de modelo. Se publica como nota técnica negativa autónoma.

5. **Esqueleto Lean parcial con lemas no triviales — agente_04 + agente_07.** Dos ficheros coordinados (`namespace Collatz`, misma `T` no comprimida, mismo `Titer`): `Collatz_Q.lean` (T, parityBit, Q, shift + 7 lemas + 1 sorry estructural en `Q_conjugates_T_to_shift`); `FriedmanReduction.lean` (stopsBy, sigmaLe, LogBoundHyp, CollatzConjecture + 5 lemas + 1 sorry estructural en `collatz_of_log_bound`). 12 lemas totales sin `sorry`, 2 `sorry` declarados, 0 sorry ocultos. **Sobrevive con la tacha registrada en §2.2**: pendiente de ejecución `lake build` externa.

6. **Reducciones condicionales como postulados con interfaz — agente_02, agente_09.** Postulado S2 (transferencia densidad-log → norma `U²`) con constantes nombradas (`C_S2`, `δ_S2 = c(ε)/2`, `A_S2`, `N₀(c,ε)`, `X₀(ε)`) y firma consumible para 09 y lectores externos. Postulado P-9 (no-regularidad de `L_div` condicional a H-Tao★ y H-Bomb) con cota explícita `p₀(ε*) ≥ exp((1/(c*−1))·log(C₀/c_{reg,1}))`. Ambos sobreviven al diagnóstico de que la línea analítica no cerró: dejan la grieta localizada como problema autónomo cerrable por otro.

7. **Conjetura R-9 — agente_09 + agente_10.** Canal de rescate combinatorio (no demostrado) que combinaría la cota `1.940^k` sobre prefijos divergentes de 10 con el bombeo Myhill–Nerode de 09 para cerrar la no-regularidad de `L_div` *sin* requerir `c(ε) > 1`. agente_09 lo formula explícitamente como sub-problema de mes, no de sprint, y lo recomienda como ataque prioritario sobre `c(ε) > 1`.

8. **Cinco callejones cerrados con argumento cuantificado** (heredados del sprint 2, consolidados en el 3):
   - Rigidez de medidas EKL (03): acción rango 1, soporte numerable, entropía cero trivial.
   - Cortes semiregulares vía cota lineal en `log` (08): `log` es PR-cerrado, blindaje empírico de `σ/log` acotado hasta `10^{11}`.
   - Ciclos vía complejidad combinatoria (06 + 10): brecha 1.930 vs 1.3066 estructural.
   - Régimen fácil `k ≤ (1/2)log₂N` de la cota `β₂` (02): trivial por Parseval + Terras.
   - Mejora de `K₀` sólo subiendo `B` post-Eliahou (06): barrera blanda; sin medida de irracionalidad post-Rhin con constantes, retornos sublineales.

Lo que NO sostiene una nota técnica autónoma: el `c(ε)=ε³/80` de 01 como número positivo (sí como cota de trabajo, no como derivado), el postulado-con-interfaz S2 si A1 cae duro en una auditoría más estricta (la estructura sobrevive, el valor numérico no), la conjetura R-9 como teorema (es propuesta de ataque, no resultado).

---

## 4. Lo que NO se logró

Sin edulcorar:

- **`c(ε)` certificable como derivado de Tao 2019.** 07 lo concedió como cota de trabajo, no como derivado de Prop. 1.17. La cuenta línea a línea contra el preprint no se hizo en este sprint y no era hacible por una persona en una sesión.
- **Compilación Lean genuina.** El entorno carece de `lean`/`lake`/`elan`. No es excusa cómoda; es límite real. Pero la consecuencia es que el `.lean` se entrega "sintácticamente revisado", no "ejecutado". El compromiso binario R-N4 cae a "métrica pragmática 80%".
- **Cierre teórico de cualquier rama central de Collatz.** Ninguna de las tres tuberías del experimento (ANÁLISIS EFECTIVO, COMPUTACIONAL-LÓGICA, CICLOS) entrega teorema positivo sobre la conjetura.
- **Cualquier avance sobre Tao 2019.** La efectivización de Prop. 1.17 sigue exactamente donde la dejó la comunidad en 2019. agente_01 lo declara explícitamente: "trabajo de un mes para una persona capacitada, que ningún sprint en solitario absorbe". No movimos el cuello.
- **Cierre del paso H-Bomb de agente_09** (combinatoria binaria estándar, ligero pero no ejecutado). Necesario para la conjetura R-9.
- **Localización de medida de irracionalidad post-Rhin con constantes explícitas** (agente_06). Sin ella, `K₀ ≈ 1.4·10⁹` no es novedoso respecto a Simons–de Weger 2005.

---

## 5. Veredicto sobre la auditoría de agente_07 (capa final)

agente_07 emite: **A1 inconcluyente, A2 concedido, agregado: "Concedido como cota de trabajo derivable, NO certificado como número derivado de Tao 2019"**.

**Estoy de acuerdo, sin matices.** Repaso brevemente:

- A1 (exponente cúbico en Erdős–Turán cuantitativo): la analogía unidimensional de 01 es plausible pero no es derivación. La distinción "analogía no es derivación" es la correcta. 07 hace bien en marcar inconcluyente.
- A2 (factor `ε²/16` del balance Borel–Cantelli): el factor `1/16` parece elegido para que el denominador salga 80, lo cual no es derivación. 01 mismo lo declara como "elección honesta, no la optimizada". Concedo el cargo igual que 07.
- Veredicto agregado: el número es derivable, no derivado. La consecuencia operativa para 09 (`1/640 ≪ 1`, grieta de tres órdenes con `>1`) **es robusta** porque sobrevive a cualquier cuantificación razonable; lo que no sobrevive es la afirmación específica `c(ε) = ε³/80` como teorema.

**Implicación para la etiqueta final de agente_01.** Bajo criterio estricto, 01 cae a **Callejón documentado**: produjo argumento cuantificado de por qué la línea se cierra (exponente cúbico mínimo en Erdős–Turán → `c(ε) ≪ 1` → criterio de 09 no se satisface por tres órdenes → cadena ANÁLISIS EFECTIVO bloqueada en el método de Tao). El propio 01 anticipa este desenlace en su §6 (epitafio técnico): *"Si 07 reclasifica este sprint como epitafio, mi etiqueta cae a Callejón documentado"*. **Yo formalizo esta reclasificación.** La autoevaluación condicional "Resultado parcial publicable / Callejón documentado" se resuelve a *Callejón documentado* con honestidad operativa.

Esto **no es derrota** y 01 lo escribió con la calibración correcta: hay producción negativa cuantificada (la grieta para 09 está identificada con precisión, y el cuello de botella analítico está localizado en Prop. 1.17 con paso identificable), pero el valor positivo no sobrevive. Es exactamente lo que sprint 2 dejó como apuesta binaria: o `c(ε)` numérico certificado, o cierre del callejón con argumento. Salió la segunda.

---

## 6. Disolución del equipo

El experimento se cierra aquí. Tres sprints, diez agentes simulados, sin sprint 4. La clasificación final, **con mi juicio del jefe donde discrepa de la autoevaluación del agente**, es:

### Resultado parcial publicable (cinco)
- **agente_04** — concuerdo. Esqueleto `Collatz_Q.lean` con un único `sorry` declarado estructural y siete lemas demostrados es objeto técnico autónomo. Tacha: ejecución `lake build` pendiente.
- **agente_05** — concuerdo. Dataset reproducible + README autocontenido. La nota técnica computacional más limpia del experimento.
- **agente_07** — concuerdo. Esqueleto `FriedmanReduction.lean` con `sigmaLe_mono` sustantivo + auditoría sprint 2 + certificado sprint 3 emitido sin complacencias. Tacha compartida con 04.
- **agente_10** — concuerdo. Tabla exacta + cota auditable `α₀=1.930` con prueba elemental de tres líneas, ambas reusables.
- **agente_02** — concuerdo, *con la matización condicional que él mismo declara*: si A1 de 01 fallara en auditoría más estricta (no la que hizo 07), su etiqueta cae a *Callejón documentado* por arrastre. En la auditoría de 07 que aquí ratifico, A1 queda *inconcluyente* —no caído duro—, y el postulado S2 sobrevive como objeto estructural independiente del exponente concreto. Por tanto mantengo *Resultado parcial publicable*.
- **agente_09** — concuerdo con matiz. Postulado P-9 + conjetura R-9 sostienen una nota técnica autónoma sobre el estado de la cadena ANÁLISIS EFECTIVO ↔ teoría de lenguajes. El matiz: la conjetura R-9 es propuesta, no resultado; la etiqueta se justifica por P-9 + epitafio + diagnóstico cuantificado, no por R-9 sola.

### Callejón documentado (cuatro)
- **agente_01** — **discrepo con la autoevaluación dual del agente y formalizo *Callejón documentado*** por las razones de §5. El propio agente lo anticipa como desenlace con probabilidad ~60% en su §5; lo formalizo aquí. Valor científico negativo: cuello de botella analítico localizado con precisión.
- **agente_03** — concuerdo. Concesión sobre EKL en sprint 2; nota de cierre del sprint 3 honesta. El diccionario simbólico-diofántico-medible es infraestructura útil pero no autónoma.
- **agente_06** — concuerdo. La sub-célula CICLOS produjo argumento cuantificado de cierre, no teorema positivo. El enterramiento es la contribución; está bien escrito.
- **agente_08** — concuerdo. Disuelto en sprint 2, nota de cierre limpia. Sin contribución efectiva al README de 05 (ofrecida, no materializada).

### Línea no concluida (ninguno)
**Ningún agente termina con esta etiqueta.** Es resultado del diseño: todas las líneas que iban hacia *Línea no concluida* en una lectura blanda se reconvirtieron en *Callejón documentado* gracias a la regla R-N5 (epitafio técnico cuantificado). Eso es trabajo del experimento, no casualidad. La consigna explícita del sprint 2 —*una línea cerrada con argumento vale tanto como una entrega positiva*— fue lo que permitió que 01 entregara epitafio anclado a Prop. 1.17 en vez de quedarse con "no llegué". Producción negativa cuantificada en todos los frentes.

### Disensos formales del jefe
Solo uno material: la reclasificación de **01 de "Resultado parcial publicable condicional" a "Callejón documentado"** en base al veredicto de 07. El propio 01 lo había anticipado como posibilidad explícita. Es la única corrección que esta síntesis introduce sobre las autoevaluaciones de los agentes.

---

## 7. Honestidad final del jefe

Tres sprints. Diez agentes simulados. No demostramos nada nuevo sobre la conjetura de Collatz y eso quedó claro desde el sprint 2. Lo que sí dejamos es lo que un experimento honesto puede dejar cuando renuncia a la pretensión de avanzar el corazón del problema: un dataset reproducible de 10⁹⁺ enteros con código auditable bajo 230 líneas; un esqueleto Lean parcial con doce lemas no triviales y dos `sorry` declarados estructurales en los sitios correctos (la conjugación de Lagarias y el contenido de E-Friedman-σ); una cota combinatoria auditable elemental, `α₀ = 1.930`, con prueba de tres líneas que ningún lector futuro tendrá que rederivar; un enterramiento técnico cuantificado de una rama entera por brecha de tres órdenes; dos reducciones condicionales formuladas como postulados con interfaz limpia y dependencias explícitas en constantes nombradas; cinco callejones cerrados con argumento cuantificado y no por desánimo; y un cuello de botella analítico identificado con precisión en Prop. 1.17 de Tao 2019, exactamente donde lleva atascada la comunidad desde 2019. El experimento no entrega *núcleo de resultados consolidados* en el sentido fuerte —no hay teorema nuevo sobre Collatz, ni un `.lean` ejecutado contra `lake build`, ni un `c(ε)` certificado—; entrega un **intento honesto que cierra con epitafio técnico utilizable**: ciencia de bajo brillo, reproducible, citable pieza a pieza, con el mapa de qué se intentó y por qué cada cosa se cerró. Lo útil para el repo: cinco entregables que sostienen notas técnicas autónomas, doce lemas Lean revisados sintácticamente (pendientes de un tester externo de 30 minutos), y la documentación del cuello donde una persona capacitada con un mes de dedicación podría continuar (efectivización de Prop. 1.17 vía Erdős–Turán cuantitativo, o cierre combinatorio del paso H-Bomb hacia la conjetura R-9). Lo que no debería pretenderse que sea: una contribución a la conjetura, una formalización Lean completa, una efectivización de Tao 2019, o un argumento de cierre para ciclos no triviales. El experimento simulado fue eso: una simulación coordinada de cómo una decena de roles aproximados al estado del arte podrían atacar el problema en tres sprints. El resultado es exactamente lo que cabía esperar de esa simulación: plomería excelente, motor en punto muerto, callejones bien cerrados, y un epitafio que respeta al lector externo.

— *Jefe del equipo (coordinación científica), 28 de mayo de 2026*
