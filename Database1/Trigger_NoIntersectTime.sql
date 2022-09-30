 USE Database1_1
 GO

DROP TABLE dbo.Table1
 
IF OBJECT_ID('dbo.Table1') IS NULL
CREATE TABLE dbo.Table1
(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	StartedAt DATETIME NOT NULL,
	MinutesDuration INT NOT NULL,
	Comment VARCHAR(30)
)
GO

DROP TRIGGER IF EXISTS dbo.TR_NoIntersectTimeSlot_Table1
GO
CREATE TRIGGER TR_NoIntersectTimeSlot_Table1 on dbo.Table1 INSTEAD OF INSERT
AS
BEGIN
	IF NOT EXISTS (
		SELECT 1 FROM dbo.Table1 e
		WHERE EXISTS (
			SELECT 1 FROM INSERTED i
			WHERE
				i.StartedAt < DATEADD(MINUTE, e.MinutesDuration, e.StartedAt)
				AND e.StartedAt < DATEADD(MINUTE, i.MinutesDuration, i.StartedAt)
				AND e.Comment = 'Ok'
			)
	) 
	BEGIN
		INSERT INTO dbo.Table1
		(Name, StartedAt, MinutesDuration, Comment)
		SELECT Name, StartedAt, MinutesDuration, 'Ok'
		FROM INSERTED
	END
	
	ELSE
	BEGIN
		INSERT INTO dbo.Table1
		(Name, StartedAt, MinutesDuration, Comment)
		SELECT Name, StartedAt, MinutesDuration, 'Wrong!!!'
		FROM INSERTED
		-- OR --
		--RAISERROR('Time slot intersect with some other.', 16, 1)
	END
END
GO
----------------------------------------------------

----------------------------------------------------
-- TEST
----------------------------------------------------
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.Table1
(Name, StartedAt, MinutesDuration)
VALUES
('Alex', @MyDate, 30)
GO
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.Table1
(Name, StartedAt, MinutesDuration)
VALUES
('Felix', DATEADD(MINUTE, 10, @MyDate), 30)
GO
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.Table1
(Name, StartedAt, MinutesDuration)
VALUES
('Maxx', DATEADD(MINUTE, 30, @MyDate), 30)
GO
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.Table1
(Name, StartedAt, MinutesDuration)
VALUES
('Trisha', DATEADD(MINUTE, 65, @MyDate), 30)
GO
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.Table1
(Name, StartedAt, MinutesDuration)
VALUES
('Sandra', DATEADD(MINUTE, 30, @MyDate), 30)
GO
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.Table1
(Name, StartedAt, MinutesDuration)
VALUES
('Daisy', DATEADD(MINUTE, 65, @MyDate), 30)
GO
DECLARE @MyDate DATETIME = '2022-09-28 12:29:00';
INSERT INTO dbo.Table1
(Name, StartedAt, MinutesDuration)
VALUES
('Catana', DATEADD(MINUTE, 5, @MyDate), 30)
GO
DECLARE @MyDate DATETIME = '2022-09-28 12:31:00';
INSERT INTO dbo.Table1
(Name, StartedAt, MinutesDuration)
VALUES
('Donald', DATEADD(MINUTE, 5, @MyDate), 30)
GO

SELECT * FROM dbo.Table1 ORDER BY StartedAt