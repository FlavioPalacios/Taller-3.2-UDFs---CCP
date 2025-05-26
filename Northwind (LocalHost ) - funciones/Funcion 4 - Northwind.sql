--4. 
DROP FUNCTION IF EXISTS dbo.fn_ProductosMasVendidos;
GO

-- Creamos la función que devolverá una tabla con los productos más vendidos
-- NOTA: Esta función no incluye un ORDER BY interno, la ordenación se realiza al consultar la función.
CREATE FUNCTION dbo.fn_ProductosMasVendidos () -- Esta función no recibe ningún parámetro de entrada
RETURNS TABLE -- Indica que la función devolverá un conjunto de resultados (una tabla)
AS
RETURN
    -- Aquí se define la consulta que la función devolverá como tabla
    SELECT
        P.ProductName, -- Selecciona el nombre del producto
        SUM(OD.Quantity) AS TotalVendidas, -- Calcula la suma total de la cantidad vendida para cada producto y la renombra como 'TotalVendidas'
        COUNT(DISTINCT OD.OrderID) AS NumeroPedidos -- Cuenta el número de pedidos únicos en los que aparece cada producto y lo renombra como 'NumeroPedidos'
    FROM [Order Details] OD -- Usa la tabla 'Order Details' (detalles de pedidos) y lo llama 'OD'
    JOIN Products P ON OD.ProductID = P.ProductID -- Une la tabla 'Order Details' con la tabla 'Products' usando el ID del producto
    GROUP BY P.ProductName; -- Agrupa los resultados por el nombre del producto para poder sumar las cantidades y contar los pedidos
GO

-- Ahora probamos la función para mostrar los productos más vendidos
-- Los resultados se ordenan por la cantidad total vendida en orden descendente (los más vendidos primero)
SELECT *
FROM dbo.fn_ProductosMasVendidos()
ORDER BY TotalVendidas DESC;
GO