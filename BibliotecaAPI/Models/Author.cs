namespace BibliotecaAPI.Models
{
    public class Author
    {
        public int AutorId { get; set; }
        public string Nombre { get; set; } = string.Empty;
        public string Apellido { get; set; } = string.Empty;
        public int AnioNacimiento { get; set; }
        public string Nacionalidad { get; set; } = string.Empty;
    }
}
