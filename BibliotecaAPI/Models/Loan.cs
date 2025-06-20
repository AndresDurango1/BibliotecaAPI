namespace BibliotecaAPI.Models
{
    public class Loan
    {
        public int PrestamoId { get; set; }
        public DateTime FechaPrestamo { get; set; }
        public DateTime FechaDevolucion { get; set; }
        public int RenovacionesRestantes { get; set; }

        //Propiedades Relacionadas
        public int UsuarioId { get; set; }
        public int LibroId { get; set; }
    }
}
