using BibliotecaAPI.DTOs;
using BibliotecaAPI.Models;

namespace BibliotecaAPI.Repositories.Interfaces
{
    public interface IUserRepository
    {
        //Metodo asincronico para obtener todos los usuarios
        Task<IEnumerable<UserDTO>> GetAllUsersAsync();
        //Metodo asincrónico para obtener un usuario por Id
        Task<UserDTO?> GetUserByIdAsync(int id);
        //Metodo asincrónico para crear un usuario nuevo
        Task<UserDTO?> CreateUserAsync(User user);
        //Metodo asincrónico para actualizar un usuario
        Task<UserDTO?> UpdateUserAsync(User user);
        //Metodo asincrónico para eliminar un usuario
        Task<string?> DeleteUserAsync(int id);
    }
}
