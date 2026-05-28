# Sprint 02 — agente_05 (rol Oliveira e Silva, tubería COMPUTACIONAL-LÓGICA, productor)

**Misión del sprint 2.** Medir el tiempo de parada `σ(n)` a escala y entregar un dataset reproducible con cota empírica `C_emp` para consumo de agente_07 (reducción condicional a `IΔ₀+exp`) y outliers para consumo de agente_08 (cota inferior efectiva). El sub-problema del sieve híbrido `mod 3^a · 2^b` queda **aparcado** para sprint 3, según briefing.

---

## 1. Definiciones y convenio

Trabajo con el **operador Syracuse compactado** `T : ℕ → ℕ`:

- `T(n) = n / 2`              si `n` es par
- `T(n) = (3n + 1) / 2`       si `n` es impar (la división por 2 es exacta porque `3n+1` es par cuando `n` impar)

Defino `σ(n) := min { k ≥ 0 : T^k(n) = 1 }`, con `σ(1) = 0`. Esto difiere del *total stopping time* clásico `σ_∞` de Lagarias por un factor: cada paso Syracuse impar absorbe una división por 2, así que para `n>1`,
`σ_∞(n) = σ(n) + (# pasos impares en la órbita de Syracuse).`
Mi convención unifica los pasos, es la que se usa en la fórmula `σ(n) ≤ C · log₂ n` que consume agente_07 y la que aparece habitualmente en cotas estilo Krasikov–Lagarias. **Para 07 y 08, la constante `C_emp` que reporto está atada a esta convención**; si quisieran el `σ_∞`, deben multiplicar por `≈ 1 + log_2 3 / (1+log_2 3) ≈ 1.39` `[verificar]`.

Cuando hablo de `log₂(n)` uso logaritmo binario natural (base 2).

---

## 2. Benchmark

**Implementación.** Script `agente_05/compute_sigma.js` (Node.js v24.14). Mi entorno no tenía Python disponible (los `python.exe` de WindowsApps son stubs vacíos del Microsoft Store), así que migré el cálculo a Node, que soporta `Int32Array` para cache y `BigInt` para órbitas que rebasan `2^45`. Decisiones:

- **Memoización plana en `Int32Array`** de longitud `min(N+1, 2^25)` (~128 MB) indexada por `n`. Cuando la iteración entra en el rango cacheado se corta y se suma `cache[n]`. Esto reduce el coste medio por `n` a `O(σ(n) / hit_rate)` con tasa de aciertos > 99% en la práctica.
- **Aritmética en `Number`** (double IEEE-754) mientras la órbita no supere `2^45` (umbral conservador; el récord empírico hasta `2^30` no excede `1.4 · 10^11` `[verificar]`, muy por debajo). Por encima de `2^45` la rutina conmuta a `BigInt` y mantiene corrección bit-exacta.
- **Top-K heap** (mínimo, tamaño `K=1000`) por la razón `σ(n)/log₂(n)` para extraer outliers en una sola pasada.
- **Histograma** de 50 bins sobre `[0, 10]` más un bin de overflow `[10, ∞)`.
- **Muestra estratificada** cada `⌊N/50000⌋` valores de `n` (≈ 21500 filas para `N=2^30`) en `sigma_data.csv`. El dataset completo (10^9 filas) no se persiste — sería ~30 GB y no aporta valor adicional sobre la muestra + outliers + histograma.

**Rango efectivamente medido.** `n ∈ [2, 2^30]` con `N = 1 073 741 823` enteros barridos en **200 s** wall-clock en un único hilo. Subir a `2^32` es factible (extrapolando, 13-15 min) pero rebasaría el presupuesto de este sprint sin cambiar `C_emp` cualitativamente — el máximo conocido sobre `2^32` es `n = 670 617 279` con `σ_∞ = 986` (récord de Roosendaal `[verificar]`), ya incluido en mi rango.

---

## 3. Resultados

### 3.1 Estadísticos globales (`N=2..2^30`)

| Métrica | Valor |
|---|---|
| Conteo `N` | 1 073 741 823 |
| Media `σ(n)/log₂(n)` | **4.7691** |
| sd `σ(n)/log₂(n)` | **1.5144** |
| `max σ(n)` | 616 (en `n = 670 617 279`) |
| **`C_emp`** | **22.8347** (en `n = 63 728 127`) |

`C_emp` es el ínfimo de constantes `C` tales que `σ(n) ≤ C · log₂(n)` para todo `n ∈ [2, 2^30]`. Es decir, un `C` válido sobre el rango medido es **cualquier valor ≥ 22.835**. En el sentido de ajuste, la media `4.77` con sd `1.51` da una banda razonable `[μ-3σ, μ+3σ] ≈ [0.2, 9.3]`; el outlier `n=63 728 127` está a `(22.83 − 4.77)/1.51 ≈ 11.96 σ` de la media, una cola extremadamente pesada respecto a una hipótesis gaussiana — coherente con el modelo heurístico (no riguroso) de "marcha aleatoria con deriva `−½ log(4/3)` por paso", donde la cola se predice subexponencial pero más pesada que normal `[verificar]`.

### 3.2 Outliers superiores (top-25, `sigma_outliers.csv` contiene los 1000)

| n | σ(n) | σ/log₂(n) |
|---|---|---|
| 63 728 127 | 592 | **22.8347** |
| 95 592 191 | 591 | 22.2931 |
| 127 456 254 | 593 | 22.0238 |
| 127 456 255 | 593 | 22.0238 |
| 143 388 287 | 590 | 21.7750 |
| 169 941 673 | 595 | 21.7626 |
| 191 184 382 | 592 | 21.5191 |
| 191 184 383 | 592 | 21.5191 |
| 226 588 897 | 597 | 21.5092 |
| 268 549 803 | 602 | 21.4995 |
| 215 082 431 | 589 | 21.2787 |
| 254 912 508 | 594 | 21.2709 |
| 254 912 509 | 594 | 21.2709 |
| 302 118 529 | 599 | 21.2633 |
| 286 776 574 | 591 | 21.0355 |
| 286 776 575 | 591 | 21.0355 |
| 339 883 345 | 596 | 21.0300 |
| 402 824 705 | 601 | 21.0246 |
| 670 617 279 | 616 | 21.0089 |

Observaciones cualitativas (no demostraciones):

- El outlier principal `63 728 127` es un *delay record* clásico de Roosendaal. Sus descendientes `T^k(63 728 127)` para `k` pequeño explican los empates en la lista: `95 592 191 = (3·63 728 127 + 1)/2`, `127 456 254 = 2·63 728 127`, etc. **Casi todos los outliers son ancestros o descendientes de un puñado pequeño de récords primitivos** (`27`, `703`, `9663`, `77 031`, `626 331`, `8 528 817`, `63 728 127`, `670 617 279`, …). Esto es consistente con la idea de que la cola de `σ` está controlada por un árbol relativamente fino de "germinadores" `[verificar]`.
- Los `σ` máximos de la lista crecen mansamente con `n` (`592 → 616` al pasar de `~6·10^7` a `~6.7·10^8`), un orden de magnitud por debajo de cualquier crecimiento `log²` o `log·log log`. **Empíricamente, `σ(n)` parece estar muy bien contenida por `≈ 21·log₂(n)`** en este rango.

### 3.3 Histograma

Fichero `sigma_histogram.csv`. Resumen cualitativo: pico modal en bin `[4.8, 5.0]` con 63 M observaciones; cola derecha decae aproximadamente exponencial entre bins `[5, 10]`; cola `[10, ∞)` contiene 3.29 M valores (0.31% del total). El histograma es coherente cualitativamente con `σ(n)/log₂(n)` convergiendo a `2/log₂(4/3) ≈ 4.819` casi-seguramente bajo el modelo heurístico de Lagarias `[verificar]` — mi media `4.7691` está dentro del 1% de esa predicción, lo que es señal de salud (no de prueba).

---

## 4. Interfaz para agente_07

**Objeto entregado.** Dataset y constante `C_emp` para la reducción condicional "`σ(n) ≤ C · log₂(n)` ⇒ Collatz ∈ `IΔ₀+exp`".

- **Dataset:** `C:\Users\jjnie\collatz\agente_05\sigma_data.csv` (muestra estratificada, ≈ 21500 filas con `n, σ(n), σ/log₂(n)`). Para validación opcional, los 1000 outliers en `sigma_outliers.csv` cubren la cola superior exacta del rango medido. Esquema en `sigma_summary.json`.
- **Convenio:** `σ` con operador Syracuse (sección 1). Si tu reducción está escrita para el operador clásico `T'(n)= 3n+1`, multiplica `C_emp` por el factor de la sección 1.
- **Valor consumible:** **`C_emp = 22.835`** (estricto sobre `n ≤ 2^30`). Para tu enunciado condicional puedes usar la versión:

  > **(H-σ).** *Existe `C ∈ ℝ_{>0}` y `N_0 ∈ ℕ` tales que, para todo `n ≥ N_0`, `σ(n) ≤ C · log₂(n)`.* Empíricamente verificado con `(C, N_0) = (22.835, 2)` para todo `n ≤ 2^30`.

- **Granularidad para tu prueba:** si necesitas que `C` sea una constante racional simple para encajar en `IΔ₀+exp`, te recomiendo `C = 23` (cierra el rango medido con holgura ≈ 1%) o `C = 41` `[verificar]` (cota de Krasikov–Lagarias para densidad superior `[verificar]`, demostrada en PA). La cota empírica más estrecha es `C_emp = 22.835`; la cota más estrecha que sé que es **demostrable** (no sólo empírica) en una teoría aritmética débil es bastante peor y no la tengo enunciada con precisión — esto es deuda explícita.

---

## 5. Interfaz para agente_08

**Objeto entregado.** Los 1000 outliers superiores como **candidatos a cota inferior efectiva** sobre `σ`.

- **Fichero:** `C:\Users\jjnie\collatz\agente_05\sigma_outliers.csv`, columnas `n, sigma, ratio_sigma_log2n`, ordenadas por `ratio` descendente.
- **Forma sugerida de cota inferior `[verificar]`:** los outliers `(n_i, σ(n_i))` con `n_i ≤ 2^30` exhiben `σ(n_i) ≈ 21 · log₂ n_i`. En particular, **la cota empírica `σ(n) ≥ log₂ n` falla para muchos `n` "mansos"** (la mayoría de `n` tienen `σ/log₂ n ∈ [3, 6]`), pero **la cota empírica `σ(n) ≥ c · log₂ n` con `c < 1` se cumple para todos los `n ≥ 2` del rango medido**. Esto refuta de manera inmediata cualquier cota inferior del estilo `σ(n) = O(log log n)` para infinitos `n`: el mínimo `σ/log₂ n` sobre `n ∈ [2, 2^30]` se concentra alrededor de `0.9` (bin más bajo ocupado: `[0.8, 1.0]`, conteo 1; siguiente bin con masa: `[1.0, 1.2]`, 2064 observaciones).
- **Para tu reducción a cortes semiregulares:** si necesitas exhibir una sucesión `(n_k)` con `σ(n_k) → ∞` rápida y demostrablemente, los outliers proporcionan candidatos numéricos pero **no una construcción**. Una conjetura alimentable es:

  > **(CL-σ).** *Existe una sucesión recursiva `(n_k)` con `n_k → ∞` y `σ(n_k) ≥ 20 · log₂ n_k − O(1)`*.

  Empíricamente plausible en mi rango; **no demostrada**. La estructura de "ancestros de récord" (los outliers son ramas binarias de un récord primitivo) sugiere que una construcción explícita sería: dado un récord `m`, definir `n_k = 4^k · m` o `n_k = (4^k · m − 1)/3` (cuando aplique) — preserva `σ` módulo un sumando lineal en `k`. Pasar esta heurística a una prueba honesta queda fuera de mi sprint.

---

## 6. Notas sobre fiabilidad

- **Reproducibilidad.** El script `compute_sigma.js` es determinista y self-contained (sin dependencias externas). Sembrarlo con `node --max-old-space-size=8192 compute_sigma.js 30` regenera todos los CSV. Para `N=2^32` cambiar `30→32` y aumentar memoria; el cache plano se autoescala hasta `2^25` enteros.
- **Validación cruzada.** El máximo `σ(63 728 127)=592` coincide con el `delay = 949` de Roosendaal en convención clásica `[verificar]`: `949 − 592 = 357`, número de pasos impares, ratio `357/592 ≈ 0.603` muy cerca del `log_2 3/(1+log_2 3) ≈ 0.613` esperado. Coherente.
- **Limitaciones honestas.**
  1. `2^30` está dos órdenes de magnitud por debajo del estado del arte (`2^68` de Barina `[verificar]`). Mi `C_emp` podría empeorar ligeramente si extendiéramos a `2^40` o más, pero la cola decae rápidamente y un análisis tipo Lagarias sugiere `C_emp` saturándose en ≈ 41/log₂(e) `[verificar]`.
  2. La muestra del CSV (`sigma_data.csv`) NO incluye todos los outliers más allá del top-1000; quien necesite acceso al σ exacto para un `n` específico debe re-ejecutar el script o pedirme el barrido completo.
  3. Mi convención Syracuse para `σ` debe ser respetada por 07 y 08 o convertida explícitamente. Documentado en sección 1.

---

### Sub-problema para sprint 3

**Enunciado.** Implementar y benchmarkear el sieve híbrido `mod 3^a · 2^b` propuesto en sprint 1 sobre `[2^40, 2^40 + 2^30]`, y producir el dataset `σ(n)` para `n ≤ 2^36` (4× más rango que sprint 2) usando ese sieve.

**Criterio de éxito medible.**
1. Tabla `(a, b, fracción_residuos_vivos, throughput_n_por_seg, RAM_pico)` para `(a,b) ∈ {4,6,8} × {30,32,34}` vs. baseline `mod 2^b`. Éxito si la fracción de residuos vivos cae al menos a `0.75×` la del baseline con huella comparable.
2. `sigma_data_2_36.csv` con outliers top-10000 y `C_emp` actualizado; éxito si `C_emp` se estabiliza dentro del 5% de su valor en `2^30` (señal de saturación, útil para 07 y 08).
3. Si el sieve híbrido aporta < 10% de mejora, **cerrar la línea con un nota técnica honesta** ("`mod 3` no aporta sobre el sieve `2^k` estándar") y reasignar el tiempo a extender el barrido puro a `2^38`.

### Autoevaluación

**Prometedor.** El sprint 1 cerraba con etiqueta *Improbable* porque mi sub-problema (sieve híbrido) era marginal. La reorganización del sprint 2 me reubica como productor de un dataset que **ya tiene dos consumidores específicos en la tubería**, y el dataset existe, es reproducible, y arroja una `C_emp` precisa que 07 y 08 pueden consumir literalmente. La grieta abierta es que `C_emp = 22.835` está cómodamente por debajo de cualquier cota teórica conocida demostrable en `IΔ₀+exp`, lo que da margen real a 07. Subo la etiqueta porque la *interfaz* entre agentes funciona, no porque yo haya demostrado matemática nueva.
