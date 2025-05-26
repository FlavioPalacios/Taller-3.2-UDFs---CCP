--3. 
DROP FUNCTION IF EXISTS dbo.fn_NumPedidosCliente;
GO

-- Creamos la funci�n que calcular� el n�mero total de pedidos para un cliente espec�fico
CREATE FUNCTION dbo.fn_NumPedidosCliente (@CustomerID NCHAR(5)) -- Recibe el ID del cliente (cadena de 5 caracteres) como entrada
RETURNS INT -- La funci�n devolver� un n�mero entero (la cantidad de pedidos)
AS
BEGIN
    DECLARE @Cantidad INT; -- Creamos una variable para guardar el n�mero de pedidos

    -- Aqu� se hace la "cuenta": se cuenta el n�mero de filas en la tabla Orders
    SELECT @Cantidad = COUNT(*)
    FROM Orders -- Usamos la tabla de pedidos
    WHERE CustomerID = @CustomerID; -- Solo contamos los pedidos del cliente indicado

    -- Devolvemos la cantidad de pedidos calculada
    RETURN @Cantidad;
END;
GO

-- Ahora probamos la funci�n con un cliente real (por ejemplo, 'ALFKI')
SELECT 'Pedidos del Cliente ALFKI' AS Descripcion, dbo.fn_NumPedidosCliente('ALFKI') AS NumeroPedidos;
GO