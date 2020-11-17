USE AdventureWorks2014;

-- Выбрать все поля из таблицы Product схемы Production текущей базу данных.
SELECT *
FROM AdventureWorks2014.Production.Product
GO

-- Выбрать поля: Name, Weight, Color из таблицы Product.
SELECT Name, Weight, Color
FROM Production.Product
GO

-- Выбрать поля: Name, Weight, Color, и присвоить всеи полям красный цвет из таблицы Product.
SELECT Name, Weight, Color = 'Red'
FROM Production.Product
GO

-- Выбрать поля: Name, Weight, Color, где цвет красный из таблицы Product.
SELECT Name, Weight, Color
FROM Production.Product
WHERE Color = 'Red'
GO
--38

-- Выбрать поля: Name, Weight, Color, где цвет не красный из таблицы Product.
SELECT Name, Weight, Color
FROM Production.Product
WHERE Color <> 'Red'
GO
--218
-- Запрос работает не корректно, поскольку работает тернарная логика, а не бинарная.
-- Если значение цвета отсутствует (значение = NULL), то сравнение Color <> 'Red' (NULL <> 'Red')
-- возвращает не значение TRUE, а неизвестное значение UNKNOWN.

-- Запрос работает корректно.
SELECT Name, Weight, Color
FROM Production.Product
WHERE Color <> 'Red'
   OR Color IS NULL
GO
--466

-- Запрос c использованием оператора EXCEPT (фактически разность наборов).
SELECT Name, Weight, Color
FROM Production.Product
EXCEPT
SELECT Name, Weight, Color
FROM Production.Product
WHERE Color = 'Red'
GO
--466

-- Выбрать поля: Name, ListPrice, SellStartDate, для товаров выпущенных после 2010 года.
SELECT Name,
       ListPrice,
       YEAR(SellStartDate) AS Год_выпуска
FROM Production.Product
WHERE YEAR(SellStartDate) > 2010
GO

-- Выбрать поля: Name, ListPrice, SellStartDate, с указанием предыдущего года выпуска.
SELECT Name,
       ListPrice,
       YEAR(SellStartDate)     AS Год_выпуска,
       YEAR(SellStartDate) - 1 AS Предыдущий_год
FROM Production.Product
GO

-- Выбрать наименования и вес всех продуктов, у которых известен вес, упорядоченных по убыванию.
SELECT Name, Weight, Color
FROM Production.Product
WHERE Weight IS NOT NULL
ORDER BY Weight DESC
GO

-- Выбрать наименования и вес всех продуктов, у которых неизвестен цвет и известен вес, упорядоченных по убыванию.
SELECT Name, Weight, Color
FROM Production.Product
WHERE Color IS NULL
  AND Weight IS NOT NULL
ORDER BY Weight DESC
GO

-- Выбрать наименования и вес всех продуктов, у которых неизвестен цвет красный или вес больше 1000.
SELECT Name, Weight, Color
FROM Production.Product
WHERE Color = 'Red'
   OR Weight > 1000
ORDER BY Weight DESC
GO

-- Логический оператор NOT рекомендуется только для выражений с полями NOT NULL.
-- Выбрать товары, дата начала продаж которых не 2012 год.
SELECT Name, SellStartDate AS Начало_продаж
FROM Production.Product
WHERE NOT (SellStartDate >= '20120101' AND SellStartDate < '20130101')
GO

-- Логический оператор  BETWEEN рекомендуется для нахождения диапозонов.
-- Выбрать товары, вес которых от 100 до 200 включительно, упорядоченных по возрастанию.
SELECT Name, Weight, Color
FROM Production.Product
WHERE Weight BETWEEN 100 AND 200
ORDER BY Weight
GO

-- Запрос c использованием оператора AND.
SELECT Name, Weight, Color
FROM Production.Product
WHERE Weight >= 100
  AND Weight <= 200
ORDER BY Weight
GO

-- Выбрать товары по трем цветами и сгруппированных по выбранным цветам и весу.
SELECT Name, Weight, Color
FROM Production.Product
WHERE Color IN ('Red', 'Yellow', 'Blue')
ORDER BY Color, Weight DESC
GO

-- Аналогичный запрос с использованием оператора OR.
SELECT Name, Weight, Color
FROM Production.Product
WHERE Color = 'Red'
   OR Color = 'Yellow'
   OR Color = 'Blue'
ORDER BY Color, Weight DESC
GO

-- Аналогичный запрос с использованием оператора UNION SELECT.
SELECT Name, Weight, Color
FROM Production.Product
WHERE Color = ANY (SELECT 'Red' UNION SELECT 'Yellow' UNION SELECT 'Blue')
ORDER BY Color, Weight DESC
GO

-- Выбрать товары цвета которых превышают алфавитный порядок существующих цветов.
SELECT Name, Weight, Color
FROM Production.Product
WHERE Color > ANY (SELECT 'Red' UNION SELECT 'Yellow' UNION SELECT 'Blue')
ORDER BY Color, Weight DESC
GO

-- Выбрать людей фамилии которых начинается на букву Z.
SELECT LastName, MiddleName, FirstName
FROM Person.Person
WHERE LastName LIKE 'Z%'
GO

-- Выбрать людей фамилии которых вторым символом является буква Z.
SELECT LastName, MiddleName, FirstName
FROM Person.Person
WHERE LastName LIKE '_Z%'
GO

-- Выбрать людей фамилии которых начинаются с на Es или Is.
SELECT LastName, MiddleName, FirstName
FROM Person.Person
WHERE LastName LIKE '[EI][S]%'
GO

-- Выбрать людей фамилии которых начинаются с букв отличных от диапозона A-P.
SELECT LastName, MiddleName, FirstName
FROM Person.Person
WHERE LastName LIKE '[^A-P]%'
GO
