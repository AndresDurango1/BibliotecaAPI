USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Libro_CrearLibro]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Crear un libro nuevo
CREATE PROCEDURE [dbo].[sp_Libro_CrearLibro] 
					@Titulo NVARCHAR(100),
					@AnioPublicacion INT,
					@AutorId INT, 
					@CategoriaId INT,
					@EditorialId INT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
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

		-- Insertar el libro
		INSERT INTO tbl_libros(Titulo, AnioPublicacion, AutorId, CategoriaId, EditorialId)
		VALUES (@Titulo, @AnioPublicacion, @AutorId, @CategoriaId, @EditorialId);
		--Obtener el id del libro nuevo
		DECLARE @NuevoId INT = SCOPE_IDENTITY();
		-- Validar y retornar libro nuevo
		IF @NuevoId IS NOT NULL
		BEGIN
			-- Retornar libro nuevo
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
			WHERE LibroId = @NuevoId;
		END
		ELSE
		BEGIN
			-- Error en la insercion
			RAISERROR('No se pudo crear el libro', 16, 1);
		END
	END TRY
	BEGIN CATCH
		DECLARE @Message NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR(@Message, 16, 1);
	END CATCH
END
GO
