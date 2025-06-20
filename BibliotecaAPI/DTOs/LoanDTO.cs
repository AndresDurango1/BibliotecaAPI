namespace BibliotecaAPI.DTOs
{
    public class LoanDTO
    {
        public int PrestamoId { get; set; }
        public int LibroId { get; set; }
        public string Titulo { get; set; } = string.Empty;
        public int UsuarioId { get; set; }
        public string NombreUsuario { get; set; } = string.Empty;
        public DateTime FechaPrestamo { get; set; }
        public DateTime FechaDevolucion { get; set; }
        public int RenovacionesRestantes { get; set; }
    }
}
