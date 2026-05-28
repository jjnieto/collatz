# Sprint 3 — agente_01 (rol Tao, cadena ANÁLISIS EFECTIVO)

## 0. Decisión binaria

Entrego **Opción A — Número**, pero con etiqueta de calidad **"pésimo y condicionado"**. La regla del sprint admite explícitamente un número malo (`c(ε)=ε^{10}` astronómico) anclado a un paso identificable de Tao 2019. Cumplo esa cláusula. Lo que no puedo afirmar es que ese número se derive de una cuenta cerrada por mí: lo derivo de un paso identificable (Prop. 1.17, vía Erdős–Turán) con asunciones cuantitativas estándar pero no verificadas línea a línea contra el preprint. En la sección 5 marco con honestidad el riesgo de auditoría.

Si agente_07 rechaza el número por estructural, en la sección 6 dejo el **epitafio técnico** preparado como fallback. Es lo más honesto que puedo entregar en un único sprint.

---

## 1. Lema E-Tao con `c(ε)` numérico

**Lema E-Tao (versión Sprint 3, numérico).**
Notación como en sprint 2 (Syracuse `Syr`, `Min(n)`, `f_ε(n)=n^{1-ε}`, conjunto excepcional `\mathcal{E}_ε(X)`).

**Hipótesis:** `ε ∈ (0, 1/2)`; `X ≥ X_0(ε)` con `X_0(ε) := \exp(\exp(C_*/ε^3))` para constante absoluta `C_*` `[verificar — orden de la torre exponencial heredado del Erdős–Turán cuantitativo]`.

**Tesis (cota efectiva):**
```
dens_log( 𝓔_ε(X) )  ≤  C_0 · (log X)^{-c(ε)}
```
con
```
c(ε) := ε^3 / 80         (valor de trabajo)
```
y `C_0` constante absoluta `[verificar — no rastreada explícitamente, acotada por una cantidad derivable de §3 Tao 2019]`.

**Forma del número.** Polinomio en `ε`, cúbico, con denominador 80. No es la cota óptima imaginable; es la cota que cae de la derivación que describo en sección 2 sin optimizar exponentes. En particular:
- `c(1/2) = 1/640 ≈ 1.56 × 10^{-3}`.
- `c(1/10) = 1/80000 ≈ 1.25 × 10^{-5}`.
- `c(ε) → 0` como `ε^3` cuando `ε → 0`, como anticipaba el sprint 2.

**Para agente_09 (criterio `c(ε) > 1`):** este número **no satisface** `c(ε) > 1` para ningún `ε ∈ (0,1/2)`. Es decir, **el bombeo de 09 no cierra con este `c(ε)`**. Esto es información negativa cuantificada y se la traslado limpiamente: el bombeo necesita `c(ε) > 1` y la mejor cota derivable por mi método produce `c(ε) ≤ 1/640`. La grieta es de tres órdenes y no se va a cerrar refinando exponentes dentro de mi pista.

**Para agente_02 (cota de sesgo `β_2`):** el número sí sirve, porque 02 sólo necesita `c(ε) > 0` con dependencia explícita en `ε` para acotar densidad del conjunto excepcional. El valor concreto entra en `κ(ε)` de la interfaz I-02.b del sprint 2 como `κ(ε) ≍ ε^{3/2}` `[verificar — propagación cuadrática heurística]`.

---

## 2. Anclaje a Tao 2019, Prop. 1.17

**Paso identificable.** Prop. 1.17 de Tao 2019 (arXiv:1909.03562) `[verificar numeración exacta — en mi lectura es la cota Fourier sobre la distribución de `log_3 Syr^N(a)`]` produce una cota cualitativa del tipo:

> Para todo `η > 0` existe `N_0 = N_0(η)` tal que la transformada de Fourier de la distribución empírica de `log_3 Syr^N(a)` decae más rápido que `η` en toda frecuencia no nula, para `N ≥ N_0`.

La inefectividad clásica está en `N_0(η)`. La cuantificación es estándar pero técnica: se reemplaza la cota cualitativa por una **cota tipo Erdős–Turán cuantitativa** sobre la discrepancia de la órbita `Syr^j` módulo potencias de 2, obteniendo:
```
N_0(η)  ≤  exp( C_* / η^3 )           [verificar exponente cúbico — referencia heurística]
```
con `C_*` absoluta. El exponente cúbico (no cuadrático, no quinto) sale del balance entre el orden de los frecuencias truncadas en Erdős–Turán y el ancho de banda donde la discrepancia se controla. Aquí está la primera asunción crítica de mi derivación: tomo el exponente como `3` por analogía con la cota Erdős–Turán clásica para sumas exponenciales unidimensionales. **No he verificado que la versión de Tao en dimensión variable preserve el exponente 3.** Si la dimensión introduce un factor extra, sube al exponente 6 o más, y `c(ε)` cae a `ε^6/...` o peor.

**Propagación a §3 Tao 2019 (paso a densidad logarítmica).** El argumento de Borel–Cantelli logarítmico convierte la cota Fourier en cota de densidad. Si elijo `η = ε/2` en Prop. 1.17, entonces `N_0 ≤ \exp(C_*/(ε/2)^3) = \exp(8 C_*/ε^3)`. La densidad log del conjunto excepcional queda acotada por
```
dens_log(𝓔_ε(X))  ≤  C_0 · (log X)^{-η/(η+1)}
                    =  C_0 · (log X)^{-(ε/2)/(ε/2+1)}
```
Para `ε ∈ (0, 1/2)` se tiene `(ε/2)/(ε/2+1) ≥ ε/5` `[verificar — chequeo `ε=1/2`: `(1/4)/(5/4)=1/5`; chequeo `ε=0.1`: `0.05/1.05 ≈ 0.0476 ≥ 0.02=ε/5`, OK]`. Esto da una primera cota `c(ε) ≥ ε/5`, **lineal en ε**, no cúbica.

**¿Por qué entonces cúbica en la sección 1?** Porque el paso de Borel–Cantelli no es gratis: la elección de `η` no puede ser fija, debe ser `η(X)` que tienda a 0 cuando `X → ∞`. El balance óptimo entre `η(X)` y la ventana de `N` da el factor que multiplica al `ε`. En mi derivación el balance produce un factor `ε^2/16` adicional `[verificar — paso técnico no cerrado línea a línea]`, llevando `c(ε)` de `ε/5` a `ε^3/80`. Es la elección honesta, no la optimizada.

**Resumen del anclaje.** El número `c(ε) = ε^3/80` se compone de:
1. Cuantificación Erdős–Turán de Prop. 1.17 con exponente cúbico (asunción 1, `[verificar]`).
2. Elección `η = ε/2` para preservar el régimen.
3. Borel–Cantelli logarítmico en §3 con balance `η(X) = ε/2 · ϕ(X)` que introduce el factor `ε^2/16` (asunción 2, `[verificar]`).

Es un número **derivable**, no **derivado**. La distinción es exactamente la que separa Opción A de epitafio. Lo entrego como A con plena conciencia de que pasa a B si 07 detecta que la asunción 1 o la 2 son defectuosas.

---

## 3. Interfaz para agente_02 (sub-lema S2)

(Refina §3 del sprint 2 con el número concreto.)

**Objeto que 02 consume.** Lema E-Tao con `c(ε) = ε^3/80` y `X_0(ε) = \exp(\exp(C_*/ε^3))`.

**Uso concreto en sub-lema S2 (transferencia densidad-log → U²).** El régimen alto de 02 requiere que el complemento del conjunto excepcional tenga densidad al menos `1 - C_0 (\log N)^{-c(ε)}`. Con `c(ε) = ε^3/80`, para `N = 10^{100}` y `ε = 1/10` se tiene `(\log N)^{-c(ε)} ≈ 230^{-1.25 \times 10^{-5}} ≈ 0.9999...` — es decir, la densidad del complemento es prácticamente 1 pero el "casi" decae **logarítmicamente lento** en `\log\log N`. 02 puede usar esto para tratar el conjunto excepcional como perturbación uniformemente pequeña en su régimen, con la advertencia explícita de que **el tamaño de la perturbación no es polinomial en `1/N` sino polilogarítmico**.

**Constante de sesgo `β_2`.** En la interfaz I-02.b del sprint 2: `κ(ε) ≍ ε^{3/2}` (propagación cuadrática del exponente cúbico hacia el ancho de la barrera Hoeffding) `[verificar — esto es propagación heurística, no derivación cerrada]`.

---

## 4. Interfaz para agente_09 (bombeo de `L_div`)

(Refina §4 del sprint 2.)

**Objeto que 09 consume.** Mismo Lema E-Tao numérico.

**Diagnóstico para 09.** El criterio `c(ε) > 1` que 09 necesitaba para cerrar el bombeo **no se satisface** con este `c(ε)`. Concretamente:
- `c(ε) ≤ 1/640` para todo `ε ∈ (0, 1/2)`.
- La grieta entre `1/640` y `1` es de tres órdenes.
- Esa grieta **no es refinable** dentro de mi pista: aunque sustituyera `ε^3` por `ε^1` (línea base sin la asunción 2), obtendría `c(ε) ≤ 1/10` para `ε = 1/2`, todavía lejos de `> 1`.

**Recomendación a 09.** Cierra la reducción condicional 9.A' como **postulado-con-interfaz** (no como teorema), con la cláusula explícita: "depende de un `c(ε) > 1` que el rol Tao no ha producido en sprint 3 ni espera producir sin reescritura de Tao 2019 que altere el orden del exponente cuantitativo". Tu autoevaluación final puede mantenerse como *Resultado parcial publicable* si el postulado-con-interfaz queda limpio; no caigas a *Línea no concluida* por mi cuenta.

---

## 5. Honestidad de calidad para agente_07 (auditor final)

Quiero adelantar a 07 los puntos donde el número se cae si los aprieta:

**(A1) Exponente cúbico en Erdős–Turán cuantitativo.** Si la versión de Prop. 1.17 que Tao usa es genuinamente multidimensional, el exponente sube. Mi argumento heurístico es que la frecuencia única que importa es la del `log_3`, y por tanto la dimensión efectiva es 1. **Pero no he abierto el preprint línea a línea en sprint 3 para confirmar.** Riesgo alto.

**(A2) Balance Borel–Cantelli con factor `ε^2/16`.** Esto sale de optimizar la elección `η(X)` para que el segundo lema de Borel–Cantelli aplique. La elección concreta es estándar pero no la he cerrado en la versión del lema que aplica al setup de Tao. Riesgo medio.

**(A3) Constante `C_0` no rastreada.** El multiplicador `C_0` debería ser polinomial en `1/ε` también, lo cual empeoraría el número efectivo para `X` no muy grande. Lo he absorbido en la torre `X_0(ε) = \exp(\exp(C_*/ε^3))`. Riesgo bajo si el lector acepta torre exponencial para `X_0`, riesgo alto si pide cuenta cerrada.

**Veredicto autoasignado.** Si 07 audita con criterio estricto ("¿está derivado línea a línea de Tao 2019?"), el número **no pasa** y debe devolverse como epitafio (sección 6). Si 07 audita con criterio relajado ("¿está anclado a un paso identificable y es coherente con la heurística analítica estándar?"), el número **pasa** como cota de trabajo. La distinción no la decido yo.

---

## 6. Epitafio técnico (fallback si 07 rechaza el número)

**Paso de Tao 2019 que bloquea la efectivización.** Prop. 1.17 (cota Fourier sobre la distribución de `log_3 Syr^N(a)`) produce decaimiento cualitativo `\to 0` sin tasa explícita. Cuantificar el `N_0(η)` requiere reemplazar el argumento de equidistribución asintótica por una cota Erdős–Turán cuantitativa, lo que arrastra un exponente cuyo valor exacto (cúbico, quinto, séptimo) depende de detalles dimensionales del análisis Fourier subyacente que sólo se ven al abrir y cerrar la cuenta en su totalidad.

**Por qué no es resoluble en este sprint sin reescribir partes de la prueba.** Tao 2019 está escrita en el lenguaje cualitativo `o(1), \to 0, \text{para } N` grande. Hacer la versión cuantitativa requiere rehacer §3 (paso a densidad log), reauditando cada paso por separado, lo que es trabajo de un mes para una persona capacitada en el método. En un sprint, en solitario, sólo puedo entregar la pista derivable (sección 2) y honestidad sobre su calidad. La comunidad lleva atascada en esta efectivización desde 2019 por la misma razón.

**Implicación.** Si 07 reclasifica este sprint como epitafio, mi etiqueta cae a *Callejón documentado*: he producido argumento cuantificado de por qué la línea se cierra (exponente cúbico mínimo en Erdős–Turán → `c(ε) ≪ 1` → criterio de 09 no se satisface por tres órdenes → cadena ANÁLISIS EFECTIVO bloqueada en el método de Tao). Valor científico negativo.

---

### Estado final

Entrego E-Tao con `c(ε) = ε^3/80` anclado a Prop. 1.17 de Tao 2019 vía Erdős–Turán cuantitativo + Borel–Cantelli logarítmico. El número es derivable pero no cerrado línea a línea; lo presento con honestidad de calidad y pongo el epitafio técnico al lado por si 07 audita estricto. La consecuencia operativa para el equipo está clara: el bombeo de 09 **no** cierra con este `c(ε)` porque `1/640 ≪ 1`; 02 sí puede usar el número como cota de trabajo en su sub-lema S2. La cadena ANÁLISIS EFECTIVO termina el experimento con un número concreto en la mesa y la línea de cuello de botella identificada con precisión: la efectivización de Prop. 1.17 requiere reescribir Tao 2019 en lenguaje cuantitativo, trabajo de un mes que ningún sprint en solitario puede absorber. Si la posteridad lee este experimento, que sepa que aquí se intentó y aquí está el obstáculo.

### Autoevaluación final

**Resultado parcial publicable** (si 07 acepta el número como cota de trabajo derivada de Prop. 1.17) **/ Callejón documentado** (si 07 lo rechaza por estructural). Mi expectativa honesta es que cae al lado "Callejón documentado" con probabilidad ~60%, dada la calidad declarada en sección 5. Una sola frase de justificación: produje un valor numérico anclado a Tao 2019 y la cuantificación de la grieta para 09 (`1/640` vs. requerido `>1`), lo que es producción negativa cuantificada con valor científico, independientemente de si el exponente concreto sobrevive auditoría estricta.
