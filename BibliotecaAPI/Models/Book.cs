namespace BibliotecaAPI.Models
{
    public class Book
    {
        public int LibroId { get; set; }
        public string Titulo { get; set; } = string.Empty;
        public int AnioPublicacion { get; set; }

        //Propiedades relacionadas
        public int AutorId { get; set; }
        public int CategoriaId { get; set; }
        public int EditorialId { get; set; }
    }
}
