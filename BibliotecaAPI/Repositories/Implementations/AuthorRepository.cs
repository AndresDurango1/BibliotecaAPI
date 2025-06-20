using BibliotecaAPI.CustomExceptions;
using BibliotecaAPI.Data;
using BibliotecaAPI.DTOs;
using BibliotecaAPI.Exceptions;
using BibliotecaAPI.Models;
using BibliotecaAPI.Repositories.Interfaces;
using Dapper;
using Microsoft.Data.SqlClient;
using System.Data;

namespace BibliotecaAPI.Repositories.Implementations
{
    public class AuthorRepository : IAuthorRepository
    {
        private readonly DapperContext _dapperContext;
        public AuthorRepository(DapperContext dapperContext)
        {
            _dapperContext = dapperContext;
        }
        //métodos auxiliares
        private Exception HandleSqlException(SqlException ex, string contextMessage)
        {
            if (ex.Message.Contains("No se encontró"))
                return new NotFoundException(ex.Message);
            else
                return new Exception($"{contextMessage}: {ex.Message}");
        }
        //obtener todos los autores
        public async Task<IEnumerable<AuthorDTO>> GetAllAuthorsAsync()
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var autores = await connection.QueryAsync<AuthorDTO>("sp_Autor_ObtenerAutores", commandType: System.Data.CommandType.StoredProcedure);
                return autores;
            }
        }
        //obtener un autor por id
        public async Task<AuthorDTO?> GetAuthorByIdAsync(int id)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsAutor = new DynamicParameters();
                paramsAutor.Add("@AutorId", id);
                try
                {
                    var autor = await connection.QueryFirstOrDefaultAsync<AuthorDTO>("sp_Autor_ObtenerAutorPorId", paramsAutor, commandType: System.Data.CommandType.StoredProcedure);
                    return autor;
                }
                catch (SqlException ex)
                {
                    throw HandleSqlException(ex, "Error al obtener el autor");
                }
            }

        }
        //crear un autor nuevo
        public async Task<AuthorDTO?> CreateAuthorAsync(Author author)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsAutor = new DynamicParameters();
                paramsAutor.Add("@Nombre", author.Nombre);
                paramsAutor.Add("@Apellido", author.Apellido);
                paramsAutor.Add("@AnioNacimiento", author.AnioNacimiento);
                paramsAutor.Add("@Nacionalidad", author.Nacionalidad);

                try
                {
                    var autorNuevo = await connection.QueryFirstOrDefaultAsync<AuthorDTO>("sp_Autor_CrearAutor", paramsAutor, commandType: System.Data.CommandType.StoredProcedure);
                    return autorNuevo;
                }
                catch (SqlException ex)
                {
                    throw HandleSqlException(ex, "Error al crear el autor");
                }
            }
        }
        //actualizar un autor
        public async Task<AuthorDTO?> UpdateAuthorAsync(Author author)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsAutor = new DynamicParameters();
                paramsAutor.Add("@AutorId", author.AutorId);
                paramsAutor.Add("@Nombre", author.Nombre);
                paramsAutor.Add("@Apellido", author.Apellido);
                paramsAutor.Add("@AnioNacimiento", author.AnioNacimiento);
                paramsAutor.Add("@Nacionalidad", author.Nacionalidad);

                try
                {
                    var autorActualizado = await connection.QueryFirstOrDefaultAsync<AuthorDTO>("sp_Autor_ActualizarAutor", paramsAutor, commandType: System.Data.CommandType.StoredProcedure);
                    return autorActualizado;
                }
                catch (SqlException ex)
                {
                    throw HandleSqlException(ex, "Error al actualizar el autor");
                }
            }
        }
        //eliminar un autor
        public async Task<string?> DeleteAuthorAsync(int id)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsAutor = new DynamicParameters();
                paramsAutor.Add("@AutorId", id);

                try
                {
                    var filas = await connection.QueryFirstOrDefaultAsync<int>("sp_Autor_EliminarAutor", paramsAutor, commandType: CommandType.StoredProcedure);
                    return filas > 0 ? "Autor eliminado correctamente." : null;
                }
                catch (SqlException ex)
                {
                    throw HandleSqlException(ex, "Error al eliminar el autor");
                }
            }
        }
    }
}
