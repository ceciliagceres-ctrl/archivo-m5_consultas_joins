USE ventas_tech_db;

--CONSULTA 1
SELECT
V.fecha_venta,
C.id_cliente,
C.nombre,
P.nombre_producto,
V.cantidad,
V.precio_unitario,
V.total_venta
FROM ventas AS V INNER JOIN clientes AS C ON V.id_cliente = C.id_cliente
INNER JOIN productos AS P ON V.id_producto = P.id_producto;

--CONSULTA 2 Solicito que traiga todos los clientes (columna izquierda) que no hayan comprado.
SELECT
C.id_cliente,
C.nombre,
C.email,
C.fecha_registro,
V.fecha_venta
FROM clientes AS C LEFT JOIN ventas AS V ON C.id_cliente = V.id_cliente
WHERE V.id_cliente IS NULL;
--Hallazgo En esta consulta no hay ningun cliente que no haya realizado alguna compra.

-- CONSULTA 3 Productos (columna izquierda) que no tengan ninguna venta realizada
SELECT
P.nombre_producto,
Ca.id_categoria,
Ca.nombre_categoria,
P.precio
FROM productos AS P LEFT JOIN ventas AS V ON P.id_producto = V.id_producto
LEFT JOIN categorias AS Ca ON P.id_categoria=Ca.id_categoria
WHERE V.id_producto IS NULL;
-- Hallazgo no hay productos del catalogo que no tengan ventas registradas.

-- CONSULTA 4 Resultados incluyendo todas las columnas duplicadas
SELECT fecha_venta FROM ventas;

SELECT canal, SUM(total) AS total_ventas
FROM (
    SELECT cantidad * precio_unitario AS total, 'Año Anterior' AS canal
    FROM ventas 
    WHERE fecha_venta BETWEEN '2023-01-01' AND '2023-12-31'
    
    UNION ALL
    
    SELECT cantidad * precio_unitario AS total, 'Año Actual' AS canal
    FROM ventas 
    WHERE fecha_venta BETWEEN '2024-01-01' AND '2024-12-31'
) AS consolidado
GROUP BY canal;

-- Hallazgo encontramos que en el año actual tenemos un total de $6444 de ventas.




