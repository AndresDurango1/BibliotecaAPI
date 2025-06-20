USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Autor_EliminarAutor]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Autor_EliminarAutor] @AutorId INT
AS
BEGIN
	SET NOCOUNT  ON;
	BEGIN TRY
		--  Validar que el autor existe en la tabla
		IF NOT EXISTS (SELECT 1 FROM tbl_autores WHERE AutorId = @AutorId)
		BEGIN
			RAISERROR('No se encontró un autor con el ID proporcionado.', 16, 1);
			RETURN;
		END	
		-- Elimina el autor si existe
		DELETE FROM tbl_autores 
		WHERE AutorId = @AutorId;
		--Confirmar que se eliminó el usuario
		IF EXISTS (SELECT 1 FROM tbl_autores WHERE AutorId = @AutorId)
		BEGIN
			RAISERROR('El autor no se pudo eliminar', 16, 1);
		END 
		ELSE
		BEGIN
			SELECT @@ROWCOUNT AS FilasEliminadas;
		END
	END TRY
	BEGIN CATCH
		DECLARE @Message NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR(@Message, 16, 1);
	END CATCH
END
GO
