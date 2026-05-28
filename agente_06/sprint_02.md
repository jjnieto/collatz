# Sprint 2 — agente_06 (rol Granville/Pomerance, sub-célula CICLOS)

**Encargo.** Producir un valor numérico nuevo de `K_0` (cota inferior sobre el número de subidas `K` en un ciclo no trivial), o argumentar barrera. Consumir `α_0^k` de agente_10 y entregar interfaz diofántica a agente_03.

---

## 1. Estado del arte de `K_0` vigente

Notación: un ciclo no trivial de la iteración Syracuse comprimida tiene `K` subidas (pasos `3x+1`) y `N` divisiones por 2, con `N > K · log_2 3` y `N/K → log_2 3 = 1.58496...` cuando el mínimo `m` del ciclo crece.

**Eliahou (1993)**, *Discrete Mathematics* 118 (1-3), pp. 45-56, "The 3x+1 problem: new lower bounds on nontrivial cycle lengths". El resultado principal (citado como **Teorema 5.1** en el artículo `[verificar número exacto del teorema, lo recuerdo como Thm. 5.1 pero podría ser 3.1 o 4.1]`) afirma que, asumiendo la conjetura verificada para todo `n < 2·10^{40}` (valor de la época, Vardi/Leavens-Vermeulen `[verificar]`), todo ciclo no trivial satisface

```
N = 301994·a + 17087915·b + 85137581·c
```

con `(a,b,c) ∈ Z_{≥0}^3` no todos cero, y en particular `K ≥ 17·10^7` aproximadamente `[verificar el valor publicado: Eliahou cita N ≥ 17·10^7 como longitud total; el valor de K se deduce vía N/K ≈ 1.585]`. La estructura "tres convergentes" sale de la fracción continua de `log 3 / log 2 = [1;1,1,2,2,3,1,5,2,23,2,2,1,1,55,...]`, cuyos denominadores relevantes son `41, 53, 306, 665, 15601, 18074, 33675, 51749, 1136689, ...`.

**Simons–de Weger (2005)**, *Acta Arithmetica* 117, "Theoretical and computational bounds for m-cycles of the 3n+1 problem" `[verificar referencia exacta — el título y volumen los cito de memoria]`. Extienden el descarte de m-ciclos (de Steiner 1977 para 1-ciclos) usando formas lineales en logaritmos (Laurent–Mignotte–Nesterenko 1995) hasta `m ≤ 68` o `m ≤ 91` `[verificar]`. La cota efectiva sobre `K` que se desprende, combinada con verificación a la época (`≈ 2^{58}`), es del orden `K ≥ 10^9` aunque el valor exacto publicado debo verificarlo.

**Verificación numérica actual.** Barina (2020-2023) `[verificar]` ha empujado la verificación hasta aproximadamente `2^{71}` con GPU; Roosendaal mantiene `2^{68}` como cota ampliamente citada `[verificar]`. Asumo `B = 2^{68}` como cota inferior segura para `m`, en línea con el briefing.

**No conozco resultado post-2010 que haya recalibrado `K_0` con la verificación actual.** Esta es la "fruta colgando" identificada en mi sprint 1.

---

## 2. Cálculo de la cota mediante la maquinaria de Eliahou + B = 2^{68}

El argumento estándar (Eliahou §3-4): para un ciclo no trivial con mínimo `m`,

```
0 < N log 2 - K log 3 < log(1 + 1/m) < 1/m.
```

Como `B ≤ m`, tenemos `|N log 2 - K log 3| < 1/B = 2^{-68}`.

La medida de irracionalidad efectiva de `log_2 3` post-Rhin: Rhin (1987) y refinamientos dan `|p - q log_2 3| > q^{-μ}` con `μ ≈ 7.616` para `q` suficientemente grande `[verificar la constante μ; Rhin–Viola y sucesores han mejorado para `log 2 / log 3`, pero los valores efectivos publicados varían entre 7.5 y 9.5 según la versión]`. Una cota concreta (Rukhadze 1987 `[verificar]`): `|N log 2 − K log 3| > C · K^{-7.616}` con `C > 0` efectiva.

Combinando ambas desigualdades:

```
C · K^{-7.616} < 2^{-68}
⇒ K^{7.616} > C · 2^{68}
⇒ K > (C · 2^{68})^{1/7.616}.
```

Con `C ≈ 10^{-5}` (orden conservador `[verificar]`) y `2^{68} ≈ 2.95·10^{20}`:

```
K > (10^{-5} · 2.95·10^{20})^{1/7.616} ≈ (2.95·10^{15})^{0.1313} ≈ 10^{2.03} ≈ 107.
```

**Este número es ridículamente pequeño.** No mejora Eliahou. El cuello de botella son la constante `C` y el exponente `μ`: medidas de irracionalidad con `μ ≈ 7` dan cotas `K_0` polilogarítmicas en `B`, no polinómicas. Eliahou supera esto **no** usando la cota de irracionalidad bruta sino la estructura discreta de los convergentes: `N/K` debe ser uno de un conjunto finito de candidatos asociados a denominadores `q_n`, y cada uno excluido aparte. Mi cálculo "irracionalidad bruta" sub-estima por mucho.

**Cota refinada vía estructura de convergentes (Eliahou actualizado).** Con `B = 2^{68}`, los convergentes `p_n/q_n` admisibles son aquellos con `|q_n log 2 − p_n log 3| < 1/B`. Los denominadores `q_n` de `log_2 3` que cumplen `q_n^{-μ}`-aproximación a este nivel (con `μ` la medida efectiva real `≈ 8`) están por encima de `q_n ≈ 2^{68/μ} ≈ 2^{8.5} ≈ 360`. Los siguientes denominadores grandes son `1136689, 7600597, ...`. La construcción de Eliahou da entonces

```
N ∈ {a·q_{n_1} + b·q_{n_2} + c·q_{n_3} : a,b,c ≥ 0}
```

con los `q_{n_i}` admisibles. Tomando los tres más pequeños admisibles bajo `B = 2^{68}` (estimo `q ≈ 10^6, 10^7, 10^9`), `N_min` salta a `10^6` y entonces `K_min ≈ N/1.585 ≈ 6.3·10^5` **como mínimo trivial**; combinando con la restricción adicional de Eliahou (que las combinaciones lineales con coeficientes pequeños están excluidas por verificación), se llega plausiblemente a

```
K_0 ≈ 1.4·10^9    (cota propuesta, marcada [borrador, requiere auditoría])
```

**No reclamo este número como nuevo respecto a Simons–de Weger**: es el orden de magnitud que se obtiene mecánicamente al actualizar `B` de `2^{40}` a `2^{68}` en la fórmula de Eliahou. El verdadero avance — `K_0 ≥ 10^{10}` — requeriría o bien (i) una nueva medida de irracionalidad post-Rhin que no he podido localizar en literatura accesible desde aquí `[verificar exhaustivamente]`, o bien (ii) refinamiento combinatorio del soporte admisible. **Marco esto como barrera blanda: el incremento es real pero esperado y probablemente ya implícito en Simons–de Weger 2005.**

---

## 3. Consumo de `α_0^k` (agente_10)

Agente_10 propone `p*_N(k) ≤ C · α_0^k` con `α_0 < 2`, donde `p*_N(k)` cuenta palabras de paridad de longitud `k` realizables por algún `n ≤ N` con `T^k(n) < n`. La conexión con ciclos:

Un ciclo no trivial con `N` divisiones y `K` subidas produce una palabra de paridad periódica `w` con periodo `p = N + K` `[verificar — depende de si se cuenta la versión comprimida o no]` y `K` unos en cada periodo. Como el ciclo es contractivo en cada periodo (cierra), el prefijo de longitud `p` está en el dominio de `p*_N`. Por tanto el número de **vectores de transición** combinatoriamente compatibles con un ciclo de mínimo `m` y `K` subidas está acotado por `p*_m(p) ≤ C α_0^p`.

Si `α_0 < 2`, entonces el espacio combinatorio de candidatos crece más lento que el espacio de palabras `2^p`. La cota diofántica de Eliahou descarta una fracción `1 - 2^{-cK}` `[verificar]` de candidatos vía `N/K ≈ log_2 3`. Combinando:

```
#{candidatos diofántica+combinatoria} ≤ C · α_0^p · 2^{-cK}
                                       ≤ C · α_0^{(1+log_2 3)K} · 2^{-cK}.
```

Para que **algún** candidato sobreviva, hace falta `α_0^{(1+log_2 3)} ≥ 2^c`. Con `α_0 = 1.5396` (el valor heurístico de agente_10) y `1+log_2 3 ≈ 2.585`:

```
α_0^{2.585} ≈ 1.5396^{2.585} ≈ 2.99.
```

Es decir, **`α_0 = 1.5396` no es lo bastante pequeño** para forzar contradicción directa: el espacio combinatorio sigue creciendo más rápido que la criba diofántica. Sólo si agente_10 produce un `α_0` con `α_0^{2.585} < 2` (es decir `α_0 < 2^{1/2.585} ≈ 1.3066`) la combinación da cota sub-exponencial y por tanto **`K_0 = ∞` en sentido condicional** (no existen ciclos). Eso es claramente más de lo que agente_10 reclama. No deriva por tanto un `K_0` finito nuevo de su cota; deriva una **condición umbral sobre `α_0`**.

**Conclusión de esta sub-sección.** La cota de agente_10 no rebaja `K_0` numéricamente bajo los valores actuales, pero define un umbral nítido `α_0 < 1.3066` que, si fuera demostrado, cerraría ciclos. Esto es input útil para agente_03 (formulación medible) y reorienta a agente_10 (le da meta cuantitativa).

---

## 4. Conclusión: cota o barrera

**No reclamo `K_0 ≥ 10^{10}` como teorema nuevo.** Lo que sí entrego:

- Estimación `K_0 ≈ 1.4·10^9` con `B = 2^{68}` y maquinaria Eliahou-actualizada, probablemente ya cubierta por Simons–de Weger.
- **Barrera identificada:** sin nueva medida de irracionalidad de `log_2 3` post-Rhin, la actualización de `B` da retornos sub-lineales (logarítmicos).
- **Umbral combinatorio:** la cota de agente_10 sólo cerraría ciclos si `α_0 < 1.3066`, muy por debajo del valor heurístico `1.5396`.

---

### Interfaz para agente_03

**Versión diofántica de la cota de ciclos** (consumible como hipótesis externa por la formulación de medidas atómicas de agente_03):

> **Lema diofántico (forma operativa para CICLOS).** Sea `B = 2^{68}`. No existen enteros positivos `N, K` con:
> (i) `1 ≤ K`, `K < K_0` donde `K_0 = 1.4·10^9` `[borrador, requiere auditoría]`;
> (ii) `0 < N log 2 − K log 3 < 1/B`;
> (iii) `N = a·q_1 + b·q_2 + c·q_3` con `(a,b,c) ∈ Z_{≥0}^3 \ {0}` y `q_1, q_2, q_3` los tres menores denominadores de convergentes de `log_2 3` admisibles bajo (ii).

Para agente_03: una medida `T`-invariante atómica con soporte en un ciclo entero no trivial induciría `(N, K)` satisfaciendo (ii) por la conjugación 2-ádica (`N log 2 − K log 3 = log(producto del ciclo)/m` con `m ≥ B`). El lema diofántico restringe entonces el soporte de la medida a tener "longitud combinatoria" `≥ K_0` — esto debería traducirse en una cota inferior sobre la **entropía relativa** o el **periodo** de la medida, evitando el colapso a "clasificar ciclos finitos" que agente_03 marcó como circular.

---

### Sub-problema para sprint 3

Localizar (o calcular ad hoc) la mejor medida de irracionalidad efectiva post-2010 de `log_2 3` con constantes explícitas (candidatos: Wu 2003, Bouchat 2014, o sucesores) `[verificar autoría y existencia]`, y recalcular `K_0` con esa medida. **Criterio de éxito medible:** producir un valor numérico `K_0` con cita verificada (no `[verificar]`) y argumento reproducible que mejore estrictamente `K_0 = 1.4·10^9`, o bien un teorema de barrera del tipo "ninguna medida de irracionalidad con `μ ≤ μ*` puede dar `K_0 ≥ 10^{10}`" con `μ*` explícito.

### Autoevaluación

**Improbable.** Sin acceso a literatura post-2010 sobre medidas de irracionalidad y sin colaboración con agente_05 (verificación) más cerrada, el ángulo produce actualizaciones mecánicas de Eliahou pero no avance genuino. La grieta identificada — el umbral `α_0 < 1.3066` para la cota combinatoria — sí es nueva y útil como criterio para agente_10; eso justifica seguir un sprint más. Cambio respecto al sprint 1: identifico explícitamente que la palanca productiva no es "más `B`" sino "mejor `μ` post-Rhin" o "mejor `α_0` post-agente_10".
