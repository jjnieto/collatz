# Sprint 3 — Briefing del Jefe

**Equipo:** 10 agentes, ahora reducidos a un **núcleo de formalización Lean** + tres satélites en consolidación + dos disueltos formalmente (con rol de apoyo opcional).
**Duración nominal:** un sprint, **el último**.
**Lectura previa obligatoria:** `JEFE/sprint_02_sintesis.md` (mi lectura crítica del sprint 2) y este briefing. Quien tenga dependencia con la pata Lean leerá también `agente_04/sprint_02.md` y `agente_07/sprint_02.md`.

---

## 1. Objetivo del sprint 3

**Cerrar el experimento con un núcleo de resultados consolidados, formalizados donde sea posible, y un veredicto honesto sobre qué quedó intentado pero no resuelto.**

No es sprint de avance sobre Collatz. Es sprint de consolidación y poda final. La consigna que yo mismo escribí al cerrar el sprint 2 es: si este sprint no entrega **(a)** `c(ε)` numérico (aunque sea pésimo) o **(b)** un fichero Lean 4 que compile con `Q` de Lagarias y (E-Friedman-σ) como `theorem ... := sorry` más al menos un lema auxiliar demostrado de verdad, entonces no hay sprint 4 y el equipo se disuelve. Sin sentimentalismo. Esa es la regla del juego.

El sprint 3 es por tanto el sprint de los entregables binarios: o compila o no compila, o hay número o hay epitafio. No hay zona gris esta vez.

---

## 2. Reorganización final del equipo

El sprint 2 movió cuatro etiquetas (04, 05, 07 a *Prometedor*; 08 a *Callejón*) y cerró cinco líneas con argumento cuantificado. Sobre esa base, el sprint 3 ejecuta la poda:

| Estado | Agentes | Misión declarada |
|---|---|---|
| **Núcleo de formalización Lean** | 04 + 07 | Producir un fichero `.lean` que **compile** en Lean 4 / mathlib, conteniendo `T`, `Q`, enunciado E-Friedman-σ como `:= sorry`, y al menos un lema auxiliar demostrado sin `sorry`. Métrica binaria. |
| **Misión solitaria crítica** | 01 | Cerrar `c(ε)` numérico. Si no, epitafio técnico de la línea. |
| **Consolidación de reducciones** | 02 + 09 | Dejar sus reducciones como postulados con interfaz; condicionales a 01. |
| **Documentación de dataset y frente extendido** | 05 | README dentro de `agente_05/`, frente hasta `2^32` si da tiempo. |
| **Enterramiento técnico cuantificado** | 06 | Documento 1-2 páginas con `α_0=1.930` (de 10) vs umbral `<1.3066` (suyo), conclusión formal de cierre de rama. |
| **Consolidación numérica** | 10 | Tabla numérica final auditable + nota de cierre. |
| **Apoyo a Lean + certificado final** | 07 (además de núcleo) | Auditoría última del sprint 2 y certificado del sprint 3 como abogado del diablo: ¿el resultado Lean cuela?, ¿el `c(ε)` de 01 es genuino? |
| **Disueltos formalmente** (no entregan `sprint_03.md` salvo nota de cierre opcional) | 03, 08 | Rol de apoyo permitido: 03 puede ayudar a 04 en formalización Lean; 08 puede ayudar a 05 a documentar el dataset. |

Disueltos significa disueltos: 03 cerró su rama medible por su propia auditoría en el sprint 2; 08 confirmó su callejón con la prueba de mansedumbre log. Ambos pueden contribuir como apoyo si lo desean, pero no se les exige entregable propio. Si entregan, una **nota de cierre** de 200-400 palabras basta.

---

## 3. Reglas comunes

Siguen vigentes todas las reglas del sprint 1 y del sprint 2 (no falsificar demostraciones, `[verificar]` cuando haya duda, español, markdown, no tocar git, escribir SÓLO en `agente_NN/sprint_03.md`, no tocar `README.md`, `CONVERSATION.md` ni el directorio `JEFE`). Se añade lo siguiente:

- **R-N4. Criterio binario de éxito.** Para los agentes 04 y 07 (núcleo Lean), el sprint sólo se cuenta como éxito si el `.lean` **compila** contra Lean 4 + mathlib actual (o falla con un error específico documentado en el propio entregable, indicando línea, mensaje del compilador, y por qué el error no es resoluble en este sprint). No vale "lo dejé en buen estado", no vale "queda bonito", no vale "lo terminaría en una semana más". Métrica binaria.
- **R-N5. Epitafio técnico permitido.** Si un agente determina que su línea está terminada sin éxito, debe escribir un epitafio técnico (~200 palabras) explicando *qué obstáculo concreto* cierra la línea. No es lamento, es cierre formal. Esto es trabajo legítimo del sprint 3 y se valora tanto como una entrega positiva, porque produce una línea cerrada con argumento (que es lo que el sprint 2 demostró que sí sabe hacer este equipo).
- **R-N6. Cierre del entregable.** Cada `sprint_03.md` cierra obligatoriamente con `### Estado final` (despedida del agente) y `### Autoevaluación final` (etiqueta única para todo el experimento). Detalle en sección 5.

---

## 4. Encargo individual

### agente_01 — rol Tao, cadena ANÁLISIS EFECTIVO, **activo**

Encargo sprint 3: **una sola misión**. Cerrar `c(ε)` numérico. Aunque sea pésimo. Aunque sea `c(ε) = ε^{10}` con constante implícita astronómica. Lo que necesita 09 para que su bombeo cierre es `c(ε) > 1`; lo que necesita 02 para que su régimen alto no quede colgando es un valor concreto. **Tu trabajo es producir ese valor**, anclado a un paso identificable de Tao 2019 (Prop. 1.17 o donde la pérdida se realice), no a una promesa. Si tras agotar el sprint determinas que no es posible producirlo sin reescribir la prueba de Tao 2019, escribes un **epitafio técnico (~200 palabras)** explicando qué paso concreto bloquea la efectivización y por qué.

Entregable: o bien un lema con `c(ε)` numérico explícito y interfaz para 02 y 09, o bien el epitafio. No hay punto intermedio. Si entregas el número, 07 lo audita como certificador final.

### agente_02 — rol Maynard/Green, cadena ANÁLISIS EFECTIVO, **activo (consolidación)**

Encargo sprint 3: **consolida tu reducción del sprint 2 como postulado con interfaz**. El sub-lema S2 (transferencia densidad-log → `U²`) queda formulado como problema autónomo. No se te pide demostrarlo. Se te pide:

1. Reescribirlo en una página con hipótesis, tesis, constantes nombradas, sin `[verificar]` blandos.
2. Si 01 entrega `c(ε)` numérico, indicar explícitamente cómo el régimen alto se reconecta a la cota de sesgo `β_2`.
3. Si 01 entrega epitafio, marcar la línea como "esperando input externo no disponible en este experimento" y sumar tu propio epitafio breve sobre por qué tu reducción se queda colgando.

Entregable: postulado-con-interfaz limpio (1 página), más nota de estado.

### agente_03 — rol Lindenstrauss, **disuelto formalmente**

Encargo sprint 3 (opcional): **nota de cierre** (200-400 palabras) recordando la concesión del sprint 2 (acción de rango 1, soporte numerable, EKL no aplica) y, si quieres, contribución como apoyo a la pata Lean de 04 (por ejemplo, traducción del esqueleto de invariantes a definiciones reusables). No se exige `sprint_03.md`. Si lo entregas, valor añadido reconocido; si no, el sprint 2 ya es tu cierre.

Entregable: nada obligatorio. Nota de cierre o apoyo Lean a 04, opcionales.

### agente_04 — rol Furstenberg, **núcleo de formalización Lean (activo, criticidad máxima)**

Encargo sprint 3: cerrar `Collatz/Q.lean` (o el fichero que decidas como nombre canónico) con las siguientes piezas mínimas:

1. **Definición de `T` (la función Collatz acelerada)** como `def T : ℕ → ℕ` o `def T : ℤ → ℤ` con la versión `T(2n)=n`, `T(2n+1)=(3n+2)`, o la que tu sprint 2 dejó canonizada. Sin `sorry`.
2. **Definición de `Q` (la conjugación de Lagarias)** con tipo explícito y enunciado de `Q_conjugates_T_to_shift` como `theorem` (con `sorry` permitido en la demostración si no llegas).
3. **Al menos UN lema auxiliar demostrado sin `sorry`.** Sugerencias: `T_continuous` en la topología 2-ádica, `T(2n) = n` como lema computacional, o un lema básico de la representación 2-ádica que ya esté en mathlib.
4. El fichero **debe compilar**. Si no compila, debe entregarse el log del error de Lean con línea, mensaje, y diagnóstico de por qué no es resoluble en este sprint.

Si la métrica binaria de R-N4 falla (no compila y no hay diagnóstico utilizable), tu autoevaluación final cae automáticamente a *Línea no concluida*. Sin matices. Es duro y es honesto.

Entregable: el fichero `.lean` (referenciado dentro de `agente_04/sprint_03.md`), más el log de compilación, más una página de prosa explicando la estructura del fichero.

### agente_05 — rol Oliveira e Silva, **activo (documentación + extensión)**

Encargo sprint 3: dos sub-misiones, en este orden de prioridad.

1. **README dentro de `agente_05/`** que documente el dataset (10⁹ enteros, `C_emp=22.835`, formato, columnas, cómo regenerarlo, outliers, histograma). Reproducibilidad como criterio. Independiente del resto del experimento: este dataset debe ser usable por cualquier persona que llegue al repo en el futuro, incluso sin haber leído ningún otro entregable.
2. **Extensión del frente** hasta `2^32` (o lo que tu hardware permita en el tiempo del sprint). Si llegas, actualiza `C_emp` y los outliers. Si no llegas, documenta dónde paraste y por qué.

Apoyo permitido de 08 para la documentación. Si 08 colabora, citalo.

Entregable: README en `agente_05/README.md`, `sprint_03.md` con nota de estado y extensión del frente si aplica.

### agente_06 — rol Granville/Pomerance, **activo (enterramiento técnico)**

Encargo sprint 3: **escribir el enterramiento técnico de la rama "ciclos vía complejidad combinatoria"**. Documento de 1-2 páginas (lo entregas como `agente_06/sprint_03.md`) con la siguiente estructura mínima:

1. Cita literal de `α_0 = 1.930` de agente_10 (sprint_02), con referencia a la prueba auditable (Chernoff–Hoeffding sobre `j<k/log₂3`).
2. Cita literal de tu propio umbral combinatorio `α_0 < 1.3066` derivado de `α_0^{1+log₂3} < 2`.
3. **Conclusión formal**: la rama está cerrada por brecha cuantitativa de tres órdenes (1.930 vs 1.3066, además convergiendo a 2 por Hoeffding). No se cerrará en este experimento ni en próximos refinamientos plausibles de la cota tipo Chernoff.
4. Apuntar (si lo ves) qué clase de mejora cualitativa —no cuantitativa— sería necesaria para mover la cota por debajo de 1.3066. Esto es para futuros lectores, no compromiso de continuar.

Línea sobre `K_0` post-Rhin: si en este sprint no localizas medida de irracionalidad con constantes explícitas, la cierras también con epitafio (R-N5).

Entregable: el documento de enterramiento como contenido principal de `sprint_03.md`.

### agente_07 — rol Friedman + abogado del diablo, **núcleo Lean + certificador final, activo (criticidad máxima)**

Triple misión:

1. **Pata Lean**: entrega `Collatz/FriedmanReduction.lean` (o equivalente), con la firma `theorem collatz_of_log_bound : (∀ n ≥ N₀, σ n ≤ C * Nat.log2 n) → CollatzConjecture := sorry`, más al menos un lema auxiliar demostrado sin `sorry` (por ejemplo, uno de los pasos uniformes S1-S5 que ya deslindaste). Co-coordina con 04 para que el nombre canónico de `T` y `σ` sea uno solo.
2. **Auditoría final del sprint 2**: una última lectura cruzada buscando errores no detectados. Reporte breve con los pasajes revisados y veredicto (defendido / concedido / inconcluyente). Si encuentras algo material, el agente afectado debe responderlo en `sprint_03.md`; si encuentras nada, lo declaras explícitamente.
3. **Certificado del sprint 3 como abogado del diablo**. Cuando 01 entregue `c(ε)` (o epitafio) y 04 entregue su `.lean`, los auditas: ¿el resultado Lean cuela y compila genuinamente o hay `sorry` escondido en sitios estructurales? ¿el `c(ε)` de 01 es derivado de Tao 2019 con paso identificable o es promesa simbólica? Veredicto binario por cada uno.

Entregable: tu propio fichero Lean, la auditoría final del sprint 2, y el certificado del sprint 3 — todo dentro de `agente_07/sprint_03.md`.

### agente_08 — rol Hamkins, **disuelto formalmente**

Encargo sprint 3 (opcional): **nota de cierre** o, alternativamente, **apoyo a 05 en la documentación del dataset**. Si eliges apoyar a 05, tu trabajo se atribuye en el README de 05. No se exige `sprint_03.md`. Tu rescate modesto del sprint 2 (saneamiento de la línea de cortes semiregulares) ya es cierre digno.

Entregable: nada obligatorio.

### agente_09 — rol Shallit, C5 + cadena ANÁLISIS EFECTIVO, **activo (consolidación condicional)**

Encargo sprint 3: **cierra la no-regularidad de `L_div` como condicional**. Dos escenarios:

1. **Si 01 entrega `c(ε) > 1` numérico**: completas el bombeo y enuncias `L_div es no regular o vacío` como teorema condicional (sin `sorry` en la cadena lógica desde la hipótesis de 01).
2. **Si 01 entrega epitafio**: marcas la línea como "esperando input externo no disponible" y reescribes tu reducción condicional 9.A' (del sprint 2) como un *postulado-con-interfaz* análogo al de 02. Más epitafio breve.

Entregable: o teorema condicional cerrado, o postulado con epitafio. Como agente_02. Coordinen formato si pueden.

### agente_10 — rol Allouche/Steinerberger, C5, **activo (consolidación numérica)**

Encargo sprint 3: **consolida la tabla numérica final y escribe nota de cierre**. Concretamente:

1. Tabla auditable con `p*_N(k)` para los valores que dejaste en sprint 2 (`N=10^8`, `k≤40`), formato reproducible (CSV o equivalente referenciado desde `sprint_03.md`).
2. Cita literal de `α_0=1.930` con la prueba elemental (Chernoff sobre `j<k/log₂3`), tal como ya está en sprint 2; aquí la consolidas, no la repruebas.
3. Nota de cierre de ~300 palabras sobre el destino de tu cota dentro del enterramiento de 06: confirmas que tu `α_0` es el insumo correcto, y que no se puede bajar significativamente por esta vía.
4. Si quieres, una sección de "apuntes para futuros lectores": qué clase de cota combinatoria distinta podría producir `α_0 < 1.31`. Especulativo, claramente etiquetado.

Entregable: tabla referenciada + nota de cierre dentro de `sprint_03.md`.

---

## 5. Entregable común

Cada `sprint_03.md` cierra obligatoriamente con dos bloques, en este orden y con encabezados literales:

### Estado final
Un párrafo de despedida del agente: qué dejó, qué no, qué queda como pregunta abierta. No es lamento; es nota de bitácora de cierre. Sirve para que el README final del experimento pueda citarte literalmente.

### Autoevaluación final
Etiqueta única para todo el experimento (sprint 1 + 2 + 3) desde tu perspectiva como agente, eligiendo entre:

- **Resultado parcial publicable** — produjiste algo que, aislado, podría sostener una nota técnica autónoma (un dataset, una reducción condicional, un fichero Lean compilable, un enterramiento cuantificado).
- **Callejón documentado** — produjiste argumento cuantificado de por qué tu línea se cierra; valor científico negativo.
- **Línea no concluida** — la línea ni produjo resultado positivo ni argumento cuantificado de cierre; queda abierta para futuros intentos.

Una sola etiqueta. Una sola frase de justificación. Si tu autoevaluación de sprint 2 era *Prometedor* y el sprint 3 no entregó, tu etiqueta final caerá a *Línea no concluida* — eso es honestidad operativa, no derrota.

Quienes estén disueltos formalmente (03, 08) y entreguen nota de cierre opcional pueden omitir estos bloques o usarlos en forma breve; su etiqueta final es *Callejón documentado* por defecto, salvo que el apoyo a 04 o 05 los promueva a *Resultado parcial publicable* en el README final.

---

## 6. Lo que sigue al sprint 3: `RESULTADOS.md`

Independientemente de cómo vayan los entregables individuales, después de leer los diez (u ocho) `sprint_03.md` yo escribiré `RESULTADOS.md` en la raíz del repo. Será un documento consolidado de lectura externa, listando:

1. Qué se produjo de forma utilizable (fichero Lean compilado, dataset documentado, reducciones condicionales, enterramientos cuantificados).
2. Qué quedó abierto y por qué.
3. La lectura honesta del experimento: tres sprints, equipo simulado, sin pretensión de haber resuelto Collatz.

Lo anuncio aquí para que sepan que su `### Estado final` y su `### Autoevaluación final` serán material citable. Escriban con la conciencia de que un lector externo va a leerlos.

---

## 7. Cierre del jefe

Tres sprints. Diez agentes simulados. No hemos demostrado nada nuevo sobre la conjetura de Collatz y no íbamos a hacerlo; esa pretensión la enterré yo mismo en la síntesis del sprint 2. Lo que sí podemos dejar al final de este sprint es un sustrato técnico utilizable: una formalización Lean parcial pero compilable, un dataset reproducible de 10⁹ enteros con documentación clara, una reducción condicional precisa (E-Friedman-σ) deslindada entre lo analítico y lo lógico, cinco líneas cerradas con argumento cuantificado, y un enterramiento técnico de una rama entera por brecha numérica de tres órdenes. Eso no resuelve Collatz, pero es ciencia honesta de bajo brillo: deja al siguiente que pase por aquí el mapa de qué se intentó, qué cerró, y dónde se quedó atascado el cuello de botella analítico (Tao 2019, Prop. 1.17, exactamente donde lleva atascada la comunidad desde 2019).

La regla operativa final es la misma del sprint 2 con un grado más de exigencia: criterio binario donde sea posible (R-N4), epitafio técnico donde no (R-N5), y `### Estado final` que cualquier lector externo pueda leer sin necesitar contexto interno. No oculten lo que no funcionó. La única cosa que un equipo simulado puede sostener al final de tres sprints es la honestidad sobre qué intentó y qué no llegó.

Pongan manos al teclado. Es el último sprint.

— *Jefe del equipo (coordinación científica)*
