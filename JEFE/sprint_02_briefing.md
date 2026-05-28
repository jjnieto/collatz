# Sprint 2 — Briefing del Jefe

**Equipo:** 10 agentes, ahora reorganizados en **3 tuberías inter-célula + 1 sub-célula de ciclos**.
**Duración nominal:** un sprint (entregable único).
**Lectura previa obligatoria:** `JEFE/sprint_01_sintesis.md` (mi lectura crítica) y este briefing.

---

## 1. Objetivo del sprint 2

**Convertir los diez ángulos exploratorios del sprint 1 en tres tuberías productivas que, al final del sprint 3, puedan generar un primer lema formalizable.** No más mapeo. No más diez sub-problemas paralelos. Cada agente o trabaja para alimentar a otro, o audita a otro, o forma pareja con otro. El éxito del sprint se mide por el ajuste de las interfaces entre agentes, no por el brillo individual.

Lo digo sin adornos: estoy preocupado por la dispersión del sprint 1. Diez "Improbable" honestos describen un terreno donde nadie tiene la pieza que falta. Si seguimos atacando en paralelo, el sprint 2 va a producir diez ejercicios técnicos correctos y desconectados. La consigna del sprint 2 es: **conectar o producir tracción visible; si no, el sprint 3 será de poda**.

---

## 2. Reorganización del equipo

| Tubería / sub-célula | Agentes | Misión |
|---|---|---|
| **Sub-célula CICLOS** (`2^N ≈ 3^K`) | 03 + 04 + 06 | Unificar tres lentes sobre la misma desigualdad diofántica: rigidez de medidas (03), invariante simbólico/frecuencia (04), cota inferior `K_0` vía aproximación de `log 3 / log 2` (06). Output: enunciado único compartido y una cota `K_0` o teorema de no-trivialidad genuinamente nuevo. |
| **Cadena ANÁLISIS EFECTIVO** | 01 → 02 ; 01 → 09 | 01 produce un enunciado efectivo intermedio del teorema de Tao 2019. 02 (Gowers/`U^2`) y 09 (no-regularidad de `L_div`) lo consumen como hipótesis externa precisa. Sin acuerdo de interfaz no hay sprint. |
| **Tubería COMPUTACIONAL-LÓGICA** | 05 → 07 → 08 | 05 mide `σ(n)` a escala y entrega un dataset con cota empírica. 07 lo cocina para una reducción condicional (`σ ≤ C log n` ⇒ Collatz en `IΔ₀+exp`). 08 produce cotas inferiores efectivas sobre `σ` y descarta cortes semiregulares. |
| **Pareja COMPLEJIDAD COMBINATORIA** (C5) | 09 + 10 | 09 sigue en la clasificación Chomsky de `L_div` con la hipótesis de 01. 10 entrega tabla numérica de `p*_N(k)` y cota `α_0^k`, que es input para 06 y para 09. |
| **Infraestructura (rol especial de 04)** | 04 | Además de su trabajo en la sub-célula CICLOS: formalizar la conjugación `Q` de Lagarias como objeto Lean/papel reusable por 03, 07, 08. |
| **Abogado del diablo** | **07** | Encargo adicional: auditar pasajes específicos del sprint 1 que marqué como sospechosos (sección 5). |

Importante: **un agente puede pertenecer a más de un agrupamiento** (04 está en CICLOS y además es infraestructura; 09 está en C5 y además en la cadena ANÁLISIS EFECTIVO; 07 está en la tubería COMPUTACIONAL-LÓGICA y además es abogado del diablo). La pertenencia se refleja en el encargo individual.

---

## 3. Reglas comunes

Siguen vigentes todas las del sprint 1 (no falsificar demostraciones, `[verificar]` cuando haya duda, 400-1200 palabras, español, markdown, no tocar git, escribir SÓLO en `agente_NN/sprint_02.md`, no tocar `README.md`, `CONVERSATION.md` ni el directorio `JEFE`).

**Reglas nuevas para el sprint 2:**

- **R-N1. Lectura cruzada permitida dentro de la tubería.** Cada agente puede (y debe, si su tubería lo requiere) leer los `sprint_01.md` de sus compañeros de tubería. Sigue prohibido leer entregables de otras tuberías hasta que cierre el sprint. La síntesis sigue siendo trabajo mío.
- **R-N2. Respuesta a auditoría.** Si el abogado del diablo te audita y encuentra algo, tu próximo entregable (sprint 3) deberá responder con concesión o defensa explícita. En este sprint 2, sólo deben incluir el bloque `### Respuesta a auditoría` los agentes cuyo encargo individual lo indique expresamente. Si no lo indico, omitir el bloque.
- **R-N3. Interfaz explícita.** Si tu encargo dice "entregas X a agente_Y", el entregable debe contener un mini-bloque `### Interfaz para agente_Y` con el enunciado preciso de X (variables, dominios, hipótesis). Sin interfaz explícita, la tubería falla y el siguiente agente no puede consumir tu output.

---

## 4. Encargo individual

### agente_01 — rol Tao, cadena ANÁLISIS EFECTIVO (productor)

Encargo sprint 2: produce un **enunciado intermedio efectivo** del teorema de Tao 2019 al nivel que prometiste en tu sub-problema. No se te pide la prueba completa: se te pide la **redacción precisa** de la cota `g(X, f)` con `f(n) = n^{1−ε}` y `g(X,f) = O((log X)^{−c(ε)})` con un `c(ε)` simbólico (aunque sea pésimo). El entregable debe incluir:

1. **Enunciado E-Tao** en formato lema (hipótesis, tesis, constantes nombradas).
2. **Ubicación dentro de Tao 2019** de la pérdida cuantitativa (sección/página) donde se introduce `c(ε)`.
3. **Interfaz para agente_02** (cómo se usa `E-Tao` en una cota de sesgo `β_2(N,k)`) y **Interfaz para agente_09** (cómo `E-Tao` actúa como hipótesis externa en el argumento de no-regularidad de `L_div`).

Es decir: produces el adaptador que dos compañeros van a consumir. Si no llegas al enunciado E-Tao, entrega el bloqueo técnico con suficiente detalle como para que 02 y 09 sepan qué les falta.

### agente_02 — rol Maynard/Green, cadena ANÁLISIS EFECTIVO (consumidor de 01)

Encargo sprint 2: **consume el enunciado E-Tao de agente_01** y demuestra (o reduce a un sub-lema explícito) tu cota `U^2`-Gowers sobre el sesgo `β_2(N,k)` de paridad-vectores en `[N, 2N]`. Tu autoevaluación de sprint 1 decía "trivial o duro": el sprint 2 es el sprint donde decides. Output:

1. Una de dos: (a) demostración elemental que tu cota es trivial (consecuencia inmediata de Bernoulli o de Terras), en cuyo caso etiquetas la línea callejón sin salida con argumento; o (b) reducción a un sub-lema duro, con enunciado preciso del sub-lema y por qué no es trivial.
2. **Interfaz para agente_09**: si el sub-lema duro involucra estructura aditiva sobre paridad-vectores, comparte la formulación con 09 para que pueda usarla.

Lectura cruzada autorizada: `agente_01/sprint_01.md` y `agente_09/sprint_01.md`.

### agente_03 — rol Lindenstrauss, sub-célula CICLOS

Encargo sprint 2: tu sub-problema de sprint 1 (clasificar medidas `T`-invariantes ergódicas con soporte en `Z`) tú mismo lo identificaste como navegando la frontera de circularidad. **El sprint 2 es donde resuelves esa frontera.** Concretamente:

1. **Decide entre dos caminos.** O bien (a) demuestras el lema mínimo que prometiste (entropía cero ⇒ soporte en ciclo finito) y muestras que NO es circular, exhibiendo dónde sale información estructural; o bien (b) reconoces que sí colapsa la conjetura sobre sí misma y pivotas hacia el rol que la sub-célula CICLOS te abre: **traducir el invariante de frecuencia `k/p ≈ log2/log3` de agente_04 a una formulación de medida atómica**, sirviendo como puente entre 04 y 06.
2. **Interfaz para agente_06**: enunciado preciso de la conjetura "soporte en ciclo no trivial implica `K ≥ K_0(N)`" en términos diofánticos, que es lo que 06 puede atacar.

Lectura cruzada autorizada: `agente_04/sprint_01.md` y `agente_06/sprint_01.md`.

**Bloque obligatorio**: incluye `### Respuesta a auditoría` respondiendo al punto (i) de la síntesis del sprint 1 (circularidad de tu sección 2).

### agente_04 — rol Furstenberg, sub-célula CICLOS + Infraestructura

Encargo sprint 2: doble misión.

1. **En CICLOS**: el invariante de frecuencia `k/p ≈ log2/log3` es conocido (Crandall 1978, Eliahou 1993) y tú mismo lo reconociste. Tu aportación útil ahora no es redescubrirlo, sino **escribirlo como una sola desigualdad diofántica unificada** que 03, 04 y 06 puedan citar literalmente. Una página, enunciado preciso, sin ambigüedad de notación.
2. **Infraestructura**: empieza a formalizar la **conjugación `Q` de Lagarias** como objeto Lean (o, si Lean no es factible aún, en pseudocódigo formal con tipos explícitos). El target: que 03, 07 y 08 puedan referirse a `Q` por nombre sin redefinirla. Producto: un esqueleto de fichero con definiciones y firmas de lemas (no se requiere demostración).

Lectura cruzada autorizada: `agente_03/sprint_01.md` y `agente_06/sprint_01.md`.

### agente_05 — rol Oliveira e Silva, tubería COMPUTACIONAL-LÓGICA (productor)

Encargo sprint 2: **mide `σ(n)` a escala y entrega un dataset utilizable**. Concretamente:

1. **Implementa o describe con detalle reproducible** un benchmark que calcule el tiempo de parada `σ(n)` para `n ≤ 2^32` (o el rango más grande que sea factible en este sprint), exportando histograma y los outliers superiores (los 1000 `n` con mayor `σ(n)/log₂(n)`).
2. **Ajuste empírico**: la mejor cota `C` tal que `σ(n) ≤ C·log₂(n)` se cumple en tu rango, con desviación estándar y outliers identificados.
3. **Interfaz para agente_07**: el dataset (formato, columnas, dónde vive) y el valor empírico `C_emp` que 07 va a usar en su reducción condicional.
4. **Interfaz para agente_08**: los outliers como candidatos a cota inferior efectiva de `σ`.

Sub-problema de sprint 1 sobre el sieve híbrido `mod 3^a · 2^b`: aparcado para sprint 3 salvo que tengas tiempo, esto es prioritario.

Lectura cruzada autorizada: `agente_07/sprint_01.md` y `agente_08/sprint_01.md`.

### agente_06 — rol Granville/Pomerance, sub-célula CICLOS

Encargo sprint 2: **produce un valor numérico nuevo de `K_0`** (cota inferior sobre el número de subidas en un ciclo no trivial), o demuestra que el valor vigente (Eliahou 1993, refinado por Simons–de Weger `[verificar]`) no puede mejorarse sin aproximación diofántica nueva. Concretamente:

1. Estado del arte preciso del `K_0` vigente (con cita verificada, no `[verificar]`).
2. Cota nueva o argumento de barrera, usando como input la verificación numérica actual (`~ 2^68` `[verificar]`) y, si está disponible, los datos de 05 sobre `σ`.
3. **Consume la cota `α_0^k` de agente_10**: si `p*_N(k) ≤ C·α_0^k` con `α_0 < 2`, ¿qué nuevo `K_0` se deriva sobre ciclos? Hazlo explícito.
4. **Interfaz para agente_03**: la versión diofántica de tu cota en forma de "no existen `N, K` con `|N log 2 − K log 3| < ε` y `K < K_0`".

Lectura cruzada autorizada: `agente_03/sprint_01.md`, `agente_04/sprint_01.md`, `agente_10/sprint_01.md`.

### agente_07 — rol Friedman, tubería COMPUTACIONAL-LÓGICA + ABOGADO DEL DIABLO

Encargo sprint 2: doble misión. Detalle del rol de abogado del diablo en sección 5; aquí el encargo de tubería.

1. **Consume el dataset y `C_emp` de agente_05**. Escribe con precisión el enunciado condicional: "Si `∀n ≥ N_0, σ(n) ≤ C · log₂(n)`, entonces Collatz es demostrable en `IΔ₀ + exp`" (o el sistema mínimo que tu análisis identifique). Hipótesis, tesis, constantes nombradas.
2. **Esquema de prueba**: enumera los pasos del argumento, identificando cuáles requieren `C_emp` numérico y cuáles son uniformes.
3. **Interfaz para agente_08**: indica qué cotas inferiores sobre `σ` (qué tipo de `n` deben tener `σ` grande) son necesarias para excluir cortes semiregulares en modelos `M ⊨ PA + ¬Collatz`.

Lectura cruzada autorizada: `agente_05/sprint_01.md` y `agente_08/sprint_01.md`. **Adicionalmente**, en su rol de abogado del diablo, 07 puede leer los archivos citados en la sección 5.

### agente_08 — rol Hamkins, tubería COMPUTACIONAL-LÓGICA (consumidor de 05 y 07)

Encargo sprint 2: **redirige tu trabajo** desde la clasificación de cortes `I_M` (que tú mismo y la síntesis identificamos como vacua si Collatz ∈ PA) hacia el ángulo *útil para la tubería*: producir **cotas inferiores efectivas sobre `σ(n)`** a partir de los outliers de 05 y de los requerimientos de 07. Concretamente:

1. Toma los 1000 outliers de 05 con mayor `σ(n)/log₂(n)`. Ajusta una **cota inferior** tipo `σ(n) ≥ c · log₂(n)^α` para algún `α` (¿1? ¿1+ε?).
2. Argumenta cómo esa cota inferior, combinada con el enunciado condicional de 07, restringe los cortes semiregulares posibles. Esto NO requiere demostrar nada profundo en teoría de modelos: requiere conectar dos cotas.
3. **Interfaz para agente_07**: tu cota inferior como hipótesis en su reducción condicional.

Si encuentras que ninguna cota inferior no trivial se ajusta a los outliers, dilo y marca la línea como callejón. La síntesis ya advirtió que tu sub-problema original puede ser vacuo; este sprint es donde se confirma o se rescata.

Lectura cruzada autorizada: `agente_05/sprint_01.md` y `agente_07/sprint_01.md`.

### agente_09 — rol Shallit, C5 (consumidor de 01) + complejidad combinatoria con 10

Encargo sprint 2: **consume el enunciado E-Tao de agente_01** y demuestra (o reduce) tu sub-problema de sprint 1: `L_div` (lenguaje de paridad-vectores de órbitas divergentes) es vacío o no regular. Concretamente:

1. Versión precisa de "no regular": pumping lemma con la constante de bombeo expresada en términos de las constantes de `E-Tao`.
2. **Consume la tabla `p*_N(k)` de agente_10**: si `p*_N(k)` tiene crecimiento `α^k` con `α` específico, ¿qué dice sobre el lenguaje de prefijos de palabras divergentes?
3. **Interfaz para agente_02** si tu argumento requiere estructura aditiva sobre paridad-vectores.

Lectura cruzada autorizada: `agente_01/sprint_01.md`, `agente_02/sprint_01.md`, `agente_10/sprint_01.md`.

### agente_10 — rol Allouche/Steinerberger, C5 (productor de datos para 06 y 09)

Encargo sprint 2: **produce los datos prometidos** en tu sub-problema de sprint 1.

1. Tabla numérica de `p*_N(k)` para `N ∈ {10^6, 10^8}` y `k ∈ {10, 20, 30, 40}`.
2. Conjetura cuantitativa `p*_N(k) = α^k (1+o(1))` con `α` a tres decimales y contraste con `2^{1/(1+log₂3)} ≈ 1.5396`.
3. Intento de cota superior `p*_N(k) ≤ C·α_0^k` con `α_0 < 2` explícito y prueba auditable (no heurística).
4. **Interfaz para agente_06**: tu `α_0` y `C` como insumo formal para su cota de ciclos.
5. **Interfaz para agente_09**: la tabla numérica como evidencia empírica para o contra la no-regularidad de `L_div`.

Sobre el punto (iv) de la síntesis del sprint 1 (mezcla de "frecuencia 1/2 de Bernoulli" y "frecuencia diofántica del ciclo" en tu sección 4): **desambígualo en una nota al pie** dentro de tu entregable. Esto se cuenta como respuesta implícita a la observación; no necesitas bloque `### Respuesta a auditoría` separado.

Lectura cruzada autorizada: `agente_06/sprint_01.md` y `agente_09/sprint_01.md`.

---

## 5. Encargo especial — agente_07 como abogado del diablo

Además del encargo de tubería de la sección 4, **agente_07 debe auditar tres pasajes específicos** del sprint 1 que detecté como sospechosos. Su entregable de sprint 2 incluirá una sección `### Auditoría como abogado del diablo` con el veredicto sobre cada uno. La auditoría debe **citar literalmente** los pasajes y emitir uno de tres veredictos: **defendido** (la objeción del jefe es infundada), **concedido** (el agente auditado debe corregir), o **inconcluyente** (necesita más datos del propio agente auditado, en cuyo caso 07 formula la pregunta concreta que el agente debe responder en sprint 3).

### Pasaje A — agente_03, archivo `agente_03/sprint_01.md`

Cita literal (líneas 43-45):

> *"un ciclo no trivial de Collatz produciría una **medida `T`-invariante atómica con soporte finito en `Z` ⊂ Z_2**, soporte que es disjunto del ciclo trivial `{1,2,4}`. Si pudiera demostrarse que **toda medida `T`-invariante ergódica sobre `Z_2` cuyo soporte está contenido en `Z` debe estar contenida en el ciclo trivial**, eso cerraría la parte de ciclos."*

**Razón para sospechar.** El propio agente_03 admite en la línea siguiente (su sección 2, párrafo final) que la formulación "puede colapsar a clasificar ciclos finitos, que es Collatz mismo". 07 debe decidir: ¿la reformulación medible aporta estructura nueva (entropía, dimensión, equidistribución 2-ádica) que no esté ya en el enunciado combinatorio "no hay ciclos no triviales"?, ¿o es una traducción de notación sin ganancia?

### Pasaje B — agente_01, archivo `agente_01/sprint_01.md`

Cita literal (línea 13, capa B):

> *"Una órbita podría oscilar indefinidamente entre, digamos, `log log n` y `log log log n` sin contradecir el teorema."*

**Razón para sospechar.** La afirmación está enunciada con grado de certeza superior al `[verificar]` adyacente. 07 debe verificar contra el texto literal del preprint de Tao 2019 (arXiv:1909.03562 o equivalente) si esta afirmación es (i) literalmente cierta, (ii) cierta con matiz (qué matiz), o (iii) sobre-estirada. Es un detalle pequeño, pero el resto del argumento de 01 depende de él.

### Pasaje C — agente_10, archivo `agente_10/sprint_01.md`

Cita literal (línea 33, sección 4, punto 1):

> *"el balance crítico es `log_2 3 / (1+log_2 3) ≈ 0.6309`, no `1/2`, **una vez se contabiliza el peso multiplicativo**."*

**Razón para sospechar.** En la frase se mezclan dos conteos: la frecuencia 1/2 de Bernoulli en `Z_2` (medible) y la frecuencia diofántica del ciclo (combinatoria/multiplicativa). 07 debe decidir si los dos conteos están bien separados en el resto del entregable de 10, o si hay contaminación que invalide la cota propuesta `α_0^k`. Esto es crítico porque 06 va a consumir esa cota.

---

## 6. Entregable común

Cada `sprint_02.md` cierra con los bloques siguientes, en este orden y con encabezados literales:

### Sub-problema para sprint 3
Enunciado en una o dos frases. **Criterio de éxito medible** (teorema, cota numérica, experimento, formalización Lean nombrada). Nada de "entender mejor".

### Autoevaluación
Una de: **Prometedor**, **Improbable**, **Callejón sin salida**, con frase de justificación. Se permite —y se valora— el cambio de etiqueta respecto al sprint 1 si tu tubería abrió una grieta o, al contrario, cerró la puerta.

### Respuesta a auditoría
**Sólo si tu encargo individual lo indica explícitamente** (en este sprint 2: agente_03, por el punto (i) de la síntesis del sprint 1). Si no lo indico, omitir este bloque.

Y, cuando aplique según R-N3:

### Interfaz para agente_NN
Bloque con la firma precisa de lo que produces para un compañero. Si tu encargo dice "entregas X a Y", este bloque es obligatorio.

---

## 7. Cierre del jefe

Sprint 1 nos dio el mapa. Sprint 2 tiene que ser el primer terraplén. La regla operativa es simple: **al final de este sprint, las tres tuberías deben estar enchufadas**. Si las interfaces no cuadran, si 02 no puede consumir lo que 01 produce, si 07 no puede usar el dataset de 05, si la sub-célula CICLOS publica tres enunciados disjuntos en lugar de uno solo —entonces el sprint 3 será de poda: cerraremos las líneas que no produjeron tracción y reasignaremos el equipo, posiblemente a un sub-problema acotado fuera del corazón de Collatz (formalización Lean de Eliahou, infraestructura de verificación, o pivote a un problema vecino). No es amenaza, es planificación honesta.

Recuerden las dos reglas no negociables: nadie demuestra Collatz en un sprint; el `[verificar]` honesto vale más que la atribución falsa. Y la regla nueva de este sprint: si su tubería pide interfaz, escriban la interfaz. La calidad de la junta entre dos agentes es lo que estoy midiendo esta vez.

— *Jefe del equipo (coordinación científica)*
