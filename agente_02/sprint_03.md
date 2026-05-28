# Sprint 03 — agente_02 (rol Maynard/Green, cadena ANÁLISIS EFECTIVO)

**Modo:** consolidación. Sub-lema S2 (transferencia densidad-log → norma `U^2`) queda como **postulado con interfaz** para que un lector externo pueda recogerlo aislado. No afirmo demostración. Reconecto con el `c(ε) = ε^3/80` de agente_01 (sprint 3) con honestidad operativa sobre los `[verificar]` que arrastra.

---

## 1. Sub-lema S2 — postulado con interfaz (una página)

**Notación fijada.**
- `N ≥ N_0` entero grande; `c ∈ (1/2, 1)` constante; `ε ∈ (0, 1/2)`.
- `ω = (a_1, …, a_k) ∈ ℕ^k` paridad-vector Terras, con `Σa_i ≤ k ≤ c · log_2 N`.
- `P_ω(N) := { n ∈ [N, 2N] : v_2(3·Syr^{i-1}(n) + 1) = a_i, i = 1..k }`.
- Por Terras, `P_ω(N)` es progresión aritmética módulo `2^{Σa_i}`, con `|P_ω(N)| ≈ N · 2^{-Σa_i}`.
- `‖·‖_{U^2[N,2N]}` es la norma Gowers de orden 2 sobre el intervalo (normalización Green–Tao).
- `c(ε)` es la constante de Tao efectiva entregada por agente_01 (en este sprint, `c(ε) = ε^3/80`).

**Postulado S2 (transferencia densidad-log → `U^2`).** Sean `c ∈ (1/2, 1)`, `ε ∈ (0, 1/2)`. Existen constantes
- `C_S2 = C_S2(c, ε) > 0`,
- `δ_S2 = δ_S2(c, ε) := c(ε) / 2 > 0`,
- `A_S2 ≥ 0` polinomial en `1/ε`,

tales que, asumiendo el **Lema E-Tao efectivo** de agente_01 con constante `c(ε)`, para todo `N ≥ N_0(c, ε)` y todo `ω` con `Σa_i ≤ k ≤ c · log_2 N`:

```
‖ 1_{P_ω(N)} − N · 2^{-Σa_i} · 1_{[N,2N]} ‖_{U^2[N,2N]}
        ≤   C_S2 · N · (log N)^{-δ_S2}.
```

**Hipótesis explícitas (sin `[verificar]` blandos).**
- (H1) Vale `E-Tao` con `c(ε) > 0` numérica concreta.
- (H2) `N ≥ X_0(ε)` con `X_0(ε)` el umbral entregado por 01 (`exp(exp(C_*/ε^3))` en su sprint 3).
- (H3) `k ≤ c · log_2 N`.

**Tesis.** La cota `U^2` listada arriba, **uniforme** en `ω`.

**Constantes nombradas.** `C_S2`, `δ_S2`, `A_S2`, `N_0(c,ε)`, `X_0(ε)`. La dependencia `δ_S2 = c(ε)/2` es el contenido aritmético del postulado: la mitad de la tasa de Tao se traslada a la tasa Gowers tras Plancherel.

**Qué no es S2.** No es teorema demostrado. No es Parseval (Parseval cubre el régimen fácil `k ≤ (1/2)log_2 N`, ya etiquetado callejón en sprint 02 §2). Es exactamente la afirmación de que el cambio de variable `n = e^t` preserva norma `U^2` hasta factor `O((log N)^{A_S2})`, en el régimen duro `(1/2)log_2 N < k ≤ c · log_2 N`.

**Interfaz consumible (firma formal para 09 y para lectores externos).**

```
Asume:  E-Tao(c(ε)) [input externo, hoy = c(ε) de agente_01].
Asume:  N ≥ X_0(ε).
Entonces para todo ω con Σa_i ≤ k ≤ c·log_2 N y todo α ∈ R/Z:
    | Σ_{n ∈ P_ω(N)} e(α n) |
        ≪   (N · 2^{-Σa_i})^{1/2} · N^{1/2} · (log N)^{-c(ε)/4}.
```

(El exponente `c(ε)/4` sale de `δ_S2/2 = c(ε)/4` por la traducción `U^2 → ℓ^∞` estándar.)

---

## 2. Reconexión con `c(ε) = ε^3/80` (régimen alto ↔ `β_2`)

Agente_01 entrega `c(ε) = ε^3/80`, anclado a Prop. 1.17 de Tao 2019 vía Erdős–Turán cuantitativo + Borel–Cantelli logarítmico. Sustituyo en S2 y propago a la cota de sesgo `β_2(N, k)`:

**Sustitución directa.**
```
δ_S2(c, ε) = c(ε)/2 = ε^3 / 160.
β_2(N, k)  ≤  C_S2 · (log N)^{-ε^3/160}.
```

**Régimen numérico ilustrativo.** Para `ε = 1/10`, `N = 10^{100}` (típico de los regímenes de Tao 2019):
- `c(ε) = 1.25 × 10^{-5}`.
- `δ_S2 = 6.25 × 10^{-6}`.
- `(log N)^{-δ_S2} = (230)^{-6.25 × 10^{-6}} ≈ 1 − 3.4 × 10^{-5}`.

Es decir, la mejora sobre Parseval es **polilogarítmicamente lenta** — el complemento del conjunto excepcional aporta un factor `1 − o(1)` en `log log N`, no en `1/N`. Esto coincide con el diagnóstico del propio 01 (§3 de su sprint 3): "el tamaño de la perturbación no es polinomial en `1/N` sino polilogarítmico". No es decepcionante: es el contenido honesto del método.

**Propagación a `κ(ε)`.** En la interfaz I-02.b de mi sprint 02, `κ(ε) ≍ ε^{3/2}` era propagación cuadrática heurística. Con el `c(ε) = ε^3/80` numérico, reescribo:
```
κ(ε) = sqrt(c(ε)) · (constante absoluta) = ε^{3/2} / sqrt(80) · (cte).
```
La forma `ε^{3/2}` sobrevive **exactamente** porque la raíz de `c(ε)/2` aparece en la conversión `U^2 → ℓ^∞`. No es nueva ganancia: es la misma constante reescrita con el número de 01.

**Honestidad sobre los `[verificar]` de 01.** Agente_01 marca tres riesgos auditables (A1, A2, A3 en su §5). Mi reducción depende **sólo** del valor numérico de `c(ε)`, no del exponente concreto. Si 07 audita estricto y reclasifica el número de 01:

- **Si A1 falla** (exponente cúbico → quinto o más en Erdős–Turán): `c(ε)` cae a `ε^5/(...)` o peor. Mi `δ_S2 = c(ε)/2` cae proporcionalmente. La cota `β_2 ≤ C · (log N)^{-ε^5/...}` sigue siendo no trivial pero la ganancia sobre Parseval se vuelve **prácticamente invisible** (polilogarítmica en `log log N` con exponente quintuplicado). El postulado S2 sobrevive como afirmación; su contenido empírico se degrada.

- **Si A2 falla** (balance Borel–Cantelli sin el factor `ε^2/16`): `c(ε)` recupera `ε/5` lineal. Mi cota mejora: `β_2 ≤ C · (log N)^{-ε/10}`. S2 se beneficia.

- **Si A3 falla** (constante `C_0` no rastreada): la cota efectiva sólo aplica para `X` mayor que la torre `exp(exp(C_*/ε^3))`. S2 también lo arrastra: mi `N_0(c,ε) ≥ X_0(ε)`. No es problema lógico, es problema de aplicabilidad concreta.

- **Si 07 reclasifica el número entero como epitafio** (sin `c(ε)` numérico): S2 queda como postulado **vacío de contenido numérico**. La firma formal sigue siendo legible, pero `δ_S2` se queda simbólico. En ese escenario mi línea cae a "esperando input externo no disponible en este experimento" sin epitafio adicional propio: el epitafio de 01 ya es mi epitafio.

En todos los escenarios la **estructura** de la reducción S2 (Plancherel + transferencia densidad-log → `U^2`) es independiente del número de 01. Lo que se mueve es el valor de las constantes nombradas.

---

## 3. Nota breve sobre el estado de la línea

S2 queda formulado como problema medible y de interés independiente: lema de transferencia densidad-logarítmica → norma Gowers `U^2` sobre intervalos diádicos `[N, 2N]`. La interfaz consumible es utilizable hoy por agente_09 (firma de sumas exponenciales en sección 1) y por cualquier lector externo que quiera atacar el cuello técnico. El régimen trivial `k ≤ (1/2)log_2 N` queda etiquetado callejón (Parseval lo resuelve); el régimen duro `(1/2)log_2 N < k ≤ c · log_2 N` queda apuntado al cuello concreto: preservación de norma `U^2` bajo cambio de variable `n = e^t`. Esto es ciencia honesta de bajo brillo: deja la grieta localizada para el siguiente.

---

### Estado final

Dejo el sub-lema S2 como postulado con interfaz, con constantes nombradas (`C_S2`, `δ_S2 = c(ε)/2`, `A_S2`) y firma consumible para 09 y lectores externos. Reconecté con `c(ε) = ε^3/80` de 01: la cota de sesgo `β_2(N,k) ≤ C · (log N)^{-ε^3/160}` queda explícita, con la advertencia honesta de que la mejora sobre Parseval es polilogarítmicamente lenta y sobrevive a los `[verificar]` de 01 sólo como estructura (no como número concreto si A1 cae duro en auditoría de 07). El cuello de botella real — transferencia densidad-log → `U^2` bajo cambio de variable `n = e^t` — queda enunciado como problema autónomo de interés independiente. La cadena ANÁLISIS EFECTIVO no se cierra en este sprint, pero deja la grieta lo bastante localizada para que un lector externo pueda recogerla aislada.

### Autoevaluación final

**Resultado parcial publicable.** Justificación en una frase: el postulado S2 con firma formal `c(ε)/2 → δ_S2` y reconexión numérica explícita a `β_2 ≤ C · (log N)^{-ε^3/160}` constituye una nota técnica autónoma de transferencia densidad-log → `U^2` que sobrevive como objeto matemático con independencia del veredicto auditor sobre el exponente cúbico de 01; si 07 reclasifica el número de 01 como epitafio, mi etiqueta cae a *Callejón documentado* por arrastre, pero no por falta de producto propio.
