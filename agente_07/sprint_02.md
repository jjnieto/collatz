# Sprint 02 — agente_07 (rol Friedman): tubería COMPUTACIONAL-LÓGICA + ABOGADO DEL DIABLO

**Doble misión.** Sección 1: consumir el dataset y `C_emp` de agente_05, redactar el enunciado condicional "`σ ≤ C·log₂ n` ⇒ Collatz ∈ `IΔ₀+exp`" y abrir la interfaz hacia agente_08. Sección 2: auditar literalmente tres pasajes señalados por el jefe (Pasaje A: agente_03; Pasaje B: agente_01; Pasaje C: agente_10).

---

## Sección 1 — Tubería COMPUTACIONAL-LÓGICA

### 1.1 Enunciado condicional preciso (E-Friedman-σ)

**Notación.** Sea `T : ℕ⁺ → ℕ⁺` el operador de Syracuse `T(n) = n/2` si `n` par y `T(n) = (3n+1)/2` si `n` impar. Definimos el tiempo total de parada `σ(n) := min{k ≥ 0 : T^k(n) = 1}` (con `σ(n) = ∞` si no existe tal `k`). Sea `IΔ₀+exp` la teoría aritmética acotada extendida con un axioma de totalidad de la exponenciación binaria `2^x` (Wilkie–Paris; equivalente a `EFA`, *Elementary Function Arithmetic*).

**Enunciado E-Friedman-σ.** Supongamos las dos hipótesis siguientes:

- **(H1) Cota empírica uniforme.** Existen constantes `N₀ ∈ ℕ` y `C ∈ ℝ⁺` (provistas por agente_05; valor candidato `C_emp ≈ 6.95` y `N₀ ≤ 2³²` `[verificar]`) tales que `∀n ∈ ℕ⁺ con n ≥ N₀, σ(n) ≤ C · log₂(n)`.
- **(H2) Verificación finita debajo.** `∀n < N₀, σ(n) < ∞` (mecánicamente decidible, `Δ₀`).

**Tesis.** Bajo (H1)+(H2), la sentencia `Collatz := ∀n ≥ 1, ∃k, T^k(n)=1` es demostrable en `IΔ₀+exp`. En particular, (H1)+(H2) ⊢_{IΔ₀+exp} `Collatz`.

Conviene insistir: el enunciado NO es "Collatz es verdadero porque cumplimos (H1)"; es un **condicional puramente sintáctico**. (H1) no se demuestra aquí; se postula. La utilidad del condicional es deslindar qué fragmento del problema es analítico (probar (H1) uniformemente) y qué fragmento es lógico (esta reducción).

### 1.2 Esquema de prueba en pasos numerados

**(S1) Codificación de `T^k` como término `Δ₀`-acotado.** `T` es polinomial-tiempo en la longitud binaria. La función `iterT(n,k) := T^k(n)` admite definición Σ₁ estándar con cota explícita `iterT(n,k) ≤ 3^k · n + 3^k ≤ 2^{2k} · n`. **Uniforme** (no depende de `C_emp`); demostrable en `IΔ₀+exp` porque `2^{2k}·n` es total ahí.

**(S2) Acotación del testigo.** Bajo (H1), para `n ≥ N₀` el testigo `k` de `∃k T^k(n)=1` cumple `k ≤ C · log₂(n)`. La existencia del testigo se reescribe como `∃k ≤ ⌈C·log₂(n)⌉, T^k(n) = 1`, que es **Δ₀ acotado** (cuantificador acotado por una función `IΔ₀+exp`-total). **Requiere `C_emp` numérico** sólo como parámetro del esquema; cualquier `C` real funciona porque `⌈C·log₂(n)⌉` es término elemental.

**(S3) Reducción Π₂ → Π₁(exp).** Una sentencia originalmente `Π₂` (`∀n ∃k …`) se reduce, vía la cota explícita `k ≤ C·log₂(n)`, a una sentencia `∀n ∃k ≤ f(n), …` con `f` elemental. Esto es una sentencia **`Π_1^{exp}`** (`Π₁` en el lenguaje extendido con `exp`); es decidible para cada `n` fijo dentro de `IΔ₀+exp`. **Uniforme**.

**(S4) Combinación con (H2).** El caso `n < N₀` se cubre por verificación finita: hay un `Δ₀`-predicado `Verif(N₀)` que codifica "`∀n < N₀, ∃k < B, T^k(n)=1`" con `B = max{σ(n) : n < N₀}`. Por (H2) este predicado es verdadero y, por `Σ₁`-completitud sobre estructuras finitas, demostrable en `IΔ₀+exp`. **Requiere `C_emp` y `N₀`** en el sentido de que la longitud del término es proporcional a `N₀`; estructuralmente no se necesita `C`, sí `N₀`.

**(S5) Cierre Π₂.** Para `n ≥ N₀`, (S2)+(S3) dan el testigo acotado. Para `n < N₀`, (S4) lo da por tabla. Conjunción ⇒ `∀n, ∃k T^k(n)=1`, que es `Collatz`. **Uniforme**.

**Pasos que requieren `C_emp` numérico:** (S2) usa el valor de `C` como parámetro del término testigo; (S4) usa `N₀` como tamaño de la verificación finita. Ambos son parámetros de **esquema**, no constantes mágicas.

**Pasos uniformes (no dependen del valor concreto):** (S1), (S3), (S5). Esto es importante: la **forma lógica** del argumento (reducir Π₂ a Π₁(exp) vía cota log explícita) no depende del valor exacto de `C`.

### 1.3 Comentarios honestos sobre el alcance

- El sistema mínimo identificado es `IΔ₀+exp` precisamente porque (i) `2^{k}` debe ser un término total para escribir la cota acotada, y (ii) la verificación finita debajo de `N₀` necesita `exp` para razonar sobre tablas de tamaño `O(N₀ · log N₀)`. Sin `exp` (sólo `IΔ₀` puro), no podemos siquiera demostrar la totalidad de `iterT` en términos `Δ₀`-acotados con cuantificador. `[verificar]` que `EFA = IΔ₀+exp` en la jerarquía de Wilkie–Paris.
- Podría argumentarse que basta `PRA` o incluso una sub-teoría de `IΔ₀+Ω₁`. No lo afirmo; mi lectura es que `IΔ₀+exp` es **suficiente**, no necesariamente óptimo. `[verificar]`
- **No estoy demostrando Collatz.** Estoy demostrando un condicional. Si (H1) falla — y agente_05 nos dirá si los outliers en `[1, 2³²]` ya muestran que `C_emp` debe crecer — la conclusión no se obtiene.

### 1.4 Interfaz para agente_08

**Lo que agente_08 debe producir para que (E-Friedman-σ) tenga mordida modelo-teórica.**

Considera `M ⊨ PA + ¬Collatz`. Si existe corte semiregular `I ⊊ M` cerrado bajo todas las funciones definibles totales en PA y que contiene `N`, y si `Collatz` falla en `M`, entonces el testigo de la falla vive en `M \ I`. La interfaz que necesito de 08:

**(I-08.a) Cota inferior uniforme.** Una sentencia `∀^∞ n ∈ ℕ, σ(n) ≥ φ(n)` con `φ` definible en PA y de crecimiento superior a `log₂ n / C` para todo `C` (esto es el complemento natural de (H1)). Si tal `φ` existe y agente_05 corrobora con outliers que `σ(n)/log₂ n → ∞`, entonces (H1) **falla** y (E-Friedman-σ) se vuelve vacuo. **Por tanto, lo que pido a 08 es lo contrario**: que muestre que **no** se puede construir cota inferior `σ(n) ≥ ω(log₂ n)` a partir de los outliers de 05, o bien que la cota inferior compatible con los datos es `σ(n) ≥ c·log₂ n` con `c < C_emp` (compatible con H1).

**(I-08.b) Restricción de cortes semiregulares.** Necesito de 08 una **lista cerrada** de tipos de cortes (semiregular, regular, fuerte) compatibles con `PA + ¬Collatz`, indizados por la cota inferior efectiva sobre `σ`. Formato:

> Si `σ(n) ≥ c·log₂ n` para infinitos `n ∈ ℕ`, entonces todo corte `I_M` Collatz en `M ⊨ PA + ¬Collatz` debe satisfacer la propiedad `P_c` (lista de propiedades de Kirby–Paris).

Mi reducción (S2)–(S5) combina con esta lista así: la cota inferior excluye cortes en los que el testigo `k` cabría en `I_M` (porque `k ≤ C·log₂ n` forzaría `k ∈ N`); si **todo** corte semiregular satisface eso, entonces `M` no puede contener un contraejemplo en `M \ I_M` por debajo de `2^{N₀ · ...}` `[verificar]`, lo que cierra el modelo.

**(I-08.c) Formato del entregable de 08 que consumo en sprint 3.** Una proposición de la forma: `Si σ(n) ≥ c·log₂ n para n en conjunto de densidad positiva, entonces ningún corte semiregular es Collatz-corte`. Si 08 nos da eso, junto con (H1), tenemos una **dicotomía**: o (H1) es cierto (y E-Friedman-σ aplica), o existe `n` con `σ(n) ≫ log n` (y el corte semiregular se excluye). Es una pinza débil pero estructural.

---

## Sección 2 — Auditoría como abogado del diablo

### Pasaje A — agente_03

**Cita literal (verificada contra `agente_03/sprint_01.md` línea 43):**

> *"un ciclo no trivial de Collatz produciría una **medida `T`-invariante atómica con soporte finito en `Z` ⊂ Z_2**, soporte que es disjunto del ciclo trivial `{1,2,4}`. Si pudiera demostrarse que **toda medida `T`-invariante ergódica sobre `Z_2` cuyo soporte está contenido en `Z` debe estar contenida en el ciclo trivial**, eso cerraría la parte de ciclos."*

**Veredicto: concedido (parcialmente).**

**Justificación técnica.** La primera mitad de la afirmación es trivialmente cierta y útil sólo a nivel de notación: un ciclo finito da una medida atómica uniforme sobre sus puntos, y esta es `T`-invariante; en `Z`, el soporte es disjunto del ciclo trivial por hipótesis. La segunda mitad —la propuesta de que "clasificar medidas ergódicas con soporte en `Z`" sería un programa— **colapsa a Collatz mismo**, y agente_03 mismo lo advierte en el párrafo siguiente (línea 45: *"esto requiere auditoría: el cruce entre 'entropía positiva en Z_2' y 'soporte numerable' puede colapsar la afirmación a algo trivial o vacuo"*).

El problema técnico es agudo: una medida invariante ergódica con soporte numerable en `Z_2` es **necesariamente atómica concentrada en una órbita periódica** (porque por ergodicidad, casi toda órbita es densa en el soporte, y un soporte numerable forzaría densidad numerable trivial). Por tanto, "clasificar tales medidas" es literalmente "clasificar las órbitas periódicas de `T` sobre `Z`", que es **exactamente** la parte ciclos de Collatz. No hay entropía positiva genuina (la acción es de rango 1, como agente_03 reconoce en su autoevaluación, línea 62), y por tanto la rigidez de Furstenberg–Rudolph–Lindenstrauss no aplica.

La reformulación medible es una **traducción de notación sin ganancia estructural**. La objeción del jefe es correcta: hay que conceder. El agente_03 debe pivotar (como su propio briefing del sprint 2 le indica como camino (b)) a servir de puente entre 04 y 06, no perseguir clasificación de medidas.

### Pasaje B — agente_01

**Cita literal (verificada contra `agente_01/sprint_01.md` línea 13):**

> *"Una órbita podría oscilar indefinidamente entre, digamos, `log log n` y `log log log n` sin contradecir el teorema."*

**Veredicto: defendido (con matiz).**

**Justificación técnica.** El teorema de Tao 2019/2022 (Forum of Mathematics, Pi) establece que para *cualquier* `f: ℕ → ℝ` con `f(N) → ∞`, la densidad logarítmica de `{n ≤ N : ∃k T^k(n) ≤ f(n)}` tiende a 1. La cuantificación `∃k T^k(n) ≤ f(n)` significa "la órbita **toca** un valor `≤ f(n) en algún momento", no "termina ahí" ni "se queda abajo".

Por tanto, el teorema **no prohíbe**: (a) que `f(n)` se toque pero la órbita rebote luego; (b) que la órbita oscile entre escalas `log log n` y `log log log n` después de tocar `f`; (c) que vuelva a subir. Tao mismo es explícito sobre esto en la introducción de su preprint (arXiv:1909.03562) `[verificar página exacta, sección 1.2]`: el resultado controla un **mínimo a lo largo de la órbita**, no la dinámica posterior.

Que la afirmación de agente_01 está formulada con certeza superior al `[verificar]` adyacente es una observación estilística válida del jefe, pero el contenido es correcto: literalmente cierto. **Matiz**: agente_01 usa "oscilar indefinidamente entre `log log n` y `log log log n`" como ejemplo plausible; estrictamente, sería más preciso decir "podría reasumir cualquier comportamiento por encima de `log log log n`" — el teorema no obliga a que la órbita se mantenga oscilando entre esas dos escalas particulares, sólo que **no puede inferirse** que se quede acotada por debajo de `f`. El ejemplo concreto de oscilación entre las dos escalas iteradas-log es ilustrativo, no demostrado.

Conclusión: defendido. Agente_01 puede mantener la frase. Si quiere blindarla en sprint 3, basta cambiar "podría oscilar indefinidamente entre `log log n` y `log log log n`" por "podría volver a niveles arbitrariamente por encima de `f(n)`" — equivalente lógicamente y menos vulnerable a malentendido.

### Pasaje C — agente_10

**Cita literal (verificada contra `agente_10/sprint_01.md` línea 33):**

> *"el balance crítico es `log_2 3 / (1+log_2 3) ≈ 0.6309`, no `1/2`, **una vez se contabiliza el peso multiplicativo**."*

**Veredicto: inconcluyente.**

**Justificación técnica.** El número `log₂ 3 / (1 + log₂ 3) ≈ 0.6309` es la **densidad crítica de unos** (`w_i = 1`) en una palabra de paridad para que el producto multiplicativo `∏ 3^{w_i} / 2^k` sea exactamente 1; equivalentemente, `n_k = n_0` en log: `k log 2 − (#unos)·log 3 = 0` da `#unos / k = log 2 / log 3 ≈ 0.6309`. Aritméticamente, el número es correcto y conocido (es la frecuencia diofántica del ciclo). Hasta aquí, sin problema.

El cargo del jefe es que se mezclan dos conteos distintos: la frecuencia 1/2 de Bernoulli (la palabra de paridad bajo la medida de Haar en `Z_2`, push-forward = Bernoulli(1/2,1/2)) versus la frecuencia 0.6309 (la que haría que el producto multiplicativo sea unitario). Esto es legítimo y crítico porque agente_10 está construyendo `p*_N(k)` que mezcla las dos cuentas.

**Por qué inconcluyente y no concedido.** En la frase aislada, agente_10 **sí** distingue: dice "balance crítico ... una vez se contabiliza el peso multiplicativo". La cláusula final separa explícitamente. El problema potencial está en el uso posterior: en la sección 5, donde define `p*_N(k)` (línea 40), incorpora la condición `T^k(n) < n` (que es multiplicativa: `3^{|u|_1} < 2^k`) y al mismo tiempo cuenta palabras `u ∈ {0,1}^k`. Si interpreta `α^k` con `α` derivado del conteo Bernoulli plano, la cota es trivial (`α = 2`); si lo deriva del conteo multiplicativo, obtiene `α = 2^{1/(1+log₂ 3)} ≈ 1.5396`. La cota propuesta `α_0 < 2` (sprint 2 de 10) sólo es no-trivial si proviene del segundo conteo y se mantiene puro.

**Por qué inconcluyente.** No puedo decidirlo sin ver el sprint 2 de agente_10 con `p*_N(k)` tabulada. La frase del sprint 1 es defendible aislada, pero la pregunta crítica para 06 (que va a consumir `α_0`) es: **¿la prueba de `α_0 < 2` que agente_10 entregue en sprint 2 deriva `α_0` del peso multiplicativo de manera limpia, sin importar la frecuencia Bernoulli en ningún paso intermedio?**

**Pregunta concreta para sprint 3 (que debería responder agente_10).** Sea `p*_N(k)` tu función de complejidad ponderada. En la prueba de la cota `p*_N(k) ≤ C·α_0^k`, ¿en qué paso entra el conteo `2^k` (Bernoulli/cardinalidad de `{0,1}^k`) y en qué paso entra el conteo `3^{|u|_1} < 2^k` (multiplicativo)? Específicamente: el exponente `α_0` que obtienes, ¿coincide con `2^{1/(1+log₂ 3)} ≈ 1.5396` (puramente multiplicativo) o con `2 · 2^{−1/(1+log₂ 3)} ≈ 1.299` (caso de cancelación entre Bernoulli y multiplicativo), o con algo intermedio? El veredicto final sobre el Pasaje C depende de esa respuesta. Hasta entonces, marco la línea como cota **defendible pero no defendida en el material disponible**.

---

### Sub-problema para sprint 3

Formalizar (E-Friedman-σ) en Lean 4 / mathlib como lema condicional `collatz_of_log_bound : (∀ n ≥ N₀, σ n ≤ C * log₂ n) → (∀ n ≥ 1, ∃ k, T^[k] n = 1)`, parametrizado en `N₀, C` numéricos provistos por agente_05. **Criterio de éxito medible:** archivo `Collatz/FriedmanReduction.lean` con la definición de `σ`, los pasos (S1)–(S5) demostrados modulo (H1)+(H2) (que entran como hipótesis), y la firma del lema cerrada (`#check collatz_of_log_bound`). Adicionalmente, una nota de una página que evalúe si `IΔ₀+exp` puede sustituirse por una sub-teoría más débil sin perder la reducción.

### Autoevaluación

**Prometedor.** Pivote frente al sprint 1, donde marqué "Improbable". Razón del cambio: la tubería con agente_05/agente_08 da un punto de apoyo concreto. (E-Friedman-σ) es un condicional formalizable y, aunque no resuelve Collatz, **separa limpiamente** la parte analítica (probar (H1)) de la parte lógica (esta reducción), que era el deslinde que prometí. La auditoría como abogado del diablo produjo: A concedido, B defendido, C inconcluyente — distribución sana, ni complaciente ni paranoica.

