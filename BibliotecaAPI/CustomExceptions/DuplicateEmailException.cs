namespace BibliotecaAPI.Exceptions
{
    public class DuplicateEmailException : Exception
    {
        // Constructor vacío: permite lanzar la excepción sin mensaje
        public DuplicateEmailException() { }
        // Constructor con mensaje: permite especificar un mensaje al lanzar la excepción
        public DuplicateEmailException(string message) : base(message) { }
        // Constructor con mensaje + innerException: útil si otra excepción causó esta
        public DuplicateEmailException(string message, Exception innerException)
            : base(message, innerException) { }
    }
}
