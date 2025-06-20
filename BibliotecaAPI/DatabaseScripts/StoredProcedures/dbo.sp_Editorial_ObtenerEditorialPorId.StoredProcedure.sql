USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Editorial_ObtenerEditorialPorId]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Obtener una categoria por id
CREATE PROCEDURE [dbo].[sp_Editorial_ObtenerEditorialPorId] @EditorialId INT
AS
BEGIN
	SET NOCOUNT ON;
	-- Validar que el ID es Válido
	IF @EditorialId IS NULL OR @EditorialId <= 0
	BEGIN
		RAISERROR('El ID de la editorial no es válido', 16, 1);
		RETURN;
	END
	-- Validar que la categoría existe en la tabla
	IF NOT EXISTS (SELECT 1 FROM tbl_editoriales WHERE EditorialId = @EditorialId)
    BEGIN
        RAISERROR('No se encontró una editorial con el ID proporcionado.', 16, 1);
        RETURN;
    END
	-- Seleccionar la editorial por su @EditorialId
	SELECT EditorialId, Nombre, Pais 
	FROM tbl_editoriales
	WHERE EditorialId = @EditorialId;
END
GO
