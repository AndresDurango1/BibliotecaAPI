using BibliotecaAPI.CustomExceptions;
using BibliotecaAPI.Data;
using BibliotecaAPI.Models;
using BibliotecaAPI.Repositories.Interfaces;
using Dapper;
using Microsoft.Data.SqlClient;

namespace BibliotecaAPI.Repositories.Implementations
{
    public class EditorialRepository : IEditorialRepository
    {
        private readonly DapperContext _dapperContext;
        public EditorialRepository(DapperContext dapperContext)
        {
            _dapperContext = dapperContext;
        }
        //obtener todas las editoriales
        public Task<IEnumerable<Editorial>> GetAllEditorialsAsync()
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var editoriales = connection.QueryAsync<Editorial>("sp_Editorial_ObtenerEditoriales", commandType: System.Data.CommandType.StoredProcedure);
                return editoriales;
            }
        }
        //obtener editorial por id
        public Task<Editorial?> GetEditorialByIdAsync(int id)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsEditorial = new DynamicParameters();
                paramsEditorial.Add("@EditorialId", id);

                var editorial = connection.QueryFirstOrDefaultAsync<Editorial>("sp_Editorial_ObtenerEditorialPorId", paramsEditorial, commandType: System.Data.CommandType.StoredProcedure);
                if (editorial == null)
                {
                    throw new NotFoundException($"No se encontró la editorial con ID {id}.");
                }
                return editorial;
            }
        }
        //crear una editorial nueva
        public async Task<Editorial?> CreateEditorialAsync(Editorial editorial)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsEditorial = new DynamicParameters();
                paramsEditorial.Add("@Nombre", editorial.Nombre);
                paramsEditorial.Add("@Pais", editorial.Pais);
                try
                {
                    var editorialNueva = await connection.QueryFirstOrDefaultAsync<Editorial>("sp_Editorial_CrearEditorial", paramsEditorial, commandType: System.Data.CommandType.StoredProcedure);
                    return editorialNueva;
                }
                catch (SqlException ex)
                {
                    if (ex.Message.Contains("Ya existe una editorial con ese Nombre"))
                        throw new ConflictException(ex.Message);
                    else
                        throw new Exception($"Error al crear la categoría: {ex.Message}");
                }
            }
        }
        //actualizar una editorial existente
        public async Task<Editorial?> UpdateEditorialAsync(Editorial editorial)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsEditorial = new DynamicParameters();
                paramsEditorial.Add("@EditorialId", editorial.EditorialId);
                paramsEditorial.Add("@Nombre", editorial.Nombre);
                paramsEditorial.Add("@Pais", editorial.Pais);

                var editorialActualizada = await connection.QueryFirstOrDefaultAsync<Editorial>("sp_Editorial_ActualizarEditorial", paramsEditorial, commandType: System.Data.CommandType.StoredProcedure);
                if (editorialActualizada == null)
                {
                    throw new NotFoundException("No se encontró la categoría para actualizar.");
                }
                return editorialActualizada;
            }
        }
        // eliminar una editorial por id
        public async Task<string> DeleteEditorialAsync(int id)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsEditorial = new DynamicParameters();
                paramsEditorial.Add("@EditorialId", id);
                var resultado = await connection.ExecuteAsync("sp_Editorial_EliminarEditorial", paramsEditorial, commandType: System.Data.CommandType.StoredProcedure);
                if (resultado == 0)
                    throw new NotFoundException($"No se encontró la editorial con ID {id} para eliminar.");
                return "Editorial eliminada correctamente.";
            }
        }
    }
}
