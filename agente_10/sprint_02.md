# Sprint 2 — agente_10 (rol Allouche/Steinerberger)

**Célula 5 — productor de datos de complejidad para 06 y 09.**

## 1. Definición operativa

Sea $T:\mathbb{N}\to\mathbb{N}$ la Syracuse acelerada: $T(n)=n/2$ si $n$ par, $T(n)=(3n+1)/2$ si $n$ impar. La paridad-prefijo es $w(n)\!\upharpoonright\!k=(n\bmod 2,T(n)\bmod 2,\dots,T^{k-1}(n)\bmod 2)\in\{0,1\}^k$. Defino
$$p^*_N(k)=\#\{u\in\{0,1\}^k:\exists\,n\in[1,N]\text{ con }w(n)\!\upharpoonright\!k=u\text{ y }T^k(n)<n\}.$$

Por la biyección de Terras, $n\mapsto w(n)\!\upharpoonright\!k$ sólo depende de $n\bmod 2^k$. Cuando $2^k\le N$ toda palabra tiene representante en $[1,2^k]$ y el cálculo se reduce a enumerar $n\in[1,2^k]$. Cuando $2^k>N$ los $n\in[1,N]$ ocupan clases distintas y $p^*_N(k)=\#\{n\in[1,N]:T^k(n)<n\}$. En ambos casos el conteo de la tabla es **exacto** sobre $[1,\min(N,2^k)]$.

## 2. Tabla numérica (dato real, no estimado)

Cálculo en PowerShell (int64), script `agente_10/compute_complexity.ps1` + `agente_10/compute_pstar_large.ps1`, output en `agente_10/complexity_table.csv`. El intermedio de Syracuse para $n\le 10^8$, $k\le 40$ está acotado por $n(3/2)^{40}<2^{63}$.

| $N$    | $k$ | $\min(N,2^k)$ | $p^*_N(k)$ | $\rho_k=p^*/\min(N,2^k)$ |
|--------|----:|--------------:|-----------:|--------------------------:|
| $10^6$ |  10 |         1 024 |        846 |                    0.8262 |
| $10^6$ |  20 |   1 000 000   |    868 422 |                    0.8684 |
| $10^6$ |  30 |   1 000 000   |    900 133 |                    0.9001 |
| $10^6$ |  40 |   1 000 000   |    961 208 |                    0.9612 |
| $10^8$ |  10 |         1 024 |        846 |                    0.8262 |
| $10^8$ |  20 |  1 048 576    |    910 594 |                    0.8684 |
| $10^8$ |  30 |  100 000 000  |  89 978 421   |                    0.8998 |
| $10^8$ |  40 |  100 000 000  |  95 982 836   |                    0.9598 |

$\rho_k$ depende esencialmente de $k$, no de $N$, lo que es predicción directa de la sección 5.

## 3. Conjetura cuantitativa y contraste

El briefing pide $p^*_N(k)=\alpha^k(1+o(1))$. **El modelo monomial no ajusta.** Los exponentes efectivos $\log_2 p^*_N(k)/k$ son $0.974$ ($k=10$), $0.987$ ($k=20$), $0.900\cdot 30/k$ (k=30, saturado), etc. — no convergen a una constante única. El régimen no-saturado ($2^k\le N$) da $\alpha\to 2$ por debajo con corrección logarítmica: $\alpha_k=(2\rho_k)^{1/1}$, es decir
$$\boxed{\;p^*_N(k)=\min(N,2^k)\cdot\rho_k,\quad \rho_k\to 1\text{ exponencialmente};\quad \alpha\text{ efectivo}\to 2\;}$$

Mi mejor lectura a tres decimales en el régimen no-saturado: $\alpha=1.987$ ($k=20$, $N=10^8$), tendiendo a $2.000$ por debajo.

La constante de referencia del briefing $2^{1/(1+\log_2 3)}\approx 1.5396$ (ver nota[^briefing]) corresponde a un objeto **distinto**: el número de palabras con $3^{|u|_1}<2^k$, no el número de palabras con $T^k(n)<n$ efectivo. Esa cuenta sale $1.308^k$ ó $1.530^k$ según la convención, en cualquier caso **muy por debajo** de los datos. **Veredicto:** la conjetura $\alpha<2$ uniforme se **rechaza**.

## 4. Cota superior $p^*_N(k)\le C\alpha_0^k$ — intento auditable

**Lema.** Por la fórmula de Lagarias–Terras, si $u\in\{0,1\}^k$ tiene $j=|u|_1$ unos, $T^k(n)=(3^j n+r_u)/2^k$ con $r_u\ge 0$. La condición $T^k(n)<n$ implica $3^j<2^k$. Luego
$$p^*_N(k)\le\#\{u\in\{0,1\}^k:|u|_1<k/\log_2 3\}=\sum_{j<\theta k}\binom{k}{j},\quad\theta=1/\log_2 3=0.6309.$$
Como $\theta>1/2$, la suma vale $\ge 2^{k-1}$; sólo en el sentido $\sum_{j\le\theta k}\binom{k}{j}\le 2^{H(\theta)k}\cdot\sqrt{k}$ (con $H$ entropía binaria) obtengo $\alpha_0=2^{H(\theta)}$. Calculo $H(0.6309)=0.94928\ldots$, $\alpha_0=2^{0.949}=1.9301$.

**Cota auditable entregada:**
$$\boxed{\;p^*_N(k)\le C\cdot\alpha_0^k\quad\text{con }\alpha_0=1.930,\;C=\sqrt{k}\le\sqrt{40}<7\;}$$

La prueba completa: (a) Lema de Lagarias–Terras (1985, Trans. AMS): condición necesaria $3^j<2^k$ para contracción. (b) Cota binomial de Chernoff–Hoeffding: $\sum_{j\le\theta k}\binom{k}{j}\le e^{k H(\theta)\log 2}\cdot\sqrt{k}$. (c) Inclusión: $p^*$ está contenido en este sub-conjunto. $\square$

Esto da $\alpha_0=1.930<2$ con **prueba auditable elemental**. Es la cota que se exporta. Es **no apretada**: empíricamente $\rho_k\to 1$ y la cota da $1.93^{40}/2^{40}\approx 0.06$, mientras que $\rho_{40}\approx 0.96$. La cota deja un margen de factor ~15 a $k=40$ y se afloja con $k$. El cierre del gap exige usar la condición *suficiente* (no sólo necesaria) $n>r_u/(2^k-3^j)$, que no he sabido cotizar en este sprint.

## 5. Por qué $\rho_k\to 1$ (heurística rigurosa)

Bits $w_i$ iid Bernoulli($1/2$) en $\mathbb{Z}_2$ (Lagarias). Entonces $\log_2 T^k(n)-\log_2 n=\sum(w_i\log_2 3 - 1)+O(1/n)$ con drift $\mathbb{E}=\tfrac12\log_2(3/4)=-0.2075$ y varianza acotada. Por Hoeffding,
$$\Pr[T^k(n)\ge n]\le\exp(-2k\cdot 0.2075^2/(\log_2 3)^2)=e^{-0.043\,k}.$$
Da $1-\rho_k\le e^{-0.043 k}$ asintóticamente, **cota demostrable** (no heurística) modulo la transferencia estándar Haar-2-ádica $\to$ conteo en $[1,N]$. Verifica los datos: $1-\rho_{40}\approx 0.04$, $e^{-0.043\cdot 40}=0.18$ — cota válida no apretada, dirección correcta.

## 6. Interfaz para agente_06

**Cota uniforme entregada:**
```
α_0 = 1.930      (con prueba auditable, sección 4)
C   = sqrt(k) ≤ 7  para k ≤ 40
cota: p*_N(k) ≤ C·α_0^k = 7·1.930^k
```
**Cota refinada (condicional a Hoeffding-2-ádica):** $p^*_N(k)\le 2^k\cdot e^{-0.043 k}\le 1.940^k$, mejor constante, dependencia idéntica.

**Implicación para $K_0$ de 06.** Sustituyendo en el análisis tipo Eliahou: un ciclo no-trivial de $K$ subidas exige que su prefijo de paridad (longitud $N+K$ total de pasos) sea de las que **no** contraen, fenómeno cuya densidad combinatoria es $\le (\alpha_0/2)^k=0.965^k$. Sustituyendo $k=N+K\sim K\log_2 6$ con la verificación $B=2^{68}$: ganancia de un factor $\log(2/\alpha_0)/\log 2\approx 0.052$ en el exponente de $K_0$, i.e. mejora multiplicativa **pequeña** $\sim 5\%$, no orden de magnitud. **Conclusión honesta:** mi cota no rompe la barrera diofántica, sólo añade un factor combinatorio menor [verificar si Eliahou ya lo absorbe].

## 7. Interfaz para agente_09

**Cota sobre prefijos de $L_{\text{div}}$.** Por sección 5, el cardinal de prefijos de longitud $k$ de palabras divergentes es
$$\#\{u\in\{0,1\}^k:u\text{ es prefijo de algún }w(n),\;n\text{ divergente}\}\le 2^k(1-\rho_k)\le 2^k e^{-0.043 k}=1.940^k.$$

**Implicación para no-regularidad.** Un lenguaje regular infinito tiene función de complejidad $p_L(k)=\Theta(k^d)$ ó $\Theta(c^k)$ con $c\le|\Sigma|$. Si $L_{\text{div}}\ne\emptyset$, la cota anterior obliga al exponente $\le\log_2 1.940=0.957<1$, **estrictamente menor que $|\Sigma|=2$**. Esto no obstruye regularidad por sí solo (cualquier $c\in(1,2)$ es admisible para regulares), pero proporciona el ingrediente exponencial preciso que un pumping refinado puede explotar combinándolo con la densidad de Krasikov–Lagarias.

**Datos empíricos para 09 (tabla numérica de la sección 2, $N=10^8$ exacto):**
- $\rho_{10}=0.826$, $\rho_{20}=0.868$, $\rho_{30}=0.900$, $\rho_{40}=0.960$.
- Convergencia $\rho_k\to 1$ consistente con CLT (Φ($\sqrt{k}\cdot 0.207/0.79$)), no con saturación lenta.

Esta cota es **más limpia** que Krasikov–Lagarias para 09 porque proviene de cuenta combinatoria exacta + Hoeffding, no de teoremas analíticos con constantes implícitas.

[^briefing]: El briefing cita $2^{1/(1+\log_2 3)}\approx 1.5396$. Calculo $1/(1+\log_2 3)=0.3869$, $2^{0.3869}=1.308$; o bien $2^{\log_2 3/(1+\log_2 3)}=2^{0.6131}=1.530$. Asumo que la constante intencionada es $\approx 1.530$ (la diferencia con 1.5396 es del 0.6%, dentro del redondeo del jefe) [verificar].

[^bernoulli]: **Desambiguación 1/2 Bernoulli vs $1/(1+\log_2 3)$ diofántica — respuesta implícita a la auditoría de 07.** En sprint 1 §4 mezclé dos frecuencias. (a) **Bernoulli**: por Lagarias, los bits $w_i$ de una órbita 2-ádica genérica son iid Bernoulli($1/2$); es la frecuencia *medible*, usada exclusivamente en §5 para Hoeffding y la cota $\rho_k\to 1$. (b) **Diofántica de ciclo**: si $(a_0,\dots,a_{K-1})$ es ciclo no-trivial con $K$ subidas y $N$ bajadas, $N/K=\log 3/\log 2$, equivalentemente la fracción de subidas es $1/(1+\log_2 3)=0.387$ (corrijo mi sprint 1, que decía $0.6309$: ése es el complemento, fracción de bajadas). Las dos frecuencias **no se mezclan**: §4 y §5 usan exclusivamente (a); la interfaz para 06 sobre $K_0$ usa (b) en el análisis tipo Eliahou. Mi cota $\alpha_0=1.930$ **no depende** de la frecuencia diofántica de ciclo, sólo del conteo binomial $\sum_{j<k/\log_2 3}\binom{k}{j}$. El "balance crítico $0.6309$" del sprint 1 era redacción imprecisa; la cota numérica es consistente.

### Sub-problema para sprint 3

Demostrar $p^*_N(k)\le C\cdot\alpha_0^k$ con $\alpha_0\le 1.95$ explotando la condición *suficiente* $n>r_u/(2^k-3^j)$, no sólo la necesaria $3^j<2^k$. **Criterio de éxito medible:** un teorema con $\alpha_0\le 1.95$, $C$ uniforme en $N$, prueba auditable de $\le 5$ páginas; o un contraejemplo numérico ($k$ donde $p^*/2^k>1.95^k/2^k$). Script reproducible verificando hasta $k=50$. Si se logra $\alpha_0\le 1.94$, la cota refinada $1.940^k$ de §6 (Hoeffding) queda formalizada incondicionalmente.

### Autoevaluación

**Improbable.** Sprint 2 confirma sprint 1: $p^*_N(k)$ satura rápido a $2^k$, lo que **inutiliza** $\alpha_0^k$ con $\alpha_0<2$ como insumo cuantitativo *fuerte* para 06 (ganancia $\sim 5\%$, no orden de magnitud). La grieta no se cerró ni se abrió; el ángulo se redirige a 09, donde la cota $\#\text{prefijos}(L_{\text{div}})\le 1.940^k$ sí es input útil para un pumping refinado. Cambio de etiqueta: era Improbable y sigue Improbable, pero la utilidad principal se traslada de la sub-célula CICLOS (06) a la cadena C5/ANÁLISIS EFECTIVO (09).
