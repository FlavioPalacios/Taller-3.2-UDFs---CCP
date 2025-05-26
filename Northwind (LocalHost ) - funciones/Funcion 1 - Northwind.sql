
-- Si la funci�n ya existe, la borramos para evitar errores al volver a crearla
DROP FUNCTION IF EXISTS dbo.fn_TotalPedido;
GO

-- Creamos la funci�n que calcular� el total de un pedido espec�fico
CREATE FUNCTION dbo.fn_TotalPedido (@OrderID INT)  -- Recibe el ID del pedido como entrada
RETURNS MONEY                                     -- Devuelve un n�mero con decimales (tipo MONEY)
AS
BEGIN
    DECLARE @Total MONEY;                         -- Creamos una variable para guardar el total final

    -- Aqu� se hace la "cuenta": se suman todos los productos del pedido
    -- multiplicando el precio por la cantidad, y aplicando el descuento
    SELECT @Total = SUM(UnitPrice * Quantity * (1 - Discount))
    FROM [Order Details]                          -- Usamos la tabla de detalles de pedidos
    WHERE OrderID = @OrderID;                     -- Solo tomamos los productos del pedido indicado

    -- Devolvemos el total calculado
    RETURN @Total;
END;
GO

-- Ahora probamos la funci�n con un pedido real (por ejemplo, el 10248)
SELECT 'Total del Pedido 10248' AS Descripcion, dbo.fn_TotalPedido(10248) AS TotalPedido;
GO