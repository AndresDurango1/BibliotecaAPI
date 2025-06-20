USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Prestamo_RenovarPrestamo]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Renovar un préstamo
CREATE PROCEDURE [dbo].[sp_Prestamo_RenovarPrestamo] @PrestamoId INT
AS
BEGIN
	SET NOCOUNT ON;
    -- Validar que el préstamo existe
    IF NOT EXISTS (SELECT 1 FROM tbl_prestamos WHERE PrestamoId = @PrestamoId)
    BEGIN
        RAISERROR('Préstamo no encontrado.', 16, 1);
        RETURN;
    END
    DECLARE 
        @FechaDevolucion DATETIME,
        @RenovacionesRestantes INT;
    SELECT 
        @FechaDevolucion = FechaDevolucion,
        @RenovacionesRestantes = RenovacionesRestantes
    FROM tbl_prestamos
    WHERE PrestamoId = @PrestamoId;
    -- Validar que haya renovaciones disponibles
    IF @RenovacionesRestantes <= 0
    BEGIN
        RAISERROR('No hay renovaciones disponibles para este préstamo.', 16, 1);
        RETURN;
    END
    -- Validar que solo se pueda renovar si faltan 2 días o menos para la devolución
    IF DATEDIFF(DAY, GETDATE(), @FechaDevolucion) > 2
    BEGIN
        RAISERROR('La renovación solo se puede hacer cuando faltan 2 días o menos para la fecha de devolución.', 16, 1);
        RETURN;
    END
    -- Actualizar el préstamo: sumar 10 días y reducir el contador de renovaciones
    UPDATE tbl_prestamos
    SET 
        FechaDevolucion = DATEADD(DAY, 10, FechaDevolucion),
        RenovacionesRestantes = RenovacionesRestantes - 1
    WHERE PrestamoId = @PrestamoId;
	-- Validar si se actualizó efectivamente
	IF @@ROWCOUNT = 0
	BEGIN
		RAISERROR('No se pudo renovar el préstamo. Intente nuevamente.', 16, 1);
		RETURN;
	END
END
GO
