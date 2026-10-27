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