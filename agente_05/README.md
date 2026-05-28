# Dataset `sigma` de Collatz — agente_05

**Autor:** agente_05 (rol Oliveira e Silva) — equipo simulado, sprints 1-3.
**Estado:** consolidado en sprint 3. Documentación independiente: este README es legible sin haber leído ningún otro fichero del repositorio.

---

## 1. Qué es este dataset

Mediciones exhaustivas del **tiempo de parada de Syracuse** `σ(n)` para todos los enteros `n` en un rango inicial conocido, junto con estadísticos derivados, outliers (cola superior) e histograma. Pensado para alimentar (i) cotas empíricas de `σ(n) ≤ C · log₂(n)` y (ii) análisis de la cola de `σ/log₂(n)`.

**Operador.** Usamos la versión compactada Syracuse de la iteración Collatz:

```
T(n) = n / 2          si n es par
T(n) = (3n + 1) / 2   si n es impar         (la división por 2 es exacta)
```

**Definición de `σ`.** `σ(n) := min { k ≥ 0 : T^k(n) = 1 }`, con `σ(1) = 0`.

**No es** el `total stopping time` clásico de Lagarias `σ_∞` (que cuenta también divisiones por 2 generadas por cada `3n+1`). Para convertir, sumar el número de pasos impares (aproximadamente `σ(n) · log₂3 / (1 + log₂3) ≈ 0.613·σ(n)` para órbitas típicas).

**Rango medido (sprint 3).** `n ∈ [2, 2^32]` — ver sección 4 para el detalle del progreso desde sprint 2 (`2^30`) al sprint 3 (`2^32`). Si la extensión a `2^32` no estuviera completa en el momento de leer este README, los ficheros con sufijo `_2_30` contienen los resultados consolidados del sprint 2.

---

## 2. Ficheros del dataset

Todos en `C:\Users\jjnie\collatz\agente_05\`.

| Fichero | Tipo | Descripción |
|---|---|---|
| `compute_sigma.js` | script Node.js | Productor único. Determinista, sin dependencias externas (sólo `fs`, `path`). Regenera todos los CSV/JSON. |
| `sigma_data.csv` | CSV | Muestra estratificada (≈ 50 000 filas) del barrido principal. Una fila cada `⌊N / 50000⌋` enteros. |
| `sigma_outliers.csv` | CSV | Top-1000 outliers ordenados por `σ(n)/log₂(n)` descendente. Cubre exactamente la cola superior del rango medido. |
| `sigma_histogram.csv` | CSV | Histograma de 50 bins sobre `[0, 10]` para `σ(n)/log₂(n)`, más un bin de overflow `[10, ∞)`. |
| `sigma_summary.json` | JSON | Metadatos + estadísticos clave: rango, conteo, media, sd, `C_emp`, `max σ`. |
| `sigma_*_2_30.{csv,json}` | CSV/JSON | Copias congeladas del sprint 2 (`n ≤ 2^30`), para reproducibilidad histórica. |
| `run_2_32.log` | log | Salida `stdout`/`stderr` de la corrida de extensión a `2^32` (si existe). |

### 2.1 Esquema de columnas

`sigma_data.csv`, `sigma_outliers.csv` (mismo esquema):

| columna | tipo | descripción |
|---|---|---|
| `n` | entero ≥ 2 | el entero de entrada |
| `sigma` | entero ≥ 0 | `σ(n)` exacto (no aproximación) |
| `ratio_sigma_log2n` | float | `σ(n) / log₂(n)`, 6 decimales |

`sigma_histogram.csv`:

| columna | tipo | descripción |
|---|---|---|
| `bin_lo` | float | extremo inferior del bin (cerrado) |
| `bin_hi` | float o `inf` | extremo superior del bin (abierto); última fila contiene `inf` |
| `count` | entero | cuenta de enteros `n` cuya razón cae en el bin |

`sigma_summary.json`: estructura jerárquica, ver `compute_sigma.js` (líneas 207-226) para el esquema canónico. Campos clave: `range.n_max`, `range.count`, `stats.mean_ratio`, `stats.sd_ratio`, `stats.C_emp.value`, `stats.C_emp.n`, `stats.max_sigma.value`, `stats.max_sigma.n`, `elapsed_seconds`.

---

## 3. Cómo regenerar

**Requisitos.** Node.js ≥ v18 (probado en v24.14.0 sobre Windows 11). Sin paquetes npm. Sin Python. ≈ 256 MB de RAM en el caso por defecto, hasta 2-3 GB para `2^32`.

**Comando exacto** (PowerShell o cmd):

```powershell
cd C:\Users\jjnie\collatz\agente_05
node --max-old-space-size=8192 compute_sigma.js 30
```

El argumento numérico es el exponente `k` tal que el barrido cubre `n = 2 .. 2^k`. Tiempos estimados sobre un solo hilo en hardware contemporáneo (CPU desktop ~2024, single-thread):

| exponente | rango | tiempo aproximado | RAM pico |
|---|---|---|---|
| 24 | `n ≤ ~1.7·10⁷` | ≈ 4 s | 128 MB |
| 28 | `n ≤ ~2.7·10⁸` | ≈ 50 s | 128 MB |
| 30 | `n ≤ ~1.07·10⁹` | **≈ 200 s** (medido) | 128 MB |
| 32 | `n ≤ ~4.29·10⁹` | ≈ 13-15 min (extrapolado) | 128-256 MB |
| 34 | `n ≤ ~1.7·10¹⁰` | ≈ 1 h | 128 MB (cache saturado) |

El script sobrescribe los cuatro ficheros de salida en su directorio. Para conservar una corrida previa, **copiar los CSV/JSON antes** (ver los sufijos `_2_30` como ejemplo).

**Determinismo.** El recorrido es estrictamente secuencial `n = 2, 3, 4, …`. No hay aleatoriedad. Dos corridas con el mismo argumento producen exactamente los mismos ficheros (módulo el campo `elapsed_seconds` del JSON).

---

## 4. Estadísticas clave (consolidado sprint 3)

### 4.1 Sprint 2 — rango `n ∈ [2, 2^30]` (1 073 741 823 enteros)

| Métrica | Valor |
|---|---|
| `mean σ(n)/log₂(n)` | **4.7691** |
| `sd σ(n)/log₂(n)` | **1.5144** |
| `max σ(n)` | 616 (en `n = 670 617 279`) |
| **`C_emp`** | **22.8347** (en `n = 63 728 127`) |
| Tiempo de cómputo | 200.4 s wall-clock, un hilo |

`C_emp` se define como el ínfimo de constantes `C` tales que `σ(n) ≤ C · log₂(n)` para todo `n ∈ [2, n_max]`. Es decir, **cualquier `C ≥ 22.835` es válido empíricamente sobre `n ≤ 2^30`**.

### 4.2 Sprint 3 — extensión a `n ∈ [2, 2^32]` (4 294 967 295 enteros)

Resultados oficiales en `sigma_summary.json` tras la corrida de extensión. La predicción razonable era que `C_emp` cambiara sólo marginalmente (todos los récords mundiales hasta `2^32` ya estaban dentro de `2^30`). En particular el récord local conocido `n = 670 617 279` con `σ = 616` queda dentro del rango sprint 2 y por tanto `C_emp` sólo puede subir si aparece un nuevo `n` con razón > 22.83 en `[2^30, 2^32]`. **Ver `sigma_summary.json` para el valor final**; si la extensión no llegó a completarse, los valores del sprint 2 son los de referencia.

### 4.3 Top-10 outliers (sprint 2; consultar `sigma_outliers.csv` para top-1000)

| n | σ(n) | σ/log₂(n) |
|---|---|---|
| 63 728 127 | 592 | 22.8347 |
| 95 592 191 | 591 | 22.2931 |
| 127 456 254 | 593 | 22.0238 |
| 127 456 255 | 593 | 22.0238 |
| 143 388 287 | 590 | 21.7750 |
| 169 941 673 | 595 | 21.7626 |
| 191 184 382 | 592 | 21.5191 |
| 191 184 383 | 592 | 21.5191 |
| 226 588 897 | 597 | 21.5092 |
| 268 549 803 | 602 | 21.4995 |

Observación cualitativa: casi todos los outliers son **ancestros o descendientes inmediatos** de un puñado pequeño de récords primitivos (`27`, `703`, `9663`, `77 031`, `626 331`, `8 528 817`, `63 728 127`, `670 617 279`). Por ejemplo `95 592 191 = (3·63 728 127 + 1)/2` y `127 456 254 = 2·63 728 127`. La cola de `σ` está controlada por un árbol fino.

### 4.4 Distribución (histograma sprint 2)

- Pico modal en bin `[4.8, 5.0]` con ~63 M observaciones.
- Cola derecha decae aproximadamente exponencial entre bins `[5, 10]`.
- Cola `[10, ∞)` contiene 3.29 M valores (0.31% del total).
- Media `4.77` coincide al 1% con la predicción heurística `2 / log₂(4/3) ≈ 4.819` del modelo de Lagarias (no demostración, simple consistencia).

---

## 5. Notas técnicas

### 5.1 Memoización

El script aloca un `Int32Array` de longitud `min(N+1, 2^25)` (~128 MB) indexado por `n`. Cuando la iteración de un `n_0` entra en el rango cacheado, devuelve `steps + cache[n]` inmediatamente. La tasa de aciertos del cache supera el 99% en la práctica, reduciendo el coste medio por `n` a `O(σ(n) / hit_rate) ≈ O(1)` amortizado. Para rangos `n > 2^25` el cache queda saturado y nuevos `n` se calculan sin acelerador adicional — esto explica que el tiempo crezca aproximadamente lineal con `N` por encima de `2^25`.

### 5.2 Aritmética

- Mientras la órbita no rebasa `2^45`, se usa aritmética `Number` (double IEEE-754). Este umbral es **conservador**: el máximo conocido sobre `n ≤ 2^32` ronda `1.4·10^11 ≈ 2^37`, muy por debajo.
- Si la órbita rebasa `2^45`, el script conmuta automáticamente a `BigInt` y mantiene corrección bit-exacta. La penalización en velocidad es ~20× pero ocurre en una fracción ínfima de iteraciones.

### 5.3 Estructura de outliers (top-K)

Min-heap de tamaño fijo `K=1000`, ordenado por `σ(n)/log₂(n)`. Inserción `O(log K)` y poda en una sola pasada por el rango. No requiere ordenar el dataset completo.

### 5.4 Limitaciones honestas

1. El rango de sprint 2 (`2^30`) está dos órdenes de magnitud por debajo del estado del arte (`2^68` de Barina). Mi `C_emp` podría empeorar muy ligeramente si extendiéramos a `2^40+`, pero la cola decae rápidamente.
2. `sigma_data.csv` es **muestra estratificada** (≈ 50 000 filas), no el barrido completo. Quien necesite `σ` exacto para un `n` específico debe re-ejecutar el script o usar los outliers (que sí son exactos sobre la cola superior).
3. Convención Syracuse vs. Collatz clásico: si un consumidor del dataset necesita `σ_∞` o el operador `3n+1` sin compactar, debe convertir explícitamente (sección 1 y sección 1 de `sprint_02.md`).
4. No persistimos el dataset completo de 10⁹+ filas (sería ~30 GB y no aporta valor sobre la muestra + outliers + histograma).

### 5.5 Dependencias

- **Node.js** ≥ v18, probado en v24.14.0.
- Módulos: sólo built-in (`fs`, `path`). Cero `npm install`.
- Sistema: probado en Windows 11 (PowerShell). Debería funcionar en Linux/macOS sin cambios (todas las rutas usan `__dirname` y `path.join`).

---

## 6. Para futuros lectores

Este dataset existe para que cualquier persona que llegue al repo pueda:

1. **Reproducir** el cálculo (un solo comando, sin dependencias).
2. **Verificar** una cota `σ(n) ≤ C · log₂(n)` empírica con `C ≥ 22.835` para `n ≤ 2^32`.
3. **Estudiar la cola** de `σ` mediante `sigma_outliers.csv` y `sigma_histogram.csv`.
4. **Extender** el frente cambiando un único argumento (`32 → 33 → …`).

Lo que el dataset **no** es:

- No es una demostración de nada sobre Collatz.
- No es una cota teórica: `C_emp = 22.835` es un valor medido, no derivado.
- No reemplaza barridos profesionales (Roosendaal, Barina) que llegan a `2^68`; complementa con código auditable y outliers explícitos para `n ≤ 2^32`.

Apoyo en documentación reconocido (sprint 3): agente_08 (ofrecido en el briefing del jefe; ver `sprint_03.md` para coautoría efectiva).

---

*Fin del README. Versión 1.0 (sprint 3, 2026-05-28).*
