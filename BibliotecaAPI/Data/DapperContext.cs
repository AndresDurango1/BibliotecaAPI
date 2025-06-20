using Microsoft.Data.SqlClient;
using System.Data;

namespace BibliotecaAPI.Data
{
    public class DapperContext
    {
        private readonly IConfiguration _configuration;
        private readonly string _connectionString;

        public DapperContext(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("DefaultConnection") ??
                throw new InvalidOperationException("La cadena de conexión 'DefaultConnection' no se encontró en el archivo de configuración.");
        }
        public IDbConnection CreateConnection() => new SqlConnection(_connectionString);
    }
}
