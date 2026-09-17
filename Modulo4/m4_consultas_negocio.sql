USE Ventas_Tech_DB;

--Consulta 1 — Resumen ejecutivo mensual 
SELECT SUM(cantidad * precio_unitario) AS total_facturado,
       COUNT(*) AS pedidos,
       AVG(cantidad * precio_unitario) AS ticket_promedio,
       MONTH(fecha_venta) AS mes_de_venta
FROM ventas
GROUP BY MONTH(fecha_venta);

--Consulta 2 — Ranking de productos
SELECT TOP 5 id_producto, 
       SUM(cantidad * precio_unitario) AS total_facturado,
       SUM(cantidad) AS unidades_vendidas
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

--Consulta 3 — Clientes recurrentes
SELECT id_cliente,
       COUNT(*) AS pedidos,
       SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;

--Consulta 4 — Meses por encima/por debajo del promedio
SELECT MONTH(fecha_venta) AS mes_de_venta,
       SUM(cantidad * precio_unitario) AS total_facturado,
       CASE 
           WHEN SUM(cantidad * precio_unitario) > (SELECT AVG(total_facturado)
               FROM (SELECT SUM(cantidad * precio_unitario) AS total_facturado,
                            MONTH(fecha_venta) AS mes_de_venta
                     FROM ventas
                     GROUP BY MONTH(fecha_venta)
               ) AS totales_mensuales)
           THEN 'Por encima'
           ELSE 'Por debajo'
       END AS comparacion_promedio
FROM ventas
GROUP BY MONTH(fecha_venta);


-- ══════════════════════════════════════════
-- Hallazgos
-- ══════════════════════════════════════════
-- 1) El producto 1 (Laptop Pro 15) es el que más plata generó de todos, 3600 de los 6444 
--    totales que se facturaron en el mes. O sea que un solo producto explica más de la 
--    mitad de toda la facturación.
-- 2) Los 5 clientes que tenemos cargados compraron 2 veces cada uno, así que en este caso 
--    todos entran como clientes recurrentes. El cliente 1 y el cliente 5 son los que más 
--    gastaron (2640 y 2100), bastante por encima de los otros tres.
-- 3) En la consulta 4 el mes de marzo dio "Por debajo" del promedio, pero es medio engañoso: 
--    como solo hay datos cargados de un único mes, el total de ese mes y el promedio general 
--    terminan siendo el mismo número, y al no ser estrictamente mayor cae en "Por debajo". 
--    Con más meses cargados esta comparación tendría más sentido real.
