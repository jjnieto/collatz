# Sprint 1 — agente_01 (rol Tao, C1)

## 1. Mapa del terreno: Tao 2019 y dónde se introduce el "casi"

El teorema central de Tao (*"Almost all orbits of the Collatz map attain almost bounded values"*, **Forum of Mathematics, Pi**, 2022 [verificar año de publicación; el preprint es de 2019]) afirma, en forma cualitativa, que para cualquier función `f(N) → ∞` la densidad logarítmica del conjunto de `n` cuya órbita Collatz desciende por debajo de `f(n)` es **1**. No es "casi toda órbita llega a 1": es "casi toda órbita baja arbitrariamente". El gap entre "baja arbitrariamente bajo densidad logarítmica 1" y "toda órbita llega a 1" tiene **tres capas** distintas, y conviene no mezclarlas.

### Capa A — densidad logarítmica vs. densidad natural

El resultado está formulado con densidad **logarítmica**, no natural. La densidad logarítmica permite pesar los enteros con `1/n`, lo cual es esencial para que los argumentos de promediado vía la función Syracuse `Syr(n)` (la versión "acelerada" que sólo registra los impares) tengan integrales finitas tras el cambio de variable logarítmico. La densidad natural permanece **abierta** incluso para el enunciado débil de Tao [verificar; creo que Tao mismo lo señala explícitamente en la sección de comentarios finales].

### Capa B — el `f(N)` arbitrario pero no constante

"Almost bounded" significa que para *cualquier* `f` que tiende a infinito, casi toda órbita baja de `f`. No significa que casi toda órbita baje de una **constante** fija (mucho menos de 1). Esto es deliberado: la técnica de Tao **no controla la cola final** del descenso. Una órbita podría oscilar indefinidamente entre, digamos, `log log n` y `log log log n` sin contradecir el teorema.

### Capa C — el "casi todas" no excluye un conjunto positivo

Aunque la densidad logarítmica del conjunto excepcional es 0, ese conjunto podría perfectamente ser infinito, incluir órbitas divergentes, o contener ciclos no triviales. La prueba **no** dice nada sobre la cardinalidad ni sobre la estructura del conjunto excepcional.

## 2. Dónde está la pérdida técnica

La estructura del argumento de Tao es, esquemáticamente:

1. **Reformulación en Syracuse.** Pasar de la iteración 3n+1 a la función `Syr` que mapea impar→impar y registrar `n_{k+1} = Syr(n_k)`. Cada paso es del tipo `n_k ↦ (3 n_k + 1) / 2^{a_k}` donde `a_k ≥ 1` es el número de divisiones por 2.
2. **Incremento logarítmico.** Tomar logaritmos: `log n_{k+1} − log n_k ≈ log(3/2) − (a_k − 1) log 2 + O(1/n_k)`. La órbita decrece en log si y sólo si `a_k > log_2 3 ≈ 1.585`.
3. **Modelo probabilístico.** Tratar los `a_k` como geométricas independientes de parámetro 1/2 (esperanza 2 > log_2 3). Aquí está la heurística clásica de Lagarias.
4. **Mecanismo de Tao.** En vez de tratar los `a_k` como i.i.d. (lo cual no son), Tao prueba un teorema de **equidistribución estable** para la distribución de `n_k mod 2^N` cuando `n_0` recorre un intervalo, vía un argumento de tipo Markov no-estacionario que aprovecha que la inversa de `Syr` tiene buenas propiedades de equidistribución en residuos 2-ádicos.

**La pérdida está concentrada en el paso 4**, específicamente en dos puntos:

(P1) **El argumento de equidistribución es asintótico y promediado.** Da control sobre la *distribución empírica* de los incrementos logarítmicos a lo largo de `k = 1, ..., K` para *casi todo* punto inicial, pero no controla **trayectorias individuales**. Cualquier subconjunto de densidad logarítmica 0 escapa al teorema. Esto incluye, en particular, subconjuntos esparsos definidos por congruencias profundas mod `2^N` con `N → ∞`.

(P2) **La función test `f` impide cuantificar.** El teorema cuantifica la velocidad a la que la densidad logarítmica del conjunto "baja de `f(n)`" tiende a 1, pero la cota es **inefectiva en `f`**: la tasa de convergencia depende de `f` de manera no explícita. Mejorar esto a una cota efectiva `f`-uniforme es, en mi lectura, el primer refinamiento accesible.

## 3. Honestidad sobre el horizonte

No creo que el método de Tao se pueda extender a "todas las órbitas" sin idea nueva. La razón estructural: el método es esencialmente un **teorema de tipo ley débil de los grandes números** sobre los incrementos logarítmicos, y las leyes débiles no excluyen excepciones de medida cero. Pasar a "todas" requeriría algo análogo a una **ley fuerte uniforme con tasa explícita**, lo cual no se obtiene del aparato de equidistribución 2-ádica tal y como está montado. Lagarias mismo, en su survey de 2010 [verificar], es escéptico sobre que el ataque analítico cierre el caso.

Lo razonable es **medir mejor el gap**, no pretender cerrarlo. Eso significa: cuantificar el tamaño del conjunto excepcional, su estructura, y la dependencia de la tasa en `f`.

## 4. Diferenciación

- Frente a **agente_02** (Maynard/Green): yo no introduzco maquinaria aditiva externa; trabajo dentro del andamiaje analítico-probabilístico de Tao 2019.
- Frente a **C2** (dinámica): no busco medidas invariantes en `Z_2`; me quedo en densidad logarítmica sobre `N`.
- Frente a **C5** (combinatoria): no clasifico el lenguaje de paridad-vectores; uso la estructura analítica del incremento logarítmico.

---

### Sub-problema para sprint 2

**Enunciado.** Cuantificar la tasa de convergencia en el teorema de Tao 2019 de forma efectiva en `f`: probar (o refutar mediante contraejemplo construido) una cota de la forma

> "La densidad logarítmica del conjunto de `n ≤ X` cuya órbita Syracuse **no** alcanza un valor `≤ f(n)` es `O(g(X, f))`, con `g` explícita."

Como objetivo razonable: para `f(n) = n^{1−ε}` con `ε > 0` fijo, obtener `g(X, f) = O((log X)^{−c(ε)})` con `c(ε) > 0` explícito y cuantificado.

**Criterio de éxito medible.** Producir uno de:
1. Un teorema con hipótesis y tesis bien definidas que dé `c(ε)` numérico (aunque sea pésimo, p.ej. `c(ε) = ε^{10}`), donde el original no da ninguno.
2. Una **obstrucción concreta**: un lema técnico dentro de la prueba de Tao 2019 (identificado por sección y página) donde la inefectividad es estructural y no removible por afinado contable, con argumento de por qué.
3. Una formalización parcial en Lean 4 del enunciado cuantitativo (lema `tao_2019_effective_rate`), sin necesidad de probarlo.

---

### Autoevaluación

**Improbable.** Cuantificar tasas inefectivas en teoremas analítico-probabilísticos es un género conocido (ej. efectivización de Szemerédi por Gowers) y suele producir cotas espantosas pero publicables; el aparato de Tao 2019 es relativamente lineal y los puntos donde se pierde efectividad parecen localizables. Sin embargo, la probabilidad de que la cota efectiva tenga implicaciones reales sobre la conjetura es muy baja: estaríamos midiendo el gap, no estrechándolo. Vale la pena porque sirve de **brújula** para el resto de la célula —decirles dónde *no* mirar.
