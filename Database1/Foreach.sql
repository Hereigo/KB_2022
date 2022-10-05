USE Database1_1
GO

DROP TABLE dbo.TableForTests

CREATE TABLE dbo.TableForTests
(
	UserId INT NOT NULL IDENTITY PRIMARY KEY,
	UserName VARCHAR(30) NOT NULL
)
GO

INSERT INTO dbo.TableForTests (UserName)
VALUES
('Alex'),('Felix'),('Max'),('Sandy'),('Daisy'),('Catana')
GO

--------------------------------
-- FOREACH implementation :
--------------------------------

DECLARE @PrevNum int;
DECLARE @CurrentNum int;
DECLARE @User varchar(30);

SELECT TOP 1 @CurrentNum = UserId, @User = UserName 
FROM dbo.TableForTests 
ORDER BY UserId

WHILE @CurrentNum IS NOT NULL
BEGIN
	PRINT(CONCAT('User: ', @User, ' has ID = ', @CurrentNum))

	SELECT 
		@PrevNum = @CurrentNum,
		@User = NULL,
		@CurrentNum = NULL
		
	SELECT TOP 1 @CurrentNum = UserId, @User = UserName
	FROM dbo.TableForTests 
	WHERE UserId > @PrevNum
	ORDER BY UserId
END
