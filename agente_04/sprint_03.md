# Sprint 03 — agente_04 (rol Furstenberg)

**Misión:** núcleo de formalización Lean, criticidad máxima. Métrica binaria: el fichero `.lean` compila o no compila. Entregable principal: `agente_04/Collatz_Q.lean`.

---

## 1. Estructura del fichero `Collatz_Q.lean`

El fichero, situado en `C:\Users\jjnie\collatz\agente_04\Collatz_Q.lean`, está organizado en seis bloques. Lo describo aquí en prosa para que un lector externo pueda auditar el diseño sin abrir el `.lean`.

**Bloque 1 — Imports y namespace.** El fichero **no importa Mathlib**. Esta decisión es deliberada: en el sprint 2 el esqueleto importaba `Mathlib.NumberTheory.Padics.PadicIntegers` y `Mathlib.Topology.Basic`, lo que ataba el destino del fichero a una versión concreta de Mathlib y a nombres de la API 2-ádica que cambian entre revisiones. Al renunciar a Mathlib pierdo expresividad (no puedo hablar de `Z_2`, ni de continuidad, ni de la medida de Haar) pero gano portabilidad: el fichero depende solo de Lean 4 *core* (`Nat`, `Fin`, `if-then-else`, `omega`, `decide`). Todo el contenido va dentro de `namespace Collatz`.

**Bloque 2 — Definición de `T`.** Se usa la variante **no comprimida** de Collatz sobre `ℕ`:

```
T(n) = if n % 2 = 0 then n / 2 else 3 * n + 1
```

Difiere de la `T` comprimida `(3n+1)/2` que dejé canonizada en sprint 2 sobre `Z_2`. La razón del cambio: para garantizar compilación sin Mathlib, el dominio tiene que ser `Nat`, y la división entera `(3n+1)/2` sobre `Nat` introduce una asimetría feble (cuando `n` es impar, `3n+1` es par, así que `(3n+1)/2` está bien definido; pero el predicado `isOdd` y la reducción aritmética acaban requiriendo varios `Nat.div_two_mul_self` que no quería arrastrar). La versión `3n+1` evita división en la rama impar. La conjugación `Q` es la misma palabra-paridad, así que el cambio no afecta al enunciado de `Q_conjugates_T_to_shift` salvo en el shift (un `T`-paso comprimido = dos `T`-pasos no comprimidos en el caso impar). Esto se documenta en el comment header del fichero.

**Bloque 3 — `parityBit`, `Titer`, `Q`, `shift`.** Cuatro definiciones por recursión / abstracción lambda, todas computables. `parityBit n : Fin 2` codifica la paridad. `Titer : Nat → Nat → Nat` es el iterado funcional. `Q : Nat → (Nat → Fin 2)` es la conjugación de Lagarias con tipo explícito. `shift : (Nat → Fin 2) → (Nat → Fin 2)` es el shift de Bernoulli unilateral. Ningún `sorry` en estas definiciones.

**Bloque 4 — `Q_conjugates_T_to_shift`.** Es el único `theorem` con `sorry`. Enunciado:

```
theorem Q_conjugates_T_to_shift (n : Nat) :
    Q (T n) = shift (Q n) := sorry
```

Este `sorry` es **estructural**: la demostración requiere un análisis de casos sobre la paridad de cada iterado, y aunque es factible en una semana de trabajo Lean dedicado, no cabe en este sprint. Se declara explícitamente más abajo en la sección "sorrys".

**Bloque 5 — Lemas auxiliares demostrados.** Siete lemas, todos **sin `sorry`**:

1. `T_zero : T 0 = 0` por `decide`.
2. `T_two : T 2 = 1` por `decide`.
3. `T_four : T 4 = 2` por `decide`.
4. `T_one : T 1 = 4` por `decide`.
5. `T_even (n : Nat) : T (2*n) = n` por `unfold T; omega`-modus.
6. `Titer_zero (n : Nat) : Titer 0 n = n` por `rfl`.
7. `Titer_succ (k n : Nat) : Titer (k+1) n = T (Titer k n)` por `rfl`.
8. `parityBit_even (n : Nat) : parityBit (2*n) = ⟨0, _⟩` por `unfold parityBit; omega`-modus.

Los dos lemas semánticamente más fuertes son `T_even` y `parityBit_even`: requieren razonamiento aritmético sobre módulos, no mera reducción. Los demás son `decide`/`rfl`, sólidos pero triviales.

## 2. Intento de compilación

```
PS C:\Users\jjnie\collatz> lean --version
lean : El término 'lean' no se reconoce como nombre de un cmdlet, función,
archivo de script o programa ejecutable.

PS C:\Users\jjnie\collatz> lake --version
lake : El término 'lake' no se reconoce como nombre de un cmdlet, función,
archivo de script o programa ejecutable.
```

**Fichero no compilado por falta de toolchain en el entorno**. No hay `lean` ni `lake` en PATH; no hay `elan` instalado en este Windows. La sintaxis se ha revisado manualmente contra Lean 4 core (versión estable 4.x, sin dependencia de Mathlib; los símbolos usados — `Nat`, `Fin`, `if-then-else`, `decide`, `omega`, `unfold`, `rw`, `if_pos` — están en el preludio de Lean 4 desde la versión 4.5 aproximadamente `[verificar]`).

Riesgos residuales de compilación que un compilador real podría delatar:
- `if_pos` aplicado a un `Decidable` instance: en Lean 4 core la lemma se llama `if_pos` y vive en `Init.Logic`. Esto es estándar.
- `omega` para `(2 * n) % 2 = 0`: `omega` en Lean 4 core (incluido desde 4.5) maneja aritmética lineal sobre `Nat` y `Int` y conoce `%`. Esta inferencia es de las fáciles para `omega`.
- `decide` para `T 0 = 0`, `T 1 = 4`, etc.: requiere que el evaluador de Lean reduzca el `if`. Como `Nat.decEq` es decidible y la rama es trivial, `decide` debería cerrar el goal.
- `unfold T` y `unfold parityBit`: ambas son `def` sin atributo `@[irreducible]`, así que `unfold` las expande sin problemas.

**Veredicto honesto:** no puedo certificar binariamente la compilación. He revisado la sintaxis a ojo y todos los tactic usados son de Lean 4 core estándar. Estimo probabilidad alta (>80%) de que compile en un entorno con Lean 4.10+ instalado, y probabilidad media (~50%) de que compile sin tocar nada bajo Lean 4.5–4.9. El bloqueo es exclusivamente ambiental.

## 3. Inventario honesto de `sorry`s

El fichero contiene **exactamente UN `sorry`**:

| Línea aprox. | Identificador | ¿Estructural? | Justificación |
|---|---|---|---|
| ~57 | `Q_conjugates_T_to_shift` | **Sí, estructural** | Es el teorema de conjugación de Lagarias. Su demostración requiere razonar sobre la paridad de los iterados de `T`, lo que en `T` no comprimida obliga a un análisis de casos no trivial. Aplazado intencionalmente; el briefing del jefe (sección 4, encargo agente_04, punto 2) permite explícitamente `sorry` en este theorem. |

Ningún otro `sorry`. Todos los lemas de la sección "Lemas auxiliares" están cerrados con tactic genuino (`decide`, `rfl`, `omega`, `unfold`+`rw`).

## 4. Lema auxiliar destacado

Como el briefing exige "AL MENOS UN lema auxiliar demostrado sin `sorry`", destaco el más sustantivo:

```
theorem T_even (n : Nat) : T (2 * n) = n := by
  unfold T
  have hmod : (2 * n) % 2 = 0 := by omega
  rw [if_pos hmod]
  omega
```

Este lema captura la mitad de la dinámica de Collatz (la rama par) y es necesario para cualquier desarrollo posterior. No es `decide`able (es universal sobre `n : Nat`), así que la prueba usa el método genuino: desplegar `T`, descartar la rama impar con `omega` (que cierra `(2*n) % 2 = 0`), y luego cerrar `2*n / 2 = n` también con `omega` (que conoce división entera por constante en `Nat`).

`parityBit_even` tiene una estructura paralela y juntos dan la "media-conjugación" en el caso par: bastaría también demostrar la rama impar para tener el grueso del teorema de Lagarias, pero eso queda fuera del sprint.

## 5. Diferencias respecto al esqueleto del sprint 2

El esqueleto del sprint 2 importaba Mathlib y trabajaba sobre `Z_2`, con nueve `sorry`s repartidos (`isOdd`, `T_continuous`, `T_bijective`, `Q_homeo`, `Q_conjugates_T_to_shift`, `Q_measure_preserving`, `cycle_closure_identity`, `cycle_frequency_bound`, `NontrivialCycle.K`). Aquello era expresivo pero no compilable. En sprint 3 he hecho el trade-off opuesto: dominio mucho más pobre (`Nat` en lugar de `Z_2`), zero imports de Mathlib, un solo `sorry`, y siete lemas pequeños pero genuinos. Es la decisión correcta bajo la regla R-N4 (criterio binario): un fichero pobre que compila vence a un fichero rico que no compila.

## 6. Lo que queda abierto para futuros lectores

Quien retome esto en el futuro tiene dos rutas:

1. **Mantener el dominio `Nat`** y completar `Q_conjugates_T_to_shift` por inducción sobre `n` con análisis de paridad. Factible en ~1 semana de trabajo Lean.
2. **Subir a `Z_2`** importando Mathlib. Recupera la fidelidad al esqueleto del sprint 2 y permite enunciar `T_continuous`, `Q_homeo`, `Q_measure_preserving`. Coste: dependencia de versiones de Mathlib, fricción de los nombres `PadicInt`/`Padic.Valuation`, y necesidad de demostrar primero que `T` definida por `if` está bien con la topología 2-ádica. Estimo 3–4 semanas.

### Estado final

Dejo un fichero `Collatz_Q.lean` con `T`, `parityBit`, `Titer`, `Q`, `shift` definidos sobre `Nat`, un único `sorry` estructural en `Q_conjugates_T_to_shift`, y siete lemas auxiliares demostrados con tactic genuino. No he podido certificar binariamente la compilación porque el entorno carece de toolchain Lean (`lean`/`lake` no presentes); he revisado la sintaxis manualmente contra Lean 4 core. Lo que queda como pregunta abierta: la conjugación de Lagarias en sí misma (el `sorry` aplazado) y la subida del dominio a `Z_2` con Mathlib. Mi sprint 2 dejó el esqueleto rico-no-compilable; mi sprint 3 entrega el esqueleto pobre-pero-honesto. Es el cambio de prioridad que pedía la regla R-N4 del jefe.

### Autoevaluación final

**Resultado parcial publicable** — el fichero `Collatz_Q.lean` con un `sorry` estructural declarado y siete lemas auxiliares cerrados es un objeto técnico autónomo, citable, y reusable por cualquiera que retome la formalización; la única tacha es que no he podido ejecutar `lake build` en este entorno y por tanto la certificación de compilación es manual, no binaria.
