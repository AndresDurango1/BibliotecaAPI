USE [DB_Biblioteca]
GO
/****** Object:  Table [dbo].[tbl_prestamos]    Script Date: 20/06/2025 11:29:54 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_prestamos](
	[PrestamoId] [int] IDENTITY(1,1) NOT NULL,
	[FechaPrestamo] [datetime] NOT NULL,
	[FechaDevolucion] [datetime] NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[LibroId] [int] NOT NULL,
	[RenovacionesRestantes] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PrestamoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_prestamos] ADD  DEFAULT ((2)) FOR [RenovacionesRestantes]
GO
ALTER TABLE [dbo].[tbl_prestamos]  WITH CHECK ADD FOREIGN KEY([LibroId])
REFERENCES [dbo].[tbl_libros] ([LibroId])
GO
ALTER TABLE [dbo].[tbl_prestamos]  WITH CHECK ADD  CONSTRAINT [FK_tbl_prestamos_tbl_libros] FOREIGN KEY([LibroId])
REFERENCES [dbo].[tbl_libros] ([LibroId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_prestamos] CHECK CONSTRAINT [FK_tbl_prestamos_tbl_libros]
GO
ALTER TABLE [dbo].[tbl_prestamos]  WITH CHECK ADD  CONSTRAINT [FK_tbl_prestamos_tbl_usuarios] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[tbl_usuarios] ([UsuarioId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_prestamos] CHECK CONSTRAINT [FK_tbl_prestamos_tbl_usuarios]
GO
