# Sprint 1 — agente_04 (rol Furstenberg, Célula 2)

**Ángulo:** dinámica simbólica y 2-ádicos. Diferenciación con agente_03 (Lindenstrauss): él ataca lo **medible** (medidas invariantes, rigidez); yo trabajo en lo **topológico/simbólico** (conjugaciones continuas, invariantes de órbita, factores sobre el shift de Bernoulli).

---

## 1. Estado del arte: la extensión de Lagarias a Z_2

Sea `T: Z -> Z` la función de Syracuse comprimida: `T(n) = n/2` si `n` par, `T(n) = (3n+1)/2` si `n` impar. Lagarias (1985, *Amer. Math. Monthly* 92) `[verificar]` extendió `T` a una función continua `T: Z_2 -> Z_2` que es una **biyección** (de hecho un homeomorfismo) sobre los 2-ádicos. La construcción es: para `x` en Z_2, decidir paridad por el bit menos significativo y aplicar la rama correspondiente; las dos ramas tienen inversas continuas (`2x` y `(2x-1)/3`, donde la división por 3 es lícita en Z_2 porque 3 es unidad).

El resultado central es la **función de paridad** (o "Q-map" de Lagarias):
- A cada `x` en Z_2 se le asocia la secuencia binaria `Q(x) = (a_0, a_1, a_2, ...)` donde `a_k = T^k(x) mod 2`.
- `Q: Z_2 -> {0,1}^N` es un **homeomorfismo** que conjuga `T` con el shift de Bernoulli `sigma` en `{0,1}^N` `[verificar: la afirmación habitual es que Q conjuga T con la suma de Mahler o con un shift; la conjugación exacta merece revisión cuidadosa]`.

Si la conjugación con el shift es estricta, la dinámica 2-ádica de `T` es **topológicamente isomorfa al shift completo de Bernoulli**: el sistema "más caótico posible". Esto suena espectacular y no lo es: significa precisamente que **toda la información dinámica en Z_2 se evapora**, porque el shift de Bernoulli no distingue sus puntos de manera computable a partir de propiedades enteras.

## 2. Por qué el isomorfismo no se traduce a Z

Esta es la barrera crítica. Z es **denso** en Z_2 pero **insignificante** topológicamente: Z es contable, Z_2 es no numerable. Bajo la conjugación `Q`:

- Los enteros positivos `n` corresponden a paridades **eventualmente periódicas** (porque la órbita Collatz se vuelve periódica en `1 -> 4 -> 2 -> 1` si la conjetura es cierta, o periódica en otro ciclo, o no periódica si diverge).
- La inversa `Q^{-1}` envía paridades eventualmente periódicas a `Q` (los racionales 2-ádicos con denominador potencia de 2 — o más precisamente, a un subconjunto de Z[1/2] cuyo estudio se debe a Lagarias).
- **Que `Q(n)` sea eventualmente la palabra `(1,0,0,1,0,0,...)`** (paridad del ciclo trivial) equivale a que la órbita de `n` alcance 1. Pero el shift no "sabe" cuáles palabras provienen de enteros.

El problema en una frase: **Z dentro de Z_2 es un subconjunto invariante por `T` pero sin estructura topológica que el shift respete**. La conjugación es ciega a la aritmética entera.

## 3. Trabajos previos y obstáculos conocidos

- **Bernstein–Lagarias (1996)** `[verificar]` estudian la función `Q` y muestran que es un homeomorfismo medible que preserva la medida de Haar 2-ádica si y solo si la distribución de paridades es Bernoulli(1/2). Esto es coherente con Tao 2019 (densidad logarítmica), pero medible, no topológico.
- **Akin (2004)** y trabajos posteriores examinan la **dinámica topológica** de `T` en Z_2: minimalidad, equicontinuidad, puntos periódicos. La conclusión es que el sistema es **topológicamente mezclador** (mixing) y tiene puntos periódicos densos `[verificar]`. De nuevo: información estructural que no discrimina Z.
- **Müller, Monks, y otros** han estudiado **representaciones en árboles binarios infinitos** de las preimágenes de 1 bajo `T`, obteniendo conexiones con autómatas y sustituciones.

Mi impresión honesta tras esta revisión: **la dinámica simbólica en Z_2 está muy bien entendida y no contiene la obstrucción**. La parte difícil está en el contraste Z vs. Z_2, no en Z_2 solo.

## 4. Dónde podría haber grieta: invariantes que distingan ciclos

La pregunta de mi encargo es: ¿qué **invariante dinámico** puede distinguir el ciclo trivial `1 -> 4 -> 2 -> 1` (paridad-vector periódico `100 100 100 ...`) de un hipotético ciclo no trivial?

Un ciclo no trivial de `T` en Z corresponde, vía `Q`, a una palabra **periódica** `w in {0,1}^N` con periodo `p`. Si la palabra tiene `k` ocurrencias de `1` (pasos impares) y `p - k` de `0` (pasos pares), la condición de cierre del ciclo es la célebre identidad de **Steiner/Eliahou**:
- `n * (2^p - 3^k) = `(suma de términos `3^{k-i} 2^{...}`)`
- En particular, `2^p / 3^k` debe ser una aproximación racional a 1 cercana a la unidad, lo que conecta con la teoría diofántica de log_2(3) (terreno del agente_06).

El invariante natural desde la dinámica simbólica: **la frecuencia asintótica de paridad 1** en la palabra. Para el ciclo trivial, esa frecuencia es exactamente `1/3`. Para un ciclo no trivial de longitud `p` y `k` impares, es `k/p` con `2^p > 3^k` apenas (porque la órbita debe cerrarse sin divergir ni colapsar). Eso fuerza `k/p` muy cerca de `log 2 / log 3 ≈ 0.6309`, es decir, frecuencia de impares ≈ 0.6309, **no 1/3**.

**Conclusión topológica clave:** la palabra del ciclo trivial y la palabra de cualquier ciclo no trivial viven en **regiones disjuntas del simplejo de medidas invariantes** del shift restringido a palabras periódicas con cierre Collatz. Esto no demuestra nada por sí mismo (no excluye que existan tales palabras periódicas con la frecuencia mala), pero **sí da un invariante topológico-combinatorio limpio**: la frecuencia 1/3 vs ≈ 0.6309.

---

### Sub-problema para sprint 2

**Enunciado.** Formalizar y estudiar el siguiente invariante: para cada órbita finita o ciclo `O` de la función de Syracuse comprimida `T`, defínase la **medida empírica de paridad** `mu_O` en `{0,1}` como la frecuencia relativa de pasos impares. Sub-problema: demostrar (o refutar con contraejemplo) que **toda palabra periódica `w` en `{0,1}^*` con frecuencia de unos en el intervalo `(1/3, log 2 / log 3 - epsilon)` es realizable como Q(n) para algún `n` racional 2-ádico, pero NO para ningún `n` en Z**, para algún `epsilon > 0` explícito.

**Criterio de éxito medible.** Producir **uno** de los siguientes en sprint 2:
1. Un teorema con enunciado y prueba (o borrador con `requiere auditoría`) de la forma: "Si `n` en Z y `Q(n)` es periódica con frecuencia de unos `rho`, entonces `rho` pertenece a `{1/3}` union `[log 2/log 3 - delta, log 2/log 3]`", con `delta` explícito.
2. Una **cota inferior numérica** sobre la longitud mínima `p` de un ciclo no trivial obtenida puramente desde el invariante de frecuencia (sin invocar verificación computacional hasta 2^68), comparable a la cota de Eliahou.
3. Una formalización Lean 4 del enunciado del invariante de frecuencia bajo el nombre `collatz.parity_frequency_invariant` con su tipo bien definido (la prueba puede quedar como `sorry`).

### Autoevaluación

**Improbable.** El invariante de frecuencia es real, limpio y topológicamente natural, pero es **conocido** desde Crandall (1978) `[verificar]` y Eliahou (1993): toda la información que aporta está ya capturada por las cotas diofánticas sobre `2^p - 3^k`. Mi ángulo simbólico-topológico, en honestidad, parece reformular en lenguaje dinámico lo que la teoría diofántica clásica ya dice mejor. La razón para seguir: la **formalización del invariante como propiedad de la conjugación Q** puede dar un marco unificado útil para combinar con el ataque del agente_06 (cotas diofánticas) y del agente_09 (autómatas sobre paridad-vectores). El valor del ángulo es **infraestructural**, no de avance directo.
