using BibliotecaAPI.CustomExceptions;
using BibliotecaAPI.Data;
using BibliotecaAPI.DTOs;
using BibliotecaAPI.Models;
using BibliotecaAPI.Repositories.Interfaces;
using Dapper;
using Microsoft.Data.SqlClient;

namespace BibliotecaAPI.Repositories.Implementations
{
    public class CategoryRepository : ICategoryRepository
    {
        private readonly DapperContext _dapperContext;
        public CategoryRepository(DapperContext dapperContext)
        {
            _dapperContext = dapperContext;
        }
        //obtener todas las categorías
        public async Task<IEnumerable<Category>> GetAllCategoriesAsync()
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var categorias = await connection.QueryAsync<Category>("sp_Categoria_ObtenerCategorias", commandType: System.Data.CommandType.StoredProcedure);
                return categorias;
            }
        }
        //obtener categoría por id
        public async Task<Category?> GetCategoryByIdAsync(int id)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsCategoria = new DynamicParameters();
                paramsCategoria.Add("@CategoriaId", id);

                var categoria = await connection.QueryFirstOrDefaultAsync<Category>("sp_Categoria_ObtenerCategoriaPorId", paramsCategoria, commandType: System.Data.CommandType.StoredProcedure);
                if (categoria == null)
                {
                    throw new NotFoundException($"No se encontró la categoría con ID {id}.");
                }
                return categoria;
            }
        }
        //crear una categoría nueva
        public async Task<Category?> CreateCategoryAsync(Category category)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsCategoria = new DynamicParameters();
                paramsCategoria.Add("@Nombre", category.Nombre);
                paramsCategoria.Add("@Descripcion", category.Descripcion);
                try
                {
                    var categoriaNueva = await connection.QueryFirstOrDefaultAsync<Category>("sp_Categoria_CrearCategoria", paramsCategoria, commandType: System.Data.CommandType.StoredProcedure);
                    return categoriaNueva;
                }
                catch (SqlException ex)
                {
                    if (ex.Message.Contains("Ya existe una categoría con ese Nombre"))
                        throw new ConflictException(ex.Message);
                    else
                        throw new Exception($"Error al crear la categoría: {ex.Message}");
                }
            }
        }
        // actualizar una categoría existente

        public async Task<Category?> UpdateCategoryAsync(Category category)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsCategoria = new DynamicParameters();
                paramsCategoria.Add("@CategoriaId", category.CategoriaId);
                paramsCategoria.Add("@Nombre", category.Nombre);
                paramsCategoria.Add("@Descripcion", category.Descripcion);

                var categoriaActualizada = await connection.QueryFirstOrDefaultAsync<Category>("sp_Categoria_ActualizarCategoria", paramsCategoria, commandType: System.Data.CommandType.StoredProcedure);
                if (categoriaActualizada == null)
                {
                    throw new NotFoundException("No se encontró la categoría para actualizar.");
                }
                return categoriaActualizada;
            }
        }
        // eliminar una categoría por id
        public async Task<string> DeleteCategoryAsync(int id)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsCategoria = new DynamicParameters();
                paramsCategoria.Add("@CategoriaId", id);
                var resultado = await connection.ExecuteAsync("sp_Categoria_EliminarCategoria", paramsCategoria, commandType: System.Data.CommandType.StoredProcedure);
                if (resultado == 0)
                    throw new NotFoundException($"No se encontró la categoría con ID {id} para eliminar.");
                return "Categoría eliminada correctamente.";
            }
        }
    }
}
