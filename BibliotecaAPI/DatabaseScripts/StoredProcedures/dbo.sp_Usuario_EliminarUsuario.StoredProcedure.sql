USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Usuario_EliminarUsuario]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Usuario_EliminarUsuario] @UsuarioId INT
AS
BEGIN
	SET NOCOUNT  ON;
	BEGIN TRY
		--  Validar que el usuario existe en la tabla
		IF NOT EXISTS (SELECT 1 FROM tbl_usuarios WHERE UsuarioId = @UsuarioId)
		BEGIN
			RAISERROR('No se encontró un usuario con el ID proporcionado.', 16, 1);
			RETURN;
		END	
		-- Elimina el usuario si existe
		DELETE FROM tbl_usuarios 
		WHERE UsuarioId = @UsuarioId;
		--Confirmar que se eliminó el usuario
		IF EXISTS (SELECT 1 FROM tbl_usuarios WHERE UsuarioId = @UsuarioId)
		BEGIN
			RAISERROR('El usuario no se pudo eliminar', 16, 1);
		END 
		ELSE
		BEGIN
			SELECT 'Usuario eliminado correctamente.' AS Mensaje;
		END
	END TRY
	BEGIN CATCH
		DECLARE @Message NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR(@Message, 16, 1);
	END CATCH
END
GO
