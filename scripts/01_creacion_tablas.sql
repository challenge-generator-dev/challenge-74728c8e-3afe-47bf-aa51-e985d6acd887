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