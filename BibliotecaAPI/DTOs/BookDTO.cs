namespace BibliotecaAPI.DTOs
{
    public class BookDTO
    {
        public int LibroId { get; set; }
        public string Titulo { get; set; } = string.Empty;
        public int AnioPublicacion { get; set; }
        public string NombreAutor { get; set; } = string.Empty;
        public string NombreCategoria { get; set; } = string.Empty;
        public string NombreEditorial { get; set; } = string.Empty;
        public bool EstaPrestado { get; set; }

        public string EstadoPrestamo => EstaPrestado ? "Prestado" : "Disponible para préstamo";
    }
}
