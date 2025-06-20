USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Prestamo_ActualizarPrestamo]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Actualizar un préstamo
CREATE PROCEDURE [dbo].[sp_Prestamo_ActualizarPrestamo]
					@PrestamoId INT,
					@NuevaFechaDevolucion DATETIME
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM tbl_prestamos WHERE PrestamoId = @PrestamoId)
    BEGIN
        RAISERROR('Préstamo no encontrado.', 16, 1);
        RETURN;
    END
	-- Actualizar prestamo
    UPDATE tbl_prestamos
    SET FechaDevolucion = @NuevaFechaDevolucion
    WHERE PrestamoId = @PrestamoId;
END
GO
