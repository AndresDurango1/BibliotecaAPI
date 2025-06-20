# 📚 BibliotecaAPI
Una API RESTful desarrollada en **.NET 8** que gestiona recursos de una biblioteca: libros, autores, categorías, editoriales, usuarios y préstamos. Utiliza **Dapper** para la comunicación eficiente con una base de datos SQL Server mediante **procedimientos almacenados**.
---

## 🚀 Funcionalidades principales
- 🔹 CRUD de Libros, Autores, Editoriales, Categorías y Usuarios  
- 🔹 Gestión de Préstamos y Devoluciones  
- 🔹 Uso de **Dapper** para ejecutar procedimientos almacenados  
- 🔹 Arquitectura limpia y modular  
- 🔹 Scripts SQL incluidos para crear tablas y procedimientos  
---

## 🛠️ Tecnologías usadas
- [.NET 8](https://learn.microsoft.com/en-us/dotnet/core/whats-new/dotnet-8)  
- [ASP.NET Core Web API](https://learn.microsoft.com/en-us/aspnet/core/web-api/)  
- [Dapper](https://github.com/DapperLib/Dapper) como micro ORM  
- [SQL Server](https://www.microsoft.com/en-us/sql-server)  
---

## 📁 Estructura del proyecto
BibliotecaAPI/
├── Controllers/ # Controladores HTTP
├── Data / # DapperContext.cs
├── DTOs / # Objetos de transferencia de datos
├── Models/ # Clases de dominio
├── Repositories/ # Acceso a datos con Dapper
├── DatabaseScripts/
│ ├── Tables/ # Scripts CREATE TABLE
│ └── StoredProcedures/ # Stored procedures
├── appsettings.json # Configuración general y conexión
├── Program.cs
└── BibliotecaAPI.csproj
---

## ⚙️ Configuración del entorno
### 1. Clonar el repositorio
```bash
git clone https://github.com/AndresDurango1/BibliotecaAPI.git
cd BibliotecaAPI

### 2. Configurar la cadena de conexión en appsettings.json
"ConnectionStrings": {
  "DefaultConnection": "Server=TU_SERVIDOR;Database=BibliotecaDB;Trusted_Connection=True;TrustServerCertificate=True;"
}
3. Crear base de datos
Abre SQL Server Management Studio

Ejecuta los scripts dentro de la carpeta Scripts/tablas y luego Scripts/procedimientos en orden lógico

▶️ Ejecutar la API
dotnet restore
dotnet build
dotnet run
