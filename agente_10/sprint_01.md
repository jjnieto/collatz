# Sprint 1 — agente_10 (rol Allouche/Steinerberger)

**Célula 5 — Combinatoria de palabras, complejidad sub-lineal**

## 1. Encuadre

Dado $n \in \mathbb{N}$, sea $T(n) = n/2$ si $n$ par, $T(n) = (3n+1)/2$ si $n$ impar (función de Syracuse). Definimos la **palabra de paridad** $w(n) = w_0 w_1 w_2 \dots \in \{0,1\}^{\mathbb{N}}$ con $w_i = n_i \bmod 2$, donde $n_0=n$ y $n_{i+1}=T(n_i)$. Si $n$ alcanza el ciclo trivial, la palabra termina con sufijo $\overline{10}$ (paridades de $\dots,2,1,2,1\dots$); si no, es infinita aperiódica.

Mi ángulo: tratar $w(n)$ como objeto combinatorio y medir cuantitativamente su complejidad, en lugar de clasificar el lenguaje subyacente en la jerarquía de Chomsky (eso lo hace agente_09).

## 2. Estado del arte breve

**Terras (1976) y Everett (1977)** establecieron que la aplicación $n \mapsto w(n)\!\upharpoonright\! k$ (los primeros $k$ bits) recorre todas las $2^k$ palabras posibles sobre clases de congruencia módulo $2^k$, y que cada clase tiene densidad $2^{-k}$. Es decir, **toda palabra finita aparece como prefijo de alguna órbita**, y de hecho aparece con la frecuencia "esperada" $2^{-k}$ entre los enteros. Consecuencia inmediata: el **lenguaje de factores** del conjunto $\{w(n) : n \in \mathbb{N}\}$ es trivialmente $\{0,1\}^*$. Esto mata cualquier intento ingenuo de medir la "complejidad combinatoria" mirando solo qué palabras finitas aparecen.

**Lagarias (1985, survey)** y luego **Lagarias–Weiss** formalizaron la dinámica 2-ádica: la extensión $T:\mathbb{Z}_2 \to \mathbb{Z}_2$ es conjugada al shift de Bernoulli $(\mathbb{Z}_2,+1)$ mediante la "función conjugadora" $\Phi$ de Bernstein [verificar referencia exacta]. Bajo esta conjugación, la medida de Haar en $\mathbb{Z}_2$ corresponde a la medida de Bernoulli $(1/2,1/2)$ sobre las palabras de paridad. Esto implica que, **vista en $\mathbb{Z}_2$**, la dinámica simbólica de Collatz es la de máxima entropía posible: $h_{\text{top}} = \log 2$, frecuencias de bits exactamente $1/2$, factores equidistribuidos.

**Allouche–Shallit (Automatic Sequences, 2003)** desarrollan la teoría de complejidad sub-lineal: una secuencia tiene complejidad $p(n) = n+1$ sii es sturmiana (rotación irracional en el círculo), $p(n) = O(n)$ para secuencias automáticas, $p(n)$ polinomial para morphic, etc. Aplicado a Collatz: ninguna palabra $w(n)$ individual con $n$ no preperiódico al ciclo trivial se sabe sturmiana o automática.

**Steinerberger (2017–2022)** [verificar] introdujo perspectivas de tipo "ergódico cuantitativo" sobre la distribución del cociente $T(n)/n$ en escala logarítmica, conectando con la heurística de Sinai–Kakutani y con desigualdades isoperimétricas. Su aportación útil aquí es la idea de medir **desviaciones de la frecuencia esperada** $1/2$ en prefijos finitos.

**Kontorovich–Sinai (2002)** [verificar] dieron una formulación estructural en términos de paseos aleatorios sobre el árbol de Collatz inverso; la entropía relativa de los paseos respecto a Bernoulli es 0 a la primera aproximación, pero las correcciones de orden inferior contienen, en principio, información.

## 3. Lo que huele a muerto

- **Buscar complejidad sub-lineal $p_{w(n)}(k) \le Ck$ para un $n$ específico.** Si existiera tal $n$ con $w(n)$ sturmiana o automática, sería un teorema enorme; nadie lo cree, y la conjugación 2-ádica con Bernoulli es evidencia fuerte en contra.
- **Frecuencias de letras individuales.** Por el argumento de Terras, la frecuencia asintótica de $1$ en $w(n)$ es $1/2$ para casi todo $n$ en sentido natural; no aporta.
- **Entropía topológica del shift cerradura de $\{w(n)\}$.** Es $\log 2$. Trivial.

## 4. Lo que sí puede dar fruto

La esperanza no está en la complejidad **global** sino en **invariantes finos de palabras individuales**:

1. **Discrepancia de prefijos.** Definir $D_k(n) = \big|\,\#\{i<k : w_i(n)=1\} - k/2\,\big|$. La heurística Bernoulli predice $D_k = O(\sqrt{k \log\log k})$ (LIL). ¿Hay órbitas con discrepancia anómala? Una órbita divergente debe tener $D_k$ con sesgo negativo persistente (más $0$s, porque $1$s suben y $0$s bajan; el balance crítico es $\log_2 3 / (1+\log_2 3) \approx 0.6309$, no $1/2$, **una vez se contabiliza el peso multiplicativo**).
2. **Función de complejidad ponderada.** En vez de contar factores de $w(n)$, contar factores **ponderados por su contribución multiplicativa** $\prod 3^{w_i} / 2$. La pregunta natural: ¿qué palabras finitas $u$ son "compatibles" con $T^k(n) < n$? Esto da una función $p^*(k)$ = número de prefijos de longitud $k$ realizables por algún $n < N$ y cuyo producto sea $< 1$. Mediblemente sub-exponencial en $k$.
3. **Frecuencias de factores prohibidos en bajo nivel.** Para $n$ pequeño y prefijos cortos, identificar **factores raros** (palabras $u$ que aparecen con frecuencia mucho menor que $2^{-|u|}$ cuando uno restringe a $n$ que alcanzan $1$ en tiempo $\le c \log n$). Esto es estadística combinatoria, computable.
4. **Entropía topológica de la "trayectoria normalizada".** Steinerberger sugiere mirar $\log n_i - \log n_0$ como paseo; la palabra natural no es $w(n)$ sino la **secuencia de signos de incrementos**, que es función de $w(n)$ pero más rica.

## 5. Sub-problema para sprint 2

Estudio de la **función de complejidad ponderada** $p^*_N(k)$: número de palabras binarias $u \in \{0,1\}^k$ tales que existe $n \le N$ con $w(n)\!\upharpoonright\! k = u$ **y** $T^k(n) < n$ (contracción efectiva en $k$ pasos). Comparar con la cota trivial $\min(2^k, N)$ y con la cota multiplicativa $\#\{u : 3^{|u|_1} < 2^k\} \sim 2^{k/(1+\log_2 3)}$.

**Criterio de éxito medible (sprint 2):**
- Calcular $p^*_N(k)$ para $N \in \{10^6, 10^8\}$ y $k \in \{10, 20, 30, 40\}$ — tabla numérica.
- Producir una **conjetura cuantitativa** de la forma $p^*_N(k) = \alpha^k (1+o(1))$ con $\alpha$ estimado a tres decimales, y contrastar con $2^{1/(1+\log_2 3)} \approx 1.5396$.
- Demostrar (con prueba auditable, no heurística) una cota superior $p^*_N(k) \le C\cdot \alpha_0^k$ con $\alpha_0$ explícito $< 2$, independiente de $N$.

Si $\alpha < 2$ con prueba, se obtiene una **cota combinatoria sobre el número de órbitas contractivas**, traducible a densidad de enteros con tiempo de parada corto.

## 6. Autoevaluación

### Sub-problema para sprint 2
Cuantificar $p^*_N(k) = \#\{u \in \{0,1\}^k : \exists\, n \le N,\ w(n)\!\upharpoonright\! k = u,\ T^k(n) < n\}$ y demostrar una cota $p^*_N(k) \le C\alpha_0^k$ con $\alpha_0 < 2$ explícito.
**Criterio de éxito:** tabla numérica para $N \le 10^8$, $k \le 40$; conjetura para la constante $\alpha$; teorema con $\alpha_0$ explícito y prueba auditable (no heurística probabilística).

### Autoevaluación
**Improbable.** La estructura "Bernoulli en $\mathbb{Z}_2$" sugiere que toda complejidad medible será trivialmente máxima, y los refinamientos finos (discrepancia, complejidad ponderada) son notoriamente resistentes — la cota $2^{k/(1+\log_2 3)}$ es del tipo de las que Krasikov–Lagarias y sucesores ya han manejado sin lograr cerrar Collatz. Vale la pena seguir porque la métrica $p^*_N(k)$ es **computable** y nunca se ha tabulado sistemáticamente con foco en complejidad de factores (sólo en tiempo de parada), de modo que aunque el ángulo no produzca un teorema, sí puede aportar datos limpios reutilizables por agentes_05, 06 y 09.
