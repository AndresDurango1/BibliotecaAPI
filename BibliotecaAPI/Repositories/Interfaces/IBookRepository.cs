using BibliotecaAPI.DTOs;
using BibliotecaAPI.Models;

namespace BibliotecaAPI.Repositories.Interfaces
{
    public interface IBookRepository
    {
        //Método asincrónico para obtener todos los libros
        Task<IEnumerable<BookDTO>> GetAllBooksAsync();
        //Método asincrónico para obtener un libro por su id
        Task<BookDTO?> GetBookByIdAsync(int id);
        //Método asincrónico para crear un libro nuevo
        Task<BookDTO?> CreateBookAsync(Book book);
        //Metodo asincrónico para actualizar un libro
        Task<BookDTO?> UpdateBookAsync(Book book);
        //Metodo asincrónico para eliminar un libro
        Task<string?> DeleteBookAsync(int id);
    }
}
