--Task1

CREATE DATABASE Market
USE Market
CREATE TABLE Products(
id int,
[Name] nvarchar(10),
Price decimal);
ALTER TABLE PRODUCTS
ADD Brand nvarchar(20);
ALTER TABLE PRODUCTS 
ALTER COLUMN [Name] nvarchar(100);
ALTER TABLE PRODUCTS 
ALTER COLUMN Brand nvarchar(100);
INSERT INTO Products(id,[Name],Price,Brand)
VALUES
(1,'Product1',25.00,'Brand1'),
(2,'Product2',50,'Brand1'),
(3,'Product3',100,'Brand2'),
(4,'Product4',130,'Brand3'),
(5,'Product5',200,'Brand4'),
(6,'Product6',500,'Brand5'),
(7,'Product7',250,'Brand6'),
(8,'Product8',1000,'Brand3'),
(9,'Product9',1200,'Brand5'),
(10,'Product10',1500,'Brand4');
DELETE FROM Products WHERE id=1;
SELECT * FROM Products Where Price<(SELECT AVG(Price) FROM Products)
SELECT * FROM Products WHERE Price>200
SELECT Name + ' ' + Brand AS ProductInfo FROM Products WHERE LEN(Brand) > 5;

DROP TABLE Products

--Task2

CREATE DATABASE Department
USE Department
CREATE TABLE Employee
(
Id int primary key identity,
[Name] nvarchar(255) NOT NULL,
Age int NOT NULL CHECK (Age>0),
Email nvarchar(100) NOT NULL UNIQUE,
Salary decimal NOT NULL CHECK(Salary>300.00 AND Salary<2000.00));
EXEC sp_rename 'Employee.[Name]', 'Fullname', 'COLUMN';
INSERT INTO Employee (Fullname, Age, Email, Salary) 
VALUES
    ('Rasim abbasov', 30, 'rasim.abbasov@example.com', 1500.00),
    ('Alex Twen', 25, 'alex.twen@example.com', 1800.00),
    ('Smith Johnson', 35, 'smith.johnson@example.com', 1200.00),
    ('Emily Peterson', 28, 'emily.peterson@example.com', 1700.00),
    ('Michael Statham', 40, 'michael.statham@example.com', 1000.00);
	SELECT * FROM Employee
	UPDATE Employee
    SET Salary = Salary+200
    WHERE Salary<1500;
	DELETE FROM EMPLOYEE WHERE Salary<1500

	DROP TABLE Employee


	--Task3

	CREATE DATABASE Relations
	USE Relations
	--One to One
	CREATE TABLE Persons
	(
	 Id int primary key identity,
	 FirstName nvarchar(20) NOT NULL,
	 LastName nvarchar(20) NOT NULL
	);
	INSERT INTO Persons(FirstName,LastName)
	VALUES('Rasim','Abbasov')
	SELECT * FROM Persons

	CREATE TABLE Passport
	(
	 Passport_id int primary key identity,
	 Passport_number int,
	 Valid_date date,
	 Person_id int foreign key references Persons(Id)
	);
	INSERT INTO Passport(Passport_number,Person_id)
	VALUES(12,2)
	SELECT * FROM Passport

	--One to Many
	CREATE TABLE Stores
	(
	 StoreId int primary key identity,
	 StoreName nvarchar(20) NOT NULL
	);
	INSERT INTO Stores(StoreName)
	VALUES('Dominos')
	CREATE TABLE Customers(
	CustomerId int primary key identity,
	CustomerName nvarchar(20),
	ContactInfo int,
	store_Id int foreign key references Stores(StoreId)
	);
    INSERT INTO Customers(CustomerName,ContactInfo,store_Id)
	VALUES('Rasim Abbasov',0554270082,1);
	SELECT * FROM Stores
	CREATE TABLE Orders
	(
	 OrderId int primary key identity,
	 OrderDate date,
	 customer_Id int foreign key references Customers(CustomerId)
	);
	INSERT INTO Orders(OrderName,customer_Id)
	VALUES('Order1a',1)
	ALTER TABLE Orders
	ADD OrderName nvarchar(20);
	SELECT * FROM Orders

	--Many to Many
	CREATE TABLE Departments
	(
	 Department_Id int primary key identity,
	 DepartmentName nvarchar(20)
	);
	INSERT INTO Departments(DepartmentName)
	VALUES ('Software Development');
	CREATE TABLE Projects
	(
	 Project_Id int primary key identity,
	 ProjectName nvarchar(20)
	);
	INSERT INTO Projects(ProjectName)
	VALUES ('Project1');
	CREATE TABLE DepartmentProjects
    (
	 Id int primary key identity,
	 department_id int foreign key references Departments(Department_Id),
     project_id int foreign key references Projects(Project_Id)
	);
	INSERT INTO DepartmentProjects(department_id,project_id)
	VALUES (1,1)
    SELECT * FROM DepartmentProjects


    --Task4
	CREATE DATABASE [Library]
	USE [Library]
    CREATE TABLE Libraries (
    Library_id int primary key identity,
    Library_name nvarchar(100) NOT NULL
    );

    CREATE TABLE Genres (
    genre_id int primary key identity,
    genre_name nvarchar(50) NOT NULL
    );
	CREATE TABLE Authors(
	AuthorId int primary key identity,
	FirstName NVARCHAR(100) NOT NULL,
	LastName NVARCHAR(100) NOT NULL,
	BirthDate DATE
	);

    CREATE TABLE Books (
    book_id int primary key identity,
    Title NVARCHAR(100) NOT NULL,
	PublicationYear DATE,
    author_id INT,
    genre_id INT,
    library_id INT,
	FOREIGN KEY(author_id) REFERENCES Authors(AuthorId),
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id),
    FOREIGN KEY (library_id) REFERENCES Libraries(library_id)
);

CREATE TABLE library_Books (
    lib_book_id int primary key identity,
    library_id INT NOT NULL,
    book_id INT NOT NULL,
    FOREIGN KEY (library_id) REFERENCES Libraries(Library_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Users (
    User_id int primary key identity,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    RegistrationDate DATE
    );
    CREATE TABLE UserDetails(
    Id int primary key identity,
    Email NVARCHAR(50) NOT NULL,
    PhoneNumber NVARCHAR(50) NOT NULL,
    [Address] NVARCHAR(50) NOT NULL,
	BirthDate DATE,
	user_id INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES Users(User_id)
	);

    CREATE TABLE Loan (
    loan_id int primary key identity,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    loan_date DATE DEFAULT GETDATE(),
    due_date DATE,
    return_date DATE,
    loan_status bit,
    FOREIGN KEY (user_id) REFERENCES Users(User_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);
