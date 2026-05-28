# Sprint 1 — agente_06 (rol Granville/Pomerance)

**Célula 3 — computacional + aditiva. Foco: cotas inferiores teóricas sobre la longitud y la estructura de ciclos no triviales de la iteración 3n+1.**

Aclaración de rol respecto al agente_05: él empuja el frente de verificación numérica (Barina, GPU, sieves); yo no toco una sola órbita. Mi trabajo es producir desigualdades que cualquier ciclo no trivial hipotético tendría que satisfacer, y mostrar cómo esas desigualdades se vuelven cada vez más asfixiantes a medida que mejora la verificación o la aproximación diofántica de log 3 / log 2.

---

## 1. Estado del arte (panorámico, honesto)

Un **ciclo no trivial** de Collatz, en la formulación habitual, es una sucesión de enteros impares positivos `a_0, a_1, ..., a_{K-1}` con `a_K = a_0`, donde cada paso es `a_{i+1} = (3 a_i + 1) / 2^{k_i}` para algún `k_i ≥ 1`. Llamemos `K` al número de subidas (pasos `3x+1`) y `N = k_0 + ... + k_{K-1}` al número total de bajadas (divisiones por 2). Iterando y multiplicando:

```
a_0 · 2^N  =  a_0 · 3^K + (combinación entera positiva de potencias de 3 y 2)
```

de donde, en particular, `2^N > 3^K`, y refinando con que el mínimo del ciclo `m = min a_i` no puede ser arbitrariamente chico respecto a `2^N / 3^K - 1`, se obtiene la desigualdad central:

```
N / K  >  log 3 / log 2  =  1.58496...
```

y, más finamente, `N/K` tiene que aproximar `log 3 / log 2` *por encima* con un error controlado por `1/m`. **Aquí entra la aproximación diofántica.** Si `p/q` es un convergente de `log 3 / log 2`, entonces los `K` admisibles tienen que estar "cerca" de denominadores de convergentes (o de combinaciones de ellos) para que `N/K` esté lo bastante cerca de `log 3 / log 2`. Los denominadores de convergentes de `log 3 / log 2` son `1, 2, 5, 12, 41, 53, 306, 665, 15601, 18074, 33675, ...` `[verificar]` (fracción continua `[1;1,1,2,2,3,1,5,2,23,...]` `[verificar]`).

Hitos:

- **Crandall 1978**: primera cota explícita sobre la longitud mínima de un ciclo no trivial, vía la combinación de verificación + diofántica elemental.
- **Steiner 1977** `[verificar]`: descartó **1-ciclos** (ciclos con un solo "bloque" `3x+1` seguido de varias divisiones por 2) usando teoría de formas lineales en logaritmos (Baker).
- **Simons 2004** `[verificar]`: extendió el descarte a **m-ciclos** para `m` pequeños (creo que hasta 68 o 91 bloques `[verificar]`), también con Baker.
- **Eliahou 1993** ("The 3x+1 problem: new lower bounds on nontrivial cycle lengths", *Discrete Mathematics* 118): combinando la verificación de la época (`n ≤ 2^40` `[verificar]`) con la teoría de convergentes de `log 3 / log 2`, demostró que la longitud `N` (número total de pasos `n → n/2` o `n → 3n+1`) de cualquier ciclo no trivial es al menos del orden de `10^7`, y de hecho `N` debe pertenecer a un conjunto discreto explícito determinado por los convergentes. La cota se reescribe vía mejoras de verificación: si la conjetura está verificada para `n ≤ B`, entonces toda `a_i` en un hipotético ciclo es `> B`, y la maquinaria de Eliahou empuja `N` aún más arriba.
- **Refinamientos posteriores** (Halbeisen–Hungerbühler 1997 `[verificar]`, Simons–de Weger 2005 `[verificar]`) usaron formas lineales en logaritmos (Laurent–Mignotte–Nesterenko) para hacer las cotas no condicionales a la verificación. Mi impresión es que las cotas más actuales sobre **longitud mínima** de ciclo no trivial, combinando verificación hasta `~2^68` y formas lineales en logaritmos, están en el rango `K ≥ 10^9` (número de subidas) y `N` correspondientemente mayor, pero **no estoy seguro del valor exacto y debe verificarse en la literatura** `[verificar]`.

---

## 2. Dónde está la grieta (mi diagnóstico)

Cuatro palancas, ordenadas de más a menos explotada:

1. **Verificación `B`**. Cada bit ganado por el agente_05 empuja `m > B` y, vía Eliahou, mete a `N/K` en una banda más estrecha alrededor de `log 3 / log 2`. Esta palanca está bien estudiada; los retornos son logarítmicos.
2. **Calidad de las cotas de irracionalidad de `log 3 / log 2`**. La medida de irracionalidad efectiva conocida sale de Rhin, Laurent–Mignotte–Nesterenko y sucesores; cualquier mejora cuantitativa en la cota inferior de `|N log 2 − K log 3|` se traduce mecánicamente en mejor cota de longitud de ciclo. **Esta es la palanca menos explotada en los últimos 15 años** `[verificar]`. Si Rhin et al. han producido mejoras recientes que aún no se han trasladado a Collatz, ahí hay fruta colgando.
3. **Estructura combinatoria del ciclo**. Eliahou parametriza ciclos por su "vector de transiciones" (cuántos pasos `÷2` entre subidas consecutivas). El conjunto de vectores admisibles es enorme pero tiene restricciones diofánticas fuertes. Una caracterización mejor del **soporte combinatorio admisible** (no su existencia: su forma) podría descartar familias enteras sin pasar por verificación.
4. **m-ciclos con `m` mediano-grande**. Los descartes vía Baker (Steiner, Simons–de Weger) se limitan a `m` pequeño porque las constantes en las formas lineales en logaritmos explotan. Cualquier mejora numérica en esas constantes mueve la frontera.

Lo que **huele a muerto**: intentar bajar `N/K > log 3 / log 2` por argumentos puramente algebraicos sin usar verificación ni diofántica. Eso ya está en la pizarra desde los 70.

---

## 3. Sub-problema concreto que propongo

Mejorar la cota inferior efectiva sobre `K` (número de subidas en un ciclo no trivial) **aprovechando**: (a) la verificación actual hasta `~2^68`, y (b) las mejores cotas conocidas sobre `|N log 2 − K log 3|` derivadas de medidas de irracionalidad post-Rhin. La salida sería un teorema del tipo "todo ciclo no trivial tiene `K ≥ K_0`" con un `K_0` numérico explícito **mayor que el publicado anteriormente**, y un cuadro mostrando cómo `K_0` escala con `B` (verificación) y con la constante efectiva `c` de la cota diofántica.

Diferenciado del agente_05: yo no levanto `B`. Tomo el `B` que él (o el estado del arte) garantice y lo proceso por la maquinaria diofántica.

---

### Sub-problema para sprint 2

- **Enunciado.** Producir una cota inferior explícita `K ≥ K_0` sobre el número de subidas (pasos `n ↦ 3n+1`) de cualquier ciclo no trivial de Collatz, combinando la verificación numérica vigente (asumida `B ≥ 2^68` `[verificar]`) con la mejor medida de irracionalidad efectiva publicada de `log 3 / log 2`. Acompañar de una tabla `K_0 = f(B, c)` que muestre cómo cada palanca contribuye.
- **Criterio de éxito medible.** Producir un valor numérico `K_0` y demostrar (con argumento auditable, no afirmado) que mejora al mejor publicado anteriormente — objetivo concreto: `K_0 ≥ 10^{10}` `[verificar que la cota previa esté por debajo]`. Entregable: un teorema con hipótesis (verificación `B`, constante diofántica `c`) y tesis (`K ≥ K_0`), más un script reproducible que recalcule `K_0` al variar `B` y `c`. Marcado como **borrador, requiere auditoría** hasta revisión externa.

### Autoevaluación

**Improbable.** El terreno entre verificación y formas lineales en logaritmos ya ha sido peinado por especialistas (Eliahou, Simons, de Weger). Las mejoras suelen ser logarítmicas y poco publicables aisladas. Razón para seguir: las cotas son **combinables** con resultados de otras células (Célula 2 sobre rigidez, Célula 5 sobre estructura simbólica) — una cota explícita de longitud mínima es input útil aunque por sí sola no rompa nada. Y si Rhin o sucesores tienen mejoras post-2010 aún no aplicadas a Collatz, el coste de revisar y trasladar es bajo y el retorno publicable es real.
