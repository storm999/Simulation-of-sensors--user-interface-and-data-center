USE [master]
GO
/****** Object:  Database [thesisDB]    Script Date: 01/02/2022 22:56:58 ******/
CREATE DATABASE [thesisDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'thesisDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\thesisDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'thesisDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\thesisDB_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [thesisDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [thesisDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [thesisDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [thesisDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [thesisDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [thesisDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [thesisDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [thesisDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [thesisDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [thesisDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [thesisDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [thesisDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [thesisDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [thesisDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [thesisDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [thesisDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [thesisDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [thesisDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [thesisDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [thesisDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [thesisDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [thesisDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [thesisDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [thesisDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [thesisDB] SET RECOVERY FULL 
GO
ALTER DATABASE [thesisDB] SET  MULTI_USER 
GO
ALTER DATABASE [thesisDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [thesisDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [thesisDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [thesisDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [thesisDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [thesisDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'thesisDB', N'ON'
GO
ALTER DATABASE [thesisDB] SET QUERY_STORE = OFF
GO
USE [thesisDB]
GO
/****** Object:  Table [dbo].[sensors]    Script Date: 01/02/2022 22:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sensors](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[sensorType] [ntext] NULL,
	[userId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[getAssignedSensors]    Script Date: 01/02/2022 22:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getAssignedSensors] (@user_id INT)
RETURNS TABLE
AS
RETURN
	(SELECT s.*
	from sensors as s
	where @user_id =  s.userId)
GO
/****** Object:  Table [dbo].[questions]    Script Date: 01/02/2022 22:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[questions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[question] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[getQuestionById]    Script Date: 01/02/2022 22:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getQuestionById]
(
	@questionId int
)
RETURNS TABLE
AS
RETURN
	(SELECT question 
	 from questions
	 where questions.Id = @questionId)
GO
/****** Object:  Table [dbo].[questionsAssignedToEachPerson]    Script Date: 01/02/2022 22:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[questionsAssignedToEachPerson](
	[FK_quesstionId] [int] NOT NULL,
	[FK_userId] [int] NOT NULL,
	[date] [datetime] NOT NULL,
	[isAnswered] [bit] NULL,
 CONSTRAINT [PK_assignedQuestionsPerPerson] PRIMARY KEY CLUSTERED 
(
	[date] ASC,
	[FK_quesstionId] ASC,
	[FK_userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 01/02/2022 22:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[surname] [nvarchar](50) NULL,
	[birthdate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[getAssignedQuestions]    Script Date: 01/02/2022 22:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getAssignedQuestions] (@user_id INT)
RETURNS TABLE
AS
RETURN
	(SELECT question, date
	from users as p, questions as q, questionsAssignedToEachPerson aq
	where @user_id = p.Id and q.Id = aq.FK_quesstionId and p.Id = aq.FK_userId)
GO
/****** Object:  Table [dbo].[questionsToBeAskedToEachPerson]    Script Date: 01/02/2022 22:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[questionsToBeAskedToEachPerson](
	[FK_userId] [int] NOT NULL,
	[FK_questionId] [int] NOT NULL,
	[questionJSON] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[FK_questionId] ASC,
	[FK_userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[questionsAssignedToEachPerson] ADD  DEFAULT ((0)) FOR [isAnswered]
GO
ALTER TABLE [dbo].[questionsAssignedToEachPerson]  WITH CHECK ADD  CONSTRAINT [FK_questionsAssignedToEachPerson_ToTable] FOREIGN KEY([FK_userId])
REFERENCES [dbo].[users] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[questionsAssignedToEachPerson] CHECK CONSTRAINT [FK_questionsAssignedToEachPerson_ToTable]
GO
ALTER TABLE [dbo].[questionsAssignedToEachPerson]  WITH CHECK ADD  CONSTRAINT [FK_questionsAssignedToEachPerson_ToTable_1] FOREIGN KEY([FK_quesstionId])
REFERENCES [dbo].[questions] ([Id])
GO
ALTER TABLE [dbo].[questionsAssignedToEachPerson] CHECK CONSTRAINT [FK_questionsAssignedToEachPerson_ToTable_1]
GO
ALTER TABLE [dbo].[questionsToBeAskedToEachPerson]  WITH CHECK ADD  CONSTRAINT [FK_questionsToBeAsked_ToUsers] FOREIGN KEY([FK_userId])
REFERENCES [dbo].[users] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[questionsToBeAskedToEachPerson] CHECK CONSTRAINT [FK_questionsToBeAsked_ToUsers]
GO
ALTER TABLE [dbo].[questionsToBeAskedToEachPerson]  WITH CHECK ADD  CONSTRAINT [FK_questionsToBeAskedToEachPerson_ToQuestions] FOREIGN KEY([FK_questionId])
REFERENCES [dbo].[questions] ([Id])
GO
ALTER TABLE [dbo].[questionsToBeAskedToEachPerson] CHECK CONSTRAINT [FK_questionsToBeAskedToEachPerson_ToQuestions]
GO
ALTER TABLE [dbo].[sensors]  WITH CHECK ADD  CONSTRAINT [FK_sensors_users] FOREIGN KEY([userId])
REFERENCES [dbo].[users] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sensors] CHECK CONSTRAINT [FK_sensors_users]
GO
/****** Object:  StoredProcedure [dbo].[SPaddPerson]    Script Date: 01/02/2022 22:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPaddPerson] 
	@name nvarchar(50),
	@surname nvarchar(50),
	@birthdate datetime
AS 
BEGIN
	INSERT INTO [dbo].[users] (name, surname, birthdate) VALUES (@name, @surname, @birthdate )
END
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[SPaskQuestionToPatient]    Script Date: 01/02/2022 22:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPaskQuestionToPatient]
	@patientId int,
	@questionId int,
	@date Datetime
AS
	INSERT INTO [dbo].[questionsAssignedToEachPerson] (FK_userId, FK_quesstionId, date) VALUES (@patientId, @questionId, @date)
RETURN 0	
GO
/****** Object:  StoredProcedure [dbo].[SPassignQuestionToPatient]    Script Date: 01/02/2022 22:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPassignQuestionToPatient]
	@userId int,
	@questionId int,
	@questionJSON nvarchar(MAX)
AS
	INSERT INTO  [dbo].questionsToBeAskedToEachPerson(FK_questionId,FK_userId,questionJSON)
	VALUES (@questionId, @userId, @questionJSON)
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[SPcreateSensor]    Script Date: 01/02/2022 22:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPcreateSensor]
	@sensor ntext,
	@userId int
AS
	INSERT INTO  [dbo].sensors(sensorType,userId) 
	OUTPUT INSERTED.Id
	VALUES (@sensor,@userId )
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[SPdeletePatient]    Script Date: 01/02/2022 22:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPdeletePatient]
	@Id int
AS
    DELETE from [dbo].[users]  
    WHERE users.Id = @Id
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[SPdeleteQuestionToBeAsked]    Script Date: 01/02/2022 22:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPdeleteQuestionToBeAsked]
	@userId int,
	@questionId int
AS
    DELETE from [dbo].[questionsToBeAskedToEachPerson]  
    WHERE FK_userId = @userId and FK_questionId = @questionId
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[SPdeleteSensor]    Script Date: 01/02/2022 22:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPdeleteSensor]
	@Id int
AS
    DELETE from [dbo].[sensors]  
    WHERE sensors.Id = @Id
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[SPupdateSensor]    Script Date: 01/02/2022 22:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPupdateSensor]
	@sensorId int,
	@sensor ntext
AS
	UPDATE sensors
SET 
    sensorType = @sensor

WHERE
    @sensorId =Id
RETURN 0
GO
USE [master]
GO
ALTER DATABASE [thesisDB] SET  READ_WRITE 
GO
