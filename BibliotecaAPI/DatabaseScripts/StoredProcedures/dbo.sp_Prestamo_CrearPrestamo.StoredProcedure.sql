USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Prestamo_CrearPrestamo]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Crear un préstamo nuevo
CREATE PROCEDURE [dbo].[sp_Prestamo_CrearPrestamo] 
					@LibroId INT,
					@UsuarioId INT
AS
BEGIN
    SET NOCOUNT ON;
    -- Validar existencia del libro
    IF NOT EXISTS (SELECT 1 FROM tbl_libros WHERE LibroId = @LibroId)
    BEGIN
        RAISERROR('Libro no encontrado.', 16, 1);
        RETURN;
    END
    -- Validar si el libro ya está prestado y aún no se ha devuelto
    IF EXISTS (
        SELECT 1 
		FROM tbl_prestamos 
        WHERE LibroId = @LibroId AND GETDATE() < FechaDevolucion
    )
    BEGIN
        RAISERROR('El libro ya está prestado.', 16, 1);
        RETURN;
    END
    -- Si el libro existe y no está prestado, crear préstamo
    INSERT INTO tbl_prestamos (LibroId, UsuarioId, FechaPrestamo, FechaDevolucion)
    VALUES (@LibroId, @UsuarioId, GETDATE(), DATEADD(DAY, 10, GETDATE()));
END
GO
