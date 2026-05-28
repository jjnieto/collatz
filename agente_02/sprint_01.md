# Sprint 01 — agente_02 (rol Maynard/Green)

**Célula 1 — análisis y probabilidad. Ángulo: métodos aditivos y sumas exponenciales.**

Mi encargo no es refinar Tao 2019 (eso lo hace agente_01). Yo aporto **maquinaria externa**: ¿qué pueden decir las herramientas que Green–Tao y Maynard han desarrollado para primos sobre la iteración 3n+1?

---

## 1. Estado del arte breve

### 1.1. El objeto natural: el paridad-vector de Terras

Para `n` impar, defínase la **función de Syracuse** `Syr(n) = (3n+1)/2^{v_2(3n+1)}`, donde `v_2` es la valuación 2-ádica. Iterando, asociamos a `n` su paridad-vector `(a_1, a_2, …, a_k) ∈ N^k` con `a_i = v_2(3n_i + 1)`. Terras (1976) y Everett (1977) demostraron que, para `n` recorriendo `[1, 2^k]`, los `2^k` paridad-vectores de longitud `k` son **todos distintos** y se distribuyen uniformemente módulo `2^k`. Ése es el sustrato probabilístico que Tao 2019 explota con técnicas de transferencia logarítmica.

### 1.2. ¿Por qué pensar en sumas exponenciales?

Una vez fijado el paridad-vector `(a_1, …, a_k)`, el valor final es

```
Syr^k(n) = (3^k · n + C(a_1,…,a_k)) / 2^{a_1+…+a_k}
```

donde `C` es un polinomio explícito en `3` y `2`. Es decir, **a paridad-vector fija, la iteración es afín**. Si uno suma exponenciales tipo `e(α · Syr^k(n))` sobre `n ∈ [N, 2N]`, cada rama afín contribuye una progresión aritmética, y aparecen sumas geométricas `Σ e(α · 3^k n / 2^A)` con `A = a_1+…+a_k`. Esto huele a **Vinogradov / Weyl** vía la mezcla de bases coprimas 2 y 3.

### 1.3. Lo que ya se ha intentado (y donde está la sangre)

- **Sinai, Kontorovich** (~2002–2013) [`verificar`]: introdujeron la perspectiva de la iteración como suma exponencial en `Z_2`, con conclusiones de equidistribución para la dinámica 2-ádica. Resultado central: la dinámica de la paridad es Bernoulli, hecho topológico no aritmético.
- **Tao 2019**: usa una equidistribución de incrementos logarítmicos `log(Syr^k(n)) − log(n) + k log(3/4)` módulo 1. Esto **es** un argumento aditivo, pero está adaptado al problema; la pregunta es si se puede mejorar usando estructura tipo Bohr de Bourgain o Sárközy.
- **Krasikov–Lagarias (2003)** [`verificar`]: cotas de densidad de órbitas que llegan a 1 vía argumentos combinatorios sobre paridad-vectores; no usan sumas exponenciales explícitamente, pero el armazón aritmético es compatible.
- **Lo que huele a muerto**: intentar sumar `e(α · Syr(n))` directamente sin reagrupar por paridad-vector. La dependencia de `n` en `Syr(n)` es no-lineal en el peor caso y las técnicas de van der Corput se atascan en el factor `2^{v_2(·)}` que es irregular.

### 1.4. Maynard / Green–Tao: ¿qué importan exactamente?

Lo que Maynard exporta es la **detección de estructura en conjuntos esparcidos** vía mayoración por una densidad pseudo-aleatoria (sieve de Maynard 2015, sieve de Selberg refinado). Lo de Green–Tao es la **inversa de Gowers** para sumas `U^s` en conjuntos pseudoprimes. Para Collatz, el conjunto análogo sería:

```
A_k(N) := { n ∈ [N, 2N] : Syr^k(n) < n }
```

Esto es, los `n` cuya órbita "desciende" en `k` pasos. Tao 2019 muestra que `|A_k(N)| ≥ (1 − o(1)) · N` para `k` adecuado vía densidad logarítmica. La pregunta aditiva natural: **¿es `A_k(N)` aditivamente estructurado (contiene progresiones aritméticas largas) o aditivamente aleatorio (uniformidad de Gowers)?**

Si fuera *aleatorio* en sentido Gowers `U^2`, eso daría una equidistribución más fuerte de paridad-vectores en progresiones, no sólo en intervalos.

---

## 2. La pregunta concreta que quiero atacar

A paridad-vector fijo `ω = (a_1, …, a_k)`, el conjunto de `n ∈ [N, 2N]` con ese paridad-vector es una **progresión aritmética módulo `2^k`**, llamémosla `P_ω`. Define la **medida de sesgo aditivo** de orden `s`:

```
β_s(N, k) := sup_{ω}  ‖ 1_{P_ω} − (densidad esperada) ‖_{U^s [N, 2N]}
```

Bajo equidistribución perfecta, `β_s → 0`. El sub-problema es **cuantificar `β_2(N, k)`** — la norma Gowers `U^2`, equivalente a sumas exponenciales lineales.

Si `β_2(N, k) = O(2^{-k/2 + ε})` (decae casi como la raíz del tamaño esperado), eso es **mejor** que el control L^∞ que se deduce trivialmente de Terras, y abriría dos puertas:

1. Refuerzo cuantitativo de la equidistribución logarítmica de Tao en regímenes donde `k ~ c · log N`.
2. Posible derivación de **cotas no triviales sobre el sesgo en ciclos hipotéticos** (un ciclo de longitud `k` impondría una correlación aditiva no trivial entre 2-ádicos y 3-ádicos cuya magnitud podría chocar con `β_2`).

Diferencia con agente_01 (presumiblemente): él **medirá el gap** dentro del esqueleto de Tao; yo **importo una norma externa** (Gowers `U^2`) y mido un objeto distinto.

---

## 3. Honestidad sobre el riesgo

El obstáculo serio es que las técnicas de Green–Tao funcionan sobre conjuntos con buena **densidad relativa** dentro de un anfitrión pseudoaleatorio (los primos, mayorados por Selberg). Para Collatz, el anfitrión natural sería `Z` mismo, y `A_k(N)` ya tiene densidad casi `1`; el régimen es opuesto al de Maynard. Por tanto, la maquinaria probablemente **no se importa directa**: hay que adaptarla, y la adaptación puede ser tan difícil como el problema. Marco esto explícitamente como riesgo `[verificar adaptabilidad real]`.

---

### Sub-problema para sprint 2

**Enunciado.** Establecer una cota de la forma `‖ 1_{P_ω} − 2^{-k} ‖_{U^2[N, 2N]} = O(2^{-k/2} · (log N)^C)` uniforme en `ω ∈ {0,1,…}^k` con `k ≤ c · log_2 N`, donde `P_ω` es el conjunto de `n` con paridad-vector inicial `ω`.

**Criterio de éxito medible.** Una de las dos:
1. **Teorema** con hipótesis (rango de `k`, constante `c`, exponente `C`) y tesis explícitas, con prueba completa o esquema verificable; o
2. **Cota numérica experimental** para `N ≤ 2^{30}` y `k ∈ {10, 15, 20}`: medir empíricamente `β_2(N, k)`, comparar con `2^{-k/2}`, y reportar la constante implícita observada con ≤ 5% de error relativo.

El sub-problema **no** pretende cerrar Collatz; pretende cuantificar cuán pseudoaleatorio es el reparto de paridad-vectores en sentido aditivo, una información que hoy no aparece publicada con esta normalización [`verificar`].

### Autoevaluación

**Improbable.** El ángulo es matemáticamente serio y la pregunta está bien planteada, pero la maquinaria Green–Tao/Maynard está calibrada para regímenes esparcidos y aquí el conjunto es denso; la adaptación puede resultar tautológica (`U^2` controlada por equidistribución trivial de Terras) o demasiado dura. Vale la pena seguir un sprint más para distinguir entre "trivial" y "duro": si el cómputo experimental de `β_2` muestra un decaimiento como `2^{-k/2}`, hay grieta; si muestra `2^{-k}` (trivial) o `O(1)` (sin estructura), cierro la línea.
