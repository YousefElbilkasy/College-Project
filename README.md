# College Management System

A comprehensive web-based College Management System built with ASP.NET Web Forms, designed to streamline academic operations and enhance communication between administrators, professors, and students.

## 🚀 Features

### Administrative Dashboard
- Manage student enrollments and academic records
- Handle professor and assistant professor profiles
- Course management and assignment
- Automated timetable generation
- User verification system

### Professor Portal
- Track student attendance
- Manage assignments and course materials
- Monitor student performance
- View and manage teaching schedule

### Student Portal
- View and track attendance
- Access and submit assignments
- View personal timetable
- Course enrollment management
- Track academic progress

## 🛠️ Technologies Used

- **Backend:** ASP.NET Web Forms, C#
- **Frontend:** HTML5, CSS3, JavaScript, jQuery
- **Database:** SQL Server
- **UI Framework:** Bootstrap
- **Authentication:** ASP.NET Identity

## 📋 Prerequisites

- Visual Studio 2019 or later
- SQL Server 2014 or later
- .NET Framework 4.7.2 or later
- IIS Express (comes with Visual Studio)

## ⚙️ Setup and Installation

1. **Clone the Repository**
   ```bash
   git clone [repository-url]
   ```

2. **Database Setup**
   - Open SQL Server Management Studio
   - Create a new database
   - Execute the SQL scripts provided in the `Queries` folder

3. **Configure Connection String**
   - Open `Web.config`
   - Update the connection string with your database details

4. **Open in Visual Studio**
   - Open `WebApplication3.sln`
   - Restore NuGet packages
   - Build the solution

5. **Run the Application**
   - Press F5 or click the IIS Express button in Visual Studio
   - The application will launch in your default browser

## 👥 User Roles

1. **Administrator**
   - Full system access
   - Manage all users and courses
   - Generate and modify timetables
   - Handle user verification

2. **Professor**
   - Manage assigned courses
   - Track student attendance
   - Create and grade assignments
   - View teaching schedule

3. **Student**
   - View enrolled courses
   - Check attendance
   - Submit assignments
   - Access course materials

## 🔒 Security Features

- Role-based access control
- Secure authentication
- Password encryption
- Session management
- Input validation and sanitization

## 🔧 Project Structure

```
WebApplication3/
├── Default.aspx          # Landing page
├── Layout.Master         # Master page template
├── admin_dashboard/      # Admin portal files
├── css/                  # Stylesheets
├── imgs/                 # Image assets
├── bin/                  # Compiled assemblies
└── Queries/             # Database scripts
```

## 📝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## ⚖️ License

This project is licensed under the MIT License - see the LICENSE file for details

## 📧 Contact

Your Name - [your-email@example.com]

Project Link: [https://github.com/yourusername/college-management-system]

## 🙏 Acknowledgments

- ASP.NET Web Forms Documentation
- Bootstrap Templates
- jQuery Community
- Stack Overflow Community
