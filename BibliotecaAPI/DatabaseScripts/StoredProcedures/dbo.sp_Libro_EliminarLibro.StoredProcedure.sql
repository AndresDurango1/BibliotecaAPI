USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Libro_EliminarLibro]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Eliminar un libro
CREATE PROCEDURE [dbo].[sp_Libro_EliminarLibro] @LibroId INT
AS
BEGIN
	SET NOCOUNT  ON;
	BEGIN TRY
		--  Validar que el libro existe en la tabla
		IF NOT EXISTS (SELECT 1 FROM tbl_libros WHERE LibroId = @LibroId)
			THROW 50001, 'No se encontró un Libro con el ID proporcionado.', 1;
		-- Elimina el libro si existe
		DELETE FROM tbl_libros 
		WHERE LibroId = @LibroId;
		--Confirmar que se eliminó el libro
		IF EXISTS (SELECT 1 FROM tbl_libros WHERE LibroId = @LibroId)
		BEGIN
			RAISERROR('El libro no se pudo eliminar', 16, 1);
		END 
		ELSE
		BEGIN
			SELECT 'Libro eliminado correctamente.' AS Mensaje;
		END
	END TRY
	BEGIN CATCH
		DECLARE @Message NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR(@Message, 16, 1);
	END CATCH
END
GO
