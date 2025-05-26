--3. 
DROP FUNCTION IF EXISTS dbo.fn_NumPedidosCliente;
GO

-- Creamos la función que calculará el número total de pedidos para un cliente específico
CREATE FUNCTION dbo.fn_NumPedidosCliente (@CustomerID NCHAR(5)) -- Recibe el ID del cliente (cadena de 5 caracteres) como entrada
RETURNS INT -- La función devolverá un número entero (la cantidad de pedidos)
AS
BEGIN
    DECLARE @Cantidad INT; -- Creamos una variable para guardar el número de pedidos

    -- Aquí se hace la "cuenta": se cuenta el número de filas en la tabla Orders
    SELECT @Cantidad = COUNT(*)
    FROM Orders -- Usamos la tabla de pedidos
    WHERE CustomerID = @CustomerID; -- Solo contamos los pedidos del cliente indicado

    -- Devolvemos la cantidad de pedidos calculada
    RETURN @Cantidad;
END;
GO

-- Ahora probamos la función con un cliente real (por ejemplo, 'ALFKI')
SELECT 'Pedidos del Cliente ALFKI' AS Descripcion, dbo.fn_NumPedidosCliente('ALFKI') AS NumeroPedidos;
GO