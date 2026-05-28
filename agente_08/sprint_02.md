# Sprint 02 — agente_08 (rol Hamkins, tubería COMPUTACIONAL-LÓGICA)

**Redirección aceptada.** Mi sub-problema del sprint 1 (clasificar `I_M` semiregular en `M ⊨ PA + ¬Collatz`) es vacuo si Collatz ∈ PA, y la síntesis del jefe me lo señaló. Pivoto al ángulo de **cotas inferiores efectivas sobre `σ(n)`**, que sí alimenta directamente la reducción condicional de agente_07.

Nota de procedimiento: `agente_05/sprint_02.md` aún no existe en el momento en que escribo. Trabajo con (i) el plan de medición declarado en `agente_05/sprint_01.md`, (ii) outliers conocidos de la literatura, y (iii) la columna `C_emp ≈ 6.95` que agente_07 mencionó en su sprint 1. Cada número va etiquetado [medido] o [literatura/folclore] o `[verificar]`.

---

## 1. Outliers conocidos de `σ(n)/log₂(n)`

Tabla de **records de tiempo total de parada** (OEIS A006877, *delay records*); `σ` es el tiempo total de parada en el operador `n → n/2` (par) ó `n → 3n+1` (impar). Si se prefiere el operador "Syracuse" `T_S(n) = (3n+1)/2` para impares, los valores escalan por un factor `≈ log 2 / (log 2 + log 3 / (1+log_2 3))` `[verificar]`; aquí uso la convención `n → 3n+1`/`n/2` por consistencia con la literatura citada.

| n (récord) | σ(n) [literatura] | log₂(n) | σ(n)/log₂(n) |
|---:|---:|---:|---:|
| 27 | 111 | 4.755 | 23.34 |
| 703 | 170 | 9.458 | 17.97 |
| 6 171 | 261 | 12.591 | 20.73 |
| 77 031 | 350 | 16.234 | 21.56 |
| 837 799 | 524 | 19.677 | 26.63 |
| 8 400 511 | 685 | 22.999 | 29.78 |
| 63 728 127 | 949 | 25.926 | 36.60 |
| 670 617 279 | 986 | 29.321 | 33.62 |
| 9 780 657 630 | 1132 | 33.187 | 34.11 |
| 75 128 138 247 | 1228 | 36.129 | 33.99 |

Fuente nominal: OEIS A006877 + A006878 `[verificar números exactos, especialmente σ(8 400 511) y σ(63 728 127)]`. Lagarias 1985 (*The 3x+1 problem and its generalizations*) discute estos valores como "campeones" de paridad. Roosendaal `ericr.nl/wondrous` los mantiene actualizados.

**Observación 1.** El cociente `σ(n)/log₂(n)` para los récords no es monótono ni en `n` ni en `log n`, pero está acotado superiormente en este rango por ~37 y oscila visiblemente. Si se cree la cota empírica `σ(n) ≤ 6.95 · log₂(n)` mencionada por agente_07, este conjunto la **viola** por un factor ~5. Esto es importante: o el `C_emp` de agente_07 está mal (probable: `6.95` debe ser el factor para el tiempo de parada *promedio* sobre un rango, no para el peor `n`), o se refiere al "stopping time" `σ_1(n)` (primera vez que la órbita baja de `n`) que sí es ≈ `log_2(n) · log 4 / (log 4 − log 3)` ≈ `6.95 · log_2 n` por el heurístico de Terras `[verificar]`. **Anoto la ambigüedad como punto a resolver con agente_07 en sprint 3.**

---

## 2. Ajuste de cota inferior

**Pregunta.** ¿Existe `c, α` tales que infinitos `n` cumplen `σ(n) ≥ c · (log₂ n)^α`?

Caso `α = 1` (lineal). Tomando los récords de la tabla:

`σ(n_k) / log₂(n_k)` sobre los récords arroja un mínimo de ~18 (en n=703) y un máximo de ~37, con tendencia ligeramente creciente (regresión informal: `σ ≈ (28 ± 6) · log₂ n` sobre récords) [medido sobre tabla anterior, regresión a ojo]. Por tanto **es razonable conjeturar**:

> **C-Inf-1:** Existen infinitos `n` con `σ(n) ≥ 20 · log₂(n)`. (Conjetura empírica, no demostrada.)

Caso `α > 1`. Si dibujamos `σ(n_k)` vs `log₂(n_k)` en los récords, los puntos son casi-lineales; no hay evidencia de crecimiento super-lineal. Un ajuste `σ ∝ (log n)^α` con `α > 1` requeriría que los cocientes crecieran sin cota, lo que en el rango medido (`n` hasta ~`10^11`) no ocurre. Conclusión:

> **C-Inf-2:** Para `α > 1`, no hay evidencia empírica de `σ(n) ≥ c (log₂ n)^α` infinitamente. Probablemente falso (heurístico Lagarias predice `σ(n) ~ 2/log(4/3) · log n ≈ 6.95 log n` *en promedio* `[verificar]`, y récords sólo escalan el factor constante).

**Demostrabilidad en PA de C-Inf-1.** Esto es el punto crítico. Aunque empíricamente `σ(n) ≥ 20 log₂(n)` parece suceder para infinitos `n`, no conozco demostración. Lagarias (*The 3x+1 problem: an annotated bibliography*) menciona que sólo se conoce rigurosamente `σ(n) ≥ log₂(n)` para todo `n > 1` (trivial: hay que dividir por 2 al menos `log₂ n` veces para llegar a 1, aplicable incluso si no hubiese pasos `3n+1`) `[verificar]`. Lo "trivial" da `α=1, c=1`. Todo lo que mejora `c=1` parece estar fuera del alcance demostrable actual.

**Resumen del ajuste.**

- **Cota inferior trivial demostrable:** `σ(n) ≥ ⌊log₂ n⌋` para todo `n ≥ 1` `[verificar como folclore]`.
- **Cota inferior empírica (no demostrada):** `σ(n) ≥ 20 · log₂ n` infinitamente.
- **Cota inferior fuerte (`α > 1`):** sin soporte; probable callejón.

---

## 3. Conexión con agente_07: ¿qué cortes semiregulares quedan excluidos?

agente_07 propuso: *Si `∀n ≥ N_0, σ(n) ≤ C · log₂(n)`, entonces Collatz ∈ `IΔ₀+exp`*. La hipótesis usada es **superior**. Mi cota inferior actúa de modo distinto: descarta no-trivialidad, no demuestra Collatz.

Concretamente, en un modelo `M ⊨ PA + ¬Collatz` consideremos el corte `I_M = {n ∈ M : σ(n) existe en M}`. agente_07 necesita excluir que `I_M` sea **semiregular** (cerrado bajo funciones definibles totales). Mi contribución:

> **Interfaz potencial.** Si demostrásemos `σ(n) ≥ f(log n)` con `f` una función definible que crece *más rápido que cualquier función PR estándar* sobre los `n` no estándar del corte, entonces `σ` no podría ser total sobre un corte semiregular, porque semiregular ⇒ cerrado bajo `f`.

Pero `f = c · log` es *demasiado mansa* para producir esa exclusión: cualquier corte semiregular es cerrado bajo `log` trivialmente. **Por tanto la cota lineal `c log n` NO restringe semiregularidad.** Para restringirla necesitaríamos al menos cota super-polinómica, que la evidencia empírica contradice.

**Diagnóstico honesto.** El ángulo "cota inferior efectiva ⇒ exclusión de cortes semiregulares" **no funciona** con cotas lineales o sub-polinómicas. Esto era el riesgo señalado por el jefe en la síntesis del sprint 1. **Confirmado: la rama "exclusión de semiregularidad" es callejón.**

Sin embargo, la cota inferior sí tiene un uso *complementario* en la reducción de agente_07: garantiza que la hipótesis `σ(n) ≤ C log n` no es vacuamente cierta sobre `N` (no es que `σ` sea acotado por una constante), por lo que la reducción es *no degenerada*. Es un papel de saneamiento, no de exclusión.

---

## 4. Interfaz para agente_07

```
Hipótesis L (cota inferior empírica, no demostrada):
  Para infinitos n ∈ N, σ(n) ≥ 20 · log₂(n).
  [Soporte: tabla de récords A006877 hasta n ≈ 7.5 × 10^10.]

Hipótesis L-triv (demostrable en PA, folclore):
  Para todo n ≥ 2, σ(n) ≥ ⌊log₂ n⌋.

Uso recomendado en tu reducción condicional:
  - L-triv basta para garantizar que la cota superior C_emp · log₂ n
    no es vacua sobre N (saneamiento).
  - L NO es suficiente para excluir que I_M sea corte semiregular en
    M ⊨ PA + ¬Collatz: log n es definible y cualquier corte
    semiregular es cerrado bajo log.
  - Por tanto, el paso "I_M no semiregular" en tu esquema de prueba
    NO se sigue de cotas inferiores sub-polinómicas sobre σ.
    Sugiero formular la reducción evitando ese paso, o pedirme una
    cota mucho más fuerte (cuyo soporte empírico actualmente no existe).

Pregunta para ti: ¿qué hipótesis exacta sobre σ por debajo necesitas
para que tu esquema cierre? Si es del tipo "σ(n) → ∞ efectivamente",
L-triv alcanza. Si necesitas "σ(n) ≥ φ(n) con φ no acotada por PR",
es callejón.
```

---

### Sub-problema para sprint 3

Verificar contra los outliers efectivos de `agente_05/sprint_02.md` (cuando estén) si el ratio `σ(n)/log₂(n)` es **acotado** en el rango medido (hasta `n ≤ 2^32` previsto). **Criterio de éxito medible:** producir el valor numérico `R_max = max_{1<n≤N} σ(n)/log₂(n)` para el `N` máximo de agente_05, junto con la lista de los 10 `n` que lo alcanzan; y decidir empíricamente entre las dos hipótesis (H-acotado: `R_max → R_∞ < ∞`) vs (H-divergente: `R_max → ∞`). Output mínimo: un número, una lista, y un veredicto entre H-acotado/H-divergente con barras de confianza honestas.

### Autoevaluación

**Callejón sin salida** (cambio respecto a sprint 1, que era *Improbable*). El ángulo de cota inferior efectiva como restricción de cortes semiregulares **no funciona** porque los cocientes empíricos `σ/log` están en `O(1)` y log es definible/PR-cerrado. La pieza que rescato — saneamiento de la hipótesis de agente_07 — es valiosa pero modesta: vale dos líneas, no un agente. Recomiendo al jefe poda en sprint 3 o reasignación.

