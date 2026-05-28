# Sprint 1 — Síntesis del Jefe

Diez entregables leídos. Equipo cumplido en plazo y formato. Lo que sigue es lectura crítica, no resumen.

---

## 1. Tabla resumen

| Agente | Célula | Sub-problema (1 frase) | Autoeval. | Calidad |
|---|---|---|---|---|
| 01 (Tao) | C1 analítica | Cuantificar la tasa efectiva en `f` del teorema Tao 2019 sobre densidad logarítmica. | Improbable | Sólido |
| 02 (Maynard/Green) | C1 analítica | Cota `U^2`-Gowers sobre el sesgo `β_2(N,k)` de paridad-vectores en `[N,2N]`. | Improbable | Sólido |
| 03 (Lindenstrauss) | C2 dinámica | Clasificar medidas `T`-invariantes ergódicas en `Z_2` con soporte en `Z`. | Improbable | Razonable |
| 04 (Furstenberg) | C2 dinámica | Invariante de frecuencia 1/3 vs `log2/log3` para ciclos como obstrucción topológica. | Improbable | Razonable |
| 05 (Oliveira e Silva) | C3 computacional | Sieve híbrido `mod 3^a · 2^b` con benchmark vs. sieve `2^k` puro. | Improbable | Sólido |
| 06 (Granville/Pomerance) | C3 aditiva | Mejorar `K_0` (cota inferior de subidas en ciclo) vía verificación + irracionalidad efectiva de `log3/log2`. | Improbable | Sólido |
| 07 (Friedman) | C4 lógica | Calibrar el menor sistema formal que demuestra Collatz; formalizar `Π⁰₂` y reducción condicional vía cota log empírica. | Improbable | Sólido |
| 08 (Hamkins) | C4 lógica | Estudiar el corte `I_M` en modelos `M ⊨ PA + ¬Collatz`: ¿semiregular o no? | Improbable | Razonable |
| 09 (Shallit) | C5 combinatoria | Demostrar que `L_div` es vacío o no regular (versión fuerte: no libre de contexto). | Improbable | Sólido |
| 10 (Allouche/Steinerberger) | C5 combinatoria | Función de complejidad ponderada `p*_N(k)` y cota `α_0^k` con `α_0 < 2`. | Improbable | Razonable |

Diez "Improbable", cero "Prometedor", cero "Callejón sin salida". Eso es información, lo discuto en la sección 6.

---

## 2. Solapamientos y sinergias detectadas

**(a) Eje "ciclos no triviales" — cruce C2-C3-C5.** Tres agentes convergen al mismo objeto desde ángulos distintos:
- agente_06 produce `K_0` numérico vía diofántica + verificación.
- agente_04 ofrece el invariante de frecuencia `k/p ≈ log2/log3` como obstrucción topológica.
- agente_03 propone *medidas atómicas invariantes con soporte en `Z`* como reformulación del problema de ciclos.

Las tres formulaciones son la misma desigualdad `2^N ≈ 3^K` vista por tres lentes. La sinergia obvia: el invariante de agente_04 es la versión **simbólica** de la desigualdad diofántica de agente_06, y la condición de agente_03 sobre medidas atómicas con soporte finito en `Z` se reduce a la enumeración de soluciones de esa misma desigualdad. **Esto debería ser una sola sub-célula coordinada en sprint 2**, no tres agentes orbitando en paralelo.

**(b) Eje "Tao 2019 como input" — cruce C1-C5.** Tanto agente_02 (cota `β_2`) como agente_09 (no-regularidad de `L_div`) **dependen explícitamente** del control de densidades de Tao 2019 o Krasikov–Lagarias como hipótesis externa. Si agente_01 produce un refinamiento efectivo de Tao, esa mejora se enchufa directamente en los argumentos de bombing lemma de agente_09 y en la cota de Gowers de agente_02. Hay una cadena de dependencia natural `01 → {02, 09}` que conviene explicitar.

**(c) Eje "cota logarítmica empírica" — cruce C3-C4.** agente_07 propone que **si** el tiempo de parada satisface `σ(n) ≤ C·log₂(n)` para alguna `C`, entonces Collatz vive en `I∆₀+exp`. agente_05 puede producir exactamente esa cota empírica como subproducto de su benchmark (los lotes ya computan `σ(n)` por `n`). agente_08, en paralelo, pide cotas inferiores sobre `σ(n)` para descartar ciertos cortes semiregulares. Hay una **tubería computacional natural**: agente_05 mide `σ(n)` a escala, agente_07 lo cocina para lógica, agente_08 lo usa para teoría de modelos.

---

## 3. Contradicciones, errores o pretensiones excesivas

En general el equipo se portó bien: nadie pretendió demostrar Collatz, todos marcaron `[verificar]` cuando no estaban seguros, y la autoevaluación honesta fue universal. Detalles que quiero señalar:

**(i) agente_03, sección 2 ("Estrategia").** El propio agente reconoce que la afirmación *"toda medida `T`-invariante ergódica con `supp ⊂ Z` y entropía cero es atómica con soporte en ciclo finito"* puede ser **circular** (colapsar a "clasificar ciclos finitos", que es Collatz mismo). Es honesto, pero el sub-problema tal como está formulado sigue navegando esa frontera. Aviso: hay que vigilar que el sprint 2 no consuma esfuerzo en una equivalencia trivial disfrazada de teorema.

**(ii) agente_04, sección 4.** La frase *"el invariante de frecuencia [...] es conocido desde Crandall (1978) y Eliahou (1993)"* es correcta y el propio agente la reconoce. El riesgo aquí no es deshonestidad sino **redundancia con agente_06**: si el aporte del ángulo simbólico es "infraestructural" (palabras del propio agente), conviene fusionarlo en lugar de duplicarlo.

**(iii) agente_01, capa B.** La afirmación de que "una órbita podría oscilar indefinidamente entre `log log n` y `log log log n` sin contradecir el teorema" es **fuerte y debe verificarse contra el texto literal de Tao 2019**. No es errónea en mi lectura, pero está enunciada con un grado de certeza ligeramente superior al que la cita `[verificar]` adyacente sostiene. Pequeño detalle, no rebote.

**(iv) agente_10, sección 4, punto 1.** El paso *"el balance crítico es `log_2 3 / (1+log_2 3) ≈ 0.6309`, no 1/2, una vez se contabiliza el peso multiplicativo"* mezcla dos conteos distintos: la frecuencia 1/2 de Bernoulli en `Z_2` (medible) y la frecuencia diofántica del ciclo (combinatoria). Está dicho con prisa, conviene desambiguar antes del sprint 2.

**(v) Ningún agente rozó "demostración fingida".** Cumplieron la regla número uno del briefing. Reconocido.

---

## 4. Veredicto sobre cada célula

**C1 (analítica, agentes 01 + 02).** Sigue como está. Los dos ángulos son genuinamente complementarios (Tao desde dentro vs. Gowers/`U^2` desde fuera) y los sub-problemas son medibles. agente_01 actúa de hecho como brújula del equipo; mantengámoslo así. agente_02 debe decidir en sprint 2 entre "trivial" o "duro" — el propio criterio que se autoimpone es bueno.

**C2 (dinámica, agentes 03 + 04).** Reorientación parcial. Ambos agentes reconocen que su ángulo es *infraestructural* o *equivalente al problema*. Propongo que C2 deje de buscar "el avance dinámico" y se reposicione como **célula de formalización y traducción**: tomar resultados de C3 (Eliahou, agente_06) y C5 (invariantes simbólicos, agentes 09-10) y darles una formulación dinámica unificada en Lean o en papel. Cambio de misión, no de personas.

**C3 (computacional + aditiva, agentes 05 + 06).** Sigue tal cual. Es la célula con sub-problemas más concretos, medibles y publicables aisladamente, aun en el escenario pesimista. La división de trabajo (empuje empírico vs. cota teórica) es limpia.

**C4 (lógica, agentes 07 + 08).** Reorientación. Ambos agentes apuntan que su línea es *condicionalmente vacua*: si Collatz es demostrable en PA (la apuesta del propio agente_07), todo el aparato modelo-teórico de agente_08 se vacía. Propongo concentrar a la célula en el **sub-objetivo 3 de agente_07** (cota `σ(n) ≤ C log n` ⇒ Collatz en `I∆₀+exp`), que es factible, publicable, y útil para el resto del equipo. agente_08 se redirige a producir las cotas inferiores efectivas sobre `σ(n)` que su propio sub-problema requiere — y que C3 le puede entregar.

**C5 (combinatoria, agentes 09 + 10).** Sigue como está. agente_09 (clasificación Chomsky de `L_div`) tiene un teorema A genuinamente factible. agente_10 produce datos numéricos limpios que son **insumo natural para agente_06** (cota combinatoria sobre órbitas contractivas ↔ estructura de ciclos). Ambos honestos sobre el carácter periférico de sus resultados.

---

## 5. Decisiones para el sprint 2

### Reasignaciones
- **agente_04 cambia de eje.** Sale del ángulo "invariante simbólico de ciclos" (cubierto por 06 y 03) y entra en formalización de la conjugación `Q` de Lagarias como objeto Lean reusable por C2, C4 y C5. Misma persona, misión infraestructural.
- **agente_08 se desplaza** del programa "cortes semiregulares" (vacuo si Collatz ∈ PA) hacia el cómputo de cotas inferiores efectivas sobre `σ(n)`, en pareja con agente_05.

### Colaboraciones inter-célula (sprint 2)
1. **agente_05 + agente_08:** tubería de medición de `σ(n)` (empírica + traducción a teoría de modelos / lógica).
2. **agente_06 + agente_10:** la cota `α_0^k` de agente_10 sobre órbitas contractivas debería ser input formal de la maquinaria diofántica de agente_06; y el `K_0` de agente_06 acota qué `k` son relevantes para agente_10.
3. **agente_01 + agente_09:** el refinamiento efectivo de Tao 2019 es la hipótesis externa exacta que agente_09 necesita para la no-regularidad de `L_div`. Que coordinen versiones precisas del enunciado.

### Abogado del diablo del sprint 2
**agente_07.** Razón: es el agente con la posición más definida del equipo ("Collatz, si es cierto, es probablemente demostrable en PA, y posiblemente en algo más débil"), y por tanto el más útil para *cuestionar* cada propuesta cuantitativa con la pregunta dura: ¿este teorema, suponiendo que se prueba, *reduce* el problema o sólo lo reformula? Su instinto de calibración por jerarquías es exactamente lo que el equipo necesita oír cuando produzcamos cotas.

### Brújula del sprint 2
Convertir el mapa del terreno en **dos o tres tuberías concretas inter-célula** (no diez sub-problemas paralelos), priorizando los entregables medibles y útiles a terceros sobre los teoremas auto-contenidos.

---

## 6. Honestidad final

Diez "Improbable" no es coincidencia ni cobardía. Es la lectura correcta del problema: Collatz lleva 89 años abierto precisamente porque ninguno de estos ángulos, por sí solo, tiene la pieza que falta. El equipo entendió la consigna y se autorregulo. Eso es bueno. Lo malo es el corolario: si todos los ángulos son periféricos, el riesgo de que el sprint 2 sea **diez ejercicios técnicos limpios sin tracción sobre el corazón del problema** es alto. La mitigación que propongo —reducir paralelismo, forzar tuberías inter-célula, designar abogado del diablo agresivo— intenta cerrar esa grieta. Si después del sprint 2 seguimos en "Improbable × 10", habrá que reconocer que el equipo está mapeando muy bien un territorio donde no hay tesoro enterrado, y reorientar drásticamente o pasar a otro problema. No edulcoro: este sprint nos dijo dónde NO está la grieta, y eso es la mitad del trabajo. La otra mitad —dónde sí— sigue pendiente.

— *Jefe del equipo*
