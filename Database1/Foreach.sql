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
-- SELECT * FROM dbo.TableForTests
--------------------------------
-- FOREACH implementation :
--------------------------------
DECLARE @PrevNumb int;
DECLARE @CurrentNumb int;
DECLARE @Text varchar(30);

SELECT TOP 1 @CurrentNumb = UserId, @Text = UserName FROM dbo.TableForTests 
	ORDER BY UserId

WHILE @CurrentNumb IS NOT NULL
BEGIN
	PRINT(CONCAT('Number=',@CurrentNumb,' Text=',@Text));

	SELECT @PrevNumb = @CurrentNumb, @CurrentNumb = NULL, @Text = NULL;

	SELECT TOP 1 @CurrentNumb = UserId, @Text = UserName 
	FROM dbo.TableForTests 
	WHERE @CurrentNumb > @PrevNumb
	ORDER BY UserId
END
GO
