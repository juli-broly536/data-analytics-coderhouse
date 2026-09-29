-- Ventas_Tech_DB – Consultas con JOINs (Módulo 5)
-- Autor: Juliano Fayolle
-- Fecha: 29/09/2026

USE Ventas_Tech_DB;

-- ── CONSULTA 1: VISTA BASE DEL PROYECTO (INNER JOIN) ──────
-- Pregunta de negocio: ¿Cómo se ve cada venta individual con toda
-- su información enriquecida (cliente, producto, categoría)?
-- Esta es la fuente de datos principal para el dashboard de Power BI.
SELECT
    v.fecha_venta,
    v.id_cliente,
    c.ciudad,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    (v.precio_unitario * v.cantidad) AS total_venta
FROM ventas AS v
INNER JOIN clientes AS c ON c.id_cliente = v.id_cliente
INNER JOIN productos AS p ON p.id_producto = v.id_producto
INNER JOIN categorias AS cat ON cat.id_categoria = p.id_categoria;

-- ── CONSULTA 2: CLIENTES SIN VENTAS (LEFT JOIN) ───────────
-- Pregunta de negocio: ¿Qué clientes registrados nunca hicieron
-- una compra? (pedido del área de CRM)
-- Resultado esperado: 0 filas, ya que los 5 clientes cargados
-- tienen al menos una venta asociada en los datos actuales.
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- ── CONSULTA 3: PRODUCTOS SIN VENTAS (LEFT JOIN) ──────────
-- Pregunta de negocio: ¿Qué productos del catálogo nunca se
-- vendieron? (pedido del área de producto)
-- Resultado esperado: 0 filas, ya que los 6 productos cargados
-- tienen al menos una venta asociada en los datos actuales.
SELECT
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos AS p
LEFT JOIN ventas AS v ON p.id_producto = v.id_producto
INNER JOIN categorias AS cat ON p.id_categoria = cat.id_categoria
WHERE v.id_venta IS NULL;

-- ── CONSULTA 4: CONSOLIDADO POR ZONA (UNION ALL) ──────────
-- Pregunta de negocio: ¿cuánto se vendió en CABA vs. el resto
-- del país? Base directa del análisis central del proyecto
-- (concentración de ventas por región).
SELECT zona, SUM(total) AS total_por_zona
FROM (
    SELECT
        v.fecha_venta,
        (v.precio_unitario * v.cantidad) AS total,
        'CABA' AS zona
    FROM ventas AS v
    INNER JOIN clientes AS c ON c.id_cliente = v.id_cliente
    WHERE c.ciudad = 'Buenos Aires'
    UNION ALL
    SELECT
        v.fecha_venta,
        (v.precio_unitario * v.cantidad) AS total,
        'Resto Del Pais' AS zona
    FROM ventas AS v
    INNER JOIN clientes AS c ON c.id_cliente = v.id_cliente
    WHERE c.ciudad != 'Buenos Aires'
) AS ventas_por_zona
GROUP BY zona;
