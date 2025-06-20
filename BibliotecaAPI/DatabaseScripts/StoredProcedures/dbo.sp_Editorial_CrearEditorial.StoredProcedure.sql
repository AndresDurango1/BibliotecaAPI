USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Editorial_CrearEditorial]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Crear una categoria nueva
CREATE PROCEDURE [dbo].[sp_Editorial_CrearEditorial]
					@Nombre NVARCHAR(100),
					@Pais NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		-- Validar que no exista una editorial con ese nombre
		IF EXISTS (SELECT 1 FROM tbl_editoriales WHERE Nombre = @Nombre)
		BEGIN
			RAISERROR('Ya existe una editorial con ese Nombre', 16, 1);
			RETURN
		END
		--Insertar la categoría
		INSERT INTO tbl_editoriales(Nombre, Pais)
		VALUES (@Nombre, @Pais);
		--Obtener el id de la editorial nueva
		DECLARE @NuevoId INT = SCOPE_IDENTITY();
		-- Validar y retornar usuario nuevo
		IF @NuevoId IS NOT NULL
		BEGIN
			-- Retornar usuario nuevo
			SELECT EditorialId, Nombre, Pais  FROM tbl_editoriales
			WHERE EditorialId = @NuevoId;
		END
		ELSE
		BEGIN
			-- Error en la insercion
			RAISERROR('No se pudo crear la editorial', 16, 1);
		END
	END TRY
	BEGIN CATCH
		DECLARE @Message NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR(@Message, 16, 1);
	END CATCH
END
GO
