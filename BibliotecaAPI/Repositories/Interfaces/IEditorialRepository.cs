using BibliotecaAPI.Models;

namespace BibliotecaAPI.Repositories.Interfaces
{
    public interface IEditorialRepository
    {
        //Método asincrónico para obtener todas las categorías
        Task<IEnumerable<Editorial>> GetAllEditorialsAsync();
        //Método asincrónico para obtener una editorial por su id
        Task<Editorial?> GetEditorialByIdAsync(int id);
        //Método asincrónico para crear una editorial nueva
        Task<Editorial?> CreateEditorialAsync(Editorial editorial);
        //Metodo asincrónico para actualizar una editorial
        Task<Editorial?> UpdateEditorialAsync(Editorial editorial);
        //Metodo asincrónico para eliminar una editorial
        Task<string> DeleteEditorialAsync(int id);
    }
}
