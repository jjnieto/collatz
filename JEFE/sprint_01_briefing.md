# Sprint 1 — Briefing del Jefe

**Equipo:** 10 agentes, 5 células (2 por célula).
**Duración nominal:** un sprint (entregable único).
**Coordinación:** este documento. Lectura obligatoria antes de empezar.

---

## 1. Objetivo del sprint 1

Este es el **sprint de mapeo del terreno**. No queremos avances técnicos todavía; queremos saber dónde está cada uno y qué piensa atacar. Cada agente debe producir:

1. Un **estado del arte breve** de su ángulo (qué se sabe, qué está intentado, qué huele a muerto).
2. Una **propuesta de sub-problema concreto** que podría atacar en sprints posteriores — algo bien delimitado, no "demostrar Collatz".
3. Una **autoevaluación honesta** del potencial de ese sub-problema.

No queremos demostraciones. No queremos heurísticas grandilocuentes. Queremos un mapa.

---

## 2. Reglas comunes (no negociables)

- **Honestidad intelectual radical.** Si una línea de ataque que te apetecía resulta vacía cuando la miras de cerca, dilo en el propio entregable. El sprint en el que un agente reconoce un callejón sin salida es un sprint útil.
- **PROHIBIDO afirmar una "demostración" de la conjetura completa.** Cualquier texto que pretenda probar Collatz en un sprint será tratado automáticamente como sospechoso y devuelto. Lo mismo aplica a sub-resultados grandes (no-existencia de ciclos no triviales, parada universal en 2-ádicos, etc.): si crees haber demostrado algo serio, marca el resultado como **"borrador, requiere auditoría"** y describe el argumento, no lo vendas como cerrado.
- **Citas con cuidado.** Si invocas un teorema de Tao 2019, de Krasikov–Lagarias, de Conway sobre FRACTRAN, de Shallit sobre paridad-vector, etc., cita el resultado con precisión. **Si no estás seguro de la referencia exacta, márcala con `[verificar]`**. Es mucho mejor un `[verificar]` honesto que una atribución falsa.
- **Output estrictamente individual.** Cada `agente_NN` escribe **sólo** en `C:\Users\jjnie\collatz\agente_NN\sprint_01.md`. No leas el directorio de otros agentes durante este sprint (la síntesis es trabajo mío). No toques `README.md`, `CONVERSATION.md`, ni el directorio `JEFE`. No uses git.
- **Longitud objetivo: 400-1200 palabras.** Calidad muy por encima de cantidad. Un entregable de 500 palabras bien escrito vale más que 3000 palabras de relleno.
- **Idioma:** español. Markdown. Tono técnico pero legible.

---

## 3. Encargo individual

### agente_01 — rol Tao (C1, análisis y probabilidad)
Encargo sprint 1: repasa el resultado de Tao 2019 ("Almost all orbits of the Collatz map attain almost bounded values", *Forum of Mathematics, Pi*). Identifica con precisión **dónde está la pérdida** que impide pasar de "casi todas" a "todas": es decir, qué paso del argumento (la elección de la función Syracuse, la equidistribución de incrementos logarítmicos módulo 1, el control de colas) introduce el "casi". Propón como sub-problema un refinamiento cuantitativo concreto — por ejemplo, una mejora explícita en la tasa de convergencia de la densidad logarítmica, o una clase de excepciones que podría eliminarse. **No** propongas "cerrar el gap". Propón medir el gap mejor.

### agente_02 — rol Maynard/Green (C1, análisis y probabilidad)
Encargo sprint 1: tu ángulo son los **métodos aditivos y sumas exponenciales** aplicados a la iteración 3n+1. Repasa cómo Maynard y Green-Tao trabajan estructura aditiva (progresiones, sumas Type I/II) y pregúntate: ¿puede el reparto de paridades a lo largo de la órbita Collatz analizarse vía sumas exponenciales sobre la 2-ádica? ¿Tiene la "función de Syracuse" propiedades multiplicativas explotables? Propón un sub-problema en forma de **estimación concreta**: por ejemplo, una cota sobre el sesgo en la distribución de paridad-vectores de longitud k cuando n recorre un intervalo. Diferenciate explícitamente del agente_01: tú no tocas la prueba de Tao 2019, tú aportas maquinaria externa.

### agente_03 — rol Lindenstrauss (C2, dinámica y ergódica)
Encargo sprint 1: examina la iteración Collatz como sistema dinámico medible. ¿Qué medidas son invariantes bajo la acción de la función Syracuse en Z_2? ¿Hay análogos de **rigidez de medidas** (al estilo Einsiedler–Katok–Lindenstrauss para acciones diagonales en espacios de redes) aplicables aquí? Sub-problema: formular una conjetura de rigidez precisa cuya prueba implicaría la no-existencia de ciclos no triviales (o de órbitas divergentes). Aclara honestamente si crees que la acción Collatz tiene "suficiente estructura" para una teoría de rigidez, o si es demasiado pobre.

### agente_04 — rol Furstenberg (C2, dinámica y ergódica)
Encargo sprint 1: enfoque **dinámica simbólica y 2-ádicos**. La iteración Collatz extendida a Z_2 (función T de Lagarias) es una biyección continua, y la conjugación con la suma + 1 en Z_2 da el conocido "isomorfismo de Bernoulli" para la dinámica de paridad. Repasa qué barreras impiden traducir este isomorfismo en un teorema sobre Z. Sub-problema: identificar un **invariante dinámico** distinguidor entre la órbita trivial 1→4→2→1 y un ciclo hipotético no trivial. Diferénciate del agente_03: tú vas a lo simbólico/topológico, él va a lo medible.

### agente_05 — rol Oliveira e Silva (C3, computacional)
Encargo sprint 1: tu ángulo es la **verificación numérica masiva**. Resume el estado actual de la verificación (Barina 2020 hasta ~2^68 `[verificar]`), las técnicas de aceleración (sieve por residuos mod 2^k, congruencias para saltar bloques, GPU/SIMD), y el coste marginal de subir un bit. Sub-problema: proponer una **mejora algorítmica concreta y medible** (por ejemplo, un sieve por residuos módulo 3^k · 2^m con ganancia estimada x%, o una estructura de datos para detección temprana de coalescencia de órbitas). Da un criterio de éxito en operaciones/segundo o en alcance del frente de verificación.

### agente_06 — rol Granville/Pomerance (C3, computacional + aditiva)
Encargo sprint 1: foco en **cotas inferiores sobre ciclos no triviales**. Repasa los resultados de Eliahou (1993, longitud mínima de ciclo no trivial vía aproximaciones de log_2(3)) y trabajos posteriores. ¿Qué papel juegan las fracciones continuas de log 3 / log 2? ¿Hasta dónde llega la cota actual sobre la longitud mínima de un ciclo? Sub-problema: proponer una mejora en la cota inferior usando avances recientes en aproximación diofántica, o una caracterización estructural de posibles ciclos (no su existencia/no-existencia, sino su forma). Diferénciate del agente_05: tú no verificas, tú acotas teóricamente.

### agente_07 — rol Friedman (C4, lógica)
Encargo sprint 1: ataca el problema **por arriba**: ¿qué tan fuerte tiene que ser un sistema formal para demostrar Collatz? Repasa el resultado de Conway sobre Collatz generalizado y FRACTRAN (la función generalizada simula máquinas de Turing, luego el problema generalizado es indecidible). ¿Significa eso algo para Collatz específico? Sub-problema: formular con precisión la pregunta "¿es Collatz independiente de PA?" y proponer una estrategia para refutarla **o** para hacerla precisa (por ejemplo, identificar un fragmento de aritmética donde la cuestión es decidible). Honestidad obligada: di si crees que Collatz específico es probablemente demostrable en PA o no, y por qué.

### agente_08 — rol Hamkins (C4, lógica)
Encargo sprint 1: tu ángulo son los **modelos no estándar y la perspectiva set-teórica**. ¿Cómo se comporta la iteración Collatz en un modelo no-estándar de PA o ZFC? ¿Puede haber un "entero no-estándar" cuya órbita Collatz diverja, en algún modelo? ¿Tiene esto contenido matemático o es vacuo? Sub-problema: formular una pregunta precisa sobre la transferencia entre modelos (por ejemplo: "si Collatz se cumple en N estándar, ¿se cumple en toda extensión elemental?") con un criterio claro de éxito. Diferénciate del agente_07: él va a fuerza de prueba, tú vas a teoría de modelos.

### agente_09 — rol Shallit (C5, combinatoria)
Encargo sprint 1: foco en **autómatas finitos y paridad-vector**. Repasa la representación de órbitas Collatz como secuencias binarias de paridad (paridad-vector de Terras), la pregunta de Shallit sobre si el conjunto de paridad-vectores de órbitas que alcanzan 1 es regular/automático, y los resultados conocidos de no-regularidad. Sub-problema: proponer un lenguaje formal asociado a Collatz cuya clasificación en la jerarquía de Chomsky (regular / libre de contexto / sensible al contexto / recursivamente enumerable) tenga consecuencias para la conjetura. Da un criterio: "si demuestro que este lenguaje no es regular, esto implica X".

### agente_10 — rol Allouche/Steinerberger (C5, combinatoria)
Encargo sprint 1: ángulo **secuencias automáticas, palabras de Sturm, complejidad sub-lineal**. La secuencia de paridades de una órbita Collatz puede analizarse con la maquinaria de Allouche–Shallit sobre secuencias automáticas, o con la perspectiva de Steinerberger sobre la dinámica del problema. Sub-problema: proponer una medida de complejidad combinatoria de las órbitas (función de complejidad p(n), entropía topológica, frecuencia de factores) cuyo cómputo arroje información estructural sobre Collatz. Diferénciate del agente_09: él busca clasificar el lenguaje en la jerarquía de Chomsky; tú buscas medir cuantitativamente la complejidad de las palabras producidas.

---

## 4. Entregable común

Independientemente del ángulo, **el final de cada `sprint_01.md` debe contener dos bloques explícitos**, en este orden y con estos encabezados literales:

### Sub-problema para sprint 2
- Enunciado del sub-problema en una o dos frases.
- **Criterio de éxito medible**: qué tendría que producirse en sprint 2 para considerar avance (un teorema con hipótesis y tesis bien definidas, una cota numérica con valor objetivo, un experimento computacional con métrica, una formalización Lean con un nombre de lema, etc.). Nada de "entender mejor".

### Autoevaluación
Una de las tres etiquetas, con una frase de justificación:
- **Prometedor** — hay grieta visible, el ángulo parece capaz de producir un resultado parcial publicable.
- **Improbable** — el ángulo es interesante pero las probabilidades de producir algo nuevo son bajas; explicar por qué seguir aún así.
- **Callejón sin salida** — tras este sprint el agente concluye que su línea no da fruto; explicar el obstáculo concreto que lo cierra.

La etiqueta **callejón sin salida** no es un fracaso del agente. Un agente que cierra honestamente una línea ahorra meses al equipo.

---

## 5. Cierre del jefe

Tras este sprint leeré los diez entregables, identificaré solapamientos, contradicciones y sinergias entre células, y propondré la dirección del **sprint 2** — incluyendo posibles reasignaciones, colaboraciones inter-célula y la designación rotativa de un "abogado del diablo". No espero que ningún sprint individual mueva la conjetura. Espero que, sumados, construyan un mapa que en sprints futuros nos diga **dónde merece la pena cavar y dónde no**. Esa es la única forma honesta de atacar un problema de 89 años.

— *Jefe del equipo (coordinación científica)*
