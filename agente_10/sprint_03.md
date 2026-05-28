# Sprint 3 — agente_10 (rol Allouche/Steinerberger)

**Misión final.** Consolidación numérica: tabla auditable de $p^*_N(k)$, cita literal de la cota $\alpha_0=1.930$ con su prueba elemental, y nota de cierre sobre el destino de la cota dentro del enterramiento de agente_06.

Este entregable **no reprueba** nada; consolida lo que ya está en `agente_10/sprint_02.md` y lo deja en forma citable por el `RESULTADOS.md` final del jefe y por el enterramiento técnico de 06.

---

## 1. Tabla auditable de $p^*_N(k)$

**Fuente primaria:** `C:\Users\jjnie\collatz\agente_10\complexity_table.csv` (8 filas, generadas por el script `compute_complexity.ps1` del sprint 2; todos los renglones tienen `method = exacto`, no hay muestreo en la tabla final).

| $N$    | $k$ | $\min(N,2^k)$ | $p^*_N(k)$    | $\rho_k = p^*/\min(N,2^k)$ | método  |
|--------|----:|--------------:|--------------:|---------------------------:|--------:|
| $10^6$ |  10 |         1 024 |           846 |                     0.8262 | exacto  |
| $10^6$ |  20 |     1 000 000 |       868 422 |                     0.8684 | exacto  |
| $10^6$ |  30 |     1 000 000 |       900 133 |                     0.9001 | exacto  |
| $10^6$ |  40 |     1 000 000 |       961 208 |                     0.9612 | exacto  |
| $10^8$ |  10 |         1 024 |           846 |                     0.8262 | exacto  |
| $10^8$ |  20 |     1 048 576 |       910 594 |                     0.8684 | exacto  |
| $10^8$ |  30 |   100 000 000 |    89 978 421 |                     0.8998 | exacto  |
| $10^8$ |  40 |   100 000 000 |    95 982 836 |                     0.9598 | exacto  |

**Reproducibilidad (PowerShell, comando exacto):**

```powershell
powershell -ExecutionPolicy Bypass -File C:\Users\jjnie\collatz\agente_10\compute_complexity.ps1
```

El script enumera $n\in[1,\min(N,2^k)]$ en `int64`, aplica $k$ pasos de la Syracuse acelerada ($T(2n)=n$, $T(2n+1)=(3n+2)$), e incrementa el contador cuando $T^k(n)<n$. El intermedio está acotado por $n\cdot(3/2)^{40}<2^{63}$ para $n\le 10^8$, por lo que no hay desbordamiento. La justificación de exactitud (clases mod $2^k$) está en `sprint_02.md` §1; aquí sólo confirmo que cada fila del CSV es un conteo determinista, no estocástico, y que regenerar el CSV con el comando anterior reproduce las ocho filas bit-a-bit. Tiempo total (Win11, hardware nominal): ~17 minutos, dominado por las dos filas $N=10^8$, $k\in\{30,40\}$.

---

## 2. Cita literal de $\alpha_0=1.930$ y prueba elemental

Reproduzco la cota tal cual aparece en `agente_10/sprint_02.md` §4 (consolidación, no re-prueba):

> **Lema (sprint 2 §4).** Por la fórmula de Lagarias–Terras, si $u\in\{0,1\}^k$ tiene $j=|u|_1$ unos, entonces $T^k(n)=(3^j n+r_u)/2^k$ con $r_u\ge 0$. La condición $T^k(n)<n$ implica $3^j<2^k$. Luego
> $$p^*_N(k)\le\#\{u\in\{0,1\}^k:|u|_1<k/\log_2 3\}=\sum_{j<\theta k}\binom{k}{j},\quad\theta=1/\log_2 3=0.6309.$$
> Por Chernoff–Hoeffding, $\sum_{j\le\theta k}\binom{k}{j}\le 2^{H(\theta)k}\sqrt{k}$ con $H$ entropía binaria. Calculo $H(0.6309)=0.94928\ldots$, $\alpha_0=2^{0.949}=1.9301$.

**Cota final, auditable:**

$$\boxed{\;p^*_N(k)\le C\cdot\alpha_0^k,\quad \alpha_0=1.930,\quad C=\sqrt{k}\le 7\text{ para }k\le 40.\;}$$

La prueba es elemental (Lagarias–Terras 1985 + cota binomial estándar), de tres líneas, y no usa ninguna hipótesis no demostrada. Es la versión que se exporta a 06.

---

## 3. Nota de cierre (destino dentro del enterramiento de agente_06)

Mi cota $\alpha_0=1.930$ vive ahora dentro del enterramiento técnico que agente_06 redacta como contenido principal de su sprint 3. La estructura del entierro es la siguiente: el umbral combinatorio que 06 derivó de $\alpha_0^{1+\log_2 3}<2$ es $\alpha_0<1.3066$; mi cota auditable entrega $\alpha_0=1.930$; la brecha es de tres órdenes de magnitud en el sentido del exponente efectivo y, peor aún, los datos numéricos de §1 muestran $\rho_k\to 1$, lo que implica que el verdadero $\alpha$ efectivo converge a $2.000$ por debajo, no a $1.30$. La distancia entre lo que la rama necesita ($<1.3066$) y lo que la naturaleza del objeto entrega ($\to 2$) es estructural, no de afinado de constantes.

Por tanto consolido aquí lo siguiente: **mi $\alpha_0=1.930$ es el insumo correcto** para el enterramiento de 06. Es la mejor cota superior auditable elemental que se puede obtener combinando (i) la condición *necesaria* $3^j<2^k$ de Lagarias–Terras y (ii) la cota binomial de Chernoff–Hoeffding. **No se baja significativamente por esta vía**: el sub-problema que dejé abierto al sprint 2 (explotar la condición *suficiente* $n>r_u/(2^k-3^j)$) podría arañar quizá $\alpha_0\le 1.95$ con $C$ pero ni siquiera ese refinamiento, en el caso optimista, mueve la cota por debajo de 1.5, mucho menos por debajo de 1.31. La razón profunda es la de §5 del sprint 2: los bits de paridad son Bernoulli($1/2$) en la medida de Haar 2-ádica, y $H(0.6309)=0.949$ es una constante combinatoria fija; cualquier cota que se obtenga *vía conteo binomial sobre el prefijo* heredará exactamente esta constante. Bajar de $1.930$ exige cambiar la clase de cota, no afinarla.

La rama queda cerrada cuantitativamente. Mi contribución al cierre es el dato numérico de §1 (que confirma $\rho_k\to 1$, dirección contraria a lo que 06 necesitaría) y la cota elemental de §2 (que da el techo auditable). El epitafio combinatorio lo redacta 06; yo proporciono los dos insumos numéricos sin los cuales ese epitafio no sería defensible frente a un lector externo.

---

## 4. Apuntes para futuros lectores [especulativo]

**Etiqueta: especulativo, no compromiso de continuar.** ¿Qué clase de cota combinatoria *distinta* podría producir $\alpha_0<1.31$? No por afinado del argumento Chernoff, sino por cambio de objeto:

- **Cotas tipo Sinai / Krasikov–Lagarias afinadas a prefijos con contracción uniforme.** En lugar de contar palabras $u$ con $3^{|u|_1}<2^k$ (condición necesaria), contar pares $(u,n)$ con $T^k(n)<n^{1-\delta}$ para algún $\delta>0$ fijo. Eso induce una condición $3^j<2^{k(1-\delta)}$ que mueve el umbral $\theta$ y el $H(\theta)$ asociado. Para $\delta\approx 0.3$ se entra en el régimen $\theta<0.5$ donde $H(\theta)<H(0.5)=1$ de forma sustancial; ahí $\alpha_0<1.31$ podría ser plausible. Pendiente: confirmar que la sub-familia $T^k(n)<n^{1-\delta}$ es la correcta para el análisis tipo Eliahou de 06 (cuello: los ciclos no-triviales viven en $T^k(n)=n$ exacto, no $<n^{1-\delta}$).
- **Cotas no-binomiales (medida de Bernoulli sesgada).** Si en lugar de iid $1/2$ se modela con $p\ne 1/2$ obtenido del propio análisis diofántico del ciclo ($p=1/(1+\log_2 3)=0.387$), la entropía relevante baja a $H(0.387)=0.961$, peor; no mejora. Cualquier sesgo plausible que mejore $H$ debe venir de una estructura externa (diofántica de Baker–Rhin), no del paseo de paridad.
- **Cotas multi-escala (concatenación de prefijos con drift mejorado).** Contar bloques de tamaño $\ell\gg 1$ y agregar; análogo a una transferencia de paseo aleatorio a un proceso con memoria. Si las correlaciones entre bloques fueran ligeramente sub-independientes, el exponente combinatorio efectivo podría bajar. Heurística sin esqueleto técnico todavía.

Ninguna de estas tres rutas está cerca de ser un sprint corto; las anoto sólo como mapa para quien retome la rama.

---

### Estado final

Como agente_10 (Allouche/Steinerberger, Célula 5) dejo dos cosas utilizables en este experimento: (a) la tabla numérica exacta de $p^*_N(k)$ para $N\in\{10^6,10^8\}$, $k\in\{10,20,30,40\}$, reproducible con un solo comando PowerShell, y (b) la cota elemental $p^*_N(k)\le 7\cdot 1.930^k$ con prueba auditable de tres líneas (Lagarias–Terras + Chernoff–Hoeffding). El sub-problema que dejé abierto al sprint 2 —bajar $\alpha_0$ por debajo de 1.95 usando la condición suficiente, no sólo la necesaria— no lo intenté en este sprint porque la consigna era consolidar, no avanzar, y porque la diagnosis de §3 sugiere que el techo natural por esta vía está cerca de 1.93. La rama de ciclos-vía-complejidad-combinatoria queda formalmente enterrada por 06, con mis dos insumos como pilares numéricos del entierro. Lo que queda como pregunta abierta para futuros lectores: si alguna de las tres rutas de §4 (sub-familia $T^k(n)<n^{1-\delta}$ en particular) admite una cota auditable, esa sí podría reactivar la rama; pero exige rehacer el modelo combinatorio, no afinarlo.

### Autoevaluación final

**Resultado parcial publicable.** Produje tabla numérica exacta y reproducible (10⁸ enteros, 8 filas auditables, un comando) más cota combinatoria auditable $\alpha_0=1.930$ con prueba elemental de tres líneas; ambos insumos sostienen el enterramiento cuantificado de 06 y son citables como nota técnica autónoma.
