namespace BibliotecaAPI.CustomExceptions
{
    public class ConflictException : Exception
    {
        // Constructor vacío: permite lanzar la excepción sin mensaje
        public ConflictException() { }
        // Constructor con mensaje: permite especificar un mensaje al lanzar la excepción
        public ConflictException(string message) : base(message) { }
        // Constructor con mensaje + innerException: útil si otra excepción causó esta
        public ConflictException(string message, Exception innerException)
            : base(message, innerException) { }

    }
}
