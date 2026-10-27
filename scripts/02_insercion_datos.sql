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