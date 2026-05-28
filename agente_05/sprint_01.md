# Sprint 01 — agente_05 (rol Oliveira e Silva, Célula 3)

**Ángulo:** verificación numérica masiva de la conjetura de Collatz. No demostramos nada; empujamos el frente de búsqueda de contraejemplos (ciclos no triviales u órbitas que escapan) y publicamos *no-existencia abajo de N*. La diferencia con el agente_06 es nítida: él acota teóricamente la longitud mínima de un ciclo hipotético usando aproximaciones diofánticas a `log 3 / log 2`; yo verifico algorítmicamente y reporto récord y coste marginal.

---

## 1. Estado del arte de la verificación

El récord publicado más alto que conozco con confianza es el de **David Barina** (artículo en *Journal of Supercomputing*, 2020-2021 `[verificar]`): convergencia comprobada para todo `n < 2^68`, sustituyendo la marca anterior de **Oliveira e Silva** en `~2^60` (`5.764 × 10^18`, alrededor de 2008-2009 `[verificar]`). Roosendaal mantiene en su web `ericr.nl/wondrous` una página de récords y *delay records* que históricamente ha funcionado como tabla viva del frente; el último valor que recuerdo allí es coherente con `~2^68` (`[verificar]`).

Las técnicas estándar, en orden de impacto:

1. **Sieve por residuos módulo 2^k.** En vez de iterar cada `n`, se observa que el destino tras `k` pasos sólo depende de `n mod 2^k`. Se precomputa una tabla `T[r]` con (a) el "valor de salida" y (b) el "multiplicador / divisor" tras `k` pasos para cada residuo `r ∈ [0, 2^k)`. Sólo hay que iterar sobre los `r` cuya trayectoria de `k` pasos no haya bajado de `n` (los demás son "convergentes garantizados" porque cualquier órbita que baja de su valor inicial está cubierta por la verificación previa). Esto poda típicamente >99% del rango para `k ≈ 30-40` (`[verificar]` la fracción exacta).
2. **Saltos congruenciales largos.** En lugar de un paso `n → 3n+1` ó `n/2`, se aplica el operador **Syracuse** `T(n) = (3n+1)/2^v2(3n+1)` ó incluso un operador compuesto que avanza varios bits *garantizados* impares de golpe. La aritmética se realiza con multiplicación entera de 128 bits (o 192) y se utiliza el contador `popcount`/`ctz` para extraer `v2` en una instrucción.
3. **Aritmética sin ramas + SIMD/GPU.** Barina explota AVX-512 y, en versiones posteriores, GPU. La iteración Collatz es paralela en `n`, no en pasos: cada hilo lleva su propio `n` y el host hace *gather* del sieve. La latencia de memoria (la tabla `T[r]` con `k = 32` ocupa 32 GiB si guardas 64 bits, demasiado para caché L3) es el cuello de botella real (`[verificar]` cifras).
4. **Detección temprana de coalescencia.** Si dos `n` distintos en el lote actual aterrizan en el mismo valor intermedio, se fusionan. En la práctica se usa una tabla hash de "valores ya verificados en este lote" o un Bloom filter; ahorra factor constante, no asintótico.

El **coste marginal de subir un bit** es lineal en el tamaño del rango (doblar `N` dobla trabajo) modulado por el sieve. Con un sieve `2^k` la constante mejora por un factor `(fracción de residuos vivos)^-1`, pero el sieve cuesta `O(2^k)` en RAM. Hay un óptimo plano entre `k = 32` y `k = 40` (`[verificar]`). Más allá, el sieve no cabe en memoria y hay que comprimirlo (estructuras tipo *bitset* con metadatos resumidos).

---

## 2. Lo que huele a muerto

- **Verificar "más alto y ya".** Saltar de `2^68` a `2^70` es una mejora honesta pero no estructural: cuesta proporcionalmente, no enseña matemática nueva. El valor publicable está en la *técnica*, no en el número.
- **Heurísticas tipo "ya casi llegamos".** A `2^68 ≈ 3 × 10^20`, comparado con la cota inferior teórica para la longitud de un ciclo no trivial (millones o miles de millones de pasos, vía Eliahou y descendientes `[verificar]`), seguimos a años-luz de cualquier evidencia decisiva. Decir "casi" es ruido.
- **GPU bruto sin sieve.** Un kernel CUDA que itera Collatz sin sieve pierde frente a un AVX-512 bien hecho. Lo confirma la literatura `[verificar]`.

---

## 3. Propuesta concreta: sieve `mod 3^a · 2^b` con factorización del operador Syracuse

La función Syracuse `T(n) = (3n+1)/2^v` mezcla la estructura `mod 2^k` (controla `v`) con la estructura `mod 3^j` (controla cuántos pasos `3n+1` se han aplicado). Los sieves clásicos usan sólo `2^k`. Mi hipótesis es que un sieve combinado `mod 3^a · 2^b` permite detectar bloques convergentes adicionales, porque el numerador acumulado `3^a · n + c(a,b)` con `c` determinado por el patrón de paridades de longitud `a+b` cae en clases residuales `mod 3^a` que se pueden tabular.

Pseudocódigo ilustrativo (no ejecutado):

```c
// k pasos del operador Syracuse aplicado a residuo r mod 2^k.
// Devuelve (multiplicador A, sumando C, divisor D=2^k) tal que
// T^k(n) = (A*n + C) / D para todo n con n ≡ r (mod 2^k),
// asumiendo que el patrón de paridades coincide con el de r.
typedef struct { uint128 A, C; int D; } step_t;
step_t precompute_step(uint64 r, int k);
```

El sieve combinado descarta `r` cuyo `T^k(r)` ya sea `< 2^k` (convergencia garantizada por inducción) **y** cuyo `A mod 3^a` caiga en una clase residual marcada como "siempre convergente abajo" en un sieve auxiliar `mod 3^a` precalculado. La intuición es que doblar el módulo añade información de un factor que el sieve `2^k` ignora.

**Criterio de éxito empírico:** mostrar, en un benchmark sobre `[2^30, 2^34]`, que el sieve combinado reduce el número de `n` que requieren iteración explícita en al menos **25%** frente al sieve `2^k` puro con la misma huella de memoria. Si el ahorro no llega al 10%, la idea se cierra.

Adicionalmente, propongo una **estructura de coalescencia incremental**: en lugar de Bloom filter por lote, un *radix trie* de prefijos binarios de altura `h ≈ 24` que indexa "valores intermedios ya visitados en cualquier lote previo del shard actual". Esto requiere medir si la tasa de aciertos compensa la presión de caché.

---

### Sub-problema para sprint 2

Implementar y benchmarkear un sieve híbrido `mod 3^a · 2^b` para verificación Collatz, con `a ∈ {4,6,8}` y `b ∈ {30,32,34}`, contra el sieve `mod 2^b` puro.

**Criterio de éxito medible:**
- *Métrica primaria:* fracción de residuos vivos tras el sieve, medida sobre los `2^b` (o `3^a · 2^b`) residuos. Éxito si la fracción cae al menos **0.75×** la del sieve `2^b` puro con huella de memoria comparable (±2×).
- *Métrica secundaria:* iteraciones Collatz por segundo en single-thread x86-64 con AVX2, sobre el intervalo de prueba `[2^40, 2^40 + 2^30]`. Éxito si el rendimiento neto (tras contar coste del sieve más grande) sube ≥ **15%**.
- *Entregable:* tabla `(a, b, fracción_viva, throughput, RAM)` y código de referencia ≤ 800 líneas C reproducible.

### Autoevaluación

**Improbable.** El sieve `mod 2^k` está muy refinado tras dos décadas; arañar 15-25% con un módulo mixto es plausible pero no transformador, y otros (Barina incluido) probablemente lo han intentado sin publicarlo. Sigo porque incluso un resultado nulo bien medido — *"el módulo 3 no aporta"* — cierra una pregunta abierta de folclore y libera a la célula para atacar el cuello de botella real, que es ancho de banda de memoria, no aritmética.
