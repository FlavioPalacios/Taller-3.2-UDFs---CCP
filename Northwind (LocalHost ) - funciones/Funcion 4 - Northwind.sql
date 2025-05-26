--4. 
DROP FUNCTION IF EXISTS dbo.fn_ProductosMasVendidos;
GO

-- Creamos la funci�n que devolver� una tabla con los productos m�s vendidos
-- NOTA: Esta funci�n no incluye un ORDER BY interno, la ordenaci�n se realiza al consultar la funci�n.
CREATE FUNCTION dbo.fn_ProductosMasVendidos () -- Esta funci�n no recibe ning�n par�metro de entrada
RETURNS TABLE -- Indica que la funci�n devolver� un conjunto de resultados (una tabla)
AS
RETURN
    -- Aqu� se define la consulta que la funci�n devolver� como tabla
    SELECT
        P.ProductName, -- Selecciona el nombre del producto
        SUM(OD.Quantity) AS TotalVendidas, -- Calcula la suma total de la cantidad vendida para cada producto y la renombra como 'TotalVendidas'
        COUNT(DISTINCT OD.OrderID) AS NumeroPedidos -- Cuenta el n�mero de pedidos �nicos en los que aparece cada producto y lo renombra como 'NumeroPedidos'
    FROM [Order Details] OD -- Usa la tabla 'Order Details' (detalles de pedidos) y lo llama 'OD'
    JOIN Products P ON OD.ProductID = P.ProductID -- Une la tabla 'Order Details' con la tabla 'Products' usando el ID del producto
    GROUP BY P.ProductName; -- Agrupa los resultados por el nombre del producto para poder sumar las cantidades y contar los pedidos
GO

-- Ahora probamos la funci�n para mostrar los productos m�s vendidos
-- Los resultados se ordenan por la cantidad total vendida en orden descendente (los m�s vendidos primero)
SELECT *
FROM dbo.fn_ProductosMasVendidos()
ORDER BY TotalVendidas DESC;
GO