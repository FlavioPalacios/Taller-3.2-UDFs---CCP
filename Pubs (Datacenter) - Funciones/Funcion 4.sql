-- FUNCI�N 4 Consulta derivada con JOIN (Funci�n con valor de tabla) (Datacenter)
DROP FUNCTION IF EXISTS dbo.AutoresConSusLibros;
GO

-- Esta es una funci�n en l�nea que retorna directamente el resultado de un SELECT como tabla
CREATE FUNCTION dbo.AutoresConSusLibros ()
RETURNS TABLE  -- Indica que esta funci�n retorna una tabla completa
AS
RETURN
(
    -- Se retorna el resultado de la siguiente consulta
    SELECT 
        a.au_id,  -- ID del autor
        a.au_lname + ', ' + a.au_fname AS NombreAutor,  -- Nombre completo formateado: Apellido, Nombre
        t.title AS Titulo,           -- T�tulo del libro
        p.pub_name AS Editorial      -- Nombre de la editorial
    FROM authors a
    -- Se relaciona con la tabla intermedia titleauthor (relaci�n N:M entre autores y t�tulos)
    JOIN titleauthor ta ON a.au_id = ta.au_id
    -- Se relaciona con la tabla de t�tulos para obtener el nombre del libro
    JOIN titles t ON ta.title_id = t.title_id
    -- Se une con publishers para obtener el nombre de la editorial que public� el libro
    JOIN publishers p ON t.pub_id = p.pub_id
);
GO

SELECT * FROM dbo.AutoresConSusLibros();
