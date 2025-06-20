USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Prestamo_EliminarPrestamo]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Eliminar un prestamo
CREATE PROCEDURE [dbo].[sp_Prestamo_EliminarPrestamo] @PrestamoId INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM tbl_prestamos WHERE PrestamoId = @PrestamoId)
    BEGIN
        RAISERROR('Préstamo no encontrado.', 16, 1);
        RETURN;
    END
	-- Eliminar préstamo
    DELETE FROM tbl_prestamos WHERE PrestamoId = @PrestamoId;
END
GO
