CREATE DATABASE [QuestionWarehouse];
GO
USE [QuestionWarehouse]
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 5/22/2024 04:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[questionId] [uniqueidentifier] NOT NULL,
	[question] [nvarchar](max) NOT NULL,
	[optionA] [nvarchar](max) NOT NULL,
	[optionB] [nvarchar](max) NOT NULL,
	[optionC] [nvarchar](max) NULL,
	[optionD] [nvarchar](max) NULL,
	[answer] [nvarchar](1) NOT NULL,
 CONSTRAINT [PK_Questions] PRIMARY KEY CLUSTERED 
(
	[questionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Records]    Script Date: 5/22/2024 04:38:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Records](
	[recordId] [uniqueidentifier] NOT NULL,
	[userId] [uniqueidentifier] NOT NULL,
	[userAnswer] [nvarchar](1) NOT NULL,
	[questionId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Records] PRIMARY KEY CLUSTERED 
(
	[recordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/22/2024 04:38:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[userId] [uniqueidentifier] NOT NULL,
	[username] [varchar](20) NOT NULL,
	[password] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Records]  WITH CHECK ADD  CONSTRAINT [FK_Records_Questions] FOREIGN KEY([questionId])
REFERENCES [dbo].[Questions] ([questionId])
GO
ALTER TABLE [dbo].[Records] CHECK CONSTRAINT [FK_Records_Questions]
GO
ALTER TABLE [dbo].[Records]  WITH CHECK ADD  CONSTRAINT [FK_Records_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[Users] ([userId])
GO
ALTER TABLE [dbo].[Records] CHECK CONSTRAINT [FK_Records_Users]
GO


--CREATE STORED PROCEDURE
CREATE PROCEDURE [dbo].[CreateRecord]
    @userId UNIQUEIDENTIFIER,
    @questionId UNIQUEIDENTIFIER,
    @userAnswer NVARCHAR(1)
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the questionId exists in the Questions table
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Questions] WHERE [questionId] = @questionId)
    BEGIN
        RAISERROR('Invalid questionId.', 16, 1);
        RETURN;
    END

    -- Check if the userId exists in the Users table
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [userId] = @userId)
    BEGIN
        RAISERROR('Invalid userId.', 16, 1);
        RETURN;
    END

    -- Insert the new record into the Records table
    INSERT INTO [dbo].[Records] ([recordId], [userId], [userAnswer], [questionId])
    VALUES (NEWID(), @userId, @userAnswer, @questionId);

    PRINT 'Record created successfully.';
END
GO

-- USING PROCEDURE
DECLARE @userId UNIQUEIDENTIFIER;
SELECT TOP 1 @userId = [userId] FROM [dbo].[Users] WHERE LTRIM(RTRIM(username)) = 'phongluu';
    PRINT 'UserId: ' + CAST(@userId AS NVARCHAR(36));

DECLARE @questionId UNIQUEIDENTIFIER;
SELECT TOP 1 @questionId = [questionId] FROM [dbo].[Questions] WHERE question = 'HIHI';
	PRINT 'QuestionId: ' + CAST(@questionId AS NVARCHAR(MAX));

DECLARE @userAnswer NVARCHAR(1) = 'A';
	PRINT 'UserAnswer: ' + @userAnswer;
EXEC [dbo].[CreateRecord] @userId, @questionId, @userAnswer;

--Check Procedure
EXEC sp_helptext 'CreateRecord';

--DROP STORED PROCEDURE
USE [QuestionWarehouse];
GO
DROP PROCEDURE [dbo].[CreateRecord];

DECLARE @userId UNIQUEIDENTIFIER = '316395d4-f1af-46f7-947b-a4021b670c07'