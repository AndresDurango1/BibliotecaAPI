USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Editorial_ObtenerEditoriales]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Editorial_ObtenerEditoriales]
AS
BEGIN
	SELECT EditorialId, Nombre, Pais FROM tbl_editoriales;
END
GO
