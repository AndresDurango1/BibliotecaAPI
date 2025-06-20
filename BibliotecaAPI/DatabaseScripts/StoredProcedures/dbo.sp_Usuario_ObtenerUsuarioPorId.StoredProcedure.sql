USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Usuario_ObtenerUsuarioPorId]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Usuario_ObtenerUsuarioPorId] @UsuarioId INT
AS
BEGIN
	SET NOCOUNT ON;
	-- Validar que el ID es Válido
	IF @UsuarioId IS NULL OR @UsuarioId <= 0
	BEGIN
		RAISERROR('El ID del usuario no es válido', 16, 1);
		RETURN;
	END
	-- Validar que el usuario existe en la tabla
	IF NOT EXISTS (SELECT 1 FROM tbl_usuarios WHERE UsuarioId = @UsuarioId)
    BEGIN
        RAISERROR('No se encontró un usuario con el ID proporcionado.', 16, 1);
        RETURN;
    END
	-- Seleccionar el usuario por su @UsuarioId
	SELECT UsuarioId, Nombre, Apellido, DNI, Direccion, Email, Telefono 
	FROM tbl_usuarios
	WHERE UsuarioId = @UsuarioId;
END
GO
