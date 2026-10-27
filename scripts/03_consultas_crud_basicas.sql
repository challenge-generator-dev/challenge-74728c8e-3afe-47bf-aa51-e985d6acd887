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