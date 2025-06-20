USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Autor_ActualizarAutor]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Autor_ActualizarAutor]
					@AutorId INT,
					@Nombre NVARCHAR(50),
					@Apellido NVARCHAR(50),
					@AnioNacimiento INT,
					@Nacionalidad NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		--  Validar que el autor existe en la tabla
		IF NOT EXISTS (SELECT 1 FROM tbl_autores WHERE AutorId = @AutorId)
		BEGIN
			RAISERROR('No se encontró un autor con el ID proporcionado.', 16, 1);
			RETURN;
		END
		-- Si el autor existe, se actualiza la tabla
		UPDATE tbl_autores SET
			Nombre = @Nombre,
			Apellido = @Apellido,
			AnioNacimiento = @AnioNacimiento,
			Nacionalidad = @Nacionalidad
		-- Retornar el autor actualizado
		SELECT AutorId, Nombre, Apellido, AnioNacimiento, Nacionalidad
		FROM tbl_autores
		WHERE AutorId = @AutorId;
	END TRY
	BEGIN CATCH
		DECLARE @Message NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR(@Message, 16, 1);
	END CATCH
END
GO
