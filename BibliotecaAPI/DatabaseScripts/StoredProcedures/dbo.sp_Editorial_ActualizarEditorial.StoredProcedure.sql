USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Editorial_ActualizarEditorial]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Actualizar una categoria
CREATE PROCEDURE [dbo].[sp_Editorial_ActualizarEditorial]
					@EditorialId INT,
					@Nombre NVARCHAR(100),
					@Pais NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		--  Validar que la categoría existe en la tabla
		IF NOT EXISTS (SELECT 1 FROM tbl_editoriales WHERE EditorialId = @EditorialId)
		BEGIN
			RAISERROR('No se encontró una editorial con el ID proporcionado.', 16, 1);
			RETURN;
		END
		-- Si la editorial existe, se actualiza la tabla
		UPDATE tbl_editoriales SET
			Nombre = @Nombre,
			Pais = @Pais
		-- Retornar la editorial actualizado
		SELECT EditorialId, Nombre, Pais
		FROM tbl_editoriales
		WHERE EditorialId = @EditorialId;
	END TRY
	BEGIN CATCH
		DECLARE @Message NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR(@Message, 16, 1);
	END CATCH
END
GO
