USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Prestamos_ObtenerPrestamos]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Prestamos_ObtenerPrestamos] 
AS
BEGIN
    SELECT 
        P.PrestamoId,
        P.LibroId,
        L.Titulo,
        P.UsuarioId,
        U.Nombre + ' ' + U.Apellido AS NombreUsuario,
        P.FechaPrestamo,
        P.FechaDevolucion,
		P.RenovacionesRestantes
    FROM tbl_prestamos P
    INNER JOIN tbl_libros L ON P.LibroId = L.LibroId
    INNER JOIN tbl_usuarios U ON P.UsuarioId = U.UsuarioId;
END
GO
