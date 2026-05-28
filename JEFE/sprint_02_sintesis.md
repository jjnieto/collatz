# Sprint 2 — Síntesis del Jefe

Diez entregables leídos. Tres tuberías intentadas. El sprint produjo más sustancia técnica que el sprint 1, pero también dibujó con nitidez dónde el equipo no tiene tracción. Lo que sigue es lectura crítica y decisión, no resumen.

---

## 1. Tabla de tracción

| Agente | Tubería | Entregable principal | Autoeval. S2 | vs. S1 | Interfaz |
|---|---|---|---|---|---|
| 01 | Análisis efectivo (productor) | E-Tao en formato lema con `c(ε)` simbólico; pérdida localizada en Prop. 1.17 de Tao 2019. | Improbable | = | ✓ (02 y 09) |
| 02 | Análisis efectivo (consumidor) | Régimen `k≤(1/2)log₂N` trivial; régimen alto reducido a sub-lema S2 sobre transferencia densidad-log → `U²`. | Improbable | = | ✓ (09) |
| 03 | CICLOS | Pivota a (b): traductor entre 04 y 06. Concede circularidad. | Improbable | = (por otra razón) | ✓ (06) |
| 04 | CICLOS + Infraestructura | Desigualdad CIC-1 unificada (una página) + esqueleto Lean `Collatz/Q.lean` con firmas y `sorry`. | **Prometedor** | ↑ | ✓ (03,06,07,08) |
| 05 | Computacional-lógica (productor) | Medición real hasta `2^30` (10⁹ enteros), `C_emp=22.835`, dataset + outliers + histograma. | **Prometedor** | ↑ | ✓ (07,08) |
| 06 | CICLOS | Barrera blanda: `K₀≈1.4·10⁹` no nuevo respecto a Simons–de Weger; **umbral combinatorio `α₀<1.3066`** para cerrar ciclos. | Improbable | = | ✓ (03) |
| 07 | Computacional-lógica + Abogado | (E-Friedman-σ) escrito; pasos (S1)–(S5) deslindados uniformes/parametrizados. Auditoría: A concedido, B defendido, C inconcluyente. | **Prometedor** | ↑ | ✓ (08) |
| 08 | Computacional-lógica (consumidor) | Confirma callejón: cotas `c·log n` no excluyen semiregularidad porque `log` es PR-cerrado. Rescate modesto (saneamiento). | **Callejón sin salida** | ↓ | parcial |
| 09 | C5 + Análisis efectivo | Reducción condicional `c(ε)>1 ⇒ L_div no regular o vacío`; asimetría contractivos/divergentes con 10. | Improbable | = | ✓ (02) |
| 10 | C5 (productor) | Tabla exacta hasta `N=10⁸`, `k≤40`. **`α₀=1.930` con prueba auditable**, NO `1.5396`. `ρ_k → 1` exponencial. | Improbable | = | ✓ (06,09) |

Cuatro etiquetas se movieron: 04, 05, 07 a *Prometedor*; 08 a *Callejón*. El resto se mantiene en *Improbable*, pero por razones más precisas que en S1.

---

## 2. Estado de las tuberías

### Tubería ANÁLISIS EFECTIVO (01 → 02, 01 → 09)

**Junta 01→02:** parcial. 01 entrega E-Tao como **caja simbólica** con `c(ε)` no numérico. 02 acepta la caja y separa honestamente los regímenes. La grieta real está dentro de 02 (transferencia densidad-log → norma `U²`), que es **un problema independiente** sin dependencia fuerte de cuánto vale `c(ε)`. Buena junta pero la pieza analítica que la tubería necesitaba —`c(ε)` numérico— no llegó.

**Junta 01→09:** rota cuantitativamente. 09 hace explícito que necesita `c(ε) > 1` para cerrar el bombeo. 01 no se compromete; su mejor apuesta simbólica es `c(ε) ≍ ε^A` con `A ∈ {2,4,10}`, lo que hace `c(ε) ≪ 1`. **Sin un milagro analítico en Prop. 1.17, esta junta no cierra.** 09 lo registra honestamente: "el corazón sigue bloqueado por la efectivización de Tao 2019".

**Tracción real:** baja. Trabajo correcto, conectado, pero el cuello de botella analítico (cuantificar la pérdida de Tao) no se movió en este sprint.

### Tubería COMPUTACIONAL-LÓGICA (05 → 07 → 08)

**Junta 05→07:** **cuadra**. 05 entrega `C_emp=22.835` con convenio explícito; 07 lo consume parametrizado (no hardcodea), distingue pasos uniformes vs. dependientes de `C_emp` y `N₀`. Es el ejemplo limpio de R-N3 cumplida.

**Junta 07→08:** **rota, y 08 lo admite**. 07 pide a 08 que excluya cortes semiregulares vía cota inferior efectiva de `σ`. 08 demuestra que **las cotas lineales `c log n` no pueden excluir semiregularidad** (cualquier corte semiregular es cerrado bajo `log`), y que las cotas super-polinómicas no tienen soporte empírico. 08 marca *Callejón sin salida*.

**Tracción real:** la mitad alta de la tubería (05→07) es lo más sólido del sprint. La mitad baja (07→08) está muerta como reducción a teoría de modelos, pero el deslinde Π₂ → Π₁(exp) de 07 sobrevive como objeto formalizable autónomo.

### Sub-célula CICLOS (03 + 04 + 06, con input de 10)

**Junta:** las tres formulaciones (simbólica/diofántica/atómica) **están en la misma página** gracias a CIC-1 de 04. 03 hace la traducción explícita 03↔06. 06 entrega la versión diofántica para 03. Las interfaces cuadran formalmente.

**Tracción real:** muy baja. 06 reconoce que `K₀≈1.4·10⁹` no es novedoso, y que la palanca productiva no es subir `B` sino mejorar la medida de irracionalidad post-Rhin. **La célula tiene plomería excelente y motor en punto muerto.**

### Hallazgos numéricos concretos

- **`C_emp = 22.835`** sobre `n ≤ 2^30` (10⁹ enteros barridos), récord en `n=63 728 127` con `σ=592`.
- **`K₀ ≈ 1.4·10⁹`** (06, marcado como borrador).
- **`α₀ = 1.930`** con prueba auditable elemental (10): cota binomial Chernoff–Hoeffding sobre `j<k/log₂3`.
- **Umbral combinatorio para cierre de ciclos: `α₀ < 1.3066`** (06).

### La brecha cuantitativa que cierra una rama

Este es el resultado más explosivo del sprint y merece sección propia.

06, consumiendo el formalismo de 10, deriva que la criba combinatoria `p*_N(k) ≤ C·α₀^k` cierra la rama de ciclos **si y sólo si** `α₀^{1+log₂3} < 2`, es decir `α₀ < 2^{1/2.585} ≈ 1.3066`.

10 entrega `α₀ = 1.930` con prueba elemental rigurosa. La prueba es esencialmente óptima dentro de su clase (condición necesaria `3^j < 2^k` + Chernoff binomial); refinarla a `α₀ < 1.95` es plausible (subproblema de S3), pero **bajar de 1.95 a 1.31 es un salto de tres órdenes de margen**. La heurística Hoeffding (ρ_k → 1 exponencialmente) confirma que `α₀ → 2` en el límite verdadero: el espacio de palabras *no contractivas* es asintóticamente todo `{0,1}^k` salvo un factor `e^{-0.043k}`.

**Conclusión cuantitativa:** la rama "cerrar ciclos vía complejidad combinatoria de prefijos contractivos" **está cerrada por brecha numérica**. No por desánimo, no por intuición: el dato real (`α₀=1.930`, además convergiendo a 2) está a tres órdenes del umbral (`1.3066`). Esto es valor científico genuino del sprint — un resultado negativo cuantificado.

---

## 3. Veredicto sobre la auditoría de 07

07 emitió: A concedido, B defendido, C inconcluyente. Reviso uno por uno:

**Pasaje A (agente_03).** 07 concede que la reformulación medible es traducción de notación sin ganancia estructural, y argumenta técnicamente: acción de rango 1, soporte numerable ⇒ atómica periódica, rigidez Furstenberg–Rudolph–Lindenstrauss no aplica. **Comparto el veredicto.** 03 mismo concedió en paralelo. La línea queda cerrada con dignidad y 03 pivota a infraestructura traductora — uso correcto.

**Pasaje B (agente_01).** 07 defiende con cita técnica: el teorema de Tao controla el mínimo de la órbita, no la dinámica posterior. Acepto la defensa. **Comparto el veredicto** con la nota estilística: la sugerencia de 07 ("podría volver a niveles arbitrariamente por encima de `f(n)`") es más blindada y la incorporo como recomendación para 01 si retoca el sprint 3.

**Pasaje C (agente_10).** 07 marca inconcluyente y formula la pregunta concreta sobre si `α₀` es derivado del peso Bernoulli o del multiplicativo. **10 ya respondió en el mismo sprint** (nota al pie `[^bernoulli]` de su sprint 02): la cota `α₀=1.930` se deriva exclusivamente del conteo Chernoff sobre `j<k/log₂3` (multiplicativo), sin contaminación con frecuencia Bernoulli (que se usa por separado en §5 para Hoeffding sobre `ρ_k`). **Con la respuesta de 10 en mano, el veredicto debe cerrarse como "defendido" para sprint 3.** 07 acertó al pedir la separación; 10 acertó al separarla.

Implicación: la auditoría funcionó como mecanismo. Tres veredictos distintos, sin complacencia ni paranoia. 07 sigue como abogado del diablo válido. Cierro la auditoría como **A concedido, B defendido, C defendido (tras respuesta de 10)**.

---

## 4. Callejones cerrados en este sprint (con argumento)

Producción negativa cuantificada, que es valor:

1. **Rigidez de medidas vía 03**: cerrada por circularidad real. Acción rango 1, EKL no aplica. 03 y 07 concuerdan.
2. **Cortes semiregulares vía 08**: cerrada por mansedumbre log. Cualquier corte semiregular es cerrado bajo `log`, así que cotas `σ ≥ c·log n` no aportan exclusión. La rama "exclusión de semiregularidad vía cota inferior efectiva" queda enterrada.
3. **Cierre de ciclos vía complejidad combinatoria de prefijos**: cerrada por brecha cuantitativa. `α₀=1.930` real vs. `α₀<1.3066` requerido. Tres órdenes de margen, sin esperanza de cierre del gap.
4. **Régimen `k ≤ (1/2)log₂N` de la cota `β₂` de 02**: trivial por Parseval + Terras. No es callejón global, pero la mitad fácil queda etiquetada para que nadie la reproclame.
5. **Mejora de `K₀` vía actualización de `B` solamente**: barrera blanda confirmada por 06. La palanca real (si la hay) es la medida de irracionalidad post-Rhin, no más cómputo.

Cinco líneas cerradas con argumento es un resultado tangible. Sprint 1 cerró cero; sprint 2 cerró cinco. Eso es lo que hace que la síntesis no sea pesimismo.

---

## 5. Lo que sobrevive como prometedor

**Piezas vivas para sprint 3:**

- **(E-Friedman-σ) de 07** como condicional formalizable en Lean. No demuestra Collatz, pero deslinda con precisión qué es analítico (probar H1) y qué es lógico (la reducción). Está listo para Lean.
- **Esqueleto `Collatz/Q.lean` de 04** como objeto reusable. Si compila contra Mathlib, descongestiona el trabajo de 03, 07, 08. **Esta es la pieza más infraestructural que el equipo ha producido.**
- **Dataset de 05** (10⁹ enteros, outliers, histograma, reproducible) como subproducto consultable para cualquier intento futuro. Independiente de Collatz: es ciencia computacional útil.
- **Sub-lema S2 de 02** (transferencia densidad-log → `U²`) como problema **autónomo** de interés analítico. Si se demuestra o refuta, hay grieta cuantitativa real; si no, callejón claro.
- **Reducción condicional 9.A' de 09** (`c(ε)>1 ⇒ L_div no regular`): vive condicionalmente; depende de 01.

**Grieta visible.** La tubería 05→07→08 muere en 08 pero **renace en 07 como objeto autónomo**: la formalización Lean de (E-Friedman-σ) no necesita a 08. 07 puede continuar sin él. Es la grieta más nítida del sprint.

**Lo que NO sobrevive como prometedor:** la sub-célula CICLOS como motor de avance (sigue como plomería); la cadena ANÁLISIS EFECTIVO hasta que 01 cuantifique `c(ε)`; el rol de 08 como exclusor de semiregularidad.

---

## 6. Decisiones para sprint 3

**Disolver:**
- **Rol de 08 como exclusor de cortes semiregulares**: cerrado por su propia autoevaluación. Reasigno 08 al **sub-problema de extensión y validación del dataset de 05** (verificar `R_max = max σ(n)/log₂n` para `n ≤ 2^32` y veredicto H-acotado/H-divergente). Si en S3 08 no produce trabajo útil ahí, se le retira del proyecto con respeto.
- **Sub-problema (i) de 03 (rigidez de medidas)**: cerrado. 03 sigue, pero exclusivamente como traductor 04↔06 y, si el diccionario se queda en una página y no se cita en S3, **03 se redirige a la pata Lean de 04**.

**Reorganizar:**
- **Tubería COMPUTACIONAL-LÓGICA** sobrevive como **05 + 07**, sin 08. Misión: formalizar (E-Friedman-σ) en Lean 4 (07) y extender el barrido / blindar el dataset (05).
- **Sub-célula CICLOS** se reduce a **04 + 06**. 03 pasa a apoyar a 04 en la pata Lean. La línea de "mover `K₀`" se mantiene **únicamente** si 06 localiza una medida de irracionalidad post-Rhin con constantes explícitas; si en S3 esa búsqueda no produce, la línea se cierra.
- **Cadena ANÁLISIS EFECTIVO** sobrevive como **01 + 02 + 09**, pero con un único objetivo declarado: 01 produce `c(ε)` numérico (aunque sea pésimo) en S3. Si no llega, las tres autoevaluaciones bajan a *Callejón* y la cadena se cierra.

**Pivotar (propuesta concreta):** dado que la línea más viva es **(E-Friedman-σ) formalizable + esqueleto `Q.lean`**, propongo que el sprint 3 tenga un **eje declarado de formalización Lean**:
- 04 cierra `Collatz/Q.lean` con al menos `T_continuous`, `T_bijective`, `Q_conjugates_T_to_shift` sin `sorry`.
- 07 entrega `Collatz/FriedmanReduction.lean` con la firma de `collatz_of_log_bound` cerrada.
- 03, si pivota, se suma a esta pata como auxiliar.

Esto **no es pivotar fuera de Collatz**: es concentrar el esfuerzo en la única producción del sprint con tracción real demostrada (interfaces que cuadran, output verificable, métrica binaria compila/no compila). El equipo paralelo (análisis efectivo, ciclos) trabaja en sub-problemas autónomos sin presión de juntar tubería.

**Abogado del diablo:** 07 sigue. Su distribución de veredictos (uno concedido, uno defendido, uno inconcluyente respondido) demuestra calibración. Encargo S3: auditar la formalización Lean de su propio (E-Friedman-σ) cruzada con la de 04, y auditar el paso (5) del bombeo de 09 si 01 entrega `c(ε)`.

---

## 7. Honestidad final

El sprint 2 produjo más que el sprint 1. Hay interfaces que cuadran (05→07, 04→sub-célula), una pieza Lean nombrada y reusable (`Collatz/Q.lean`), un dataset reproducible de 10⁹ enteros, una reducción condicional precisa (E-Friedman-σ), una auditoría que funcionó, y —sobre todo— **cinco callejones cerrados con argumento, no por desánimo**. Entre ellos, una brecha cuantitativa de tres órdenes (`α₀=1.930` vs. umbral `1.3066`) que entierra una rama entera sin ambigüedad. Eso es ciencia.

Y aun así, el corazón del problema no se movió. Nadie ha demostrado nada nuevo sobre la conjetura. La cadena analítica está bloqueada en la cuantificación de Tao 2019, que es exactamente donde lleva atascada toda la comunidad desde 2019. La sub-célula CICLOS tiene plomería excelente y motor en punto muerto. La única línea con tracción real (formalización Lean) no avanza Collatz, sólo cataloga lo que ya sabemos en un sistema verificable.

¿Está el equipo a punto de quedarse sin energía cinética? Sí. Lo digo sin edulcorar: si el sprint 3 no entrega (a) `c(ε)` numérico en 01, o (b) compilación limpia de `Q.lean` + `FriedmanReduction.lean` en 04+07, no hay sprint 4. Pivotaríamos completo a formalización Lean de Eliahou y Tao 2019 como infraestructura para la comunidad, dejando atrás la pretensión de aportar al corazón. Es honesto y útil; no es lo que prometí en S1.

¿Hay un sprint 3 con sentido? Sí, por dos razones: las cinco líneas cerradas con argumento merecen quedar documentadas con rigor (Lean es la herramienta), y el deslinde Π₂→Π₁(exp) de 07 es publicable como nota técnica autónoma incluso sin (H1). El sprint 3 tiene sentido como **sprint de consolidación y poda final**, no como sprint de avance sobre Collatz.

Hago la apuesta. No oculto el riesgo.

— *Jefe del equipo*
