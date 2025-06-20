using BibliotecaAPI.CustomExceptions;
using BibliotecaAPI.Data;
using BibliotecaAPI.DTOs;
using BibliotecaAPI.Exceptions;
using BibliotecaAPI.Models;
using BibliotecaAPI.Repositories.Interfaces;
using Dapper;
using Microsoft.Data.SqlClient;

namespace BibliotecaAPI.Repositories.Implementations
{
    public class BookRepository : IBookRepository
    {
        private readonly DapperContext _dapperContext;
        public BookRepository(DapperContext dapperContext)
        {
            _dapperContext = dapperContext;
        }
        //métodos auxiliares
        private Exception HandleSqlException(SqlException ex, string contextMessage)
        {
            if (ex.Message.Contains("No se encontró un Autor"))
                return new NotFoundException(ex.Message);
            else if (ex.Message.Contains("No se encontró una Categoría"))
                return new NotFoundException(ex.Message);
            else if (ex.Message.Contains("No se encontró una Editorial"))
                return new NotFoundException(ex.Message);
            else
                return new Exception($"{contextMessage}: {ex.Message}");
        }

        //obtener todos los libros
        public async Task<IEnumerable<BookDTO>> GetAllBooksAsync()
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var libros = await connection.QueryAsync<BookDTO>("sp_Libro_ObtenerLibros", commandType: System.Data.CommandType.StoredProcedure);
                return libros;
            }
        }
        //obtener un libro por su id
        public async Task<BookDTO?> GetBookByIdAsync(int id)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsLibro = new DynamicParameters();
                paramsLibro.Add("@LibroId", id);
                try
                {
                    var libro = await connection.QueryFirstOrDefaultAsync<BookDTO>("sp_Libro_ObtenerLibroPorId", paramsLibro, commandType: System.Data.CommandType.StoredProcedure);
                    if (libro == null)
                        throw new NotFoundException($"No se encontró un libro con el ID {id}");
                    return libro;
                }
                catch (SqlException ex)
                {
                    throw HandleSqlException(ex, "Error al obtener el libro");
                }
            }
        }
        //crear un libro nuevo
        public async Task<BookDTO?> CreateBookAsync(Book book)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsLibro = new DynamicParameters();
                paramsLibro.Add("@Titulo", book.Titulo);
                paramsLibro.Add("@AnioPublicacion", book.AnioPublicacion);
                paramsLibro.Add("@AutorId", book.AutorId);
                paramsLibro.Add("@CategoriaId", book.CategoriaId);
                paramsLibro.Add("@EditorialId", book.EditorialId);

                try
                {
                    var libroNuevo = await connection.QueryFirstOrDefaultAsync<BookDTO>("sp_Libro_CrearLibro", paramsLibro, commandType: System.Data.CommandType.StoredProcedure);
                    return libroNuevo;
                }
                catch (SqlException ex)
                {
                    throw HandleSqlException(ex, "Error al crear el libro");
                }
            }
        }
        //editar un libro existente
        public async Task<BookDTO?> UpdateBookAsync(Book book)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsLibro = new DynamicParameters();
                paramsLibro.Add("@LibroId", book.LibroId);
                paramsLibro.Add("@Titulo", book.Titulo);
                paramsLibro.Add("@AnioPublicacion", book.AnioPublicacion);
                paramsLibro.Add("@AutorId", book.AutorId);
                paramsLibro.Add("@CategoriaId", book.CategoriaId);
                paramsLibro.Add("@EditorialId", book.EditorialId);

                try
                {
                    var libroActualizado = await connection.QueryFirstOrDefaultAsync<BookDTO>("sp_Libro_ActualizarLibro", paramsLibro, commandType: System.Data.CommandType.StoredProcedure);
                    return libroActualizado;
                }
                catch (SqlException ex)
                {
                    throw HandleSqlException(ex, "Error al actualizar el libro");
                }
            }
        }
        //eliminar un libro
        public async Task<string?> DeleteBookAsync(int id)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsLibros = new DynamicParameters();
                paramsLibros.Add("@LibroId", id);

                try
                {
                    var resultado = await connection.QueryFirstOrDefaultAsync<string>("sp_Libro_EliminarLibro", paramsLibros, commandType: System.Data.CommandType.StoredProcedure);
                    return resultado;
                }
                catch (SqlException ex)
                {
                    throw HandleSqlException(ex, "Error al eliminar el libro");
                }
            }
        }

    }
}
