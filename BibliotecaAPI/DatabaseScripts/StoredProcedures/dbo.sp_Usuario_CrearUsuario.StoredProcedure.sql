USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Usuario_CrearUsuario]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Usuario_CrearUsuario] 
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
		-- Validar que no exista un usuario con el mismo DNI
		IF EXISTS (SELECT 1 FROM tbl_usuarios WHERE DNI = @DNI)
		BEGIN
			RAISERROR('Ya existe un usuario con ese DNI', 16, 1);
			RETURN
		END
		-- Validar que no exista un usuario con el mismo Email
		IF EXISTS (SELECT 1 FROM tbl_usuarios WHERE Email = @Email)
		BEGIN
			RAISERROR('Ya existe un usuario con ese Email', 16, 1);
			RETURN
		END		
		--Insertar el usuario
		INSERT INTO tbl_usuarios (Nombre, Apellido, DNI, Direccion, Email, Telefono, Contraseña)
		VALUES (@Nombre, @Apellido, @DNI, @Direccion, @Email, @Telefono, @Contraseña);
		--Obtener el id del usuario nuevo
		DECLARE @NuevoId INT = SCOPE_IDENTITY();
		-- Validar y retornar usuario nuevo
		IF @NuevoId IS NOT NULL
		BEGIN
			-- Retornar usuario nuevo
			SELECT UsuarioId, Nombre, Apellido, DNI, Direccion, Email, Telefono FROM tbl_usuarios
			WHERE UsuarioId = @NuevoId;
		END
		ELSE
		BEGIN
			-- Error en la insercion
			RAISERROR('No se pudo crear el usuario', 16, 1);
		END
	END TRY
	BEGIN CATCH
		DECLARE @Message NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR(@Message, 16, 1);
	END CATCH
END
GO
