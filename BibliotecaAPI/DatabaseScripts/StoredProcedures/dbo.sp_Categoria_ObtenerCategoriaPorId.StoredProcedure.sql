USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Categoria_ObtenerCategoriaPorId]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Categoria_ObtenerCategoriaPorId] @CategoriaId INT
AS
BEGIN
	SET NOCOUNT ON;
	-- Validar que el ID es Válido
	IF @CategoriaId IS NULL OR @CategoriaId <= 0
	BEGIN
		RAISERROR('El ID de la categoría no es válido', 16, 1);
		RETURN;
	END
	-- Validar que la categoría existe en la tabla
	IF NOT EXISTS (SELECT 1 FROM tbl_categorias WHERE CategoriaId = @CategoriaId)
    BEGIN
        RAISERROR('No se encontró una categoría con el ID proporcionado.', 16, 1);
        RETURN;
    END
	-- Seleccionar la categoría por su @CategoriaId
	SELECT CategoriaId, Nombre, Descripcion 
	FROM tbl_categorias
	WHERE CategoriaId = @CategoriaId;
END
GO
