USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Categoria_CrearCategoria]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Categoria_CrearCategoria]
					@Nombre NVARCHAR(100),
					@Descripcion NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		-- Validar que no exista un usuario con el mismo DNI
		IF EXISTS (SELECT 1 FROM tbl_categorias WHERE Nombre = @Nombre)
		BEGIN
			RAISERROR('Ya existe una categoría con ese Nombre', 16, 1);
			RETURN
		END
		--Insertar la categoría
		INSERT INTO tbl_categorias(Nombre, Descripcion)
		VALUES (@Nombre, @Descripcion);
		--Obtener el id de la categoría nuevo
		DECLARE @NuevoId INT = SCOPE_IDENTITY();
		-- Validar y retornar usuario nuevo
		IF @NuevoId IS NOT NULL
		BEGIN
			-- Retornar usuario nuevo
			SELECT CategoriaId, Nombre, Descripcion  FROM tbl_categorias
			WHERE CategoriaId = @NuevoId;
		END
		ELSE
		BEGIN
			-- Error en la insercion
			RAISERROR('No se pudo crear la categoría', 16, 1);
		END
	END TRY
	BEGIN CATCH
		DECLARE @Message NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR(@Message, 16, 1);
	END CATCH
END
GO
