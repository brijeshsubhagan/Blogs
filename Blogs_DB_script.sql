USE [master]
GO
/****** Object:  Database [Blog]    Script Date: 5/22/2018 12:25:24 PM ******/
CREATE DATABASE [Blog]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Blog', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Blog.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Blog_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Blog_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Blog] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Blog].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Blog] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Blog] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Blog] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Blog] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Blog] SET ARITHABORT OFF 
GO
ALTER DATABASE [Blog] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Blog] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Blog] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Blog] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Blog] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Blog] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Blog] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Blog] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Blog] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Blog] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Blog] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Blog] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Blog] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Blog] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Blog] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Blog] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Blog] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Blog] SET RECOVERY FULL 
GO
ALTER DATABASE [Blog] SET  MULTI_USER 
GO
ALTER DATABASE [Blog] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Blog] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Blog] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Blog] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Blog', N'ON'
GO
USE [Blog]
GO
/****** Object:  Table [dbo].[tbBlogComments]    Script Date: 5/22/2018 12:25:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbBlogComments](
	[BlogCommentID] [int] IDENTITY(1,1) NOT NULL,
	[BlogCommentParentID] [int] NOT NULL,
	[BlogPostID] [int] NOT NULL,
	[BlogComment] [varchar](100) NOT NULL,
	[BlogCommentByUserID] [int] NOT NULL,
	[BlogCommentDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tbBlogComments] PRIMARY KEY CLUSTERED 
(
	[BlogCommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbBlogPost]    Script Date: 5/22/2018 12:25:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbBlogPost](
	[BlogPostID] [int] IDENTITY(1,1) NOT NULL,
	[BlogPostTitle] [varchar](500) NOT NULL,
	[BlogPostBody] [varchar](2000) NOT NULL,
	[BlogPostDate] [date] NULL,
	[BlogPostByUserID] [int] NOT NULL,
 CONSTRAINT [PK_tbBlogPost] PRIMARY KEY CLUSTERED 
(
	[BlogPostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbBlogPublicUserComments]    Script Date: 5/22/2018 12:25:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbBlogPublicUserComments](
	[BlogPUCommentID] [int] IDENTITY(1,1) NOT NULL,
	[BlogPUComments] [varchar](100) NOT NULL,
	[BlogPUPostID] [int] NULL,
	[BlogPUCommentsParentID] [int] NOT NULL,
	[BlogPUUserName] [varchar](50) NULL,
 CONSTRAINT [PK_tbBlogPublicUserComments] PRIMARY KEY CLUSTERED 
(
	[BlogPUCommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbBlogUser]    Script Date: 5/22/2018 12:25:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbBlogUser](
	[BlogUserID] [int] IDENTITY(1,1) NOT NULL,
	[BlogUserName] [varchar](50) NOT NULL,
	[BlogUserPassword] [varchar](50) NOT NULL,
	[BlogUserEmailID] [varchar](50) NULL,
	[BlogUserCreatedDate] [date] NOT NULL,
	[BlogIsAdmin] [bit] NULL,
 CONSTRAINT [PK_tbBlogUser] PRIMARY KEY CLUSTERED 
(
	[BlogUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[tbBlogComments]  WITH CHECK ADD  CONSTRAINT [FK_tbBlogComments_tbBlogUser] FOREIGN KEY([BlogCommentByUserID])
REFERENCES [dbo].[tbBlogUser] ([BlogUserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbBlogComments] CHECK CONSTRAINT [FK_tbBlogComments_tbBlogUser]
GO
ALTER TABLE [dbo].[tbBlogPost]  WITH CHECK ADD  CONSTRAINT [FK_tbBlogPost] FOREIGN KEY([BlogPostByUserID])
REFERENCES [dbo].[tbBlogUser] ([BlogUserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbBlogPost] CHECK CONSTRAINT [FK_tbBlogPost]
GO
ALTER TABLE [dbo].[tbBlogPublicUserComments]  WITH CHECK ADD FOREIGN KEY([BlogPUPostID])
REFERENCES [dbo].[tbBlogPost] ([BlogPostID])
GO
/****** Object:  StoredProcedure [dbo].[spAddBlogUser]    Script Date: 5/22/2018 12:25:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spAddBlogUser]
(@BlogUserName Varchar(50),
@BlogUserPassword Varchar(50),
@BlogUserEmailID Varchar(50)
)
AS
BEGIN
Declare @IsAdmin bit
IF EXISTS(Select * from  tbBlogUser)
 SET @IsAdmin=0
 ELSE
 SET @IsAdmin=1


INSERT INTO 
			 tbBlogUser(BlogUserName,BlogUserPassword ,BlogUserEmailID,BlogUserCreatedDate,BlogIsAdmin)
		Values
			(@BlogUserName,
			 @BlogUserPassword,
			 @BlogUserEmailID,
			 Getdate(),@IsAdmin);
END



GO
/****** Object:  StoredProcedure [dbo].[spGetAllUsers]    Script Date: 5/22/2018 12:25:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spGetAllUsers]
AS
BEGIN
SELECT 
   BlogUserID,
	BlogUserName, 
	BlogUserEmailID,BlogIsAdmin
	FROM tbBlogUser
ORDER BY BlogUserName
END
GO
/****** Object:  StoredProcedure [dbo].[spGetBlogs]    Script Date: 5/22/2018 12:25:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spGetBlogs]
AS
BEGIN
SELECT 
   BlogPostID,
	BlogUserName, 
	BlogPostTitle,
	BlogPostBody,
	BlogPostDate
FROM tbBlogPost tBP (nolock)
INNER JOIN tbBlogUser tBU (nolock)
ON tBU.BlogUserID=tBP.BlogPostByUserID
ORDER BY BlogPostDate desc
END
GO
/****** Object:  StoredProcedure [dbo].[spGetBlogsByBlogPostID]    Script Date: 5/22/2018 12:25:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spGetBlogsByBlogPostID]
(@BlogPostID Int)
AS
BEGIN
SELECT 
   BlogPostID,
	BlogUserName, 
	BlogPostTitle,
	BlogPostBody,
	BlogPostDate
FROM tbBlogPost tBP (nolock)
INNER JOIN tbBlogUser tBU (nolock)
ON tBU.BlogUserID=tBP.BlogPostByUserID Where BlogPostID=@BlogPostID
ORDER BY BlogPostDate
END



GO
/****** Object:  StoredProcedure [dbo].[spGetValidateUser]    Script Date: 5/22/2018 12:25:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spGetValidateUser]
(@BlogUserEmailID Varchar(50),@BlogUserPassword varchar(50))
AS
BEGIN
SELECT 
   BlogUserID,
	BlogUserName, 
	BlogUserEmailID,BlogIsAdmin,BlogUserPassword
	FROM tbBlogUser where BlogUserEmailID=@BlogUserEmailID and BlogUserPassword=@BlogUserPassword
END


GO
/****** Object:  StoredProcedure [dbo].[spUpdateAdminUser]    Script Date: 5/22/2018 12:25:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spUpdateAdminUser](@BlogUserID INT)
AS
BEGIN
DECLARE @Admin bit
IF EXISTS( SELECT 
   BlogUserID,
	BlogUserName, 
	BlogUserEmailID,BlogIsAdmin
	FROM tbBlogUser where BlogUserID= @BlogUserID AND BlogIsAdmin=1)
	SET @Admin=0
	ELSE
	SET @Admin=1

	UPDATE 
	tbBlogUser SET BlogIsAdmin=@Admin WHERE BlogUserID =@BlogUserID

END



GO
USE [master]
GO
ALTER DATABASE [Blog] SET  READ_WRITE 
GO
