USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Usuario_ActualizarUsuario]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Usuario_ActualizarUsuario]
					@UsuarioId INT,
					@Nombre NVARCHAR(50),
					@Apellido NVARCHAR(50),
					@DNI NVARCHAR(50),
					@Direccion NVARCHAR(100),
					@Email NVARCHAR(100),
					@Telefono NVARCHAR(50),
					@Contraseña NVARCHAR(256)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		--  Validar que el usuario existe en la tabla
		IF NOT EXISTS (SELECT 1 FROM tbl_usuarios WHERE UsuarioId = @UsuarioId)
		BEGIN
			RAISERROR('No se encontró un usuario con el ID proporcionado.', 16, 1);
			RETURN;
		END
		-- Validar que no exista un usuario con el mismo DNI (excepto él mismo)
		IF EXISTS (SELECT 1 FROM tbl_usuarios WHERE DNI = @DNI AND UsuarioId <> @UsuarioId)
		BEGIN
			RAISERROR('Ya existe un usuario con ese DNI', 16, 1);
			RETURN
		END
		-- Validar que no exista un usuario con el mismo Email (excepto él mismo)
		IF EXISTS (SELECT 1 FROM tbl_usuarios WHERE Email = @Email AND UsuarioId <> @UsuarioId)
		BEGIN
			RAISERROR('Ya existe un usuario con ese Email', 16, 1);
			RETURN
		END		
		-- Si el usuario existe, se actualiza la tabla
		UPDATE tbl_usuarios SET
			Nombre = @Nombre,
			Apellido = @Apellido,
			DNI = @DNI,
			Direccion = @Direccion,
			Email = @Email,
			Telefono = @Telefono,
			Contraseña = @Contraseña
		-- Retornar el usuario actualizado
		SELECT UsuarioId, Nombre, Apellido, DNI, Direccion, Email, Telefono 
		FROM tbl_usuarios
		WHERE UsuarioId = @UsuarioId;
	END TRY
	BEGIN CATCH
		DECLARE @Message NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR(@Message, 16, 1);
	END CATCH
END
GO
