-- FUNCI�N 2 Obtener ventas totales por t�tulo (funci�n escalar) (Datacenter)
DROP FUNCTION IF EXISTS dbo.VentasTotalesTitulo;
GO

-- Esta funci�n recibe el ID de un t�tulo y devuelve la cantidad total vendida
CREATE FUNCTION dbo.VentasTotalesTitulo(@title_id VARCHAR(6))
RETURNS INT  -- Tipo de valor devuelto: un n�mero entero (total de unidades vendidas)
AS
BEGIN
    DECLARE @Total INT  -- Variable para almacenar el total de unidades vendidas

    -- Se calcula la suma de las cantidades (qty) vendidas del t�tulo especificado
    SELECT @Total = SUM(qty)
    FROM sales
    WHERE title_id = @title_id;  -- Se filtra por el ID del t�tulo recibido como par�metro

    -- Si no hay ventas registradas, ISNULL asegura que se devuelva 0 en lugar de NULL
    RETURN ISNULL(@Total, 0)
END
GO
SELECT dbo.VentasTotalesTitulo('BU1032') AS VentasTotales;
