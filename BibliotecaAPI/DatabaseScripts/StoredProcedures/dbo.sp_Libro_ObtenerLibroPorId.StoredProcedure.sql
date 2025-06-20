USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Libro_ObtenerLibroPorId]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Obtener un libro por id
CREATE PROCEDURE [dbo].[sp_Libro_ObtenerLibroPorId] @LibroId INT
AS
BEGIN
	SET NOCOUNT ON;
	-- Validar que el ID es Válido
	IF @LibroId IS NULL OR @LibroId <= 0
	BEGIN
		RAISERROR('El ID del libro no es válido', 16, 1);
		RETURN;
	END
	-- Validar que el libro existe en la tabla
	IF NOT EXISTS (SELECT 1 FROM tbl_libros WHERE LibroId = @LibroId)
    BEGIN
        RAISERROR('No se encontró un libro con el ID proporcionado.', 16, 1);
        RETURN;
    END
	-- Seleccionar el libro por su @LibroId
	SELECT 
		L.LibroId,
		L.Titulo,
		L.AnioPublicacion,
		A.Nombre + ' ' + A.Apellido AS NombreAutor,
		C.Nombre AS NombreCategoria,
		E.Nombre AS NombreEditorial,
		CASE
			WHEN EXISTS (
				SELECT 1
				FROM tbl_prestamos P
				WHERE P.LibroId = L.LibroId 
				AND GETDATE() < P.FechaDevolucion 
			)
			THEN CAST (1 AS BIT)
			ELSE CAST (0 AS BIT)
		END AS EstaPrestado
	FROM tbl_libros L
	INNER JOIN tbl_autores A ON L.AutorId = A.AutorId
	INNER JOIN tbl_categorias C ON L.CategoriaId = C.CategoriaId
	INNER JOIN tbl_editoriales E ON L.EditorialId = E.EditorialId
	WHERE LibroId = @LibroId;
END
GO
