using BibliotecaAPI.DTOs;
using BibliotecaAPI.Models;

namespace BibliotecaAPI.Repositories.Interfaces
{
    public interface ILoanRepository
    {
        //Método asincrónico para obtener todos los préstamos
        Task<IEnumerable<LoanDTO>> GetAllLoansAsync();
        //Método asincrónico para obtener un préstamo por su id
        Task<LoanDTO?> GetLoanByIdAsync(int id);
        //Método asincrónico para crear un préstamo nuevo
        Task<LoanDTO?> CreateLoanAsync(Loan loan);
        //Metodo asincrónico para actualizar un prestamo
        Task<LoanDTO?> UpdateLoanAsync(Loan loan);
        //Metodo asincrónico para eliminar un préstamo
        Task<string> DeleteLoanAsync(int id);
        //Metodo para renovar un prestamo
        Task<string> RenewLoanAsync(int prestamoId);
    }
}