# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Como saber que terminaste

```bash
npm install && npm run build
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Frontend, Especialidad Desarrollador, Tecnología Bases de datos, Trainee L2

### Brecha de conocimiento
Ejecuta consultas SQL básicas CRUD (Create, Insert, Select, Update, Delete) y de optimizacion como Joins, Group By y Order By, en al menos un (1) motor de base de datos como SQL Server, Oracle, PostgreSQL, MySQL, DB2 y SQLite.

### Reto
- Tema: DML
- Seniority: trainee-l2
- Tipo: practical
- Título: Consultas DML Básicas y Avanzadas en Bases de Datos
- Tiempo estimado: 4 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Consultas CRUD Básicas — objetivo: Ejecutar consultas SQL básicas para crear, leer, actualizar y eliminar registros en la base de datos. — entregable (NO resolver): Script SQL que ejecuta las consultas CRUD básicas.
- Fase 2: Consultas Avanzadas — objetivo: Ejecutar consultas SQL avanzadas para analizar y optimizar la información de los préstamos. — entregable (NO resolver): Script SQL que ejecuta las consultas avanzadas.
- Fase 3: Optimización de Consultas — objetivo: Optimizar las consultas SQL para mejorar el rendimiento y la eficiencia. — entregable (NO resolver): Documento que describe las optimizaciones realizadas y el impacto en el rendimiento.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: package.json ===
{
  "name": "gestion-prestamos-sql",
  "version": "1.0.0",
  "description": "Sistema de gestión de préstamos con scripts SQL para PostgreSQL 16",
  "scripts": {
    "setup": "psql -U postgres -f scripts/01_creacion_tablas.sql",
    "insert-data": "psql -U postgres -f scripts/02_insercion_datos.sql",
    "run-crud": "psql -U postgres -f scripts/03_consultas_crud_basicas.sql",
    "run-advanced": "psql -U postgres -f scripts/04_consultas_avanzadas.sql",
    "run-optimized": "psql -U postgres -f scripts/05_optimizacion_consultas.sql"
  },
  "keywords": [
    "sql",
    "postgresql",
    "prestamos",
    "dml"
  ],
  "author": "Equipo de Ingeniería",
  "license": "MIT",
  "devDependencies": {
    "typescript": "~5.4.5"
  }
}

// === ARCHIVO: tsconfig.json ===
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "commonjs",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "outDir": "./dist",
    "rootDir": "./src"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules"]
}

// === ARCHIVO: angular.json ===
{
  "$schema": "./node_modules/@angular/cli/lib/config/schema.json",
  "version": 1,
  "newProjectRoot": "projects",
  "projects": {
    "gestion-prestamos": {
      "projectType": "application",
      "schematics": {
        "@schematics/angular:application": {
          "strict": true,
          "style": "scss"
        }
      },
      "root": "",
      "sourceRoot": "src",
      "prefix": "app",
      "architect": {
        "build": {
          "builder": "@angular-devkit/build-angular:application",
          "options": {
            "outputPath": "dist/gestion-prestamos",
            "index": "src/index.html",
            "main": "src/main.ts",
            "polyfills": [],
            "tsConfig": "tsconfig.json",
            "assets": [],
            "styles": [],
            "scripts": []
          },
          "configurations": {
            "development": {
              "optimization": false,
              "sourceMap": true,
              "extractLicenses": false
            },
            "production": {
              "optimization": true,
              "sourceMap": false,
              "extractLicenses": true,
              "outputHashing": "all"
            }
          },
          "defaultConfiguration": "development"
        },
        "serve": {
          "builder": "@angular-devkit/build-angular:dev-server",
          "options": {
            "browserTarget": "gestion-prestamos:build"
          },
          "configurations": {
            "development": {
              "browserTarget": "gestion-prestamos:build:development"
            },
            "production": {
              "browserTarget": "gestion-prestamos:build:production"
            }
          }
        },
        "extract-i18n": {
          "builder": "@angular-devkit/build-angular:extract-i18n",
          "options": {
            "browserTarget": "gestion-prestamos:build"
          }
        },
        "test": {
          "builder": "@angular-devkit/build-angular:karma",
          "options": {
            "main": "src/test.ts",
            "polyfills": "src/polyfills.ts",
            "tsConfig": "tsconfig.spec.json",
            "karmaConfig": "karma.conf.js",
            "styles": [],
            "scripts": [],
            "assets": []
          }
        }
      }
    }
  },
  "defaultProject": "gestion-prestamos"
}

// === ARCHIVO: src/main.ts ===
import { bootstrapApplication } from '@angular/platform-browser';
import { AppComponent } from './app/app.component';
import { provideHttpClient } from '@angular/common/http';
import { provideRouter } from '@angular/router';
import { routes } from './app/app.routes';
import { importProvidersFrom } from '@angular/core';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatSnackBarModule } from '@angular/material/snack-bar';

/**
 * Punto de entrada de la aplicación Angular para visualización de resultados SQL.
 * Este módulo configura la aplicación con los providers necesarios para:
 * - HTTP Client (para consumir resultados de consultas SQL)
 * - Router (para navegación entre vistas)
 * - Animaciones (para mejor experiencia de usuario)
 * - Notificaciones (para mostrar resultados de operaciones)
 */
bootstrapApplication(AppComponent, {
  providers: [
    provideHttpClient(),
    provideRouter(routes),
    importProvidersFrom(
      BrowserAnimationsModule,
      MatSnackBarModule
    )
  ]
}).catch(err => {
  console.error('Error al iniciar la aplicación:', err);
  // Manejo de errores al inicio de la aplicación
  const errorContainer = document.createElement('div');
  errorContainer.style.padding = '20px';
  errorContainer.style.backgroundColor = '#ffebee';
  errorContainer.style.color = '#c62828';
  errorContainer.style.border = '1px solid #ef9a9a';
  errorContainer.style.borderRadius = '4px';
  errorContainer.style.margin = '20px';
  errorContainer.style.fontFamily = 'Arial, sans-serif';
  errorContainer.innerHTML = `
    <h2>Error al iniciar la aplicación</h2>
    <p>No se pudo cargar la aplicación de gestión de préstamos.</p>
    <p>Detalles técnicos:</p>
    <pre>${err.message || err}</pre>
    <p>Verifique que:</p>
    <ul>
      <li>PostgreSQL 16.3 esté instalado y ejecutándose</li>
      <li>Los scripts SQL se hayan ejecutado correctamente</li>
      <li>No haya errores en la configuración de la base de datos</li>
    </ul>
  `;
  document.body.appendChild(errorContainer);
});


// === ARCHIVO: src/index.html ===
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <title>Sistema de Gestión de Préstamos</title>
  <base href="/">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="Sistema integral para la gestión de préstamos bancarios con consultas DML optimizadas">
  <meta name="keywords" content="préstamos, gestión financiera, SQL, PostgreSQL, DML">
  <meta name="author" content="Equipo de Ingeniería">
  <meta name="robots" content="index, follow">
  <link rel="icon" type="image/x-icon" href="favicon.ico">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    html, body {
      height: 100%;
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      background-color: #f8fafc;
      color: #1e293b;
      line-height: 1.6;
    }
    .app-loading {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      height: 100vh;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }
    .app-loading .spinner {
      width: 50px;
      height: 50px;
      border: 4px solid rgba(255, 255, 255, 0.3);
      border-top-color: #fff;
      border-radius: 50%;
      animation: spin 1s linear infinite;
    }
    .app-loading .loading-text {
      margin-top: 20px;
      color: #fff;
      font-size: 1.1rem;
      font-weight: 500;
    }
    @keyframes spin {
      to { transform: rotate(360deg); }
    }
    .error-container {
      padding: 40px;
      text-align: center;
      background: #fef2f2;
      border: 1px solid #fecaca;
      border-radius: 8px;
      margin: 20px;
    }
    .error-container h1 {
      color: #dc2626;
      font-size: 1.5rem;
      margin-bottom: 10px;
    }
    .error-container p {
      color: #7f1d1d;
      font-size: 0.95rem;
    }
  </style>
</head>
<body>
  <app-root>
    <div class="app-loading">
      <div class="spinner"></div>
      <div class="loading-text">Cargando Sistema de Gestión de Préstamos...</div>
    </div>
  </app-root>
  <noscript>
    <div class="error-container">
      <h1>JavaScript Requerido</h1>
      <p>Esta aplicación requiere JavaScript para funcionar. Por favor, habilite JavaScript en su navegador.</p>
    </div>
  </noscript>
</body>
</html>

// === ARCHIVO: scripts/01_creacion_tablas.sql ===
-- Script de creación de tablas para el sistema de gestión de préstamos
-- Este script crea la estructura de base de datos necesaria para almacenar
-- información de clientes y préstamos en una institución financiera.
-- Las tablas siguen el patrón de nomenclatura snake_case de PostgreSQL.

-- Eliminar tablas existentes si existen (para recreación limpia)
DROP TABLE IF EXISTS prestamos CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;

-- Crear tabla de clientes
-- Almacena la información personal de cada cliente de la institución financiera.
-- El campo identificador principal es cliente_id como serial para autoincremento.
CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    direccion TEXT,
    ciudad VARCHAR(100),
    codigo_postal VARCHAR(10),
    fecha_nacimiento DATE,
    fecha_registro DATE DEFAULT CURRENT_DATE NOT NULL,
    estado VARCHAR(20) DEFAULT 'activo' NOT NULL,
    limite_credito DECIMAL(12, 2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla de préstamos
-- Almacena la información de cada préstamo concedido a los clientes.
-- Cada préstamo está relacionado con un cliente a través de cliente_id.
-- El estado del préstamo indica su situación actual en el ciclo de vida.
CREATE TABLE prestamos (
    prestamo_id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL REFERENCES clientes(cliente_id) ON DELETE RESTRICT,
    numero_prestamo VARCHAR(20) NOT NULL UNIQUE,
    monto DECIMAL(12, 2) NOT NULL,
    tasa_interes DECIMAL(5, 2) NOT NULL,
    plazo_meses INTEGER NOT NULL,
    fecha_concesion DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    estado VARCHAR(20) DEFAULT 'activo' NOT NULL,
    tipo_prestamo VARCHAR(50) NOT NULL,
    cuota_mensual DECIMAL(12, 2),
    saldo_pendiente DECIMAL(12, 2),
    monto_pagado DECIMAL(12, 2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear índice para búsquedas rápidas por cliente
-- Este índice optimiza las consultas que filtran préstamos por cliente_id,
-- común en operaciones de consulta de historial de préstamos por cliente.
CREATE INDEX idx_prestamos_cliente_id ON prestamos(cliente_id);

-- Crear índice para búsquedas por estado de préstamo
-- Optimiza consultas de reportes que filtran por estado (activo, pagado, moroso, etc.)
CREATE INDEX idx_prestamos_estado ON prestamos(estado);

-- Crear índice para búsquedas por fecha de vencimiento
-- Optimiza consultas de gestión de cartera y alertas de próximos vencimientos
CREATE INDEX idx_prestamos_fecha_vencimiento ON prestamos(fecha_vencimiento);

-- Crear índice para búsquedas por número de préstamo
-- Optimiza consultas de búsqueda directa por identificador único de préstamo
CREATE INDEX idx_prestamos_numero ON prestamos(numero_prestamo);

-- Crear índice para búsquedas de clientes por email
-- Optimiza la validación de email único y búsquedas de clientes por correo
CREATE INDEX idx_clientes_email ON clientes(email);

-- Crear índice para búsquedas de clientes por ciudad
-- Optimiza reportes de distribución de clientes por ubicación geográfica
CREATE INDEX idx_clientes_ciudad ON clientes(ciudad);

-- Crear índice para búsquedas de clientes por estado
-- Optimiza filtros de clientes activos, inactivos o suspendidos
CREATE INDEX idx_clientes_estado ON clientes(estado);

-- Agregar restricción de verificación para estado de cliente
-- Asegura que el estado del cliente sea uno de los valores válidos permitidos.
ALTER TABLE clientes
ADD CONSTRAINT chk_cliente_estado 
CHECK (estado IN ('activo', 'inactivo', 'suspendido', 'bloqueado'));

-- Agregar restricción de verificación para estado de préstamo
-- Asegura que el estado del préstamo sea uno de los valores válidos permitidos.
ALTER TABLE prestamos
ADD CONSTRAINT chk_prestamo_estado 
CHECK (estado IN ('activo', 'pagado', 'moroso', 'vencido', 'cancelado'));

-- Agregar restricción de verificación para monto positivo
-- Asegura que el monto del préstamo sea mayor que cero.
ALTER TABLE prestamos
ADD CONSTRAINT chk_prestamo_monto_positivo 
CHECK (monto > 0);

-- Agregar restricción de verificación para tasa de interés válida
-- La tasa de interés debe estar en un rango razonable (0-100%).
ALTER TABLE prestamos
ADD CONSTRAINT chk_tasa_interes_valida 
CHECK (tasa_interes >= 0 AND tasa_interes <= 100);

-- Agregar restricción de verificación para plazo válido
-- El plazo del préstamo debe ser al menos 1 mes.
ALTER TABLE prestamos
ADD CONSTRAINT chk_plazo_meses_valido 
CHECK (plazo_meses >= 1);

-- Comentario sobre la estructura
COMMENT ON TABLE clientes IS 'Tabla principal de clientes de la institución financiera';
COMMENT ON TABLE prestamos IS 'Tabla de préstamos concedidos a los clientes';
COMMENT ON COLUMN prestamos.monto IS 'Monto total del préstamo concedido';
COMMENT ON COLUMN prestamos.saldo_pendiente IS 'Monto restante por pagar del préstamo';
COMMENT ON COLUMN prestamos.tasa_interes IS 'Tasa de interés anual aplicada al préstamo';

// === ARCHIVO: scripts/02_insercion_datos.sql ===
-- Script de inserción de datos iniciales para el sistema de gestión de préstamos
-- Este script populatea las tablas con datos de ejemplo para pruebas y desarrollo.
-- Cada inserción incluye información realista de clientes y sus préstamos asociados.

-- Insertar clientes de ejemplo
-- Datos de prueba representando diferentes tipos de clientes de la institución.
INSERT INTO clientes (nombre, apellido, email, telefono, direccion, ciudad, codigo_postal, fecha_nacimiento, estado, limite_credito) VALUES
('Juan', 'Pérez García', 'juan.perez@email.com', '555-0101', 'Av. Principal 123', 'Ciudad de México', '01000', '1985-03-15', 'activo', 50000.00),
('María', 'López Hernández', 'maria.lopez@email.com', '555-0102', 'Calle Norte 456', 'Guadalajara', '44000', '1990-07-22', 'activo', 75000.00),
('Carlos', 'Rodríguez Martínez', 'carlos.rodriguez@email.com', '555-0103', 'Blvd. Sur 789', 'Monterrey', '64000', '1978-11-08', 'activo', 100000.00),
('Ana', 'González Torres', 'ana.gonzalez@email.com', '555-0104', 'Av. Oriente 321', 'Puebla', '72000', '1995-01-30', 'activo', 45000.00),
('Luis', 'Fernández Ramírez', 'luis.fernandez@email.com', '555-0105', 'Calle Poniente 654', 'Tijuana', '22000', '1982-09-12', 'activo', 60000.00),
('Sofia', 'Díaz Castro', 'sofia.diaz@email.com', '555-0106', 'Av. Central 987', 'Cancún', '77500', '1988-04-25', 'activo', 80000.00),
('Miguel', 'Sánchez Rivera', 'miguel.sanchez@email.com', '555-0107', 'Calle 5ta 147', 'Mérida', '97000', '1992-12-03', 'inactivo', 30000.00),
('Elena', 'Morales Flores', 'elena.morales@email.com', '555-0108', 'Blvd. Universidad 258', 'Querétaro', '76000', '1987-06-18', 'activo', 55000.00),
('Roberto', 'Jiménez Ortiz', 'roberto.jimenez@email.com', '555-0109', 'Av. Las Américas 369', 'León', '37000', '1980-08-07', 'activo', 90000.00),
('Carmen', 'Vargas Mendoza', 'carmen.vargas@email.com', '555-0110', 'Calle Real 741', 'San Luis Potosí', '78000', '1993-02-14', 'activo', 40000.00)
ON CONFLICT (email) DO NOTHING;

-- Insertar préstamos de ejemplo
-- Préstamos asociados a los clientes insertados anteriormente.
-- Includes diferentes estados, montos y plazos para diversidad de datos de prueba.
INSERT INTO prestamos (cliente_id, numero_prestamo, monto, tasa_interes, plazo_meses, fecha_concesion, fecha_vencimiento, estado, tipo_prestamo, cuota_mensual, saldo_pendiente, monto_pagado) VALUES
(1, 'PRE-2024-001', 25000.00, 12.50, 12, '2024-01-15', '2025-01-15', 'activo', 'personal', 2230.42, 25000.00, 0.00),
(1, 'PRE-2023-045', 15000.00, 11.00, 6, '2023-06-01', '2023-12-01', 'pagado', 'consumo', 2625.00, 0.00, 15750.00),
(2, 'PRE-2024-002', 50000.00, 14.00, 24, '2024-02-20', '2026-02-20', 'activo', 'hipotecario', 2433.24, 50000.00, 0.00),
(3, 'PRE-2024-003', 80000.00, 10.50, 36, '2024-03-10', '2027-03-10', 'activo', 'negocios', 2587.50, 80000.00, 0.00),
(3, 'PRE-2023-030', 30000.00, 12.00, 18, '2023-01-15', '2024-07-15', 'moroso', 'personal', 1833.33, 18500.00, 11500.00),
(4, 'PRE-2024-004', 20000.00, 13.50, 12, '2024-04-01', '2025-04-01', 'activo', 'consumo', 1808.33, 20000.00, 0.00),
(5, 'PRE-2024-005', 35000.00, 11.50, 18, '2024-03-25', '2025-09-25', 'activo', 'personal', 2087.50, 35000.00, 0.00),
(6, 'PRE-2024-006', 60000.00, 10.00, 30, '2024-01-30', '2026-07-30', 'activo', 'hipotecario', 2129.45, 60000.00, 0.00),
(7, 'PRE-2023-050', 10000.00, 15.00, 6, '2023-08-15', '2024-02-15', 'vencido', 'consumo', 1796.25, 3000.00, 7000.00),
(8, 'PRE-2024-007', 40000.00, 12.00, 24, '2024-02-10', '2026-02-10', 'activo', 'negocios', 1887.50, 40000.00, 0.00),
(9, 'PRE-2024-008', 70000.00, 11.00, 36, '2024-04-15', '2027-04-15', 'activo', 'hipotecario', 2258.33, 70000.00, 0.00),
(10, 'PRE-2024-009', 18000.00, 14.50, 12, '2024-05-01', '2025-05-01', 'activo', 'personal', 1625.42, 18000.00, 0.00),
(2, 'PRE-2023-025', 20000.00, 13.00, 12, '2023-05-01', '2024-05-01', 'pagado', 'personal', 1775.00, 0.00, 21300.00),
(4, 'PRE-2023-040', 8000.00, 12.50, 6, '2023-09-01', '2024-03-01', 'pagado', 'consumo', 1400.00, 0.00, 8400.00),
(6, 'PRE-2023-035', 25000.00, 11.50, 12, '2023-07-15', '2024-07-15', 'pagado', 'personal', 2216.67, 0.00, 26600.00)
ON CONFLICT (numero_prestamo) DO NOTHING;

// === ARCHIVO: scripts/03_consultas_crud_basicas.sql ===
-- Script de consultas CRUD básicas para la tabla de préstamos
-- Este script contiene las operaciones fundamentales de creación, lectura,
-- actualización y eliminación de registros en la tabla de préstamos.
-- Todas las operaciones incluyen cláusulas WHERE para evitar modificaciones masivas.

-- ============================================
-- CONSULTAS DE LECTURA (SELECT)
-- ============================================

-- Consulta 1: Obtener todos los préstamos activos
-- Devuelve todos los préstamos que actualmente tienen estado 'activo'.
SELECT 
    prestamo_id,
    numero_prestamo,
    monto,
    tasa_interes,
    plazo_meses,
    fecha_concesion,
    fecha_vencimiento,
    tipo_prestamo,
    saldo_pendiente
FROM prestamos
WHERE estado = 'activo'
ORDER BY fecha_vencimiento ASC;

-- Consulta 2: Obtener préstamos de un cliente específico
-- Filtra los préstamos asociados a un cliente usando su identificador.
SELECT 
    p.prestamo_id,
    p.numero_prestamo,
    p.monto,
    p.estado,
    p.fecha_concesion,
    p.saldo_pendiente,
    c.nombre,
    c.apellido
FROM prestamos p
INNER JOIN clientes c ON p.cliente_id = c.cliente_id
WHERE p.cliente_id = 1
ORDER BY p.fecha_concesion DESC;

-- Consulta 3: Buscar préstamos por número de préstamo
-- Búsqueda exacta usando el identificador único del préstamo.
SELECT 
    prestamo_id,
    numero_prestamo,
    monto,
    tasa_interes,
    plazo_meses,
    estado,
    tipo_prestamo,
    saldo_pendiente,
    monto_pagado
FROM prestamos
WHERE numero_prestamo = 'PRE-2024-001';

-- Consulta 4: Obtener préstamos próximos a vencer
-- Identifica préstamos que vencen en los próximos 30 días.
SELECT 
    prestamo_id,
    numero_prestamo,
    cliente_id,
    monto,
    fecha_vencimiento,
    estado,
    saldo_pendiente
FROM prestamos
WHERE estado = 'activo' 
  AND fecha_vencimiento BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '30 days'
ORDER BY fecha_vencimiento ASC;

-- Consulta 5: Obtener resumen de préstamos por estado
-- Agrupa los préstamos por su estado actual para reportes.
SELECT 
    estado,
    COUNT(*) AS cantidad_prestamos,
    SUM(monto) AS monto_total,
    SUM(saldo_pendiente) AS saldo_pendiente_total
FROM prestamos
GROUP BY estado
ORDER BY cantidad_prestamos DESC;

-- ============================================
-- CONSULTAS DE INSERCIÓN (INSERT)
-- ============================================

-- Inserción 1: Insertar un nuevo préstamo
-- Crea un nuevo registro de préstamo asociado a un cliente existente.
INSERT INTO prestamos (
    cliente_id,
    numero_prestamo,
    monto,
    tasa_interes,
    plazo_meses,
    fecha_concesion,
    fecha_vencimiento,
    estado,
    tipo_prestamo,
    cuota_mensual,
    saldo_pendiente,
    monto_pagado
) VALUES (
    5,
    'PRE-2024-010',
    28000.00,
    12.50,
    12,
    '2024-05-15',
    '2025-05-15',
    'activo',
    'personal',
    2500.00,
    28000.00,
    0.00
) RETURNING prestamo_id, numero_prestamo;

-- Inserción 2: Insertar múltiples préstamos en una sola transacción
-- Inserta varios préstamos relacionados en una operación atómica.
BEGIN;

INSERT INTO prestamos (
    cliente_id, numero_prestamo, monto, tasa_interes, plazo_meses,
    fecha_concesion, fecha_vencimiento, estado, tipo_prestamo,
    cuota_mensual, saldo_pendiente, monto_pagado
) VALUES
(8, 'PRE-2024-011', 45000.00, 11.00, 24, '2024-05-20', '2026-05-20', 'activo', 'negocios', 2125.00, 45000.00, 0.00),
(9, 'PRE-2024-012', 55000.00, 10.50, 30, '2024-05-20', '2027-05-20', 'activo', 'hipotecario', 2050.00, 55000.00, 0.00);

COMMIT;

-- ============================================
-- CONSULTAS DE ACTUALIZACIÓN (UPDATE)
-- ============================================

-- Actualización 1: Actualizar el estado de un préstamo específico
-- Marca un préstamo como pagado usando su identificador único.
UPDATE prestamos
SET 
    estado = 'pagado',
    saldo_pendiente = 0.00,
    updated_at = CURRENT_TIMESTAMP
WHERE prestamo_id = 2
  AND estado != 'pagado';

-- Actualización 2: Actualizar el saldo pendiente después de un pago
-- Reduce el saldo pendiente y aumenta el monto pagado.
UPDATE prestamos
SET 
    saldo_pendiente = saldo_pendiente - 2500.00,
    monto_pagado = monto_pagado + 2500.00,
    updated_at = CURRENT_TIMESTAMP
WHERE prestamo_id = 1
  AND saldo_pendiente >= 2500.00;

-- Actualización 3: Actualizar la tasa de interés de un préstamo
-- Modifica la tasa de interés para un préstamo específico.
UPDATE prestamos
SET 
    tasa_interes = 13.00,
    updated_at = CURRENT_TIMESTAMP
WHERE prestamo_id = 4
  AND estado = 'activo';

-- Actualización 4: Actualizar el estado de préstamos vencidos
-- Identifica y marca automáticamente los préstamos que han pasado su fecha de vencimiento.
UPDATE prestamos
SET 
    estado = 'vencido',
    updated_at = CURRENT_TIMESTAMP
WHERE estado = 'activo' 
  AND fecha_vencimiento < CURRENT_DATE;

-- ============================================
-- CONSULTAS DE ELIMINACIÓN (DELETE)
-- ============================================

-- Eliminación 1: Eliminar un préstamo específico
-- Elimina un préstamo usando su identificador único.
DELETE FROM prestamos
WHERE prestamo_id = 100
  AND estado = 'cancelado';

-- Eliminación 2: Eliminar préstamos de clientes inactivos
-- Elimina todos los préstamos de clientes que están inactivos.
DELETE FROM prestamos
WHERE cliente_id IN (
    SELECT cliente_id 
    FROM clientes 
    WHERE estado = 'inactivo'
)
AND estado = 'pagado';

-- ============================================
-- CONSULTAS DE VERIFICACIÓN
-- ============================================

-- Verificar que las actualizaciones se ejecutaron correctamente
-- Confirma los cambios realizados en la tabla de préstamos.
SELECT 
    prestamo_id,
    numero_prestamo,
    estado,
    saldo_pendiente,
    monto_pagado,
    updated_at
FROM prestamos
WHERE prestamo_id IN (1, 2, 4)
ORDER BY prestamo_id;

-- Mostrar el estado actual de todos los préstamos
-- Proporciona una visión completa del estado de la cartera de préstamos.
SELECT 
    prestamo_id,
    numero_prestamo,
    cliente_id,
    monto,
    saldo_pendiente,
    monto_pagado,
    estado,
    fecha_vencimiento
FROM prestamos
ORDER BY prestamo_id;


// === ARCHIVO: scripts/04_consultas_avanzadas.sql ===
-- ============================================================================
-- CONSULTAS AVANZADAS PARA ANÁLISIS DE PRÉSTAMOS Y CLIENTES
-- Fase 2: Consultas Avanzadas - Sistema de Gestión de Préstamos
-- ============================================================================
-- Este script contiene consultas SQL avanzadas que combinan datos de múltiples
-- tablas utilizando JOIN, GROUP BY, ORDER BY y funciones de agregación para
-- generar análisis significativos del portafolio de préstamos.
-- ============================================================================

-- Habilitar timing para analizar rendimiento de consultas
\\timing on

-- ============================================================================
-- SECCIÓN 1: CONSULTAS CON JOIN - Relación Préstamos vs Clientes
-- ============================================================================

-- 1.1 Listar todos los préstamos con información completa del cliente
-- Utiliza INNER JOIN para combinar préstamos con sus clientes asociados
SELECT 
    p.id AS prestamo_id,
    p.monto AS monto_prestamo,
    p.tasa_interes,
    p.fecha_inicio,
    p.fecha_fin,
    p.estado AS estado_prestamo,
    c.id AS cliente_id,
    c.nombre AS nombre_cliente,
    c.email AS email_cliente,
    c.telefono
FROM prestamos p
INNER JOIN clientes c ON p.cliente_id = c.id
ORDER BY p.fecha_inicio DESC;

-- 1.2 Listar clientes que NO tienen préstamos asociados (LEFT JOIN con filtro)
-- Útil para identificar clientes potenciales para campaigns de nuevos préstamos
SELECT 
    c.id AS cliente_id,
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN prestamos p ON c.id = p.cliente_id
WHERE p.id IS NULL
ORDER BY c.fecha_registro DESC;

-- 1.3 Consulta con múltiples JOIN: Préstamos, Clientes y Pagos
-- Muestra el historial de pagos de cada préstamo con datos del cliente
SELECT 
    p.id AS prestamo_id,
    p.monto AS monto_total,
    p.estado,
    c.nombre AS nombre_cliente,
    c.email,
    pg.fecha_pago,
    pg.monto_pagado,
    pg.metodo_pago
FROM prestamos p
INNER JOIN clientes c ON p.cliente_id = c.id
LEFT JOIN pagos pg ON p.id = pg.prestamo_id
WHERE pg.fecha_pago IS NOT NULL
ORDER BY pg.fecha_pago DESC, p.id;

-- ============================================================================
-- SECCIÓN 2: CONSULTAS CON GROUP BY - Estadísticas y Agregaciones
-- ============================================================================

-- 2.1 Contar préstamos por estado (resumen del portafolio)
-- Útil para reportes de gestión y seguimiento de cartera
SELECT 
    estado,
    COUNT(*) AS cantidad_prestamos,
    SUM(monto) AS monto_total,
    AVG(monto) AS promedio_monot,
    MIN(monto) AS monto_minimo,
    MAX(monto) AS monto_maximo
FROM prestamos
GROUP BY estado
ORDER BY cantidad_prestamos DESC;

-- 2.2 Total de préstamos por cliente (top clientes por volumen)
-- Identifica los clientes con mayor endeudamiento
SELECT 
    c.id AS cliente_id,
    c.nombre,
    c.email,
    COUNT(p.id) AS cantidad_prestamos,
    SUM(p.monto) AS total_prestado,
    AVG(p.tasa_interes) AS tasa_promedio
FROM clientes c
INNER JOIN prestamos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre, c.email
HAVING SUM(p.monto) > 0
ORDER BY total_prestado DESC
LIMIT 20;

-- 2.3 Promedio de tasa de interés por tipo de préstamo
-- Análisis de la estructura de tasas del portafolio
SELECT 
    tipo_prestamo,
    COUNT(*) AS cantidad,
    ROUND(AVG(tasa_interes), 2) AS tasa_promedio,
    MIN(tasa_interes) AS tasa_minima,
    MAX(tasa_interes) AS tasa_maxima,
    ROUND(STDDEV(tasa_interes), 2) AS desviacion_estandar
FROM prestamos
GROUP BY tipo_prestamo
ORDER BY tasa_promedio DESC;

-- 2.4 Montos totales por mes (análisis temporal)
-- Facilita la planificación financiera y proyecciones
SELECT 
    TO_CHAR(fecha_inicio, 'YYYY-MM') AS mes,
    COUNT(*) AS cantidad_prestamos,
    SUM(monto) AS monto_total,
    ROUND(AVG(monto), 2) AS promedio
FROM prestamos
GROUP BY TO_CHAR(fecha_inicio, 'YYYY-MM')
ORDER BY mes DESC;

-- ============================================================================
-- SECCIÓN 3: CONSULTAS CON SUBQUERIES - Análisis Complejo
-- ============================================================================

-- 3.1 Clientes con préstamos acima del promedio del sistema
-- Identifica clientes de alto valor
SELECT 
    c.nombre,
    c.email,
    SUM(p.monto) AS total_prestado
FROM clientes c
INNER JOIN prestamos p ON c.id = p.cliente_id
GROUP BY c.nombre, c.email
HAVING SUM(p.monto) > (
    SELECT AVG(total)
    FROM (
        SELECT SUM(monto) AS total 
        FROM prestamos 
        GROUP BY cliente_id
    ) AS promedios
)
ORDER BY total_prestado DESC;

-- 3.2 Préstamos con pagos pendientes (morosos)
-- Identifica préstamos que requieren seguimiento
SELECT 
    p.id,
    c.nombre AS cliente,
    p.monto,
    p.fecha_fin,
    COALESCE(SUM(pg.monto_pagado), 0) AS total_pagado,
    (p.monto - COALESCE(SUM(pg.monto_pagado), 0)) AS saldo_pendiente,
    CASE 
        WHEN p.fecha_fin < CURRENT_DATE THEN 'VENCIDO'
        WHEN (p.monto - COALESCE(SUM(pg.monto_pagado), 0)) > 0 THEN 'PENDIENTE'
        ELSE 'AL_DIA'
    END AS estado_cuenta
FROM prestamos p
INNER JOIN clientes c ON p.cliente_id = c.id
LEFT JOIN pagos pg ON p.id = pg.prestamo_id
WHERE p.estado != 'PAGADO'
GROUP BY p.id, c.nombre, p.monto, p.fecha_fin, p.estado
HAVING p.monto - COALESCE(SUM(pg.monto_pagado), 0) > 0
ORDER BY saldo_pendiente DESC;

-- 3.3 Ranking de clientes por rentabilidad (basado en intereses generados)
-- Calcula el interés total generado por cada cliente
SELECT 
    c.id,
    c.nombre,
    c.email,
    COUNT(p.id) AS prestamos_activos,
    SUM(p.monto) AS capital_prestado,
    SUM(p.monto * p.tasa_interes / 100) AS interes_estimado,
    ROUND(
        SUM(p.monto * p.tasa_interes / 100) * 100.0 / SUM(p.monto), 
        2
    ) AS rendimiento_porcentual
FROM clientes c
INNER JOIN prestamos p ON c.id = p.cliente_id
WHERE p.estado IN ('ACTIVO', 'VENCIDO')
GROUP BY c.id, c.nombre, c.email
ORDER BY interes_estimado DESC
LIMIT 15;

-- ============================================================================
-- SECCIÓN 4: CONSULTAS ANALÍTICAS AVANZADAS
-- ============================================================================

-- 4.1 Distribución de préstamos por rango de monto
-- Útil para entender la composición del portafolio
SELECT 
    CASE
        WHEN monto < 5000 THEN 'MICRO (< $5K)'
        WHEN monto BETWEEN 5000 AND 15000 THEN 'PEQUEÑO ($5K-$15K)'
        WHEN monto BETWEEN 15001 AND 50000 THEN 'MEDIANO ($15K-$50K)'
        WHEN monto BETWEEN 50001 AND 100000 THEN 'GRANDE ($50K-$100K)'
        ELSE 'MAYOR (> $100K)'
    END AS rango_monto,
    COUNT(*) AS cantidad,
    SUM(monto) AS monto_total,
    ROUND(AVG(monto), 2) AS promedio
FROM prestamos
GROUP BY 
    CASE
        WHEN monto < 5000 THEN 1
        WHEN monto BETWEEN 5000 AND 15000 THEN 2
        WHEN monto BETWEEN 15001 AND 50000 THEN 3
        WHEN monto BETWEEN 50001 AND 100000 THEN 4
        ELSE 5
    END
ORDER BY rango_monto;

-- 4.2 Análisis de morosidad por período deoriginación
-- Relaciona la fecha de inicio con el estado actual
SELECT 
    TO_CHAR(fecha_inicio, 'YYYY') AS anio_origen,
    COUNT(*) AS total_prestamos,
    COUNT(*) FILTER (WHERE estado = 'ACTIVO') AS activos,
    COUNT(*) FILTER (WHERE estado = 'PAGADO') AS pagados,
    COUNT(*) FILTER (WHERE estado = 'VENCIDO') AS vencidos,
    ROUND(
        COUNT(*) FILTER (WHERE estado = 'VENCIDO') * 100.0 / COUNT(*), 
        2
    ) AS porcentaje_morosidad
FROM prestamos
GROUP BY TO_CHAR(fecha_inicio, 'YYYY')
ORDER BY anio_origen;

-- 4.3 Clientes con múltiples préstamos activos (riesgo concentrado)
-- Identifica clientes con exposición significativa
SELECT 
    c.id,
    c.nombre,
    c.email,
    COUNT(p.id) AS prestamos_activos,
    SUM(p.monto) AS exposicion_total,
    MAX(p.fecha_fin) AS fecha_vencimiento_mas_lejana
FROM clientes c
INNER JOIN prestamos p ON c.id = p.cliente_id
WHERE p.estado = 'ACTIVO'
GROUP BY c.id, c.nombre, c.email
HAVING COUNT(p.id) > 1
ORDER BY exposicion_total DESC;

-- 4.4 Promedio móvil de préstamos por mes (últimos 6 meses)
-- Tendencia del volumen de originación
WITH prestamos_mensuales AS (
    SELECT 
        TO_CHAR(fecha_inicio, 'YYYY-MM') AS mes,
        COUNT(*) AS cantidad,
        SUM(monto) AS monto
    FROM prestamos
    WHERE fecha_inicio >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '6 months'
    GROUP BY TO_CHAR(fecha_inicio, 'YYYY-MM')
)
SELECT 
    mes,
    cantidad,
    monto,
    ROUND(AVG(cantidad) OVER (ORDER BY mes ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 1) AS promedio_movil_3m
FROM prestamos_mensuales
ORDER BY mes;

-- ============================================================================
-- SECCIÓN 5: CONSULTAS DE EXPORTACIÓN Y REPORTES
-- ============================================================================

-- 5.1 Reporte completo de cartera (formato CSV-ready)
-- Combina toda la información relevante para exportación
SELECT 
    'REPORTE_CARTERA_' || TO_CHAR(CURRENT_DATE, 'YYYYMMDD') AS reporte,
    p.id AS "ID Préstamo",
    c.nombre AS "Nombre Cliente",
    c.email AS "Email",
    c.telefono AS "Teléfono",
    p.tipo_prestamo AS "Tipo",
    p.monto AS "Monto",
    p.tasa_interes AS "Tasa %",
    p.fecha_inicio AS "Fecha Inicio",
    p.fecha_fin AS "Fecha Fin",
    p.estado AS "Estado",
    COALESCE(SUM(pg.monto_pagado), 0) AS "Total Pagado",
    (p.monto - COALESCE(SUM(pg.monto_pagado), 0)) AS "Saldo Pendiente"
FROM prestamos p
INNER JOIN clientes c ON p.cliente_id = c.id
LEFT JOIN pagos pg ON p.id = pg.prestamo_id
GROUP BY p.id, c.nombre, c.email, c.telefono, p.tipo_prestamo, 
         p.monto, p.tasa_interes, p.fecha_inicio, p.fecha_fin, p.estado
ORDER BY p.id;

-- 5.2 Resumen ejecutivo de la cartera
-- Métricas clave para dirección
SELECT 
    'RESUMEN EJECUTIVO - ' || TO_CHAR(CURRENT_DATE, 'DD/MM/YYYY') AS titulo,
    (SELECT COUNT(*) FROM prestamos) AS total_prestamos,
    (SELECT COUNT(DISTINCT cliente_id) FROM prestamos) AS clientes_con_prestamo,
    (SELECT SUM(monto) FROM prestamos) AS monto_total_cartera,
    (SELECT ROUND(AVG(monto), 2) FROM prestamos) AS promedio_prestamo,
    (SELECT COUNT(*) FROM prestamos WHERE estado = 'ACTIVO') AS prestamos_activos,
    (SELECT COUNT(*) FROM prestamos WHERE estado = 'VENCIDO') AS prestamos_vencidos,
    (SELECT ROUND(COUNT(*) * 100.0 / NULLIF((SELECT COUNT(*) FROM prestamos), 0), 2) 
     FROM prestamos WHERE estado = 'VENCIDO') AS porcentaje_morosidad;

-- ============================================================================
-- FIN DEL SCRIPT: Consultas Avanzadas
-- ============================================================================
-- Este script ejecuta consultas complejas para análisis del portafolio
-- de préstamos. Los resultados sirven para reportes, dashboards y
-- toma de decisiones en la gestión de la cartera.
-- ============================================================================

// === ARCHIVO: scripts/05_optimizacion_consultas.sql ===
-- ============================================================================
-- OPTIMIZACIÓN DE CONSULTAS SQL
-- Fase 3: Optimización de Consultas - Sistema de Gestión de Préstamos
-- ============================================================================
-- Este script contiene la creación de índices, análisis de planes de
-- ejecución y reescritura de consultas para mejorar el rendimiento.
-- Se incluyen tanto las consultas optimizadas como las explicaciones
-- de por qué cada optimización mejora el rendimiento.
-- ============================================================================

\\timing on

-- ============================================================================
-- SECCIÓN 1: ANÁLISIS DEL PLAN DE EJECUCIÓN (ANTES DE OPTIMIZAR)
-- ============================================================================

-- 1.1 Análisis de consulta sin optimizar - Búsqueda por estado
-- Ejecutamos EXPLAIN ANALYZE para ver el costo real de la consulta
EXPLAIN ANALYZE 
SELECT id, monto, tasa_interes, fecha_inicio, estado
FROM prestamos
WHERE estado = 'ACTIVO';

-- 1.2 Análisis de consulta con filtro por fecha
EXPLAIN ANALYZE 
SELECT id, cliente_id, monto, fecha_inicio
FROM prestamos
WHERE fecha_inicio >= '2024-01-01';

-- 1.3 Análisis de JOIN sin índices
EXPLAIN ANALYZE 
SELECT p.id, p.monto, c.nombre, c.email
FROM prestamos p
INNER JOIN clientes c ON p.cliente_id = c.id
WHERE p.estado = 'VENCIDO';

-- ============================================================================
-- SECCIÓN 2: CREACIÓN DE ÍNDICES PARA OPTIMIZACIÓN
-- ============================================================================

-- 2.1 Índice simple en columna estado (filtro más común)
-- Este índice mejora significativamente las búsquedas por estado
CREATE INDEX IF NOT EXISTS idx_prestamos_estado 
ON prestamos(estado);

-- 2.2 Índice en fecha_inicio para filtros por rango de fechas
-- Útil para reportes por período y análisis temporal
CREATE INDEX IF NOT EXISTS idx_prestamos_fecha_inicio 
ON prestamos(fecha_inicio);

-- 2.3 Índice compuesto para consultas que filtran por estado y fecha
-- Optimiza consultas que usan ambos criterios simultáneamente
CREATE INDEX IF NOT EXISTS idx_prestamos_estado_fecha 
ON prestamos(estado, fecha_inicio);

-- 2.4 Índice en cliente_id para mejorar JOINs
-- Fundamental para todas las consultas que relacionan préstamos con clientes
CREATE INDEX IF NOT EXISTS idx_prestamos_cliente_id 
ON prestamos(cliente_id);

-- 2.5 Índice en prestamo_id en la tabla pagos
-- Acelera las consultas que unen pagos con préstamos
CREATE INDEX IF NOT EXISTS idx_pagos_prestamo_id 
ON pagos(prestamo_id);

-- 2.6 Índice en fecha_pago para consultas de historial de pagos
CREATE INDEX IF NOT EXISTS idx_pagos_fecha_pago 
ON pagos(fecha_pago);

-- 2.7 Índice en columna de tipo_prestamo para filtros por tipo
CREATE INDEX IF NOT EXISTS idx_prestamos_tipo 
ON prestamos(tipo_prestamo);

-- 2.8 Índice en email de clientes (búsqueda rápida por email)
CREATE INDEX IF NOT EXISTS idx_clientes_email 
ON clientes(email);

-- 2.9 Índice parcial para préstamos activos (reduce tamaño del índice)
-- Solo indexa los registros más consultados
CREATE INDEX IF NOT EXISTS idx_prestamos_activos 
ON prestamos(id, monto, cliente_id)
WHERE estado = 'ACTIVO';

-- 2.10 Índice compuesto para búsquedas por monto rango
CREATE INDEX IF NOT EXISTS idx_prestamos_monto 
ON prestamos(monto) 
WHERE monto BETWEEN 0 AND 100000;

-- ============================================================================
-- SECCIÓN 3: VERIFICACIÓN DE ÍNDICES CREADOS
-- ============================================================================

-- Lista de índices creados en la tabla prestamos
SELECT 
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'prestamos'
ORDER BY indexname;

-- Lista de índices creados en la tabla pagos
SELECT 
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'pagos'
ORDER BY indexname;

-- Lista de índices creados en la tabla clientes
SELECT 
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'clientes'
ORDER BY indexname;

-- ============================================================================
-- SECCIÓN 4: ANÁLISIS DEL PLAN DE EJECUCIÓN (DESPUÉS DE OPTIMIZAR)
-- ============================================================================

-- 4.1 Verificación: consulta por estado ahora usa índice
EXPLAIN ANALYZE 
SELECT id, monto, tasa_interes, fecha_inicio, estado
FROM prestamos
WHERE estado = 'ACTIVO';

-- 4.2 Verificación: consulta por fecha ahora usa índice
EXPLAIN ANALYZE 
SELECT id, cliente_id, monto, fecha_inicio
FROM prestamos
WHERE fecha_inicio >= '2024-01-01';

-- 4.3 Verificación: JOIN ahora usa índices
EXPLAIN ANALYZE 
SELECT p.id, p.monto, c.nombre, c.email
FROM prestamos p
INNER JOIN clientes c ON p.cliente_id = c.id
WHERE p.estado = 'VENCIDO';

-- ============================================================================
-- SECCIÓN 5: REESCRITURA DE CONSULTAS PARA OPTIMIZACIÓN
-- ============================================================================

-- 5.1 Optimización: Uso de EXISTS en lugar de IN para subconsultas
-- EXISTS suele ser más eficiente que IN cuando la subconsulta retorna muchos rows
-- VERSIÓN OPTIMIZADA:
EXPLAIN ANALYZE
SELECT c.id, c.nombre, c.email
FROM clientes c
WHERE EXISTS (
    SELECT 1 
    FROM prestamos p 
    WHERE p.cliente_id = c.id 
    AND p.estado = 'ACTIVO'
);

-- 5.2 Optimización: JOIN con filtrado temprano
-- Aplicar filtros antes del JOIN reduce el volumen de datos a procesar
-- VERSIÓN OPTIMIZADA:
EXPLAIN ANALYZE
SELECT 
    p.id,
    p.monto,
    c.nombre
FROM (SELECT id, monto, cliente_id 
      FROM prestamos 
      WHERE estado = 'ACTIVO') p
INNER JOIN clientes c ON p.cliente_id = c.id;

-- 5.3 Optimización: Uso de COALESCE con valor por defecto
-- Evita operaciones costosas en la función de agregación
-- VERSIÓN OPTIMIZADA:
EXPLAIN ANALYZE
SELECT 
    p.id,
    COALESCE(SUM(pg.monto_pagado), 0) AS total_pagado
FROM prestamos p
LEFT JOIN pagos pg ON p.id = pg.prestamo_id
WHERE p.estado != 'PAGADO'
GROUP BY p.id;

-- 5.4 Optimización: CTE (Common Table Expression) para consultas complejas
-- Mejora legibilidad y permite optimización por el planner
EXPLAIN ANALYZE
WITH prestamos_ativos AS (
    SELECT id, cliente_id, monto, tasa_interes
    FROM prestamos
    WHERE estado = 'ACTIVO'
),
clientes_top AS (
    SELECT id, nombre, email
    FROM clientes
    WHERE id IN (SELECT cliente_id FROM prestamos_ativos)
)
SELECT 
    pa.id,
    pa.monto,
    ct.nombre
FROM prestamos_ativos pa
INNER JOIN clientes_top ct ON pa.cliente_id = ct.id
WHERE pa.monto > 10000;

-- 5.5 Optimización: Evitar funciones en columnas del WHERE
-- Las funciones en columnas impiden uso de índices
-- VERSIÓN OPTIMIZADA (sin función en columna):
EXPLAIN ANALYZE
SELECT id, monto, fecha_inicio
FROM prestamos
WHERE fecha_inicio >= '2024-01-01' 
AND fecha_inicio < '2025-01-01';

-- 5.6 Optimización: LIMIT para consultas de top-N
-- El optimizador puede usar índices para limitar resultados
EXPLAIN ANALYZE
SELECT c.nombre, SUM(p.monto) AS total
FROM clientes c
INNER JOIN prestamos p ON c.id = p.cliente_id
GROUP BY c.nombre
ORDER BY total DESC
LIMIT 10;

-- ============================================================================
-- SECCIÓN 6: CONSULTAS OPTIMIZADAS PARA REPORTES FRECUENTES
-- ============================================================================

-- 6.1 Reporte de cartera - VERSIÓN OPTIMIZADA
-- Usa índice compuesto y proyectas solo columnas necesarias
EXPLAIN ANALYZE
SELECT 
    p.id,
    c.nombre,
    c.email,
    p.tipo_prestamo,
    p.monto,
    p.estado,
    COALESCE(pg.total_pagado, 0) AS total_pagado
FROM prestamos p
INNER JOIN clientes c ON p.cliente_id = c.id
LEFT JOIN (
    SELECT prestamo_id, SUM(monto_pagado) AS total_pagado
    FROM pagos
    GROUP BY prestamo_id
) pg ON p.id = pg.prestamo_id
WHERE p.estado IN ('ACTIVO', 'VENCIDO')
ORDER BY p.monto DESC
LIMIT 100;

-- 6.2 Dashboard de morosos - VERSIÓN OPTIMIZADA
-- Filtrado temprano y uso de índice
EXPLAIN ANALYZE
SELECT 
    c.id,
    c.nombre,
    c.email,
    COUNT(p.id) AS prestamos_vencidos,
    SUM(p.monto) AS saldo_total
FROM clientes c
INNER JOIN (
    SELECT id, cliente_id, monto
    FROM prestamos
    WHERE estado = 'VENCIDO'
    AND fecha_fin < CURRENT_DATE
) p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre, c.email
ORDER BY saldo_total DESC
LIMIT 50;

-- 6.3 Métricas por mes - VERSIÓN OPTIMIZADA
-- Usa índice en fecha_inicio para escaneo eficiente
EXPLAIN ANALYZE
SELECT 
    TO_CHAR(fecha_inicio, 'YYYY-MM') AS mes,
    COUNT(*) AS cantidad,
    SUM(monto) AS monto
FROM prestamos
WHERE fecha_inicio >= DATE_TRUNC('year', CURRENT_DATE)
GROUP BY TO_CHAR(fecha_inicio, 'YYYY-MM')
ORDER BY mes;

-- ============================================================================
-- SECCIÓN 7: ANÁLISIS DE USO DE ÍNDICES
-- ============================================================================

-- 7.1 Verificar qué índices se están usando
-- Consulta las estadísticas de uso de índices
SELECT 
    schemaname,
    tablename,
    indexname,
    idx_tup_read,
    idx_tup_fetch,
    idx_scan
FROM pg_stat_user_indexes
WHERE schemaname = 'public'
ORDER BY idx_scan DESC;

-- 7.2 Tamaño de los índices (para decidir si mantenerlos)
SELECT 
    pg_size_pretty(pg_relation_size('idx_prestamos_estado')) AS idx_estado_size,
    pg_size_pretty(pg_relation_size('idx_prestamos_fecha_inicio')) AS idx_fecha_size,
    pg_size_pretty(pg_relation_size('idx_prestamos_cliente_id')) AS idx_cliente_size,
    pg_size_pretty(pg_relation_size('idx_pagos_prestamo_id')) AS idx_pagos_size;

-- ============================================================================
-- SECCIÓN 8: RECOMENDACIONES DE MANTENIMIENTO
-- ============================================================================

-- 8.1 Análisis de tablas que necesitan VACUUM
SELECT 
    schemaname,
    relname,
    n_dead_tup,
    n_live_tup,
    last_vacuum,
    last_autovacuum
FROM pg_stat_user_tables
WHERE schemaname = 'public'
ORDER BY n_dead_tup DESC;

-- 8.2 Verificar fragmentation de índices
SELECT 
    indexrelname,
    idx_scan,
    idx_tup_read,
    idx_tup_fetch,
    pg_size_pretty(pg_relation_size(indexrelid)) AS index_size
FROM pg_stat_user_indexes
WHERE schemaname = 'public'
AND indexrelname LIKE 'idx_%'
ORDER BY pg_relation_size(indexrelid) DESC;

-- ============================================================================
-- FIN DEL SCRIPT: Optimización de Consultas
-- ============================================================================
-- Este script implementa optimizaciones de rendimiento mediante:
-- 1. Índices apropiados para los patrones de consulta más frecuentes
-- 2. Reescritura de consultas para aprovechar los índices
-- 3. Análisis de planes de ejecución (EXPLAIN ANALYZE)
-- 4. Recomendaciones de mantenimiento (VACUUM, ANALYZE)
-- ============================================================================

// === ARCHIVO: docs/06_analisis_optimizacion.md ===
# Análisis de Optimización de Consultas SQL

## Resumen Ejecutivo

Este documento presenta el análisis de rendimiento realizado sobre las consultas SQL del sistema de gestión de préstamos, incluyendo las optimizaciones implementadas, el análisis de planes de ejecución y el impacto medido en el rendimiento.

## 1. Diagnóstico Inicial

### 1.1 Consultas Analizadas

Se identificaron las siguientes categorías de consultas críticas para el sistema:

| Categoría | Frecuencia | Impacto | Prioridad |
|-----------|------------|---------|----------|
| Búsqueda por estado | Alta | Alto | Crítica |
| Consultas por fecha | Media | Alto | Alta |
| JOIN préstamos-clientes | Alta | Alto | Crítica |
| Agregaciones por cliente | Media | Medio | Media |
| Reportes por período | Baja | Alto | Media |

### 1.2 Problemas Identificados

**Sin optimización, las consultas presentaban:**
- Escaneos completos de tabla (Full Table Scans) en filtros frecuentes
- JOINs sin índices，导致 tiempos de respuesta superiores a 2 segundos
- Ausencia de índices en columnas filtradas comunmente
- Queries con funciones en columnas del WHERE que impedían uso de índices

## 2. Optimizaciones Implementadas

### 2.1 Creación de Índices

Se crearon los siguientes índices para optimizar los patrones de consulta más frecuentes:

```sql
-- Índice simple en columna estado
CREATE INDEX idx_prestamos_estado ON prestamos(estado);

-- Índice compuesto para filtros combinados
CREATE INDEX idx_prestamos_estado_fecha ON prestamos(estado, fecha_inicio);

-- Índice para JOINs
CREATE INDEX idx_prestamos_cliente_id ON prestamos(cliente_id);

-- Índice en fecha de inicio para reportes temporales
CREATE INDEX idx_prestamos_fecha_inicio ON prestamos(fecha_inicio);

-- Índice parcial para préstamos activos
CREATE INDEX idx_prestamos_activos ON prestamos(id, monto, cliente_id)
WHERE estado = 'ACTIVO';
```

### 2.2 Reescritura de Consultas

**Optimización 1: Uso de EXISTS en lugar de IN**

```sql
-- ANTES (menos eficiente)
SELECT * FROM clientes WHERE id IN (
    SELECT cliente_id FROM prestamos WHERE estado = 'ACTIVO'
);

-- DESPUÉS (más eficiente)
SELECT c.* FROM clientes c
WHERE EXISTS (
    SELECT 1 FROM prestamos p 
    WHERE p.cliente_id = c.id AND p.estado = 'ACTIVO'
);
```

**Optimización 2: Filtrado temprano (Early Filtering)**

```sql
-- ANTES
SELECT p.id, p.monto, c.nombre
FROM prestamos p
INNER JOIN clientes c ON p.cliente_id = c.id
WHERE p.estado = 'ACTIVO';

-- DESPUÉS (filtro aplicado antes del JOIN)
SELECT p.id, p.monto, c.nombre
FROM (SELECT id, monto, cliente_id FROM prestamos WHERE estado = 'ACTIVO') p
INNER JOIN clientes c ON p.cliente_id = c.id;
```

**Optimización 3: CTE para consultas complejas**

```sql
-- Uso de Common Table Expression para mejor legibilidad y optimización
WITH prestamos_activos AS (
    SELECT id, cliente_id, monto FROM prestamos WHERE estado = 'ACTIVO'
),
clientes_top AS (
    SELECT id, nombre FROM clientes WHERE id IN (
        SELECT cliente_id FROM prestamos_activos
    )
)
SELECT pa.id, pa.monto, ct.nombre
FROM prestamos_activos pa
INNER JOIN clientes_top ct ON pa.cliente_id = ct.id;
```

## 3. Análisis de Planes de Ejecución

### 3.1 Consulta por Estado (Antes vs Después)

**ANTES de optimización:**
```
Seq Scan on prestamos  (cost=0.00..245.00 rows=150 width=40)
  Filter: (estado = 'ACTIVO'::text)
Planning Time: 0.152 ms
Execution Time: 3.245 ms
```

**DESPUÉS de optimización:**
```
Index Scan using idx_prestamos_estado on prestamos  (cost=0.28..45.50 rows=150 width=40)
  Index Cond: (estado = 'ACTIVO'::text)
Planning Time: 0.189 ms
Execution Time: 0.892 ms
```

| Métrica | Antes | Después | Mejora |
|---------|-------|---------|--------|
| Costo total | 245.00 | 45.50 | 81% ↓ |
| Tiempo de ejecución | 3.245 ms | 0.892 ms | 72% ↓ |
| Tipo de operación | Seq Scan | Index Scan | - |

### 3.2 JOIN Préstamos-Clientes (Antes vs Después)

**ANTES de optimización:**
```
Hash Join  (cost=290.00..580.00 rows=150 width=60)
  Hash Cond: (p.cliente_id = c.id)
  ->  Seq Scan on prestamos p  (cost=0.00..245.00 rows=150 width=40)
  ->  Hash  (cost=180.00..180.00 rows=100 width=32)
        ->  Seq Scan on clientes c  (cost=0.00..180.00 rows=100 width=32)
Execution Time: 5.123 ms
```

**DESPUÉS de optimización:**
```
Nested Loop  (cost=0.56..125.40 rows=150 width=60)
  ->  Index Scan using idx_prestamos_cliente_id on prestamos p  (cost=0.28..45.50 rows=150 width=40)
  ->  Index Scan using clientes_pkey on clientes c  (cost=0.28..0.53 rows=1 width=32)
        Index Cond: (id = p.cliente_id)
Execution Time: 1.456 ms
```

| Métrica | Antes | Después | Mejora |
|---------|-------|---------|--------|
| Costo total | 580.00 | 125.40 | 78% ↓ |
| Tiempo de ejecución | 5.123 ms | 1.456 ms | 71% ↓ |
| Tipo de operación | Hash Join | Nested Loop Index | - |

### 3.3 Consulta por Rango de Fechas

**ANTES:**
```
Seq Scan on prestamos  (cost=0.00..290.00 rows=80 width=40)
  Filter: (fecha_inicio >= '2024-01-01'::date)
Execution Time: 2.890 ms
```

**DESPUÉS:**
```
Index Scan using idx_prestamos_fecha_inicio on prestamos  (cost=0.28..52.30 rows=80 width=40)
  Index Cond: (fecha_inicio >= '2024-01-01'::date)
Execution Time: 0.654 ms
```

| Métrica | Antes | Después | Mejora |
|---------|-------|---------|--------|
| Tiempo de ejecución | 2.890 ms | 0.654 ms | 77% ↓ |

## 4. Impacto en el Rendimiento

### 4.1 Métricas Globales

| Indicador | Valor Anterior | Valor Optimizado | Mejora |
|-----------|---------------|------------------|--------|
| Promedio tiempo de respuesta | 3.75 ms | 1.00 ms | 73% ↓ |
| Consultas por segundo (QPS) | ~267 | ~1000 | 274% ↑ |
| Uso de CPU por query | Alto | Bajo | 65% ↓ |
| I/O disco por query | Alto | Bajo | 70% ↓ |

### 4.2 Beneficios Esperados

1. **Experiencia de usuario**: Las interfaces que dependen de estas consultas serán más responsivas
2. **Capacidad de carga**: El sistema puede manejar 3x más solicitudes concurrentes
3. **Escalabilidad**: Los tiempos de respuesta se mantienen estables conforme crece la data
4. **Costo de infraestructura**: Menor uso de recursos de base de datos permite optimizar costos cloud

### 4.3 Recomendaciones de Mantenimiento

**Análisis de tablas (pg_stat_user_tables):**
```sql
-- Verificar tablas que necesitan VACUUM
SELECT relname, n_dead_tup, last_vacuum
FROM pg_stat_user_tables
WHERE n_dead_tup > 1000;
```

**Actualización de estadísticas:**
```sql
-- Ejecutar ANALYZE después de bulk inserts
ANALYZE prestamos;
ANALYZE clientes;
ANALYZE pagos;
```

**Reorganización de índices fragmentados:**
```sql
-- Si la fragmentación supera el 20%, considerar REINDEX
SELECT indexrelname, pg_size_pretty(pg_relation_size(indexrelid))
FROM pg_stat_user_indexes
WHERE idx_scan < 100;
```

## 5. Conclusiones

Las optimizaciones implementadas demuestran una mejora significativa en el rendimiento de las consultas SQL del sistema de gestión de préstamos. Los resultados clave son:

1. **Reducción del 73%** en tiempo promedio de respuesta
2. **Aumento del 274%** en capacidad de consultas por segundo
3. **Eliminación de Full Table Scans** en todas las consultas analizadas
4. **Uso eficiente de índices** con el patrón de acceso a datos del sistema

Estas optimizaciones son especialmente efectivas para los patrones de consulta más frecuentes del sistema, lo que garantizará una mejor experiencia tanto para usuarios finales como para procesos batch de reportes.

---

*Documento generado como parte del proceso de optimización del sistema de gestión de préstamos - Fase 3*

// === ARCHIVO: README.md ===
# Sistema de Gestión de Préstamos - Scripts SQL

Este proyecto contiene un conjunto de scripts SQL estructurados para la gestión de préstamos en una institución financiera, utilizando PostgreSQL 16.3 como motor de base de datos relacional.

## Estructura del Proyecto

```
gestion-prestamos-sql/
├── README.md
├── package.json
├── tsconfig.json
├── angular.json
├── scripts/
│   ├── 01_creacion_tablas.sql
│   ├── 02_insercion_datos.sql
│   ├── 03_consultas_crud_basicas.sql
│   ├── 04_consultas_avanzadas.sql
│   └── 05_optimizacion_consultas.sql
└── docs/
    └── 06_analisis_optimizacion.md
```

## Prerrequisitos

Antes de ejecutar los scripts, verifica que cumples con los siguientes requisitos:

### Software Requerido

- **PostgreSQL 16.3** o superior instalado en tu sistema
- **Cliente psql** incluido con la instalación de PostgreSQL
- **Privilegios de administrador** sobre la base de datos PostgreSQL

### Verificación de Instalación

Para verificar que PostgreSQL está correctamente instalado, ejecuta el siguiente comando en tu terminal:

```bash
psql --version
```

Deberías ver una salida similar a:

```
psql (PostgreSQL) 16.3
```

### Herramientas Opcionales

Si prefieres una interfaz gráfica, puedes utilizar alguna de las siguientes herramientas:

- **pgAdmin 4**: Herramienta oficial de administración de PostgreSQL
- **DBeaver**: Cliente universal de bases de datos con soporte para PostgreSQL
- **DataGrip**: IDE de JetBrains para bases de datos

## Configuración Inicial

### Paso 1: Conectar al Servidor PostgreSQL

Asegúrate de que el servicio de PostgreSQL está ejecutándose. En sistemas Linux/macOS:

```bash
# Ver estado del servicio
sudo systemctl status postgresql

# Iniciar el servicio si no está corriendo
sudo systemctl start postgresql
```

En Windows, el servicio generalmente se inicia automáticamente. Puedes verificarlo en los "Servicios" del sistema.

### Paso 2: Autenticarse en PostgreSQL

El proyecto está configurado para conectarse usando el usuario `postgres`. Asegúrate de que este usuario existe y tiene una contraseña configurada.

```bash
# Conectar al servidor PostgreSQL
psql -U postgres -h localhost
```

Si solicita contraseña, ingrésala cuando se te indique.

### Paso 3: Crear la Base de Datos (Opcional)

Si deseas crear una base de datos específica para los préstamos:

```bash
psql -U postgres -c "CREATE DATABASE gestion_prestamos;"
```

Para conectar a esa base de datos:

```bash
psql -U postgres -d gestion_prestamos
```

## Ejecución de Scripts

El proyecto incluye un archivo `package.json` con scripts npm que facilitan la ejecución de cada fase. Asegúrate de haber instalado las dependencias del proyecto:

```bash
npm install
```

### Script 1: Creación de Tablas

Este script crea la estructura de la base de datos definiedno las tablas necesarias para el sistema de gestión de préstamos.

```bash
npm run setup
```

O directamente con psql:

```bash
psql -U postgres -f scripts/01_creacion_tablas.sql
```

**Contenido del script**: Define las tablas de clientes, préstamos, pagos y garantías con sus respectivas restricciones y relaciones.

### Script 2: Inserción de Datos

Este script.popula la base de datos con datos de ejemplo para pruebas y desarrollo.

```bash
npm run insert-data
```

O directamente:

```bash
psql -U postgres -f scripts/02_insercion_datos.sql
```

**Contenido del script**: Inserta registros de prueba en todas las tablas creadas previamente.

### Script 3: Consultas CRUD Básicas

Este script contiene las operaciones básicas de manipulación de datos: inserción, selección, actualización y eliminación de registros.

```bash
npm run run-crud
```

O directamente:

```bash
psql -U postgres -f scripts/03_consultas_crud_basicas.sql
```

**Contenido del script**: Consultas para crear, leer, actualizar y eliminar registros en las tablas del sistema.

### Script 4: Consultas Avanzadas

Este script contiene consultas más complejas que implican joins, subconsultas, funciones de agregación y otras operaciones avanzadas de SQL.

```bash
npm run run-advanced
```

O directamente:

```bash
psql -U postgres -f scripts/04_consultas_avanzadas.sql
```

**Contenido del script**: Consultas analíticas para generar reportes, calcular estadísticas y obtener insights de los datos.

### Script 5: Optimización de Consultas

Este script implementa optimizaciones de rendimiento como índices, estadísticas y ajustes de consultas.

```bash
npm run run-optimized
```

O directamente:

```bash
psql -U postgres -f scripts/05_optimizacion_consultas.sql
```

**Contenido del script**: Creación de índices, análisis de planes de ejecución y recomendaciones de optimización.

## Ejecución Secuencial Completa

Para ejecutar todos los scripts en orden, puedes hacerlo manualmente:

```bash
# Paso 1: Crear tablas
psql -U postgres -f scripts/01_creacion_tablas.sql

# Paso 2: Insertar datos
psql -U postgres -f scripts/02_insercion_datos.sql

# Paso 3: Ejecutar CRUD básico
psql -U postgres -f scripts/03_consultas_crud_basicas.sql

# Paso 4: Ejecutar consultas avanzadas
psql -U postgres -f scripts/04_consultas_avanzadas.sql

# Paso 5: Aplicar optimizaciones
psql -U postgres -f scripts/05_optimizacion_consultas.sql
```

## Verificación de Datos

Después de ejecutar los scripts, puedes verificar que los datos se han insertado correctamente:

```bash
# Conectar a la base de datos
psql -U postgres

# Listar todas las tablas
\dt

# Ver contenido de cada tabla
SELECT * FROM clientes LIMIT 5;
SELECT * FROM prestamos LIMIT 5;
SELECT * FROM pagos LIMIT 5;
```

## Documentación Adicional

El proyecto incluye documentación adicional en la carpeta `docs/`:

- `06_analisis_optimizacion.md`: Análisis detallado de las optimizaciones realizadas y su impacto en el rendimiento

## Solución de Problemas

### Error de Conexión

Si recibes un error como `psql: could not connect to server`, verifica que el servicio de PostgreSQL esté ejecutándose:

```bash
# En Linux
sudo systemctl start postgresql

# Verificar estado
sudo systemctl status postgresql
```

### Error de Autenticación

Si falla la autenticación, edita el archivo `pg_hba.conf` para permitir conexiones locales:

```bash
# Ubicación típica en Linux
sudo nano /etc/postgresql/16/main/pg_hba.conf
```

Cambia la línea de autenticación local de `peer` a `md5`:

```
local   all             all                                     md5
```

Luego reinicia PostgreSQL:

```bash
sudo systemctl restart postgresql
```

### Error de Sintaxis SQL

Si recibes errores de sintaxis, asegúrate de estar ejecutando los scripts en el orden correcto y de haber creado las tablas antes de insertar datos.

## Referencias Externas

- [Documentación oficial de PostgreSQL](https://www.postgresql.org/docs/16/)
- [Tutorial de SQL en PostgreSQL](https://www.postgresql.org/docs/16/tutorial-sql.html)
- [Guía de optimización de consultas](https://www.postgresql.org/docs/16/performance-tips.html)

## Licencia

MIT License - Equipo de Ingeniería
```
