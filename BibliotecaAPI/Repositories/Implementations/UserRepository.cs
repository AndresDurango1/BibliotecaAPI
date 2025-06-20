using BibliotecaAPI.Data;
using BibliotecaAPI.DTOs;
using BibliotecaAPI.Exceptions;
using BibliotecaAPI.Models;
using BibliotecaAPI.Repositories.Interfaces;
using Dapper;
using Microsoft.Data.SqlClient;

namespace BibliotecaAPI.Repositories.Implementations
{
    public class UserRepository : IUserRepository
    {
        private readonly DapperContext _dapperContext;
        public UserRepository(DapperContext dapperContext)
        {
            _dapperContext = dapperContext;
        }
        //métodos auxiliares
        private Exception HandleSqlException(SqlException ex, string contextMessage)
        {
            if (ex.Message.Contains("DNI"))
                return new DuplicateDniException(ex.Message);
            else if (ex.Message.Contains("Email"))
                return new DuplicateEmailException(ex.Message);
            else
                return new Exception($"{contextMessage}: {ex.Message}");
        }
        //obtener todos los usuarios
        public async Task<IEnumerable<UserDTO>> GetAllUsersAsync()
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var usuarios = await connection.QueryAsync<UserDTO>("sp_Usuario_ObtenerUsuarios", commandType: System.Data.CommandType.StoredProcedure);
                return usuarios;
            }
        }
        //obtener un usuario por su id
        public async Task<UserDTO?> GetUserByIdAsync(int id)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsUsuario = new DynamicParameters();
                paramsUsuario.Add("@UsuarioId", id);
                try
                {
                    var usuario = await connection.QueryFirstOrDefaultAsync<UserDTO>("sp_Usuario_ObtenerUsuariosPorId", paramsUsuario, commandType: System.Data.CommandType.StoredProcedure);
                    return usuario;
                }
                catch (SqlException ex)
                {
                    throw HandleSqlException(ex, "Error al obtener el usuario");
                }
            }
        }
        //Crear un usuario nuevo
        public async Task<UserDTO?> CreateUserAsync(User user)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsUsuario = new DynamicParameters();
                paramsUsuario.Add("@Nombre", user.Nombre);
                paramsUsuario.Add("@Apellido", user.Apellido);
                paramsUsuario.Add("@DNI", user.DNI);
                paramsUsuario.Add("@Direccion", user.Direccion);
                paramsUsuario.Add("@Email", user.Email);
                paramsUsuario.Add("@Telefono", user.Telefono);
                paramsUsuario.Add("@Contraseña", user.Contrasena);

                try
                {
                    var usuarioNuevo = await connection.QueryFirstOrDefaultAsync<UserDTO>("sp_Usuario_CrearUsuario", paramsUsuario, commandType: System.Data.CommandType.StoredProcedure);
                    return usuarioNuevo;
                }
                catch (SqlException ex)
                {
                    throw HandleSqlException(ex, "Error al crear el usuario");
                }

            }
        }
        //actualizar un usuario
        public async Task<UserDTO?> UpdateUserAsync(User user)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsUsuario = new DynamicParameters();
                paramsUsuario.Add("@UsuarioId", user.UsuarioId);
                paramsUsuario.Add("@Nombre", user.Nombre);
                paramsUsuario.Add("@Apellido", user.Apellido);
                paramsUsuario.Add("@DNI", user.DNI);
                paramsUsuario.Add("@Direccion", user.Direccion);
                paramsUsuario.Add("@Email", user.Email);
                paramsUsuario.Add("@Telefono", user.Telefono);
                paramsUsuario.Add("@Contraseña", user.Contrasena);

                try
                {
                    var usuarioActualizado = await connection.QueryFirstOrDefaultAsync<UserDTO>("sp_Usuario_ActualizarUsuario", paramsUsuario, commandType: System.Data.CommandType.StoredProcedure);
                    return usuarioActualizado;
                }
                catch (SqlException ex)
                {
                    throw HandleSqlException(ex, "Error al actualizar el usuario");
                }

            }
        }
        //eliminar un usuario
        public async Task<string?> DeleteUserAsync(int id)
        {
            using (var connection = _dapperContext.CreateConnection())
            {
                var paramsUsuario = new DynamicParameters();
                paramsUsuario.Add("@UsuarioId", id);

                try
                {
                    var resultado = await connection.QueryFirstOrDefaultAsync<string>("sp_Usuario_EliminarUsuario", paramsUsuario, commandType: System.Data.CommandType.StoredProcedure);
                    return resultado;
                }
                catch (SqlException ex)
                {
                    throw HandleSqlException(ex, "Error al eliminar el usuario");
                }
            }
        }
    }
}
