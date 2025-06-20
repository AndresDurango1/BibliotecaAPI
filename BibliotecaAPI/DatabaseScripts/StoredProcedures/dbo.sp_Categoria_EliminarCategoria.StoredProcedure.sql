USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Categoria_EliminarCategoria]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Categoria_EliminarCategoria] @CategoriaId INT
AS
BEGIN
	SET NOCOUNT  ON;
	BEGIN TRY
		--  Validar que la categoría existe en la tabla
		IF NOT EXISTS (SELECT 1 FROM tbl_categorias WHERE CategoriaId = @CategoriaId)
		BEGIN
			RAISERROR('No se encontró una categoría con el ID proporcionado.', 16, 1);
			RETURN;
		END	
		-- Elimina el autor si existe
		DELETE FROM tbl_categorias 
		WHERE CategoriaId = @CategoriaId;
		--Confirmar que se eliminó la categoría
		IF EXISTS (SELECT 1 FROM tbl_categorias WHERE CategoriaId = @CategoriaId)
		BEGIN
			RAISERROR('La categoría no se pudo eliminar', 16, 1);
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
