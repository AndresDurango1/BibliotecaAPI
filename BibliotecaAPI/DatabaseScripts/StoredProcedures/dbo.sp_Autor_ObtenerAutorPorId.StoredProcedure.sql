USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Autor_ObtenerAutorPorId]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Autor_ObtenerAutorPorId] @AutorId INT
AS
BEGIN
	SET NOCOUNT ON;
	-- Validar que el ID es Válido
	IF @AutorId IS NULL OR @AutorId <= 0
	BEGIN
		RAISERROR('El ID del autor no es válido', 16, 1);
		RETURN;
	END
	-- Validar que el autor existe en la tabla
	IF NOT EXISTS (SELECT 1 FROM tbl_autores WHERE AutorId = @AutorId)
    BEGIN
        RAISERROR('No se encontró un autor con el ID proporcionado.', 16, 1);
        RETURN;
    END
	-- Seleccionar el autor por su @AutorId
	SELECT AutorId, Nombre, Apellido, AnioNacimiento, Nacionalidad 
	FROM tbl_autores
	WHERE AutorId = @AutorId;
END
GO
