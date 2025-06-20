USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Libro_ActualizarLibro]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Actualizar un libro
CREATE PROCEDURE [dbo].[sp_Libro_ActualizarLibro]
					@LibroId INT,
					@Titulo NVARCHAR(100),
					@AnioPublicacion INT,
					@AutorId INT, 
					@CategoriaId INT,
					@EditorialId INT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		--  Validar que el libro existe en la tabla
		IF NOT EXISTS (SELECT 1 FROM tbl_libros WHERE LibroId = @LibroId)
			THROW 50001, 'No se encontró un Libro con el ID proporcionado.', 1;
		-- Validaciones de las llaves foráneas
		-- AutorId
		IF NOT EXISTS (SELECT 1 FROM tbl_autores WHERE AutorId = @AutorId)
			THROW 50002, 'No se encontró un Autor con el ID proporcionado.', 1;
		-- CategoriaId
		IF NOT EXISTS (SELECT 1 FROM tbl_categorias WHERE CategoriaId = @CategoriaId)
			THROW 50003, 'No se encontró una Categoría con el ID proporcionado.', 1;
		--  EditorialId
		IF NOT EXISTS (SELECT 1 FROM tbl_editoriales WHERE EditorialId = @EditorialId)
			THROW 50004, 'No se encontró una Editorial con el ID proporcionado.', 1;
	
		-- Si el libro y las llaves foráneas existen, se actualiza la tabla
		UPDATE tbl_libros SET
			Titulo = @Titulo,
			AnioPublicacion = @AnioPublicacion,
			AutorId = @AutorId,
			CategoriaId = @CategoriaId,
			EditorialId = @EditorialId
		-- Retornar el libro actualizado
		SELECT 
			L.LibroId,
			L.Titulo,
			L.AnioPublicacion,
			A.Nombre + ' ' + A.Apellido AS NombreAutor,
			C.Nombre AS NombreCategoria,
			E.Nombre AS NombreEditorial
		FROM tbl_libros L
		INNER JOIN tbl_autores A ON L.AutorId = A.AutorId
		INNER JOIN tbl_categorias C ON L.CategoriaId = C.CategoriaId
		INNER JOIN tbl_editoriales E ON L.EditorialId = E.EditorialId
		WHERE LibroId = @LibroId;
	END TRY
	BEGIN CATCH
		DECLARE @Message NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR(@Message, 16, 1);
	END CATCH
END
GO
