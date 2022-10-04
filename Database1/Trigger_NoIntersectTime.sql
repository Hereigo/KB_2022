 USE Database1_1
 GO

DROP TABLE dbo.TableForTests
 
IF OBJECT_ID('dbo.TableForTests') IS NULL
CREATE TABLE dbo.TableForTests
(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	UserName VARCHAR(30) NOT NULL,
	StartedAt DATETIME NOT NULL,
	MinutesDuration INT NOT NULL,
	Comment VARCHAR(30)
)
GO

DROP TRIGGER IF EXISTS dbo.TR_NoIntersectTimeSlot_TableForTests
GO
CREATE TRIGGER TR_NoIntersectTimeSlot_TableForTests on dbo.TableForTests 
	INSTEAD OF INSERT
AS
BEGIN
	IF NOT EXISTS (
		SELECT TOP 1 1 
		FROM INSERTED as i
        INNER JOIN dbo.TableForTests AS e
			ON i.StartedAt < DATEADD(MINUTE, e.MinutesDuration, e.StartedAt)
			AND e.StartedAt < DATEADD(MINUTE, i.MinutesDuration, i.StartedAt)
			AND e.Comment = 'Ok'
		)
	BEGIN
		INSERT INTO dbo.TableForTests
		(UserName, StartedAt, MinutesDuration, Comment)
		SELECT UserName, StartedAt, MinutesDuration, 'Ok'
		FROM INSERTED
	END
	
	ELSE
	BEGIN
		INSERT INTO dbo.TableForTests
		(UserName, StartedAt, MinutesDuration, Comment)
		SELECT UserName, StartedAt, MinutesDuration, 'Wrong!!!'
		FROM INSERTED
		-- OR --
		-- RAISERROR('Time slot intersect with some other.', 16, 1)
	END
END
GO
----------------------------------------------------
-- TEST
----------------------------------------------------
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.TableForTests
(UserName, StartedAt, MinutesDuration)
VALUES
('Alex', @MyDate, 30)
GO
----------------------------------------------------
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.TableForTests
(UserName, StartedAt, MinutesDuration)
VALUES
('Felix', DATEADD(MINUTE, 10, @MyDate), 30)
GO
----------------------------------------------------
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.TableForTests
(UserName, StartedAt, MinutesDuration)
VALUES
('Maxx', DATEADD(MINUTE, 30, @MyDate), 30)
GO
----------------------------------------------------
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.TableForTests
(UserName, StartedAt, MinutesDuration)
VALUES
('Trisha', DATEADD(MINUTE, 65, @MyDate), 30)
GO
----------------------------------------------------
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.TableForTests
(UserName, StartedAt, MinutesDuration)
VALUES
('Sandra', DATEADD(MINUTE, 30, @MyDate), 30)
GO
----------------------------------------------------
DECLARE @MyDate DATETIME = '2022-09-28 11:00:00';
INSERT INTO dbo.TableForTests
(UserName, StartedAt, MinutesDuration)
VALUES
('Daisy', DATEADD(MINUTE, 65, @MyDate), 30)
GO
----------------------------------------------------
DECLARE @MyDate DATETIME = '2022-09-28 12:29:00';
INSERT INTO dbo.TableForTests
(UserName, StartedAt, MinutesDuration)
VALUES
('Catana', DATEADD(MINUTE, 5, @MyDate), 30)
GO
----------------------------------------------------
DECLARE @MyDate DATETIME = '2022-09-28 12:31:00';
INSERT INTO dbo.TableForTests
(UserName, StartedAt, MinutesDuration)
VALUES
('Donald', DATEADD(MINUTE, 5, @MyDate), 30)
GO
----------------------------------------------------
SELECT * FROM dbo.TableForTests ORDER BY StartedAt