USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Autor_ObtenerAutores]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Autor_ObtenerAutores]
AS
BEGIN
	SELECT AutorId, Nombre, Apellido, AnioNacimiento, Nacionalidad FROM tbl_autores;
END
GO
