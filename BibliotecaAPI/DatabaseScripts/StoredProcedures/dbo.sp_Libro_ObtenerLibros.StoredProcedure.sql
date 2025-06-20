USE [DB_Biblioteca]
GO
/****** Object:  StoredProcedure [dbo].[sp_Libro_ObtenerLibros]    Script Date: 20/06/2025 11:24:22 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- CREACION DE PROCEDIMIENTOS ALMACENADOS PROYECTO BIBLIOTECA
-- tbl_libros
-- Obtener todos los libros
CREATE PROCEDURE [dbo].[sp_Libro_ObtenerLibros] 
AS
BEGIN
	SELECT 
		L.LibroId,
		L.Titulo,
		L.AnioPublicacion,
		A.Nombre + ' ' + A.Apellido AS NombreAutor,
		C.Nombre AS NombreCategoria,
		E.Nombre AS NombreEditorial,
		CASE
			WHEN EXISTS (
				SELECT 1
				FROM tbl_prestamos P
				WHERE P.LibroId = L.LibroId 
				AND GETDATE() < P.FechaDevolucion 
			)
			THEN CAST (1 AS BIT)
			ELSE CAST (0 AS BIT)
		END AS EstaPrestado
	FROM tbl_libros L
	INNER JOIN tbl_autores A ON L.AutorId = A.AutorId
	INNER JOIN tbl_categorias C ON L.CategoriaId = C.CategoriaId
	INNER JOIN tbl_editoriales E ON L.EditorialId = E.EditorialId;
END
GO
