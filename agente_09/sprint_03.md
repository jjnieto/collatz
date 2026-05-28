# Sprint 3 — agente_09 (rol Shallit, C5 + ANÁLISIS EFECTIVO)

## 0. Decisión binaria

**Escenario B.** El `c(ε) = ε³/80` entregado por agente_01 (sprint_03 §1) **no satisface** `c(ε) > 1` para ningún `ε ∈ (0, 1/2)`. La cota máxima de su pista es `c(1/2) = 1/640 ≈ 1.56·10⁻³`, a tres órdenes de `1`. El propio agente_01 lo declara explícitamente en su §4 ("Recomendación a 09: cierra la reducción condicional 9.A' como postulado-con-interfaz"). Mi bombeo del sprint 2 (lema 9.A', paso 5) requería `c(ε) > 1` y la grieta es estructural, no refinable dentro de su pista. Por tanto consolido **postulado-con-interfaz + epitafio breve**.

Antes de cerrar, registro un canal de rescate parcial vía agente_10 (cota `1.940^k` sobre prefijos divergentes) que **no cierra la no-regularidad** pero acota cuantitativamente el espacio del problema. Lo dejo documentado para la posteridad.

---

## 1. Postulado-con-interfaz P-9 (consolidación de 9.A')

**Postulado P-9 (no-regularidad condicional de `L_div`).**

*Hipótesis:*
- **(H-Tao★)** Existe `ε* ∈ (0, 1/2)` y constantes `C₀ > 0`, `X₀ > 0` tales que para todo `X ≥ X₀`,
  `dens_log( 𝓔_{ε*}(X) ) ≤ C₀ · (log X)^{-c*}` con `c* > 1`.
- **(H-Bomb)** El paso (4) del bombeo del sprint 2 §2 se cierra con cuenta auditable: una palabra bombeable `xy^iz` con `|xy| ≤ p`, `|y| ≥ 1`, produce densidad `≥ c_{reg,1}/log X` sobre `[X, 2X]` en la realización binaria, con `c_{reg,1} > 0` absoluta. **(Marcado `[verificar]` en sprint 2 §2 paso 4; no cerrado en sprint 3.)**

*Tesis:*
`L_div = ∅`  ∨  `L_div` no es regular.

*Interfaz numérica (cómo dependería `p` de H-Tao★).*
Si las dos hipótesis se cumplen, el bombeo cierra con constante explícita
```
p ≥ p₀(ε*) := exp( (1/(c* − 1)) · log(C₀ / c_{reg,1}) ).
```
Para `c* → 1⁺` la constante de bombeo diverge; para `c* = 2` y `C₀/c_{reg,1} = 10` se obtiene `p₀ ≈ 10`. La dependencia es **explícita** en las constantes de (H-Tao★), no implícita.

*Constantes nombradas:*
- `ε*` — parámetro de E-Tao realizador de `c* > 1`.
- `c*` — exponente de decaimiento log de la densidad excepcional.
- `C₀` — multiplicador absoluto de E-Tao.
- `c_{reg,1}` — densidad mínima por palabra bombeable; depende solo del bombeo de Myhill–Nerode aplicado a `{0,1}*`, no de E-Tao.
- `p₀(ε*)` — cota inferior derivada para la constante de bombeo.

*Estado de cada hipótesis en el experimento:*
- **(H-Tao★)** No realizada. agente_01 entrega `c(ε) = ε³/80 ≤ 1/640`. La grieta entre `1/640` y `1` es de tres órdenes. agente_01 declara explícitamente que la pista de Tao 2019 vía Erdős–Turán cuantitativo + Borel–Cantelli logarítmico no permite mejorarla sin reescribir la prueba. **H-Tao★ queda como input externo no disponible en este experimento.**
- **(H-Bomb)** Reducible a combinatoria binaria estándar. En este sprint no la cierro; la dejo como tarea ligera para quien continúe (estimación de cuántos `i` mantienen `val(xy^iz) ∈ [X, 2X]`).

*Cadena lógica desde la hipótesis:* H-Tao★ ∧ H-Bomb ⊢ Tesis. Sin `sorry` simbólicos en esta cadena: el paso de la regularidad asumida a una familia paramétrica `F_p(X)` es Myhill–Nerode estándar; el choque con E-Tao en el paso (5) es aritmética directa una vez que `c* > 1`. La única opacidad declarada está en H-Bomb, que es subproblema cerrable.

---

## 2. Canal de rescate parcial vía agente_10 (no realizado)

agente_10 (sprint_02 §7) produce la cota auditable
```
#{u ∈ {0,1}^k : u prefijo de w(n) para n divergente}  ≤  1.940^k
```
vía Hoeffding 2-ádico sobre el drift `½ log₂(3/4) = −0.2075`. Esto cuantifica la entropía topológica del lenguaje de prefijos `P_div`:
```
h_top(P_div)  ≤  log₂ 1.940  ≈  0.957  <  1 = log₂ |Σ|.
```

**Lo que esto da y lo que no.** Un lenguaje regular infinito tiene función de complejidad polinómica `Θ(k^d)` o exponencial `Θ(c^k)` con `c ≤ 2`. La cota `1.940^k` es compatible con cualquier `c ∈ (1, 1.940]`; **no excluye regularidad por sí sola**. Sin embargo, sí impone:

- *Restricción cuantitativa:* un hipotético `L_div` regular debe tener exponente `c ≤ 1.940`.
- *Tensión con familias bombeables:* las familias paramétricas `{val(xy^iz)}_i` tienen complejidad de prefijos esencialmente saturada (`≈ 2^k`) en el sentido siguiente: si fijamos `y` y variamos `i`, los prefijos de longitud `k` obtenidos cubren una fracción de orden `2^k / poly(k)` de `{0,1}^k`. Esto choca con `1.940^k = 2^{0.957 k}`, que es un factor `2^{0.043 k}` más pequeño.

**Cuantificación honesta del rescate.** Si combinara H-Bomb con la cota de 10, podría reemplazar en el paso (5) del sprint 2 el factor `c_{reg,1}/log X` por algo del orden `2^{0.043 k}` con `k ~ log₂ X`, obteniendo:
```
2^{0.043 log₂ X} = X^{0.043}  vs  C₀ · (log X)^{-c(ε)}.
```
Para `X` grande, `X^{0.043}` domina cualquier `(log X)^{-c(ε)}` con `c(ε) > 0`, incluso `c(ε) = 1/640`. **Esto sugiere que el canal de rescate podría cerrar la no-regularidad sin necesitar `c(ε) > 1`.**

Marco esto como **conjetura R-9** (rescate vía agente_10) y NO la elevo a teorema porque:
- No he cerrado el paso "familias bombeables saturan el prefijo en `≈ 2^k / poly(k)`". Es plausible pero requiere combinatoria binaria explícita que no realizo en este sprint.
- La comparación `X^{0.043}` vs `(log X)^{-c(ε)}` mezcla escalas (`k = log₂ X` para una, `X` para la otra) y la transferencia precisa entre lenguaje de prefijos y densidad sobre enteros requiere un argumento que el sprint 2 no ejecutó.

**Conjetura R-9 (no demostrada).** Combinando (H-Bomb) + (cota `1.940^k` de agente_10) + E-Tao con `c(ε) > 0` cualquiera (incluido `c(ε) = ε³/80`), se obtiene: `L_div = ∅` ∨ `L_div` no es regular. *Esta conjetura, de cerrarse, evitaría depender de H-Tao★.* Queda como sub-problema abierto para sprint 4 si lo hubiera; no lo hay.

---

## 3. Epitafio técnico

La cadena de no-regularidad de `L_div` por bombeo Myhill–Nerode requiere, en su forma directa, un decaimiento `c(ε) > 1` de la densidad logarítmica del conjunto excepcional de Tao. La cuantificación más optimista de Tao 2019 Prop. 1.17 producible sin reescribir la prueba —vía Erdős–Turán cuantitativo más Borel–Cantelli logarítmico— da `c(ε) ≤ ε/5` lineal en `ε`, o `c(ε) = ε³/80` cúbica en `ε` tras balance de la elección de `η`. Ambas opciones son `≪ 1` y la grieta es de al menos tres órdenes para todo `ε ∈ (0, 1/2)`. La efectivización con `c(ε) > 1` requeriría reescribir §3 de Tao 2019 en lenguaje cuantitativo, trabajo que ningún sprint en solitario absorbe y que la comunidad no ha cerrado desde 2019. Existe un canal de rescate plausible vía la cota `1.940^k` sobre prefijos divergentes de agente_10, que podría hacer innecesario el `c(ε) > 1`, pero requiere cerrar el paso "familias bombeables saturan el prefijo" combinatorialmente — paso que dejo identificado pero no ejecutado. Mi línea queda colgando exactamente en la intersección de dos cuellos de botella: la efectivización de Prop. 1.17 (cuello de agente_01) y el cierre combinatorio del paso H-Bomb (cuello propio, ligero pero no realizado).

---

## 4. Cómo leerme a futuro

Quien retome esto debería atacar **conjetura R-9** antes que perseguir `c(ε) > 1`. La razón: R-9 es combinatoria binaria + Hoeffding 2-ádico (ya entregado por 10), mientras que `c(ε) > 1` exige análisis de Fourier cuantitativo en un setup donde la comunidad lleva atascada años. R-9 podría ser cerrable por alguien con dedicación de un mes; `c(ε) > 1` no.

---

### Estado final

Entrego postulado-con-interfaz P-9 (no-regularidad de `L_div` condicional a H-Tao★ con `c* > 1` y a H-Bomb), epitafio breve sobre por qué H-Tao★ no se realiza con el `c(ε) = ε³/80` de agente_01, y conjetura R-9 (canal de rescate vía la cota `1.940^k` de agente_10) que dejo identificada y no cerrada. Mi línea termina con dos cuellos de botella precisos: efectivización de Tao 2019 Prop. 1.17 (externo, cuello reconocido por la comunidad desde 2019) y cierre combinatorio de H-Bomb (interno, ligero pero no ejecutado en este sprint). La reducción condicional del sprint 2 sobrevive como postulado limpio con dependencia explícita en constantes nombradas; la conjetura S1 del sprint 1 ("`L_div` no regular es demostrable") queda definitivamente degradada a "reducción condicional con bloqueo cuantitativo identificado". Si la posteridad lee este experimento, que sepa que aquí se intentó por la vía de bombeo + Tao 2019 + Hoeffding 2-ádico, y que el cierre real está más cerca por R-9 que por H-Tao★.

### Autoevaluación final

**Resultado parcial publicable.** Una sola frase de justificación: el postulado-con-interfaz P-9 más la conjetura R-9 documentan con precisión qué insumo externo cerraría la línea, qué canal de rescate interno está identificado pero no ejecutado, y por qué la grieta cuantitativa (de tres órdenes) entre `c(ε) = ε³/80` y el `c(ε) > 1` requerido no es refinable sin reescribir Tao 2019 — material citable como nota técnica autónoma sobre el estado de la cadena ANÁLISIS EFECTIVO ↔ teoría de lenguajes en el problema de Collatz.
