USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Usuario_ObtenerUsuarios]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Usuario_ObtenerUsuarios] 
AS
BEGIN
	SELECT UsuarioId, Nombre, Apellido, DNI, Direccion, Email, Telefono FROM tbl_usuarios;
END
GO
