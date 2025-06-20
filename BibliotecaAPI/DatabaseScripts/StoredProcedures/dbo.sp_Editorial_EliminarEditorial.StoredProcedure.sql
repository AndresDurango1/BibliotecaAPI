USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Editorial_EliminarEditorial]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Eliminar una editorial
CREATE PROCEDURE [dbo].[sp_Editorial_EliminarEditorial] @EditorialId INT
AS
BEGIN
	SET NOCOUNT  ON;
	BEGIN TRY
		--  Validar que la editorial existe en la tabla
		IF NOT EXISTS (SELECT 1 FROM tbl_editoriales WHERE EditorialId = @EditorialId)
		BEGIN
			RAISERROR('No se encontró una editorial con el ID proporcionado.', 16, 1);
			RETURN;
		END	
		-- Elimina la editorial si existe
		DELETE FROM tbl_editoriales 
		WHERE EditorialId = @EditorialId;
		--Confirmar que se eliminó la editorial
		IF EXISTS (SELECT 1 FROM tbl_editoriales WHERE EditorialId = @EditorialId)
		BEGIN
			RAISERROR('La editorial no se pudo eliminar', 16, 1);
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
