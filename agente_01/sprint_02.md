# Sprint 2 — agente_01 (rol Tao, cadena ANÁLISIS EFECTIVO, productor)

## 0. Estado de la tarea

El encargo pide la **redacción precisa** del enunciado intermedio efectivo E-Tao con `f(n) = n^{1-ε}` y una tasa `g(X,f) = O((\log X)^{-c(\varepsilon)})` con `c(\varepsilon)` simbólico (aunque pésimo). No la prueba. A continuación cumplo con (1) el enunciado en formato lema, (2) la localización de la pérdida cuantitativa dentro del preprint de Tao 2019 (arXiv:1909.03562), (3) las dos interfaces para 02 y 09. Marco con `[verificar]` cada vez que la cita de sección/página o el exponente concreto va más allá de mi lectura segura.

---

## 1. Enunciado E-Tao (efectivo intermedio)

**Lema E-Tao (versión Sprint 2).**
Sea `Syr: 2\mathbb{N}+1 \to 2\mathbb{N}+1`, `Syr(n) = (3n+1)/2^{\nu_2(3n+1)}`, la función de Syracuse. Para `n` impar y `K \in \mathbb{N}`, sea `\mathrm{Syr}^K(n)` la `K`-ésima iteración. Sea `\mathrm{Min}(n) := \inf_{k \ge 0} \mathrm{Syr}^k(n)`.

**Hipótesis (constantes nombradas):**
- `\varepsilon \in (0, 1/2)` fijo.
- `X \ge X_0(\varepsilon)` con `X_0(\varepsilon)` efectivo `[verificar]`.
- `f_\varepsilon(n) := n^{1-\varepsilon}`.
- Constantes absolutas: `c_1 > 0` (calidad de equidistribución 2-ádica de Syracuse, §1.3 Tao 2019 `[verificar]`), `c_2 > 0` (tasa de la ley débil de los grandes números efectiva sobre los incrementos `\log(3/2^{a_k})`).

**Conjunto excepcional:**
`\mathcal{E}_\varepsilon(X) := \{ n \in [X, 2X] \cap (2\mathbb{N}+1) : \mathrm{Min}(n) > f_\varepsilon(n) \}.`

**Tesis (cota efectiva):** existe `c(\varepsilon) > 0` calculable tal que
`\mathrm{dens}_{\log}(\mathcal{E}_\varepsilon(X)) \;\le\; C_0 \cdot (\log X)^{-c(\varepsilon)},`
donde `\mathrm{dens}_{\log}` denota densidad logarítmica relativa al intervalo `[X, 2X]` y `C_0` es una constante absoluta `[verificar]`.

**Forma simbólica del exponente:** `c(\varepsilon) = \min\{c_1, c_2\} \cdot \varepsilon^{A}` con `A \in \{2, 4, 10\}` `[verificar]`. La elección concreta de `A` depende de cómo se controla el término de cola en la integración sobre `a_k`. Mi mejor apuesta razonable es `A = 4`, pero no lo afirmo: lo identifico como el **primer parámetro técnico** que 02 y 09 deben tratar como caja negra simbólica.

**Nota sobre el rango de `\varepsilon`.** El argumento es genuinamente sensible a `\varepsilon`: para `\varepsilon \to 0` (descenso muy ligero) la cota debe ser casi trivial; para `\varepsilon \to 1/2` (descenso a `n^{1/2}`, ya cerca de "casi acotado") la cota se acerca a la frontera del método de Tao y `c(\varepsilon) \to 0`. Para `\varepsilon > 1/2` el enunciado **no está cubierto** por la maquinaria de Tao 2019 sin idea nueva (capa B de mi sprint 1).

---

## 2. Localización de la pérdida cuantitativa dentro de Tao 2019

Tao 2019 (arXiv:1909.03562, "Almost all orbits of the Collatz map attain almost bounded values"). La pérdida cuantitativa de efectividad en `f` está **concentrada en la proposición 1.17 y su uso en §3**, según mi lectura del preprint `[verificar sección exacta — el preprint tiene §1.3 enunciado, §2 reducciones, §3 prueba de la cota de Fourier]`.

- **Sección 1.3 (enunciado del teorema 1.3).** El parámetro `f` aparece como función test arbitraria; no hay constantes efectivas asociadas.
- **Proposición 1.17 `[verificar numeración]`** (cota de Fourier sobre la distribución de `\log_3 Syr^N(\mathbf{a})`). Es aquí donde se pierde efectividad: la cota es del tipo "para todo `\eta > 0` existe `N_0(\eta)`". El `N_0` es el portador de la inefectividad y no se rastrea a través de §1.3.
- **§3 (paso a densidad logarítmica).** El argumento de Borel–Cantelli logarítmico convierte la cota de la proposición 1.17 en densidad 1; aquí la dependencia en `f` se diluye en un `o(1)` no rastreado.

**Punto exacto donde inyectar `c(\varepsilon)`:** la cota de tipo Fourier de la proposición 1.17 admite, *creo*, una versión cuantitativa donde `\eta` se elige `\eta = \varepsilon` y `N_0(\eta)` se acota por `(\log X)^{c'(\varepsilon)}`. Esa elección, propagada por §3, da la tasa polilogarítmica del enunciado E-Tao. **No tengo aún la cuenta cerrada**; lo afirmo como esqueleto y lo identifico como el sub-problema del sprint 3 (sección final).

---

## 3. Interfaz para agente_02 (rol Maynard/Green)

### Interfaz para agente_02

**Objeto producido por 01:** Lema E-Tao tal y como en sección 1 de este documento, con su constante simbólica `c(\varepsilon)` y su conjunto excepcional `\mathcal{E}_\varepsilon(X)`.

**Cómo se consume en una cota de sesgo `β_2(N,k)`:**
Sea `\beta_2(N,k)` el sesgo (en norma `U^2`-Gowers) del vector de paridades `(\pi_1(n), \ldots, \pi_k(n))` con `\pi_j(n) := \mathrm{Syr}^j(n) \bmod 2`, promediado sobre `n \in [N, 2N]`.

01 entrega a 02 lo siguiente:

(I-02.a) Para todo `\varepsilon \in (0, 1/2)`, salvo un conjunto excepcional de densidad logarítmica `\le C_0 (\log N)^{-c(\varepsilon)}`, la órbita Syracuse de `n \in [N, 2N]` baja de `n^{1-\varepsilon}` antes de `K_\varepsilon(n) := \lceil C_1 \log n \rceil` pasos, con `C_1 = C_1(\varepsilon)` efectivo `[verificar]`.

(I-02.b) Equivalentemente: el vector de paridades `(\pi_1, \ldots, \pi_k)` está, fuera de ese conjunto excepcional, **sesgado** hacia configuraciones con suma `\sum a_j \ge (\log_2 3) k + \kappa(\varepsilon)\sqrt{k}` para `\kappa(\varepsilon) > 0` explícito.

02 puede entonces:
- (a) o bien probar que (I-02.b) ya implica trivialmente su cota `\beta_2(N,k) = o(1)` (línea callejón sin salida, en su autoevaluación);
- (b) o bien usar (I-02.a) como hipótesis externa para reducir su cota `U^2` a un sub-lema sobre estructura aditiva del complemento del conjunto excepcional.

**Variables y dominios.** `N \ge X_0(\varepsilon)`, `k \le K_\varepsilon(N)`, `\varepsilon \in (0, 1/2)`. **Hipótesis externa que 02 no debe re-demostrar:** Tao 2019 (versión cualitativa). **Lo que 02 puede pedir a 01 en sprint 3:** que `c(\varepsilon)` se haga numérico, o que `\kappa(\varepsilon)` se haga explícito en términos de `c_1, c_2`.

---

## 4. Interfaz para agente_09 (rol Shallit)

### Interfaz para agente_09

**Objeto producido por 01:** mismo Lema E-Tao.

**Cómo actúa como hipótesis externa en el argumento de no-regularidad de `L_div`:**
Sea `L_{\mathrm{div}}` el lenguaje de paridad-vectores `\{(\pi_1(n), \pi_2(n), \ldots) : n \text{ órbita divergente}\}` sobre el alfabeto `\{0,1\}`.

(I-09.a) Bajo E-Tao, el conjunto de `n \in [X, 2X]` cuya órbita Syracuse **no** baja de `n^{1-\varepsilon}` tiene densidad logarítmica `\le C_0 (\log X)^{-c(\varepsilon)}`. En particular, cualquier palabra infinita de `L_{\mathrm{div}}` que provenga de un `n` divergente está en ese conjunto excepcional **para todo `\varepsilon`**.

(I-09.b) Constante de bombeo: si `L_{\mathrm{div}}` fuera regular con constante de bombeo `p`, existirían palabras divergentes de longitud `\le p` con prefijos arbitrariamente bombeables. E-Tao implica que tales palabras corresponden a `n` en un conjunto de densidad logarítmica `\le C_0 (\log X)^{-c(\varepsilon)}`, lo que (combinado con que la regularidad da densidad positiva sobre los prefijos) produciría una contradicción cuantificada con
`(\log X)^{-c(\varepsilon)} \cdot X \ge c_{\mathrm{reg}}(p) \cdot X / \log X,`
es decir `c(\varepsilon) \le 1` `[verificar la dirección de la desigualdad — esto es el esqueleto del argumento, no la prueba]`.

**Variables y dominios.** `\varepsilon` libre (09 lo elige), `p` la hipotética constante de bombeo. **Hipótesis externa que 09 no debe re-demostrar:** Tao 2019 cualitativo. **Lo que 09 puede pedir a 01 en sprint 3:** la dependencia de `c(\varepsilon)` cuando `\varepsilon \to 0`, porque el argumento de bombeo es más fuerte cuanto menor `\varepsilon`.

---

## 5. Bloqueo técnico abierto

No tengo aún la cuenta cerrada de cómo la proposición 1.17 de Tao 2019 admite cuantificación con `c(\varepsilon)` explícito. Es el bloqueo principal y se traduce en el sub-problema de sprint 3.

---

### Sub-problema para sprint 3

**Enunciado.** Cerrar la cuenta interna en la proposición 1.17 (Tao 2019) que convierte la cota cualitativa de Fourier en una cota con `\eta = \varepsilon` y `N_0(\eta) \le (\log X)^{c'(\varepsilon)}`. Producir un valor admisible de `c(\varepsilon)` (aunque sea `\varepsilon^{10}`).

**Criterio de éxito medible.** Un teorema con `c(\varepsilon)` numérico explícito, o bien una identificación precisa (sección + ecuación de Tao 2019) de la línea donde la inefectividad es estructural y no removible.

### Autoevaluación

**Improbable.** El enunciado E-Tao queda formulado como lema con todas sus piezas nombradas y dos interfaces explícitas. La pieza ausente —el valor concreto de `c(\varepsilon)`— está localizada pero no resuelta. La tubería ANÁLISIS EFECTIVO queda enchufada en simbólico; queda por ver si 02 y 09 pueden trabajar con `c(\varepsilon)` como caja negra o si requieren un valor antes. Mantengo "Improbable" porque la grieta sigue siendo la efectivización de una equidistribución asintótica, y eso es genéricamente difícil.
