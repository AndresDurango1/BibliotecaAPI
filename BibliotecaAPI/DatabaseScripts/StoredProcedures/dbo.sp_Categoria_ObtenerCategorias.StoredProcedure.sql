USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Categoria_ObtenerCategorias]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Categoria_ObtenerCategorias]
AS
BEGIN
	SELECT CategoriaId, Nombre, Descripcion FROM tbl_categorias;
END
GO
