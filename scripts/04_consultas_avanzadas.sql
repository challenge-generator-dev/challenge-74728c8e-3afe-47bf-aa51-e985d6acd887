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