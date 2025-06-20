USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Autor_CrearAutor]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Autor_CrearAutor]
					@Nombre NVARCHAR(50),
					@Apellido NVARCHAR(50),
					@AnioNacimiento INT,
					@Nacionalidad NVARCHAR(100)

AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		--Insertar el autor
		INSERT INTO tbl_autores (Nombre, Apellido, AnioNacimiento, Nacionalidad)
		VALUES (@Nombre, @Apellido, @AnioNacimiento, @Nacionalidad);
		--Obtener el id del autor nuevo
		DECLARE @NuevoId INT = SCOPE_IDENTITY();
		-- Validar y retornar usuario nuevo
		IF @NuevoId IS NOT NULL
		BEGIN
			-- Retornar usuario nuevo
			SELECT AutorId, Nombre, Apellido, AnioNacimiento, Nacionalidad  FROM tbl_autores
			WHERE AutorId = @NuevoId;
		END
		ELSE
		BEGIN
			-- Error en la insercion
			RAISERROR('No se pudo crear el autor', 16, 1);
		END
	END TRY
	BEGIN CATCH
		DECLARE @Message NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR(@Message, 16, 1);
	END CATCH
END
GO
