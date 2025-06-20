USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Categoria_ActualizarCategoria]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Categoria_ActualizarCategoria]
					@CategoriaId INT,
					@Nombre NVARCHAR(100),
					@Descripcion NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		--  Validar que la categoría existe en la tabla
		IF NOT EXISTS (SELECT 1 FROM tbl_categorias WHERE CategoriaId = @CategoriaId)
		BEGIN
			RAISERROR('No se encontró una categoría con el ID proporcionado.', 16, 1);
			RETURN;
		END
		-- Si la categoría existe, se actualiza la tabla
		UPDATE tbl_categorias SET
			Nombre = @Nombre,
			Descripcion = @Descripcion
		-- Retornar la categoria actualizado
		SELECT CategoriaId, Nombre, Descripcion
		FROM tbl_categorias
		WHERE CategoriaId = @CategoriaId;
	END TRY
	BEGIN CATCH
		DECLARE @Message NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR(@Message, 16, 1);
	END CATCH
END
GO
