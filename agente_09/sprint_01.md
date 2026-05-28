# Sprint 01 — agente_09 (rol Shallit, Célula 5)

**Ángulo:** autómatas finitos, paridad-vector de Terras, clasificación de lenguajes Collatz en la jerarquía de Chomsky.

---

## 1. Estado del arte (mi ángulo)

### 1.1 Paridad-vector de Terras

Dado un entero positivo `n`, sea `T(n) = n/2` si `n` par y `T(n) = (3n+1)/2` si `n` impar (Syracuse acelerada). La **paridad-vector** de longitud `k` asociada a `n` es

```
v_k(n) = (a_0, a_1, ..., a_{k-1}) ∈ {0,1}^k,   a_i = T^i(n) mod 2.
```

Terras (1976) probó que la aplicación `n ↦ v_k(n) mod 2^k` es una **biyección** sobre `Z/2^k Z`. Equivalentemente, sobre los 2-ádicos `Z_2` la aplicación de paridades `Q_∞: Z_2 → Z_2` es un homeomorfismo (Lagarias 1985), de hecho conjuga `T` con la suma `x ↦ x+1` en cierta representación [verificar — formulación exacta varía entre autores]. Esta es la base "simbólica" del problema: las paridades codifican completamente la dinámica.

### 1.2 La pregunta de Shallit

Shallit y otros (años 90 en adelante) formularon explícitamente preguntas del tipo:

- ¿Es **regular** (reconocible por autómata finito determinista, AFD) el conjunto de paridad-vectores `v_k(n)` de enteros `n` cuya órbita alcanza 1 en exactamente `k` pasos?
- ¿Es **automática** (en el sentido Allouche–Shallit) la secuencia de paridades de la órbita de un `n` fijo?

Hay resultados parciales de **no-regularidad** para variantes naturales. En particular:

- El conjunto `S = { binario(n) : la órbita de n alcanza 1 }` se considera, casi universalmente, **no regular**; pero "no regular" no implica nada sobre Collatz porque el complemento `Z_+ \ S` podría también ser no regular sin que exista divergencia. Marcado [verificar] para la atribución exacta — creo que aparece en notas de Shallit pero no tengo el paper a mano.
- Sobre la propia secuencia de paridades de una única órbita `(a_i)_{i≥0}`, se conjetura que **no es automática salvo casos triviales** (esto enlaza con el sub-problema del agente_10).

### 1.3 Conway, FRACTRAN y Chomsky

Conway (1972, 1987) probó que la variante **Collatz generalizada** (funciones `n ↦ a_i n + b_i` según `n mod m`) es Turing-completa vía FRACTRAN. Por tanto:

- El lenguaje "órbitas que terminan" para Collatz **generalizado** es ya en la cima de la jerarquía: r.e. pero no recursivo.
- Para el Collatz **clásico** específico (m=2, mapas `n/2` y `3n+1`) la situación es abierta: nadie sabe si es decidible.

Esto enmarca mi ángulo: clasificar lenguajes naturales asociados al Collatz clásico en la jerarquía regular ⊂ libre de contexto ⊂ sensible al contexto ⊂ r.e.

### 1.4 Qué huele a muerto

- **"Demostrar Collatz construyendo un AFD."** Si existiera un AFD que reconociera los `n` que terminan, Collatz sería decidible trivialmente — y dada la profundidad del problema esto es implausible. No es una vía.
- **Heurística "no regular ⇒ Collatz cierto".** Falsa: no-regularidad de `S` no obstruye divergencia. Hay que ser muy preciso sobre qué implica qué.
- **Aplicar bombing lemma directo a la secuencia de paridades.** Estéril en aislamiento: las secuencias de paridad son ya ultimadamente "uniformemente equidistribuidas" en cierto sentido medible (Lagarias), pero eso no las hace clasificables sin un objeto formal bien elegido.

---

## 2. Sub-problema propuesto: clasificación de `L_div`

Defino el lenguaje

```
L_div := { binario(n) ∈ {0,1}*  :  la órbita Collatz de n es no acotada }.
```

Bajo la conjetura, `L_div = ∅` (regular trivial). Pero **sin asumir la conjetura**, podemos preguntar:

> ¿Qué clase mínima de la jerarquía de Chomsky **puede contener** `L_div`, condicionalmente a que `L_div ≠ ∅`?

Resultado de partida (folclore, fácil): si `L_div ≠ ∅` y fuera **regular**, entonces sería infinito y por bombing lemma contendría una progresión aritmética `{u v^i w : i ≥ 0}` (en su forma binaria). Para que esto sea compatible con la dinámica Collatz haría falta una familia paramétrica de divergentes con estructura aditiva trivial — lo cual contradiría rápidamente las cotas conocidas de Krasikov–Lagarias sobre densidad de no-terminantes en intervalos `[1, N]` (densidad `≪ N^{0.84}` aproximadamente [verificar exponente exacto]). Por tanto:

> **Conjetura de trabajo (S1):** `L_div` es no regular, *incluso sin asumir Collatz*. Esto es demostrable.

Sub-problema concreto: **dar una demostración rigurosa, sin asumir Collatz, de que `L_div` no es regular**, vía un argumento de bombing lemma que use las cotas de densidad de Krasikov–Lagarias o de Tao 2019. Y luego subir un peldaño:

> **Conjetura de trabajo (S2):** `L_div` no es libre de contexto.

Esto requeriría el lema de Ogden o lema de Parikh, y la idea es que las "imágenes Parikh" (vectores de conteo de 0s y 1s) de un CFL son uniones finitas de conjuntos lineales — incompatible con las restricciones 2-ádicas del Collatz.

### 2.1 Consecuencia condicional

Si se logra establecer que `L_div` **debe ser** al menos sensible al contexto (caso `L_div ≠ ∅`), entonces cualquier "ejemplo natural" de divergencia tendría una **complejidad sintáctica mínima certificable**. Esto no demuestra Collatz, pero **acota el tipo de objeto que un contraejemplo puede ser**, y ofrece una obstrucción real a construcciones "ingenuas" (progresiones aritméticas, lenguajes de Dyck, etc.).

---

## Sub-problema para sprint 2

- **Enunciado:** Probar, sin asumir la conjetura de Collatz, que el lenguaje `L_div = { binario(n) : la órbita de n bajo Collatz es no acotada }` o bien es vacío, o bien no es regular. (Versión fuerte: o vacío, o no libre de contexto.)
- **Criterio de éxito medible:**
  1. **Teorema A (sprint 2, objetivo mínimo):** un lema con hipótesis "Si `L_div ≠ ∅`" y tesis "entonces `L_div` no es regular", con demostración completa apoyada en una cota de densidad citada con precisión (Krasikov–Lagarias `[verificar exponente]` o Tao 2019).
  2. **Teorema B (sprint 2, objetivo extendido):** la versión libre de contexto, vía Ogden/Parikh. Marcado como "borrador, requiere auditoría" si se obtiene.
  3. **Entregable formal opcional:** esbozo de enunciado Lean 4 `theorem L_div_not_regular : L_div = ∅ ∨ ¬ IsRegular L_div`.

---

## Autoevaluación

**Improbable.** La grieta existe — clasificar `L_div` parece tratable como ejercicio de teoría de lenguajes formales apoyado en cotas analíticas externas (Krasikov–Lagarias, Tao 2019) — pero el resultado, aun obtenido, **no ataca el corazón de Collatz**: sólo elimina contraejemplos de baja complejidad sintáctica. Es un resultado parcial publicable plausible (nota corta en *Theoret. Comput. Sci.* o similar) pero estructuralmente periférico. Sigo porque (a) limpia el terreno para argumentos posteriores, (b) la técnica Parikh + cotas analíticas no se ha aplicado, que yo sepa, en este contexto preciso, y (c) si `L_div` resulta forzosamente **muy** complejo (sensible al contexto, no recursivo), eso sí tendría peso conceptual y reforzaría la línea de Friedman (agente_07) sobre independencia.
