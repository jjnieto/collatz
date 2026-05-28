# agente_08 — Hamkins (Célula 4, lógica): modelos no estándar y perspectiva set-teórica

## 1. Planteo del ángulo

La pregunta que el Jefe me asigna es deliberadamente incómoda: ¿qué se gana mirando Collatz en modelos no estándar de PA (o de ZFC)? Mi compañero (agente_07) ataca la cuestión de **fuerza de prueba**. Yo me ocupo de la cuestión dual: **transferencia entre modelos**. Antes de proponer sub-problemas conviene aclarar cuándo la pregunta tiene contenido matemático y cuándo es vacua.

## 2. Lo que el formalismo dice "gratis"

La conjetura de Collatz admite varias formulaciones distintas en aritmética; estas formulaciones **no son equivalentes** sobre teorías débiles, y esto es exactamente donde aparece el contenido lógico.

- **Versión Π₂ (parada universal):** "∀n ∃k T^k(n)=1". Es Π₂ aritmética (cuantificador existencial sobre la longitud del cómputo, predicado primitivo recursivo dentro). [verificar: la clasificación estándar la sitúa en Π₂, p. ej. Kurtz–Simon 2007].
- **Versión "no hay ciclo no trivial":** Π₁ si uno acota la longitud del ciclo (con la cota de Eliahou se vuelve Π₁ efectivo); sin cota es Π₂.
- **Versión "no hay órbita divergente":** Π₃ en su forma natural ("∀n ¬∃ función f creciente tal que ∀k T^{f(k)}(n)>k"), aunque colapsa a Π₂ usando el lema de König interno.

Hechos básicos de teoría de modelos que enmarcan el problema:

1. **Π₁ se transfiere hacia abajo y hacia arriba en extensiones elementales.** Una sentencia Π₁ verdadera en N es verdadera en *todo* modelo de PA por absolutez de Σ₁ (Tarski–Vaught + decidibilidad de Δ₀). Si Collatz fuera demostrablemente equivalente a una Π₁ sobre PA, "Collatz en modelos no estándar" sería **vacuo**.
2. **Π₂ no es absoluta.** Una sentencia Π₂ verdadera en N puede fallar en una extensión elemental *no estándar*: el testigo k de "∃k T^k(n)=1" para un n no estándar tendría que ser él mismo no estándar, y nada en N estándar lo fuerza.
3. **Toda extensión elemental M ⊨ PA contiene a N como segmento inicial cerrado bajo funciones definibles.** Por tanto, para n ∈ N estándar, la órbita Collatz es la misma en M que en N. **La acción interesante ocurre únicamente sobre los elementos no estándar de M.**

De aquí, primera observación honesta: **preguntar "¿la órbita Collatz de un entero no estándar diverge en algún modelo?" no es vacuo siempre que la formulación sea Π₂ y no Π₁**. Es una pregunta sobre la estructura de los segmentos no estándar bajo iteración de una función definible.

## 3. Cuándo es vacuo y cuándo no

**Caso vacuo:** si alguien demostrara Collatz en PA (incluso en una extensión recursiva consistente de PA), entonces por completitud sintáctica relativa la sentencia se cumple en *todo* modelo de PA, incluidos los no estándar. La perspectiva modelo-teórica colapsa.

**Caso no vacuo:** si Collatz es independiente de PA (escenario que el agente_07 estudia), entonces existen modelos M ⊨ PA en los que Collatz **falla**. En tales modelos hay un n ∈ M\N cuya órbita o bien entra en un ciclo no trivial (necesariamente con elementos no estándar; el ciclo trivial 1→4→2→1 está en N) o bien es no-acotada hacia arriba en M. La pregunta "¿cómo se ve esa órbita?" deja de ser vacua: es una pregunta de **estructura de modelos**, no de aritmética concreta. Aquí entran herramientas como el teorema de MacDowell–Specker (todo modelo de PA tiene una extensión elemental conservativa) [verificar referencia exacta] y técnicas de Kirby–Paris para construcción de cortes.

**Caso intermedio (más interesante):** aun siendo Collatz demostrable en ZFC pero no en PA, los modelos no estándar de PA donde falla serían "no-ω-modelos", y la falla viviría exclusivamente en la parte no estándar. Esto da una **estrategia indirecta**: si uno demostrara que cualquier modelo no estándar de PA en el que Collatz falla debe satisfacer alguna propiedad combinatoria fuerte (p. ej. existencia de una clase definible no acotada con cierta densidad), y luego que esa propiedad es inconsistente con PA + ciertos axiomas Π₂, se obtendría una demostración de Collatz por reducción al absurdo modelo-teórica. Es el patrón usado en Paris–Harrington (con la variante de Ramsey) y, en menor medida, en Friedman para árboles. La diferencia es que aquí no tenemos todavía ningún "principio combinatorio espejo" candidato.

## 4. Lo que descarto

- **Forcing y ZFC:** Collatz es una sentencia aritmética (de hecho Π₂). Por absolutez de Shoenfield (Σ¹₂ es absoluta entre V y extensiones por forcing), forcing **no** puede cambiar el valor de verdad de Collatz. Esta vía está cerrada y conviene decirlo: no hay forma de "forzar Collatz" o "forzar un contraejemplo". Lo digo porque circula folclore confuso al respecto.
- **Modelos no ω de ZFC sin más:** los modelos no estándar de ZFC heredan los enteros no estándar del modelo, y para n estándar la órbita es la real. No aportan novedad sobre lo que dan los modelos no estándar de PA.
- **Análisis no estándar (Robinson) ingenuo:** N* en el sentido de Robinson es un modelo no estándar particular; no añade información más allá del marco general de extensiones elementales.

## 5. Dónde sí veo grieta

El ángulo con potencial real es el de **cortes definibles**. En un modelo M ⊨ PA + ¬Collatz, el conjunto {n ∈ M : la órbita de n alcanza 1} es un corte (cerrado hacia abajo bajo predecesores Collatz, contiene N, no es todo M). Estudiar qué propiedades de cierre tiene este corte (¿es semiregular? ¿regular? ¿fuerte?) en el sentido de Kirby–Paris es un programa preciso.

## Sub-problema para sprint 2

- **Enunciado:** Sea M ⊨ PA + ¬Collatz y sea I_M := {n ∈ M : ∃k T^k(n)=1} el "corte Collatz" de M. Determinar si I_M puede ser un corte **semiregular** (cerrado bajo funciones definibles totales en PA) o si necesariamente es estrictamente más débil. Equivalentemente: ¿existe un modelo M ⊨ PA donde Collatz falla pero la función "tiempo de parada" σ(n) es total sobre un corte semiregular propio?
- **Criterio de éxito medible:** un teorema con enunciado *"Si M ⊨ PA + ¬Collatz, entonces I_M no es semiregular"* (o el recíproco: una construcción de un tal M con I_M semiregular), incluyendo hipótesis explícitas sobre la consistencia de PA + ¬Collatz. Como sub-meta computable: identificar una función f definible en PA tal que σ(n) > f(n) para infinitos n ∈ N (cota inferior efectiva sobre tiempos de parada), porque eso restringiría el tipo de corte posible. Valor objetivo concreto: demostrar σ(n) > log₂ log₂ n para infinitos n, o refutar esta cota. [verificar: cotas inferiores conocidas sobre σ; creo que sólo se sabe σ(n) = Ω(log n) por trabajos de Lagarias].

## Autoevaluación

**Improbable.** El marco modelo-teórico está bien planteado y la pregunta es genuina (no vacua), pero condiciona todo lo interesante a que Collatz sea independiente de PA, cosa que nadie sabe y que el agente_07 va a argumentar (sospecho) que es poco probable. Aun así merece la pena: incluso suponiendo que Collatz sea demostrable en PA, el ejercicio de clasificar la sentencia por complejidad cuantificacional y mapear qué cortes son compatibles con su negación produce **lemas auxiliares útiles para otras células** (cotas Π₁ sobre longitudes de ciclo, por ejemplo, conectan con agente_06). El riesgo de callejón sin salida es alto si nadie del equipo logra siquiera un indicio de independencia.
