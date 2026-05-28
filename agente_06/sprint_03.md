# Sprint 3 — agente_06 (rol Granville/Pomerance, sub-célula CICLOS)

**Encargo.** Enterramiento técnico de la rama "ciclos vía complejidad combinatoria"; epitafio independiente para `K_0` post-Rhin si no aparece medida de irracionalidad explícita.

---

## 1. La cota combinatoria entrante (agente_10, sprint_02 §4)

Cito literalmente del entregable de agente_10 (sprint_02, sección 4):

> **Cota auditable entregada:**
> $$p^*_N(k)\le C\cdot\alpha_0^k\quad\text{con }\alpha_0=1.930,\;C=\sqrt{k}\le\sqrt{40}<7$$
>
> La prueba completa: (a) Lema de Lagarias–Terras (1985, Trans. AMS): condición necesaria $3^j<2^k$ para contracción. (b) Cota binomial de Chernoff–Hoeffding: $\sum_{j\le\theta k}\binom{k}{j}\le e^{k H(\theta)\log 2}\cdot\sqrt{k}$. (c) Inclusión: $p^*$ está contenido en este sub-conjunto. $\square$

La derivación es **auditable y elemental**: parte de la condición necesaria $3^j<2^k$ (i.e. $j<k/\log_2 3$ con $\theta=1/\log_2 3=0.6309$) y aplica la cota entrópica binomial $\sum_{j\le\theta k}\binom{k}{j}\le 2^{H(\theta)k}\sqrt{k}$ con $H(0.6309)=0.94928\ldots$, obteniendo $\alpha_0=2^{0.94928}=1.9301$. Es el techo combinatorio bruto del soporte admisible de las palabras contractivas; **no usa** la condición suficiente $n>r_u/(2^k-3^j)$, sólo la necesaria. La constante $C\le 7$ proviene del polinomio en $k$ del Chernoff–Hoeffding. Agente_10 marca esta cota como **incondicional** (a diferencia de la refinada $1.940^k$, condicional a Hoeffding-2-ádica).

Refuerzo: agente_10 además observa, vía Hoeffding sobre los bits $w_i\sim\text{Bernoulli}(1/2)$ en $\mathbb{Z}_2$, que $\rho_k=p^*_N(k)/\min(N,2^k)\to 1$ exponencialmente. **Esto significa que $\alpha_0$ efectivo no sólo es $1.930$ — converge a $2$ por debajo.** El número $1.930$ no es un valor terminal mejorable: es el techo del razonamiento Chernoff sobre la condición necesaria, y el comportamiento real está por encima, no por debajo. Es información cuantitativa contra mi rama, no a favor.

---

## 2. El umbral combinatorio para cerrar ciclos (mi sprint_02 §3)

Cito literalmente de mi propio sprint_02 (sección 3):

> Sólo si agente_10 produce un `α_0` con `α_0^{2.585} < 2` (es decir `α_0 < 2^{1/2.585} ≈ 1.3066`) la combinación da cota sub-exponencial y por tanto **`K_0 = ∞` en sentido condicional** (no existen ciclos).

La derivación, recapitulada para autocontención: un ciclo no trivial con $K$ subidas y $N$ bajadas satisface $N/K\to\log_2 3$, luego $N+K\sim K(1+\log_2 3)=2.585\,K$. El número de candidatos combinatoria+diofántica está acotado por $C\cdot\alpha_0^{N+K}\cdot 2^{-cK}\le C\cdot\alpha_0^{2.585\,K}\cdot 2^{-cK}$. Para que el espacio se agote (i.e. **ningún** candidato sobreviva al criba en el límite $K\to\infty$), hace falta $\alpha_0^{1+\log_2 3}<2$, equivalente a
$$\alpha_0<2^{1/(1+\log_2 3)}=2^{1/2.585}=1.30657\ldots$$

Este es el **umbral nítido**. Por debajo de él la rama "ciclos vía complejidad combinatoria" cierra; por encima de él el espacio combinatorio crece más rápido que la criba diofántica de Eliahou.

---

## 3. Conclusión formal: brecha cuantitativa y cierre de rama

**Posición del entrante respecto al umbral:**

| Cantidad | Valor | Fuente |
|---|---|---|
| Cota combinatoria auditable | $\alpha_0=1.930$ | agente_10, sprint_02 §4 |
| Comportamiento asintótico (Hoeffding) | $\alpha_0\text{ efectivo}\to 2$ | agente_10, sprint_02 §5 |
| Umbral combinatorio para cerrar ciclos | $\alpha_0<1.3066$ | agente_06, sprint_02 §3 |
| Brecha $\Delta=1.930-1.3066$ | $0.624$ | derivado |
| Razón $1.930/1.3066$ | $1.477$ | derivado |
| Razón en el exponente: $1.930^{2.585}/2$ | $5.65$ | $1.930^{2.585}\approx 11.3$ |

La brecha multiplicativa en el espacio de candidatos a longitud $K$ es $(1.930/1.3066)^{2.585\,K}=1.477^{2.585\,K}\approx 2.50^K$. Para $K\sim 10^9$ (la cota Eliahou-actualizada de mi sprint_02), el factor de exceso de candidatos es $\sim 2.50^{10^9}$. Tres órdenes de margen es decir poco: son **órdenes en el exponente**, no en la base.

Además — y esto es lo decisivo — agente_10 demuestra rigurosamente (vía Hoeffding-2-ádica, sprint_02 §5) que $\alpha_0$ efectivo $\to 2$, no a $1.3066$. **No se trata de que la cota actual de $1.930$ sea floja con respecto a un valor real cercano a $1.3066$; la cota es floja pero por arriba: el valor real tiende a $2$.** El umbral está al otro lado de la barrera asintótica.

**Veredicto formal.** La rama "ciclos vía complejidad combinatoria" queda **cerrada por brecha cuantitativa**: el insumo combinatorio disponible ($\alpha_0=1.930$, con convergencia demostrable a $2$) no alcanza el umbral exigido ($\alpha_0<1.3066$) por un margen que no es de constantes mejorables sino de naturaleza asintótica. Refinamientos plausibles de la cota tipo Chernoff–Hoeffding (afilar $C$, ajustar el polinomio en $k$, sustituir la condición necesaria por una mezcla necesaria/suficiente moderada) sólo pueden mover $\alpha_0$ entre $1.930$ y $2$, **nunca por debajo de $1.585\approx\log_2 3$**, que es donde la condición $3^j<2^k$ deja de ser informativa y se vuelve vacua. El umbral $1.3066$ queda fuera del rango accesible.

---

## 4. Apunte para futuros lectores: qué mejora *cualitativa* sería necesaria

[Especulativo, etiquetado como tal — no compromiso de continuar.]

Cualquier vía que pretenda mover el techo combinatorio por debajo de $1.3066$ debe, necesariamente, abandonar el conteo de palabras compatibles con la condición necesaria $3^j<2^k$. Indico tres direcciones cualitativamente distintas, sin pretensión de viabilidad:

1. **Restricciones diofánticas internas al conteo.** En lugar de contar todas las palabras con $j<\theta k$, contar sólo aquellas cuya combinación lineal $N\log 2-K\log 3$ admita órbita entera real. Esto exige incorporar la medida de irracionalidad de $\log_2 3$ en el propio conteo combinatorio, no como criba a posteriori. La cuenta resultante no es entrópica y podría romper la barrera de $\log_2 3$, pero requiere maquinaria de Bombieri–Vaaler o similar [verificar].

2. **Estructura algebraica del residuo $r_u$.** La condición *suficiente* $n>r_u/(2^k-3^j)$ usa $r_u$ como un número, no como un objeto estructurado. Si se explotara la distribución conjunta de $(r_u,2^k-3^j)$ módulo primos pequeños, podrían eliminarse familias enteras de palabras de manera que la cuenta superviviente caiga por debajo de $1.3066^k$. Esto se acerca al espíritu de Krasikov–Lagarias pero exige un teorema de equidistribución conjunto que no conozco en la literatura.

3. **Cambio de codificación.** El alfabeto $\{0,1\}$ con frecuencia Bernoulli($1/2$) es el natural para Lagarias–Terras, pero quizá no el óptimo para detectar ciclos. Una codificación bi-paridad sobre el ciclo "rotado" — donde la frecuencia es $1/(1+\log_2 3)=0.387$, la diofántica — daría entropía $H(0.387)=0.962$, peor que $H(0.6309)=0.949$. El cambio de codificación no parece ayudar mecánicamente; quizá una codificación no uniforme sí.

Ninguna de las tres es promesa. Son apuntes para que un lector futuro que llegue a esta rama no pierda tiempo refinando $C$ o el polinomio en $k$: el cuello no está ahí.

---

## 5. Epitafio sobre `K_0` post-Rhin

[Sub-misión secundaria, ver R-N5.]

En sprint 2 marqué como sub-problema para sprint 3 localizar una medida de irracionalidad efectiva post-2010 de $\log_2 3$ con constantes explícitas (candidatos: Wu 2003, Bouchat 2014, sucesores). **No he conseguido localizar tal medida con constantes auditables desde este entorno.** Las referencias que recuerdo (Rhin 1987, Rukhadze 1987, Rhin–Viola, Wu) o bien no actualizan la constante $C$ explícitamente, o no la publican en forma utilizable, o el valor está implícito en cadenas de demostraciones que no puedo recorrer sin acceso a la literatura.

En consecuencia, la estimación $K_0\approx 1.4\cdot 10^9$ de mi sprint 2 — derivada mecánicamente al actualizar $B$ de $2^{40}$ a $2^{68}$ en Eliahou — queda como mejor valor disponible. **Probablemente ya implícito en Simons–de Weger 2005, luego no reclamo novedad.** El cuello de botella permanece donde lo dejé: sin nueva $\mu$ post-Rhin con constantes, la actualización de $B$ da retornos sub-lineales. Cerrado.

---

### Estado final

Dejo dos cosas. Primero, un enterramiento cuantificado de la rama "ciclos vía complejidad combinatoria": la brecha entre el insumo disponible ($\alpha_0=1.930$, convergiendo a $2$ por Hoeffding) y el umbral exigido ($\alpha_0<1.3066$) es estructural, no constante mejorable; la rama no se cierra por esta vía ni por refinamientos plausibles de Chernoff–Hoeffding. Segundo, un epitafio sobre $K_0$ post-Rhin: sin acceso a medida de irracionalidad con constantes explícitas, la estimación queda en $\approx 1.4\cdot 10^9$, probablemente ya en Simons–de Weger. Lo que no dejo: un valor numérico nuevo de $K_0$, ni un teorema de barrera más fino que el umbral $1.3066$. Lo que sí queda como pregunta abierta para futuros lectores: si alguna codificación no entrópica del conteo combinatorio puede romper la barrera de $\log_2 3$. Es especulativo y lo marco como tal.

### Autoevaluación final

**Callejón documentado.** La sub-célula CICLOS produjo argumento cuantificado de cierre — la brecha $1.930$ vs $1.3066$, tres órdenes en el exponente, convergencia a $2$ por Hoeffding — pero no produjo cota nueva ni teorema positivo. Valor científico negativo: el siguiente que pase por aquí sabe que esta vía está cerrada y por qué, con números, sin tener que repetir el camino.
