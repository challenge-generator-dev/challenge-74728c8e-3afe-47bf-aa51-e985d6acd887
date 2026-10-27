# Consultas DML Básicas y Avanzadas en Bases de Datos

El sistema de gestión de préstamos de una institución financiera requiere la manipulación de datos a través de consultas SQL. Debes ejecutar consultas CRUD básicas y avanzadas en una base de datos relacional para mantener y analizar la información de los préstamos.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | DML |
| **Nivel** | trainee-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 4 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Node.js 18+, npm, VS Code o similar.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Ejecuta `npm install && npm run build` (o `npm start`). Si no hay errores, estás listo.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Consultas CRUD Básicas

**Objetivo:** Ejecutar consultas SQL básicas para crear, leer, actualizar y eliminar registros en la base de datos.

**Tiempo estimado:** 1 hora

**Instrucciones:**

- Crear una tabla para almacenar información de préstamos.
- Insertar varios registros de préstamos en la tabla.
- Seleccionar todos los registros de la tabla.
- Actualizar un registro existente con nuevos datos.
- Eliminar un registro de la tabla.

**Entregable:** Script SQL que ejecuta las consultas CRUD básicas.

<details>
<summary>Pistas de conocimiento</summary>

- Recuerda que las consultas SQL son case-insensitive.
- Utiliza cláusulas WHERE para filtrar resultados.

</details>

### Fase 2: Consultas Avanzadas

**Objetivo:** Ejecutar consultas SQL avanzadas para analizar y optimizar la información de los préstamos.

**Tiempo estimado:** 1.5 horas

**Instrucciones:**

- Realizar un JOIN entre la tabla de préstamos y la tabla de clientes para obtener información combinada.
- Agrupar los préstamos por tipo y calcular el monto total para cada tipo.
- Ordenar los préstamos por fecha de vencimiento de manera ascendente.

**Entregable:** Script SQL que ejecuta las consultas avanzadas.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza cláusulas JOIN para combinar datos de múltiples tablas.
- Aplica funciones de agregación como SUM y COUNT para analizar datos.

</details>

### Fase 3: Optimización de Consultas

**Objetivo:** Optimizar las consultas SQL para mejorar el rendimiento y la eficiencia.

**Tiempo estimado:** 1.5 horas

**Instrucciones:**

- Analizar el plan de ejecución de las consultas para identificar cuellos de botella.
- Aplicar índices a las columnas relevantes para acelerar las búsquedas.
- Reescribir consultas para minimizar el uso de recursos y mejorar la velocidad de ejecución.

**Entregable:** Documento que describe las optimizaciones realizadas y el impacto en el rendimiento.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza herramientas de profiling para analizar el rendimiento de las consultas.
- Considera el uso de vistas materializadas para consultas complejas.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué son las consultas DML y cómo se clasifican?
- **paraQueSirve**: ¿Para qué sirven las consultas DML en el contexto de una base de datos?
- **comoSeUsa**: ¿Cómo se ejecutan las consultas DML en una base de datos?
- **erroresComunes**: ¿Cuáles son los errores comunes al ejecutar consultas DML y cómo se resuelven?
- **queDecisionesImplica**: ¿Qué decisiones implica la optimización de consultas DML?

## Criterios de Evaluacion

- Ejecutar correctamente consultas CRUD básicas.
- Ejecutar correctamente consultas SQL avanzadas.
- Optimizar consultas SQL para mejorar el rendimiento.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
npm install && npm run build
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
