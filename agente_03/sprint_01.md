# Sprint 01 — agente_03 (rol Lindenstrauss, C2)

**Ángulo:** dinámica medible y rigidez de medidas sobre la acción Collatz, principalmente en su extensión 2-ádica.

---

## 1. Estado del arte (mi ángulo: medible/ergódico)

La función de Syracuse `T : Z_2 -> Z_2` definida por `T(x) = x/2` si `x` es par 2-ádicamente y `T(x) = (3x+1)/2` si es impar es **continua y suryectiva** sobre los enteros 2-ádicos, y la extensión natural (Lagarias 1985 `[verificar]`) la convierte en un sistema dinámico topológico-medible bien definido. Hechos básicos:

- **Medida invariante natural:** la medida de Haar de `Z_2` (uniforme en cilindros) es invariante por `T`. La proyección "paridad" envía órbitas a sucesiones de `{0,1}^N` y el push-forward de Haar es la medida de Bernoulli `(1/2, 1/2)` (Lagarias; ver también Bernstein–Lagarias `[verificar]`).
- **Conjugación de paridad:** existe un homeomorfismo `Q : Z_2 -> Z_2` (la "función Q" de Lagarias) que conjuga `T` con la suma `x -> x+1` (o, según la versión, con el shift de Bernoulli en `{0,1}^N`). Esto implica que **a nivel 2-ádico la dinámica medible está totalmente entendida**: es isomorfa a un sistema con espectro discreto / Bernoulli puro `[verificar]`.
- **Ergodicidad:** `(Z_2, T, Haar)` es ergódica (de hecho mixing por la conjugación) `[verificar]`.

La pregunta importante no es por tanto "¿qué pasa en `Z_2`?" — eso está domado — sino: **¿cómo distinguir `Z` (incrustado densamente en `Z_2`) dentro de esa dinámica?** Los enteros forman un conjunto de medida de Haar cero, así que los teoremas ergódicos clásicos sobre `T` no dicen nada directamente sobre órbitas enteras.

### El paralelo con rigidez (y sus límites)

El programa Einsiedler–Katok–Lindenstrauss sobre rigidez de medidas para acciones de `A = diag(R^k)` en `SL_n(Z) \ SL_n(R)` muestra que, bajo entropía positiva respecto a un elemento, las únicas medidas invariantes ergódicas son las "obvias" (Haar de subgrupos algebraicos). El triunfo paradigmático es el avance hacia Littlewood (EKL 2006 `[verificar]`).

¿Hay una **acción de rango ≥ 2** natural detrás de Collatz que justificaría buscar rigidez? Candidatos:

1. **Acción de `Z^2` (o monoide) generada por "multiplicar por 3" y "dividir por 2"** sobre `Z_2`, o más generalmente sobre `R / Z` (a la Furstenberg `x2, x3`). Esto evoca el célebre teorema de Furstenberg 1967 sobre invariancia conjunta bajo `x2, x3` en `R/Z`: las únicas medidas no atómicas son la de Lebesgue (Rudolph 1990 lo hizo bajo entropía positiva `[verificar]`).
2. **El acoplamiento Collatz mezcla `x3+1` (no homogéneo) con `x/2` (homogéneo).** El "+1" rompe la estructura multiplicativa pura y por tanto el aparato de Furstenberg–Rudolph–Lindenstrauss **no se aplica directamente**.

Esto es, en mi lectura honesta, el obstáculo central: la rigidez funciona para acciones **algebraicas** de rangos altos; Collatz tiene **una sola dirección dinámica genuina** una vez conjugada (es un odómetro / Bernoulli shift). La entropía es positiva pero la acción es de rango 1.

### Lo que sí podría tener tracción

- Trabajos de Akin (2004) y Bernstein–Lagarias sobre conjugación `[verificar]`.
- **Tao 2019** (densidad logarítmica) puede leerse como un teorema de equidistribución débil: la órbita típica visita escalas logarítmicas según una medida casi invariante. La "pérdida" entre "casi todas" y "todas" es exactamente la incapacidad de excluir un conjunto de densidad cero pero topológicamente grande.
- Análogos `p`-ádicos: ¿hay una formulación de Collatz como flujo en un grupo homogéneo donde la acción de un toro sea de rango ≥ 2? No la veo todavía; el agente_04 está mejor posicionado para esa formulación simbólica.

### Lo que huele a muerto

- Buscar una **medida `T`-invariante absolutamente continua respecto a Lebesgue en `R`** que detecte ciclos: no la hay sobre `R`, sólo sobre `Z_2`, y el problema es que `Z` tiene medida cero.
- Aplicar Ratner directamente: Collatz no es un flujo unipotente en un espacio homogéneo. No hay grupo de Lie ambiente natural.

---

## 2. Estrategia: convertir "no-ciclos" en una afirmación de rigidez

Idea de trabajo (no demostración, **borrador, requiere auditoría**): un ciclo no trivial de Collatz produciría una **medida `T`-invariante atómica con soporte finito en `Z` ⊂ Z_2**, soporte que es disjunto del ciclo trivial `{1,2,4}`. Si pudiera demostrarse que **toda medida `T`-invariante ergódica sobre `Z_2` cuyo soporte está contenido en `Z` debe estar contenida en el ciclo trivial**, eso cerraría la parte de ciclos.

Una formulación tipo rigidez sería: *"Sea μ una medida de probabilidad `T`-invariante ergódica sobre `Z_2` con `supp(μ) ⊂ Z` y entropía cero. Entonces `supp(μ) = {1,2,4}`."* (Las medidas con entropía positiva sobre `Z` son problemáticas porque `Z` es contable; pero esa misma observación da una salida.) — **esto requiere auditoría: el cruce entre "entropía positiva en Z_2" y "soporte numerable" puede colapsar la afirmación a algo trivial o vacuo.**

Para órbitas divergentes la formulación sería distinta: una órbita divergente da una medida invariante en la **compactificación**, no en `Z_2` (porque escapa al infinito). Esa parte está fuera del marco 2-ádico estándar y empuja hacia el ángulo del agente_01 (Tao).

---

### Sub-problema para sprint 2

**Enunciado.** Clasificar las medidas de probabilidad `T`-invariantes ergódicas en `Z_2` cuyo soporte está contenido en `Z`. Conjetura precisa: la única tal medida es la equidistribuida sobre el ciclo trivial `{1,2,4}`.

**Criterio de éxito medible (sprint 2):**
- (mínimo) Un lema, con hipótesis y tesis escritas formalmente, del tipo: *"Si μ es `T`-invariante, ergódica, `supp(μ) ⊂ Z`, y de entropía cero respecto al refinamiento natural de paridad, entonces μ es atómica con soporte en un ciclo finito de `T` en `Z`."* Demostración elemental (no es el resultado profundo; reduce el problema a "clasificar ciclos finitos", que es ya conocido como equivalente a Collatz-sin-divergencia).
- (objetivo) Identificar el invariante exacto cuyo control permitiría descartar ciclos de longitud ≥ N para N pequeño-medio, conectando con la cota de Eliahou (agente_06). Métrica: un valor numérico explícito de N alcanzable por el argumento.
- (fracaso aceptable) Documentar que el paso "entropía cero implica soporte en ciclo" colapsa la conjetura a sí misma, en cuyo caso etiquetar la línea como callejón y reasignar esfuerzo.

### Autoevaluación

**Improbable.** La maquinaria de rigidez de medidas funciona para acciones algebraicas de rango ≥ 2, y la acción Collatz, tras conjugación 2-ádica, es esencialmente de rango 1 (un único Bernoulli shift). El sub-problema propuesto es honesto y bien definido, pero su solución probablemente es **equivalente** a una parte de Collatz, no más fácil. Sigo porque (a) formalizar la equivalencia con precisión es útil para la Célula 4 (lógica), y (b) hay una posibilidad pequeña de que un teorema tipo Furstenberg `x2, x3` adaptado al setup `x3+1, x/2` aporte estructura que no veo aún.
