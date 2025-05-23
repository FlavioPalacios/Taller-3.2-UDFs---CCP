-- FUNCIÓN 1 (Datacenter)
-- Si la función ya existe, se elimina para evitar errores al volver a crearla
DROP FUNCTION IF EXISTS dbo.FormatearNombreAutor;
GO
-- Esta función recibe un ID de autor (@au_id) y devuelve su nombre completo formateado
CREATE FUNCTION dbo.FormatearNombreAutor(@au_id CHAR(11)) -- Parámetro de entrada: ID del autor
RETURNS NVARCHAR(150)  -- Tipo de dato que devuelve la función: cadena de texto
AS
BEGIN
    DECLARE @Nombre NVARCHAR(150);  -- Se declara una variable para almacenar el nombre formateado

    -- Se obtiene el nombre del autor en el formato "Apellido, Nombre (Estado)"
    SELECT @Nombre = au_lname + ', ' + au_fname + ' (' + state + ')'
    FROM authors
    WHERE au_id = @au_id;  -- Se filtra por el ID recibido

    RETURN @Nombre;  -- Se devuelve el valor almacenado en la variable @Nombre
END
GO

SELECT dbo.FormatearNombreAutor('172-32-1176') AS NombreFormateado;
