using BibliotecaAPI.DTOs;
using BibliotecaAPI.Models;

namespace BibliotecaAPI.Repositories.Interfaces
{
    public interface ICategoryRepository
    {
        //Método asincrónico para obtener todas las categorías
        Task<IEnumerable<Category>> GetAllCategoriesAsync();
        //Método asincrónico para obtener una categoria por su id
        Task<Category?> GetCategoryByIdAsync(int id);
        //Método asincrónico para crear una categoría nueva
        Task<Category?> CreateCategoryAsync(Category category);
        //Metodo asincrónico para actualizar una categoría
        Task<Category?> UpdateCategoryAsync(Category category);
        //Metodo asincrónico para eliminar una categoría
        Task<string> DeleteCategoryAsync(int id);
    }
}
