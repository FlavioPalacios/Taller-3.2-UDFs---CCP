-- 2. 
DROP FUNCTION IF EXISTS dbo.fn_ProductosSinStock;
GO

-- Creamos la funci�n que devolver� una tabla con los productos sin stock
CREATE FUNCTION dbo.fn_ProductosSinStock () -- Esta funci�n no recibe ning�n par�metro de entrada
RETURNS TABLE -- Indica que la funci�n devolver� un conjunto de resultados (una tabla)
AS
RETURN
    -- Aqu� se define la consulta que la funci�n devolver� como tabla
    SELECT
        P.ProductName, -- Selecciona el nombre del producto
        S.CompanyName AS Proveedor, -- Selecciona el nombre de la compa��a del proveedor y lo renombra como 'Proveedor'
        P.UnitsInStock -- Selecciona la cantidad de unidades en stock del producto
    FROM Products P -- Usa la tabla 'Products' y le da el alias 'P'
    JOIN Suppliers S ON P.SupplierID = S.SupplierID -- Une la tabla 'Products' con la tabla 'Suppliers' usando el ID del proveedor
    WHERE P.UnitsInStock = 0; -- Filtra los resultados para mostrar solo los productos con 0 unidades en stock
GO

-- Ahora probamos la funci�n para mostrar los productos sin stock
SELECT * FROM dbo.fn_ProductosSinStock();
GO