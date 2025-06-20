USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Prestamo_ObtenerPrestamoPorId]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Obtener un préstamo por id
CREATE PROCEDURE [dbo].[sp_Prestamo_ObtenerPrestamoPorId] @PrestamoId INT
AS
BEGIN
    IF @PrestamoId IS NULL OR @PrestamoId <= 0
    BEGIN
        RAISERROR('ID de préstamo no válido', 16, 1);
        RETURN;
    END
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
    INNER JOIN tbl_usuarios U ON P.UsuarioId = U.UsuarioId
    WHERE P.PrestamoId = @PrestamoId;
END
GO
