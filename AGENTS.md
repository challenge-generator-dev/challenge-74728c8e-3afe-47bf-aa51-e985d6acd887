# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Consultas DML Básicas y Avanzadas en Bases de Datos**.

| | |
|---|---|
| Tema | DML |
| Nivel | trainee-l2 |
| Chapter | Frontend |
| Especialidad | Angular |
| Stack | SQL / PostgreSQL 16 |
| Patron arquitectonico | script SQL estructurado con capas lógicas |
| Tiempo estimado | 4 horas |

## Receta del stack

Esqueleto obligatorio:

- `package.json, angular.json y tsconfig.json en la raiz`
- `src/main.ts con bootstrapApplication`
- `src/app/app.config.ts con los providers`
- `src/app/core con servicios y modelos`
- `src/app/features con componentes contenedores`
- `src/app/shared con componentes presentacionales`

Trampas conocidas:

- No inventes versiones de npm: una version inexistente hace fallar `npm install` con ETARGET y el proyecto no instala. Usa rango con caret sobre una version que exista.
- El `package.json` tiene que ser JSON valido y UNICO: nada despues de la llave de cierre.
- Angular necesita `angular.json` y `tsconfig.json` ademas del `package.json`, o `ng build` no corre.

Dependencias:

- PostgreSQL 16.3
- pgAdmin 4 n/a
- DBeaver n/a

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Corre `npm install && npm run build` y mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `npm install && npm run build` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Consultas CRUD Básicas**: Script SQL que ejecuta las consultas CRUD básicas.
- **Fase 2 — Consultas Avanzadas**: Script SQL que ejecuta las consultas avanzadas.
- **Fase 3 — Optimización de Consultas**: Documento que describe las optimizaciones realizadas y el impacto en el rendimiento.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Lo que falta y tenes que completar

No se detectaron huecos: estan los archivos declarados, el boilerplate del stack y ninguna referencia quedo colgando. Igual corre el comando de verificacion — que los archivos existan no garantiza que compilen.

### Presentes (12)

- `package.json`
- `tsconfig.json`
- `angular.json`
- `src/main.ts`
- `src/index.html`
- `scripts/01_creacion_tablas.sql`
- `scripts/02_insercion_datos.sql`
- `scripts/03_consultas_crud_basicas.sql`
- `scripts/04_consultas_avanzadas.sql`
- `scripts/05_optimizacion_consultas.sql`
- `docs/06_analisis_optimizacion.md`
- `README.md`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `scripts`
- `docs`

## Verificacion

```bash
npm install && npm run build
```

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- El patron es **script SQL estructurado con capas lógicas**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Frontend, Especialidad Desarrollador, Tecnología Bases de datos, Trainee L2
- Brecha que el reto ataca: Ejecuta consultas SQL básicas CRUD (Create, Insert, Select, Update, Delete) y de optimizacion como Joins, Group By y Order By, en al menos un (1) motor de base de datos como SQL Server, Oracle, PostgreSQL, MySQL, DB2 y SQLite.

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
