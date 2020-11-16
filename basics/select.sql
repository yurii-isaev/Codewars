-- Имя сервера.
SELECT @@SERVICENAME;

-- Выбрать все имеющиеся базы данных.
SELECT *
FROM sys.databases
GO

-- Выбрать в выбранную базу данных
USE AdventureWorks2014;

-- Выбрать все имеющиеся таблицы текущей базу данных.
SELECT *
FROM sys.tables
GO

-- Выбрать все схемы и таблицы текущей базу данных с использованием псевдонимов столбцов.
-- SCHEMA_NAME - системная функция.
SELECT SCHEMA_NAME(schema_id) AS Схема,
       name                   AS Таблица
FROM sys.tables
GO

-- Выбрать все поля из таблицы Product схемы Production текущей базу данных.
SELECT *
FROM AdventureWorks2014.Production.Product
GO

-- Выбрать некоторые поля (название товара, себестоимость, отпускная цена > 0) из таблицы Product.
SELECT Name, StandardCost, ListPrice
FROM Production.Product
WHERE ListPrice > 0
GO

-- Выбрать столбцы по идентификатору.
SELECT $ Identity
FROM Production.Product
GO

-- Выбрать столбцы по идентификатору GUID.
SELECT $Rowguid
FROM Production.Product
GO

-- Выбрать некоторые поля: название товара, себестоимость, (отпускная цена > 0) из таблицы Product.
SELECT Name                     AS Название,
       N'Товар Adventure Works' AS Статус,
       StandardCost             AS Себестоимость,
       ListPrice                AS Отпускная_цена
FROM Production.Product
WHERE ListPrice > 0
GO

SELECT Название       = Name,
       Статус         = N'Товар Adventure Works',
       Себестоимость  = StandardCost,
       Отпускная_цена = ListPrice
FROM Production.Product
WHERE ListPrice > 0
GO

SELECT Name                     Название,
       N'Товар Adventure Works' Статус,
       StandardCost             Себестоимость,
       ListPrice                Отпускная_цена
FROM Production.Product
WHERE ListPrice > 0
GO

-- Выбрать некоторые поля: название товара, отпускная цена, наценка, себестоимость > 0.
SELECT Name,
       StandardCost,
       ListPrice,
       (ListPrice - Product.StandardCost) / Product.StandardCost AS Наценка -- в числовом формате
FROM Production.Product
WHERE StandardCost > 0
GO

-- Использование функций в вычислительных выражениях.
SELECT Name,
       StandardCost,
       ListPrice,
       FORMAT((ListPrice - Product.StandardCost) / Product.StandardCost, '0.00%') AS Наценка, -- в процентном формате
       YEAR(SellStartDate)                                                        AS Год_выпуска
FROM Production.Product
WHERE StandardCost > 0
GO

/* Строковые операторы + конкатенация
   Функции IsNull, Concat
*/
-- Выбрать полное имя пользователя в столбце ФИО из таблицы Person.
SELECT FirstName + ' ' + MiddleName + ' ' + LastName AS ФИО
FROM Person.Person
GO

-- Некорректный вывода при MiddleName равно Null.
SELECT FirstName, MiddleName, LastName + ' ' + MiddleName + ' ' + LastName AS ФИО
FROM Person.Person
GO

-- Функция IsNull позволит не возвращать значение Null для тех записей, у которых MiddleName равно Null.
SELECT FirstName + IsNull(' ' + MiddleName, '') + ' ' + LastName AS ФИО
FROM Person.Person
GO

-- Функция Concat в отличии от оператора +, заменяет входящее значение Null пустой строкой.
SELECT Concat(FirstName, ' ' + MiddleName, ' ' + LastName) AS ФИО
FROM Person.Person
GO

-- Выбрать все названия цветов из таблицы Product.
SELECT Color
FROM Production.Product
GO

-- Аналогичный запрос предыдущему.
SELECT ALL Color
FROM Production.Product
GO

-- Ключевые слова DISTINCT и All в предложении SELECT
-- Выбрать уникальные названия цветов из таблицы Product
SELECT DISTINCT Color
FROM Production.Product
GO

-- Выбрать три самых дорогих товара относительно списка.
SELECT TOP (3) Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC
GO

-- Выбрать три самых дорогих товара относительно одной цены.
SELECT TOP (3) WITH TIES Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC
GO

-- Выбрать 3% самых дорогих товаров относительно всех имеющихся товаров (504*0,03 = 15,12 ~> 16).
SELECT TOP (3) PERCENT Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC
GO
