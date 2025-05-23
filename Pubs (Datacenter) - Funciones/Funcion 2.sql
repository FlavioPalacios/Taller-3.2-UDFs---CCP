-- FUNCIÓN 2 Obtener ventas totales por título (función escalar) (Datacenter)
DROP FUNCTION IF EXISTS dbo.VentasTotalesTitulo;
GO

-- Esta función recibe el ID de un título y devuelve la cantidad total vendida
CREATE FUNCTION dbo.VentasTotalesTitulo(@title_id VARCHAR(6))
RETURNS INT  -- Tipo de valor devuelto: un número entero (total de unidades vendidas)
AS
BEGIN
    DECLARE @Total INT  -- Variable para almacenar el total de unidades vendidas

    -- Se calcula la suma de las cantidades (qty) vendidas del título especificado
    SELECT @Total = SUM(qty)
    FROM sales
    WHERE title_id = @title_id;  -- Se filtra por el ID del título recibido como parámetro

    -- Si no hay ventas registradas, ISNULL asegura que se devuelva 0 en lugar de NULL
    RETURN ISNULL(@Total, 0)
END
GO
SELECT dbo.VentasTotalesTitulo('BU1032') AS VentasTotales;
