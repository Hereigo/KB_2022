 USE Database1_1
 GO
 
 IF OBJECT_ID('[dbo].[Table1]') IS NULL
CREATE TABLE [dbo].[Table1]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[Name] VARCHAR NOT NULL,
	[StartedAt] DATETIME NOT NULL,
	[MinutesDuration] INT NOT NULL
)
GO

 SELECT * FROM Table1