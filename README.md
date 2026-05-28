# Collatz

Planteamiento exploratorio sobre cómo organizar un equipo de los 20 matemáticos más brillantes del momento para atacar la **conjetura de Collatz** (problema 3n+1).

Este repositorio nace de una conversación entre Javier Nieto y Claude (Anthropic, modelo Opus 4.7). El histórico completo de la conversación se mantiene en [`CONVERSATION.md`](./CONVERSATION.md).

---

## La conjetura

Tomas cualquier entero positivo `n` y aplicas repetidamente:

- Si `n` es par: `n / 2`
- Si `n` es impar: `3n + 1`

La conjetura afirma que toda secuencia termina llegando a 1 (entrando en el ciclo `4 → 2 → 1`). Lleva abierta desde 1937 (Lothar Collatz). Verificada computacionalmente hasta ~2⁶⁸. Nadie ha conseguido demostrarla.

**Ejemplo** con `n = 6`:
```
6 → 3 → 10 → 5 → 16 → 8 → 4 → 2 → 1
```

---

## Planteamiento: el "Polymath estructurado"

Modelo base: el **Proyecto Polymath** de Tim Gowers (colaboración masiva abierta) con jerarquía añadida, porque Collatz no se descompone naturalmente en sub-lemas independientes como sí ocurrió con Zhang/Polymath8 sobre brechas entre primos.

### Composición del equipo (20)

#### Núcleo de liderazgo (2)
- **Terence Tao** — coordinador científico. Tiene el resultado parcial más fuerte (2019, densidad logarítmica).
- **Jeffrey Lagarias** — historiador del problema. Cataloga 40 años de ataques fallidos; evita reinventar callejones sin salida.

#### Célula 1 — Análisis y probabilidad (5)
Tao, Ben Green, Maksym Radziwiłł, Kannan Soundararajan, James Maynard.
**Misión:** extender el resultado de Tao 2019 de "casi todas las órbitas" a "todas". La grieta más prometedora.

#### Célula 2 — Dinámica y ergódica (4)
Elon Lindenstrauss, Manfred Einsiedler, Hillel Furstenberg (asesor sénior), Corinna Ulcigrai.
**Misión:** tratar la iteración como sistema dinámico en los 2-ádicos; buscar medidas invariantes que descarten ciclos no triviales.

#### Célula 3 — Teoría de números computacional y aditiva (3)
Andrew Granville, Carl Pomerance, Tomás Oliveira e Silva.
**Misión:** refinar cotas inferiores sobre ciclos hipotéticos, extender verificación más allá de 2⁶⁸, identificar estructura empírica.

#### Célula 4 — Lógica y computabilidad (3)
Harvey Friedman, Andreas Weiermann, Joel David Hamkins.
**Misión:** delimitar el problema desde arriba. ¿Es Collatz independiente de ZFC? ¿de PA? El trabajo de Conway sobre Collatz generalizado lo sugiere.

#### Célula 5 — Combinatoria y autómatas (3)
Jeffrey Shallit, Jean-Paul Allouche, Stefan Steinerberger.
**Misión:** representaciones simbólicas (paridad-vector, sintaxis 2-ádica), conexiones con autómatas finitos.

---

## Estructura operativa

### Ritmo
- **Retiro inicial de 2 semanas** presencial (IAS Princeton o IHÉS). Sin papers, sin clases — sólo pizarra. Objetivo: mapa compartido.
- **Sprints trimestrales de 6 semanas** por célula, con plenario de 1 semana entre sprints.
- **Horizonte total:** 5 años con revisión a los 2. Si a los 2 años no hay progreso medible (avances parciales publicables), se disuelve.

### Infraestructura
- **Wiki vivo** con el grafo completo de dependencias lógicas (todo lema demostrado, todo callejón sin salida documentado).
- **"Abogado del diablo" rotativo**: una persona por sprint cuyo único trabajo es buscar errores en los argumentos del resto.
- **Verificación formal en Lean 4** corriendo en paralelo desde el día uno — no al final.

---

## Reglas no negociables

1. **Publicar resultados parciales agresivamente.** El equipo debe producir matemáticas útiles aunque Collatz siga abierta.
2. **Prohibir el "modo Wiles".** Toda idea va al wiki en 72 horas. Nada de trabajo secreto.
3. **Aceptar la posibilidad de un veredicto negativo.** El mejor resultado posible podría ser una prueba de **independencia respecto a ZFC** — para eso está la Célula 4.

---

## Predicción honesta

Es más probable que este equipo produzca 30-40 papers excelentes sobre dinámica aritmética, mejores cotas y posiblemente una prueba de independencia, que cerrar la conjetura original. Y eso seguiría siendo un éxito enorme.

---

## Licencia

Texto bajo CC BY 4.0. Atribución: Javier Nieto + Claude (Anthropic).
