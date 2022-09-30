 USE Database1_1
 GO

DROP TABLE dbo.Table111
 
IF OBJECT_ID('dbo.Table111') IS NULL
CREATE TABLE dbo.Table111
(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	StartedAt DATETIME NOT NULL,
	MinutesDuration INT NOT NULL,
	Comment VARCHAR(30)
)
GO

DROP TRIGGER IF EXISTS dbo.TR_NoIntersectTimeSlot_Table111
GO
CREATE TRIGGER TR_NoIntersectTimeSlot_Table111 on dbo.Table111 
	INSTEAD OF INSERT
AS
BEGIN
	IF NOT EXISTS (
		-- SELECT 1 FROM dbo.Table1 e
		-- WHERE EXISTS (
		--		SELECT 1 FROM INSERTED i
		--		WHERE ...
		SELECT TOP 1 1 
		FROM dbo.INSERTED as i
        INNER JOIN dbo.Table111 AS e ON
			i.StartedAt < DATEADD(MINUTE, e.MinutesDuration, e.StartedAt)
			AND e.StartedAt < DATEADD(MINUTE, i.MinutesDuration, i.StartedAt)
			AND e.Comment = 'Ok'
		)
	BEGIN
		INSERT INTO dbo.Table111
		(Name, StartedAt, MinutesDuration, Comment)
		SELECT Name, StartedAt, MinutesDuration, 'Ok'
		FROM dbo.INSERTED
	END
	
	ELSE
	BEGIN
		INSERT INTO dbo.Table111
		(Name, StartedAt, MinutesDuration, Comment)
		SELECT Name, StartedAt, MinutesDuration, 'Wrong!!!'
		FROM dbo.INSERTED
		-- OR --
		--RAISERROR('Time slot intersect with some other.', 16, 1)
	END
END
GO
----------------------------------------------------
-- TEST
----------------------------------------------------
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.Table111
(Name, StartedAt, MinutesDuration)
VALUES
('Alex', @MyDate, 30)
GO
----------------------------------------------------
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.Table111
(Name, StartedAt, MinutesDuration)
VALUES
('Felix', DATEADD(MINUTE, 10, @MyDate), 30)
GO
----------------------------------------------------
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.Table111
(Name, StartedAt, MinutesDuration)
VALUES
('Maxx', DATEADD(MINUTE, 30, @MyDate), 30)
GO
----------------------------------------------------
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.Table111
(Name, StartedAt, MinutesDuration)
VALUES
('Trisha', DATEADD(MINUTE, 65, @MyDate), 30)
GO
----------------------------------------------------
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.Table111
(Name, StartedAt, MinutesDuration)
VALUES
('Sandra', DATEADD(MINUTE, 30, @MyDate), 30)
GO
----------------------------------------------------
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.Table111
(Name, StartedAt, MinutesDuration)
VALUES
('Daisy', DATEADD(MINUTE, 65, @MyDate), 30)
GO
----------------------------------------------------
DECLARE @MyDate DATETIME = '2022-09-28 12:29:00';
INSERT INTO dbo.Table111
(Name, StartedAt, MinutesDuration)
VALUES
('Catana', DATEADD(MINUTE, 5, @MyDate), 30)
GO
----------------------------------------------------
DECLARE @MyDate DATETIME = '2022-09-28 12:31:00';
INSERT INTO dbo.Table111
(Name, StartedAt, MinutesDuration)
VALUES
('Donald', DATEADD(MINUTE, 5, @MyDate), 30)
GO
----------------------------------------------------
SELECT * FROM dbo.Table111 ORDER BY StartedAt