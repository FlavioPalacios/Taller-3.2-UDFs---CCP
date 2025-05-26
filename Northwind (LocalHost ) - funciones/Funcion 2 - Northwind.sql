-- 2. 
DROP FUNCTION IF EXISTS dbo.fn_ProductosSinStock;
GO

-- Creamos la función que devolverá una tabla con los productos sin stock
CREATE FUNCTION dbo.fn_ProductosSinStock () -- Esta función no recibe ningún parámetro de entrada
RETURNS TABLE -- Indica que la función devolverá un conjunto de resultados (una tabla)
AS
RETURN
    -- Aquí se define la consulta que la función devolverá como tabla
    SELECT
        P.ProductName, -- Selecciona el nombre del producto
        S.CompanyName AS Proveedor, -- Selecciona el nombre de la compañía del proveedor y lo renombra como 'Proveedor'
        P.UnitsInStock -- Selecciona la cantidad de unidades en stock del producto
    FROM Products P -- Usa la tabla 'Products' y le da el alias 'P'
    JOIN Suppliers S ON P.SupplierID = S.SupplierID -- Une la tabla 'Products' con la tabla 'Suppliers' usando el ID del proveedor
    WHERE P.UnitsInStock = 0; -- Filtra los resultados para mostrar solo los productos con 0 unidades en stock
GO

-- Ahora probamos la función para mostrar los productos sin stock
SELECT * FROM dbo.fn_ProductosSinStock();
GO