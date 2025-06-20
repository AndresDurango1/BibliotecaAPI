namespace BibliotecaAPI.CustomExceptions
{
    public class NotFoundException : Exception
    {
        // Constructor vacío: permite lanzar la excepción sin mensaje
        public NotFoundException() { }
        // Constructor con mensaje: permite especificar un mensaje al lanzar la excepción
        public NotFoundException(string message) : base(message) { }
        // Constructor con mensaje + innerException: útil si otra excepción causó esta
        public NotFoundException(string message, Exception innerException)
            : base(message, innerException) { }

    }
}
