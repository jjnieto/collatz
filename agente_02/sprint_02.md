# Sprint 02 — agente_02 (rol Maynard/Green, cadena ANÁLISIS EFECTIVO)

**Consumidor del enunciado E-Tao de agente_01.** Encargo: decidir si la cota `β_2(N,k)` que propuse en sprint 1 es **trivial** (callejón) o se **reduce a un sub-lema duro** con enunciado preciso, y si tiene estructura aditiva, exportar una interfaz para agente_09.

Nota operativa: al ejecutar este sprint, `agente_01/sprint_02.md` no estaba escrito todavía. Trabajo sobre el sub-problema de sprint 1 de 01, asumiendo que el enunciado E-Tao que producirá tendrá la forma:

> **E-Tao (forma supuesta).** Para `f(n) = n^{1−ε}` y `X` grande, la densidad logarítmica de `n ≤ X` cuya órbita Syracuse no toca `[1, f(n)]` es `O((log X)^{−c(ε)})`, con `c(ε) > 0` simbólico.

Si el enunciado final de 01 difiere en constantes, el análisis siguiente se reutiliza salvo en el cuello mencionado más abajo. Marco `[verificar contra E-Tao definitivo]` donde corresponda.

---

## 1. Recordatorio del objeto

Para un paridad-vector inicial `ω = (a_1,…,a_k) ∈ N^k` denota `P_ω(N) := { n ∈ [N, 2N] : v_2(3·Syr^{i-1}(n)+1) = a_i, i=1..k }`. Por Terras, `P_ω` es una **progresión aritmética** módulo `2^{a_1+…+a_k}`, y para `k` fijo el reparto `n ↦ ω` es equiprobable sobre `Z/2^{Σa_i}Z`.

Defino el sesgo

```
β_2(N,k) := sup_{ω, Σa_i ≤ k}  ‖ 1_{P_ω(N)} − N · 2^{-Σa_i} ‖_{U^2[N,2N]} / N.
```

Pregunta de sprint 1: ¿es `β_2(N,k) = O(2^{-k/2}(log N)^C)`?

---

## 2. Veredicto: **callejón parcial** + **núcleo reducible a sub-lema duro**

Tras revisar lo que `E-Tao` (en cualquier forma razonable) produce y compararlo con la maquinaria Gowers `U^2`, la decisión binaria que el jefe pidió se desdobla naturalmente:

- **Componente trivial (callejón).** El régimen `k ≤ (1/2) log_2 N` es **trivialmente** controlable por el reparto de Terras (cada `P_ω` es una progresión aritmética genuina mod `2^{Σa_i}` con `Σa_i ≤ k ≤ (1/2)log_2 N`, y la `U^2` de una p.a. de paso `q` en `[N,2N]` es `O((q/N)^{1/2})` por Parseval, cf. Green–Tao "An inverse theorem for the Gowers `U^3` norm", apéndice sobre `U^2`). Esto da `β_2(N,k) ≪ 2^{-k/2}` **sin tocar E-Tao**: es consecuencia directa de Terras + Parseval. **Etiqueta: callejón** — no aporta nada nuevo sobre Collatz, sólo recobra lo elemental.

- **Componente no trivial.** El régimen interesante es `(1/2) log_2 N ≤ k ≤ c · log_2 N` con `c < 1`: aquí el módulo `2^{Σa_i}` supera `N^{1/2}` y la cota Parseval colapsa (la progresión tiene `≤ 1` representante en `[N,2N]` en el peor caso, y la `U^2` deja de ser informativa por argumentos elementales). En este régimen la cota `β_2(N,k) = o(1)` **no se sigue de Terras**: requiere que la equidistribución logarítmica de Tao 2019 se traslade a equidistribución en frecuencias bajas tipo `e_q(αn)`. Ahí entra `E-Tao` como hipótesis externa.

Conclusión binaria: **NO es trivial globalmente; es trivial bajo el umbral `k ≤ (1/2)log_2 N` y se reduce a un sub-lema duro en `(1/2)log_2 N < k ≤ c · log_2 N`**. El callejón es sólo el régimen fácil; el régimen útil para 01/09 es el duro.

---

## 3. Sub-lema duro (enunciado preciso)

**Sub-lema S2 (Maynard–Green-condicional a E-Tao).** Sean `c ∈ (1/2, 1)` y `ε > 0`. Asumiendo `E-Tao` con tasa `c(ε)`, existen `C = C(c, ε)` y `δ = δ(c,ε) > 0` tales que para todo `N` suficientemente grande y todo `k` con `(1/2)log_2 N ≤ k ≤ c · log_2 N`,

```
sup_{ω : Σa_i ≤ k}  ‖ 1_{P_ω(N)} − N·2^{-Σa_i} ‖_{U^2[N,2N]}  ≤  C · N · (log N)^{-δ}.
```

Equivalentemente, en lenguaje de sumas exponenciales: para todo `α ∈ R/Z`,

```
| Σ_{n ∈ P_ω(N)} e(α n) |  ≪  (N / 2^{Σa_i})^{1/2} · N^{1/2} · (log N)^{-δ/2}.
```

**Por qué es duro (no es Parseval).** La cota Parseval daría `(N/2^{Σa_i})^{1/2} · N^{1/2}` sin el factor `(log N)^{-δ/2}`; ese factor de ganancia es **exactamente** lo que distingue "equidistribución trivial mod q" de "equidistribución correlada con la dinámica Collatz". La ganancia tiene que venir de fuera: o bien de E-Tao (la mejora de tasa `c(ε)`), o bien de una entrada combinatoria nueva sobre `Z[1/2, 1/3]`.

**Reducción a E-Tao (esquema, no demostración).** El esquema es: descomponer `P_ω` según el valor de `Syr^k(n)/n`, usar E-Tao para mostrar que casi todo `n ∈ P_ω` ha descendido por debajo de `n^{1-ε}`, y deducir que la masa de Fourier de `1_{P_ω}` en frecuencias `|α| ≥ N^{-1+\eta}` decae logarítmicamente. `[verificar]` — el paso técnico real es que la **densidad logarítmica del descenso** se transfiera a una **norma `U^2` en intervalo `[N,2N]`** vía cambio de variable `n = e^t`. Esa transferencia no es automática: la densidad logarítmica es invariante por dilatación y la `U^2` no lo es. Hay aquí un cuello de botella técnico genuino — éste es el sub-lema duro real.

**Etiqueta:** reducción a sub-lema duro. **No** afirmo demostración. Afirmo: si E-Tao se materializa con `c(ε)` simbólico, el contenido `U^2` no trivial sobre paridad-vectores se reduce a la transferencia densidad-logarítmica → norma `U^2`, que es un problema medible y de interés independiente.

---

## 4. Interfaz para agente_09

El sub-lema S2 tiene **estructura aditiva genuina** sobre paridad-vectores, y por tanto es exportable a 09 para su argumento de no-regularidad de `L_div`. Formulo la interfaz:

### Interfaz para agente_09

**Objeto compartido.** Para `ω ∈ {0,1}^k` paridad-vector binario de longitud `k` (notación Terras), el conjunto `P_ω(N) ⊂ [N,2N]` es una p.a. mod `2^k`, con `|P_ω(N)| ≈ N · 2^{-k}`.

**Cota aditiva (condicional a S2 y E-Tao).** Para `k ≤ c · log_2 N`,

```
β_2(N,k)  :=  sup_ω  ‖ 1_{P_ω(N)} − N·2^{-k} ‖_{U^2}  ≤  C · N · (log N)^{-δ}.
```

**Uso para `L_div`.** Si `L_div ≠ ∅` y fuera regular, contendría una p.a. binaria `{u v^i w}`. Las palabras `u v^i w` codifican prefijos de paridad-vector que **fijan** la progresión aritmética inicial en `Z/2^{|u|+i|v|+|w|}Z`. La regularidad fuerza que la masa de `L_div` en `P_ω` correspondiente decaiga **sólo** geométricamente en `i`. Pero S2 (vía Plancherel) implica que la `U^2`-correlación de `1_{L_div ∩ [N,2N]}` con cualquier carácter aditivo `e(αn)` decae al menos como `(log N)^{-δ/2}` para los `ω` relevantes — incompatible con la rigidez de la p.a. binaria si la densidad de `L_div` cae como las cotas tipo Krasikov–Lagarias indican.

**Firma formal para 09 (consumible).**

```
Hipótesis: E-Tao con tasa c(ε) (input de 01); sub-lema S2 con (C, δ) dependientes de (c, ε).
Tesis disponible: para todo ω ∈ {0,1}^k con k ≤ c·log_2 N,
    Σ_{n ∈ P_ω ∩ [N,2N]} e(αn) ≪ (N·2^{-k})^{1/2}·N^{1/2}·(log N)^{-δ/2}   uniforme en α.
Constante δ: simbólica, función explícita de c(ε) [verificar tras E-Tao definitivo].
```

09 puede usar esto como hipótesis externa en su argumento de bombing-lemma sobre `L_div`. Si 09 sólo necesita "no hay p.a. binaria estable en `L_div`", la cota `β_2 = o(1)` ya basta — la tasa `(log N)^{-δ}` es bonificación.

---

## 5. Honestidad

- El componente trivial (régimen `k ≤ (1/2)log_2 N`) **es** un callejón. Lo dejo enunciado como recordatorio para evitar que el equipo lo reproclame.
- El componente duro (régimen `(1/2)log_2 N < k ≤ c·log_2 N`) **no es trivial** y **no se sigue automáticamente** de E-Tao: el cuello es la transferencia densidad-logarítmica → norma `U^2`. Esto es lo que llevo a sprint 3.
- La interfaz a 09 es **utilizable hoy** aunque S2 esté sin demostrar: 09 puede asumirla como hipótesis y producir un argumento condicional.

---

### Sub-problema para sprint 3

**Enunciado.** Demostrar (o refutar con contraejemplo) el **lema de transferencia**: si `D ⊂ [N,2N]` tiene densidad logarítmica `1 − O((log N)^{−c})`, entonces `‖1_D − densidad·1_{[N,2N]}‖_{U^2} ≤ C·N·(log N)^{−c/2}`. Equivalentemente, mostrar que el cambio de variable `n = e^t` preserva norma `U^2` hasta un factor `O((log N)^A)`.

**Criterio de éxito medible.** Una de:
1. Teorema con `(c, C, A)` explícitos y prueba o esquema verificable.
2. Contraejemplo: `D` con densidad logarítmica casi 1 y `U^2` saturada.
3. Reducción a un resultado conocido (Bourgain–Sárközy, lema de Heath–Brown sobre `U^2` de conjuntos densos `[verificar]`).

### Autoevaluación

**Improbable** (sin cambio respecto a sprint 1, pero con la grieta mejor localizada). El régimen trivial está honestamente etiquetado callejón; el régimen duro se reduce a un cuello técnico concreto (transferencia densidad-log → `U^2`) que es atacable independientemente y de interés autónomo. La interfaz a 09 sobrevive aunque S2 quede sin probar. Si en sprint 3 la transferencia se demuestra: hay grieta cuantitativa real. Si no, cierro la línea y libero recursos.

### Interfaz para agente_09

(Ver sección 4 — bloque ya incluido arriba con la firma formal.)
