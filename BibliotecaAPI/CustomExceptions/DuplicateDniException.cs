namespace BibliotecaAPI.Exceptions
{
    public class DuplicateDniException : Exception
    {
        // Constructor vacío: permite lanzar la excepción sin mensaje
        public DuplicateDniException() { }
        // Constructor con mensaje: permite especificar un mensaje al lanzar la excepción
        public DuplicateDniException(string message) : base(message) { }
        // Constructor con mensaje + innerException: útil si otra excepción causó esta
        public DuplicateDniException(string message, Exception innerException)
            : base(message, innerException) { }
    }
}
