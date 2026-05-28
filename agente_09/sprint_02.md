# Sprint 2 — agente_09 (rol Shallit, C5 + consumidor cadena ANÁLISIS EFECTIVO)

## 0. Estado de la tarea

El encargo pide: (a) versión precisa de "no regular" para `L_div` con constante de bombeo expresada en términos de las constantes de **E-Tao** (agente_01); (b) consumir la tabla `p*_N(k)` y la cota `α_0^k` de **agente_10** para extraer lo que dicen sobre el **lenguaje de prefijos** de palabras divergentes; (c) interfaz hacia **agente_02** si el argumento requiere estructura aditiva. No reclamo prueba completa: redacto reducciones con sus `[verificar]` y dejo el cierre técnico para sprint 3.

Aviso de coherencia con la tubería: en este sprint, el sprint_02 de agente_10 aún no está disponible en mi vista (sí el de agente_01). Trabajo con la `p*_N(k)` tal como fue prometida en `agente_10/sprint_01.md` (cota auditable `p*_N(k) ≤ C·α_0^k` con `α_0 < 2` explícito, conjetura `α ≈ 2^{1/(1+log_2 3)} ≈ 1.5396`) y marco `[verificar]` donde dependo de un valor numérico no fijado.

---

## 1. Definición del objeto

Recordatorio (de mi sprint_01). Para `n` impar, `Syr(n) = (3n+1)/2^{ν_2(3n+1)}`. La **palabra de paridad** completa de `n` es `w(n) = π_0 π_1 π_2 … ∈ {0,1}^N`, con `π_j = Syr^j(n) mod 2` (cuando se quiera, se puede usar también la versión Terras `T` no acelerada; ambas dan lenguajes regulares-equivalentes). Defino dos lenguajes naturales:

- `L_div := { bin(n) ∈ {0,1}* : la órbita Collatz de n es no acotada }`.
- `Pref_div(k) := { u ∈ {0,1}^k : ∃ n divergente con w(n)↾k = u }` (prefijos de longitud `k` de palabras de paridad divergentes).
- `P_div := ⋃_k Pref_div(k)`, el **lenguaje de prefijos** de palabras divergentes.

Hipótesis externa fija a lo largo del documento (**E-Tao**, de agente_01, sprint_02 sección 1):

> Para todo `ε ∈ (0, 1/2)`, `X ≥ X_0(ε)`, el conjunto excepcional
> `E_ε(X) := { n ∈ [X, 2X] impar : Min(n) > n^{1-ε} }`
> tiene densidad logarítmica `dens_log(E_ε(X)) ≤ C_0 · (log X)^{-c(ε)}`,
> con `c(ε) > 0` calculable (esqueleto: `c(ε) = min{c_1, c_2}·ε^A`, `A ∈ {2,4,10}` `[verificar]`).

Nota crítica: bajo E-Tao, **toda** `n` divergente pertenece a `E_ε(X)` para **todo** `ε ∈ (0,1/2)` (porque su órbita no decrece nunca, en particular no baja de `n^{1-ε}`). Esa intersección sobre `ε` es el motor del bombeo.

---

## 2. Versión precisa de "no regular" — pumping con constante derivada de E-Tao

**Lema 9.A (reducción a E-Tao).** Asuma E-Tao y `L_div ≠ ∅`. Entonces `L_div` no es regular.

**Esqueleto del argumento (no demostración cerrada).**

1. Supongamos `L_div` regular. Por el pumping lemma de Myhill–Nerode existe `p ≥ 1` (constante de bombeo) tal que toda palabra `bin(n) ∈ L_div` con `|bin(n)| ≥ p` admite descomposición `bin(n) = x y z`, `|xy| ≤ p`, `|y| ≥ 1`, con `x y^i z ∈ L_div` para todo `i ≥ 0`.

2. Fijo `ε ∈ (0, 1/2)`. Tomo `X` grande, `X ≥ X_0(ε)`. La regularidad de `L_div` y su no-vacuidad implica (lema estándar) que `L_div ∩ [X, 2X]` contiene, salvo a lo sumo `O(1)` excepciones de longitud `< p`, **una familia paramétrica infinita** `{ n_i = val(x y^i z) }_{i ≥ 0}` cuyos representantes binarios viven en `[X, 2X]` para una banda explícita de valores de `i` de tamaño `≥ X / 2^{|y|}` `[verificar combinatoria binaria exacta]`. Llamo a esa familia paramétrica `F_p(X)`.

3. Por E-Tao, `|E_ε(X) ∩ [X, 2X]| ≤ C_0 · X · (log X)^{-c(ε)}` (en densidad logarítmica relativa; uso aquí la equivalencia con densidad natural en bloques diádicos, que tiene una pérdida `O(1)` `[verificar]`).

4. Pero `F_p(X) ⊂ L_div ∩ [X, 2X] ⊂ E_ε(X) ∩ [X, 2X]`. La densidad **inducida por una palabra bombeable** sobre `[X, 2X]` es `≥ c_{reg}(p) / log X` cuando los `n_i` se realizan como números binarios (cada bombeo añade `|y|` bits y multiplica el valor por un factor controlado por la posición de `y`).

5. Comparando (3) y (4) se obtiene
   `c_{reg}(p) / log X  ≤  C_0 · (log X)^{-c(ε)}`,
   esto es **`c(ε) ≤ 1 + o_X(1)`** `[verificar la dirección y el `1` exacto — es el esqueleto que agente_01 también marca]`.

6. Para concluir la contradicción se exige una versión de E-Tao con `c(ε) > 1` para algún `ε`. Esto **no** está garantizado por el enunciado simbólico actual: si `c(ε) ≤ ε^4`, la desigualdad (5) se cumple trivialmente y **no hay contradicción**. La obstrucción es real y la registro como sub-problema (sección 6).

**Constante de bombeo expresada en términos de E-Tao.** En la versión "óptima" del argumento, la constante de bombeo `p` no es libre: queda **acotada inferiormente** por una función de `c(ε)` y `C_0`. Concretamente, despejando en (5):

> `p ≥ p_0(ε) := exp( (1/c(ε)) · log(C_0 / c_{reg,1}) )`,    `[verificar]`

donde `c_{reg,1}` es la constante "una palabra bombeable produce densidad `c_{reg,1}/log X`" del paso (4). Cuanto **más débil** E-Tao (`c(ε)` chico), **más grande** debe ser `p`; el argumento es por tanto **condicional a `c(ε) > 1`** en su forma de contradicción dura, o **condicional a una mejora cuantitativa de E-Tao** en su forma efectiva.

**Conclusión honesta (sprint 2):** *no* he probado que `L_div` sea no regular. He producido una **reducción explícita** del enunciado al subproblema de cuantificación de `c(ε)`. Lo que sí queda probado, modulo `[verificar]` del paso (5), es:

> **Lema 9.A'.** Si E-Tao se cumple con `c(ε) > 1` para algún `ε ∈ (0,1/2)`, entonces (`L_div = ∅` ∨ `L_div` no es regular).

Esto es **estrictamente más débil** que la conjetura S1 de mi sprint_01, y refleja la dependencia real con la cadena ANÁLISIS EFECTIVO.

---

## 3. Lectura del input de agente_10 sobre `Pref_div(k)`

agente_10 promete (sprint_01 §5; recogeré numéricos cuando publique sprint_02) una cota auditable `p*_N(k) ≤ C · α_0^k` con `α_0 < 2`, donde `p*_N(k)` cuenta prefijos de longitud `k` realizables por `n ≤ N` que además **contraen** (`T^k(n) < n`). La conjetura central es `α ≈ 2^{1/(1+log_2 3)} ≈ 1.5396`.

**Observación 9.B.** El lenguaje `Pref_div(k)` está esencialmente contenido en el complemento del conjunto "prefijos contractivos" usado por agente_10: un `n` divergente nunca cumple `T^k(n) < n` para todo `k`, en particular **sus prefijos no aparecen** en el conteo `p*_N(k)`. Eso da una relación dual:

> `|Pref_div(k) ∩ {prefijos realizados por n ≤ N}|  ≤  2^k − p*_N(k)  +  O(?)`,

que es una cota **trivialmente débil**. La pregunta interesante es la dirección opuesta: la **cota superior** de `α_0` para los contractivos no acota directamente `|Pref_div(k)|` (porque las palabras "no contractivas en `k` pasos" no son las divergentes; pueden ser meramente oscilatorias). `[verificar la separación exacta]`.

**Lo que sí extraigo del crecimiento `α^k`.**

- Si `α < 2` con prueba, entonces el lenguaje de **prefijos contractivos** tiene **entropía topológica** `log α < log 2`. Por dualidad, el lenguaje complementario (prefijos no contractivos) tiene entropía topológica `log 2` (saturado).
- `Pref_div ⊆ Prefijos no contractivos`. Por tanto, `Pref_div` tiene a lo sumo entropía topológica `log 2` (banal) **y al menos** la entropía residual del complemento; pero esto último no se deduce del input de 10 sin un argumento extra.
- Lo único cuantitativamente nuevo que el `α_0^k` de 10 me da sobre `L_div` es esto: **si `L_div` fuera regular con constante de bombeo `p`, la familia paramétrica `F_p(X)` produciría `≥ X^{1 - δ(p)}` prefijos no contractivos hasta `n ≤ X`**, lo cual choca con cualquier mejora futura de la cota de 10 hacia el complemento. `[verificar — no he cerrado el cómputo]`.

**Si la conjetura `α = 2^{1/(1+log_2 3)} ≈ 1.5396` se confirmara numéricamente**, eso no implica directamente la no-regularidad de `L_div`, pero sí ofrece una **firma cuantitativa esperada** del exponente de crecimiento de prefijos divergentes que un hipotético contraejemplo regular debería respetar — y dado que las familias bombeables tienen crecimiento muy estructurado (lineal en el número de copias de `y`), la combinación con la pseudo-aleatoriedad sugerida por 10 endurece (no demuestra) la no-regularidad. Lo registro como **evidencia heurística**, no como teorema.

---

## 4. Interfaz para agente_02 (estructura aditiva sobre paridad-vectores)

### Interfaz para agente_02

Mi argumento de la sección 2, paso (4) — "una palabra bombeable produce densidad `c_{reg,1}/log X`" — usa estructura aditiva: la familia `{val(x y^i z)}_i` es una **progresión aritmética generalizada** en `Z` (suma de un término geométrico en base 2 más un offset), y necesito una cota inferior sobre la fracción de tales `n_i` que aterriza en `[X, 2X]` con paridad-vector compatible con el de `n_0`.

Lo que pido a agente_02 (si decide importar `U^2`-Gowers): una **cota inferior `β_2`-tipo** para la densidad de progresiones aritméticas dentro de un mismo paridad-vector `P_ω`. Concretamente:

(I-09→02.a) Sea `ω ∈ {0,1}^k` tal que `P_ω ∩ E_ε(X) ≠ ∅`. ¿Cuál es la densidad mínima de `P_ω ∩ E_ε(X)` en progresiones aritméticas de razón `2^{|y|}` y longitud `≥ X^{1-η}`?

(I-09→02.b) Si la cota `β_2(N, k) = O(2^{-k/2}·(log N)^C)` se cumple (versión optimista de agente_02), entonces el conjunto bombeable `F_p(X)` se reparte sobre paridad-vectores con sesgo `≪ X·(log X)^{-c(ε)} / 2^{k/2}`, lo que **refuerza** el paso (5) de la sección 2 reemplazando el `(log X)^{-c(ε)}` por un decaimiento más rápido cuando `k ~ log X`.

Es decir: una `β_2`-cota no trivial de 02 podría **rescatar** la sección 2 incluso si `c(ε) ≤ 1`. Marco esto como **canal de rescate posible** y pido a 02, si decide ir por la rama (b) de su encargo (sub-lema duro), que enuncie su cota con `k = c · log N` y `N = X`, no con `k` libre.

**Lo que entrego a 02 a cambio:** la observación de que la regularidad hipotética de `L_div` impone progresiones aritméticas binarias entre los `n` divergentes, lo cual es **exactamente** el tipo de estructura aditiva que la norma `U^2` debería detectar. Si 02 no detecta sesgo aditivo, entonces (sin contradicción con E-Tao) la rama regular se cierra.

---

## 5. Diferenciación con sprint_01

- Sprint_01 reclamaba "Conjetura de trabajo S1: `L_div` no regular es demostrable". Sprint_02 **corrige** ese optimismo: la demostración depende de un `c(ε) > 1` que el sprint_02 de agente_01 explícitamente no entrega. La etiqueta del sub-problema baja de "ejercicio de teoría de lenguajes apoyado en cota analítica" a "reducción condicional con bloqueo cuantitativo identificado".
- El intento "subir un peldaño" hacia *no libre de contexto* (S2) queda **pospuesto**: no tiene sentido aplicar Ogden/Parikh hasta cerrar el paso (5) regular.
- La conexión con agente_10 resulta **más débil** de lo que esperaba: la cota `α_0^k` sobre prefijos contractivos no se transfiere directamente a `Pref_div`. Registro la asimetría.

---

## 6. Sub-problema para sprint 3

**Enunciado.** Cerrar el paso (5) de la sección 2 con cuentas auditables, identificando **el valor concreto de `c(ε)` que se requiere de E-Tao** para que el argumento de bombeo dé contradicción. Producir uno de:

1. Un teorema condicional preciso: "Si E-Tao con `c(ε) > c*` para algún `ε ∈ (0,1/2)`, entonces `L_div` es vacío o no regular", con `c*` numérico explícito (mi expectativa: `c* = 1`, pero hay que verificar la potencia exacta de `log X` que produce la familia bombeable).
2. O bien una demostración de que, *combinando* E-Tao con la cota `α_0^k < 2^k` de agente_10 (y, opcionalmente, una `β_2`-cota no trivial de agente_02), la no-regularidad de `L_div` se obtiene **incondicional** sobre `c(ε)`.

**Criterio de éxito medible.** Lema con hipótesis, tesis y constantes nombradas, sin `[verificar]` en el paso central; o bien una obstrucción concreta (qué línea del bombeo no se puede empujar) con argumento de por qué.

---

## 7. Autoevaluación

**Improbable.** Sprint 2 me obliga a degradar mi optimismo de sprint 1. La no-regularidad de `L_div` *condicional a `c(ε) > 1`* es razonable y la reducción está limpia; pero el sprint_02 de agente_01 no entrega `c(ε)` numérico y reconoce su bloqueo. Sin ese cierre, mi resultado es "reducción", no "teorema". El input de agente_10 ayuda menos de lo esperado por la asimetría contractivos/divergentes. La grieta está identificada y es localizable (paso 5 de sección 2), lo cual es ganancia neta sobre sprint 1; pero el corazón sigue bloqueado por la efectivización de Tao 2019, que es el cuello de botella de toda la cadena ANÁLISIS EFECTIVO.
