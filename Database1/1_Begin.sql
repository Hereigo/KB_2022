 USE Database1_1
 GO

DROP TABLE dbo.Table1
 
IF OBJECT_ID('dbo.Table1') IS NULL
CREATE TABLE dbo.Table1
(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	StartedAt DATETIME NOT NULL,
	MinutesDuration INT NOT NULL
)
GO


-- IF NOT EXISTS(SELECT * FROM SYS.TRIGGERS WHERE NAME='TR_MY_TRIG')
CREATE TRIGGER TR_MY_TRIG on dbo.Table1 INSTEAD OF INSERT
AS
BEGIN
	IF NOT EXISTS (
		SELECT 1 FROM inserted i 
		INNER JOIN dbo.Table1 e
		ON e.StartedAt=i.StartedAt AND e.MinutesDuration=i.MinutesDuration)
	BEGIN
		INSERT INTO dbo.Table1
		(Name, StartedAt, MinutesDuration)
		SELECT [Name], StartedAt, MinutesDuration
		FROM inserted
	END
END
GO

----------------------------------------------------

DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';

INSERT INTO dbo.Table1
(Name, StartedAt, MinutesDuration)
VALUES
('Alex', @MyDate, 30),
('Felix', DATEADD(MINUTE, 10, @MyDate), 30),
('Maxx', DATEADD(MINUTE, 30, @MyDate), 30),
('Trisha', DATEADD(MINUTE, 50, @MyDate), 30)
GO

SELECT * FROM dbo.Table1