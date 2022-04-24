------------- stored procedure -------------

CREATE TABLE [dbo].[Customer](
       [customer_id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	   [name] [varchar](20) NOT NULL,
	   [date_of_birth] date NOT NULL,
	   [gender] varchar(20) NOT NULL,
	   [address] [varchar](55) NOT NULL,
       	   [city] [varchar](20) NOT NULL,
           [state] [varchar](20) NOT NULL,
           [phone] [int] NOT NULL
 
) 
--create --

IF OBJECT_ID('cusp_CustomerCreate') IS NOT NULL
BEGIN 
DROP PROC usp_CustomerCreate 
END
GO
CREATE PROCEDURE usp_CustomerCreate
	   @name varchar(20),
	   @date_of_birth date,
	   @gender varchar(20)
	   @address varchar(55),
	   @city	varchar(20),
	   @state	varchar(20),
	   @phone int
	 
AS
BEGIN
INSERT INTO Customer  (
	   name,
	   date_of_birth,
	   gender,
	   address,
	   city,
	   state,
	   phone)
    VALUES (
	   @name,
	   @date_of_birth,
	   @gender,
	   @address,
	   @city,
	   @state,
	   @phone)
 
SET @CustomerID = SCOPE_IDENTITY()
 
SELECT 
	   name = @name,
	   date_of_birth = @date_of_birth,
	   gender = @gender,
	   address = @address,
	   city	= @city,
	   state = @state,
	   phone =@phone
FROM Customer 
WHERE  customer_id = @customer_id
END

--read--

IF OBJECT_ID('cusp_CustomerRead') IS NOT NULL
BEGIN 
    DROP PROC cusp_CustomerRead
END 
GO
CREATE PROC cusp_CustomerRead
    @customer_id int
AS 
BEGIN 
 
    SELECT customer_id, name, date_of_birth, gender, address, city, state, phone
    FROM   Customer  
    WHERE  (customer_id = @customer_id) 
END
GO


--update--

IF OBJECT_ID('cusp_CustomerUpdate') IS NOT NULL
BEGIN 
DROP PROC cusp_CustomerUpdate
END 
GO
CREATE PROC cusp_CustomerUpdate
    @customer_id int,
    @name varchar(20),
    @date_of_birth date,
    @gender varchar(20),
    @address varchar(55),
    @city varchar(20),
    @state varchar(20),
    @phone int
  
AS 
BEGIN 
 
UPDATE Customer
SET  name = @name,
		date_of_birth = @date_of_birth,
		gender = @gender,
	   address = @address,
	   city	= @city,
	   state = @state,
	   phone =@phone
WHERE  customer_id = @customer_id
END
GO


--delete--

IF OBJECT_ID('cusp_CustomerDelete') IS NOT NULL
BEGIN 
DROP PROC cusp_CustomerDelete
END 
GO
CREATE PROC cusp_CustomerDelete 
    @customer_id int
AS 
BEGIN 
DELETE
FROM   Customer
WHERE  customer_id = @customer_id
 
END
GO
