using BibliotecaAPI.DTOs;
using BibliotecaAPI.Models;

namespace BibliotecaAPI.Repositories.Interfaces
{
    public interface IAuthorRepository
    {
        //Método asincrónico para obtener todos los autores
        Task<IEnumerable<AuthorDTO>> GetAllAuthorsAsync();
        //Método asincrónico para obtener un autor por su id
        Task<AuthorDTO?> GetAuthorByIdAsync(int id);
        //Método asincrónico para crear un autor nuevo
        Task<AuthorDTO?> CreateAuthorAsync(Author author);
        //Metodo asincrónico para actualizar un autor
        Task<AuthorDTO?> UpdateAuthorAsync(Author author);
        //Metodo asincrónico para eliminar un autor
        Task<string?> DeleteAuthorAsync(int id);
    }
}
