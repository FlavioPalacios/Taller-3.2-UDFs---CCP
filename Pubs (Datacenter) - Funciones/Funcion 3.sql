-- FUNCIÓN 3 - Calcular el total de ventas de un libro y validar si supera un umbral dado. (Datacenter)
DROP FUNCTION IF EXISTS dbo.EvaluarVentasTitulo;
GO

CREATE FUNCTION dbo.EvaluarVentasTitulo
(
    @title_id VARCHAR(6),  -- Parámetro de entrada: ID del libro
    @umbral INT            -- Parámetro de entrada: umbral mínimo de ventas
)
RETURNS VARCHAR(50)        -- Tipo de dato devuelto: texto descriptivo
AS
BEGIN
    DECLARE @total INT;             -- Variable para almacenar el total de ventas del libro
    DECLARE @resultado VARCHAR(50); -- Variable para almacenar el resultado del análisis

    -- Calcula la suma de las cantidades vendidas del título indicado
    SELECT @total = SUM(qty)
    FROM sales
    WHERE title_id = @title_id;
    -- Si no se encontraron ventas, se asigna 0 para evitar NULL
    IF @total IS NULL
        SET @total = 0;
    -- Compara el total de ventas con el umbral recibido
    IF @total >= @umbral
        SET @resultado = 'Exitoso';         -- Si las ventas superan el umbral
    ELSE
        SET @resultado = 'Poco vendido';    -- Si las ventas no alcanzan el umbral

    -- Devuelve el resultado como texto
    RETURN @resultado;
END
GO
SELECT title, dbo.EvaluarVentasTitulo(title_id, 100) AS EvaluaciónFROM titles;


