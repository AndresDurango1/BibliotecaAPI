USE [DB_Biblioteca]
GO
/****** Object:  Table [dbo].[tbl_libros]    Script Date: 20/06/2025 11:29:54 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_libros](
	[LibroId] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [nvarchar](100) NULL,
	[AnioPublicacion] [int] NOT NULL,
	[AutorId] [int] NOT NULL,
	[CategoriaId] [int] NOT NULL,
	[EditorialId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LibroId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_libros]  WITH CHECK ADD FOREIGN KEY([AutorId])
REFERENCES [dbo].[tbl_autores] ([AutorId])
GO
ALTER TABLE [dbo].[tbl_libros]  WITH CHECK ADD FOREIGN KEY([CategoriaId])
REFERENCES [dbo].[tbl_categorias] ([CategoriaId])
GO
ALTER TABLE [dbo].[tbl_libros]  WITH CHECK ADD FOREIGN KEY([EditorialId])
REFERENCES [dbo].[tbl_editoriales] ([EditorialId])
GO
ALTER TABLE [dbo].[tbl_libros]  WITH CHECK ADD  CONSTRAINT [FK_tbl_libros_tbl_autores] FOREIGN KEY([AutorId])
REFERENCES [dbo].[tbl_autores] ([AutorId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_libros] CHECK CONSTRAINT [FK_tbl_libros_tbl_autores]
GO
ALTER TABLE [dbo].[tbl_libros]  WITH CHECK ADD  CONSTRAINT [FK_tbl_libros_tbl_categorias] FOREIGN KEY([CategoriaId])
REFERENCES [dbo].[tbl_categorias] ([CategoriaId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_libros] CHECK CONSTRAINT [FK_tbl_libros_tbl_categorias]
GO
ALTER TABLE [dbo].[tbl_libros]  WITH CHECK ADD  CONSTRAINT [FK_tbl_libros_tbl_editoriales] FOREIGN KEY([EditorialId])
REFERENCES [dbo].[tbl_editoriales] ([EditorialId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_libros] CHECK CONSTRAINT [FK_tbl_libros_tbl_editoriales]
GO
