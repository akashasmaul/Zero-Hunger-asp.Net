USE [master]
GO
/****** Object:  Database [ZeroHunger]    Script Date: 12/12/2023 10:42:35 PM ******/
CREATE DATABASE [ZeroHunger]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ZeroHunger', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ZeroHunger.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ZeroHunger_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ZeroHunger_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ZeroHunger] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ZeroHunger].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ZeroHunger] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ZeroHunger] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ZeroHunger] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ZeroHunger] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ZeroHunger] SET ARITHABORT OFF 
GO
ALTER DATABASE [ZeroHunger] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ZeroHunger] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ZeroHunger] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ZeroHunger] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ZeroHunger] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ZeroHunger] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ZeroHunger] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ZeroHunger] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ZeroHunger] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ZeroHunger] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ZeroHunger] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ZeroHunger] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ZeroHunger] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ZeroHunger] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ZeroHunger] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ZeroHunger] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ZeroHunger] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ZeroHunger] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ZeroHunger] SET  MULTI_USER 
GO
ALTER DATABASE [ZeroHunger] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ZeroHunger] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ZeroHunger] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ZeroHunger] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ZeroHunger] SET DELAYED_DURABILITY = DISABLED 
GO
USE [ZeroHunger]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 12/12/2023 10:42:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Age] [int] NOT NULL,
	[Sex] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[History]    Script Date: 12/12/2023 10:42:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[History](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Order_Id] [int] NOT NULL,
	[Employee_Id] [int] NOT NULL,
	[Restaurant_Id] [int] NOT NULL,
	[Collection_Time] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 12/12/2023 10:42:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Request_Id] [int] NOT NULL,
	[Employee_id] [int] NOT NULL,
	[Order_Date] [datetime2](7) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Requests]    Script Date: 12/12/2023 10:42:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Requests](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Restaurants_Id] [int] NOT NULL,
	[Description] [text] NOT NULL,
	[Expiry_Date] [datetime2](7) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Restaurants]    Script Date: 12/12/2023 10:42:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restaurants](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Location] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_Collections_Employees] FOREIGN KEY([Employee_Id])
REFERENCES [dbo].[Employees] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_Collections_Employees]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_Collections_Orders] FOREIGN KEY([Order_Id])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_Collections_Orders]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Restaurants] FOREIGN KEY([Restaurant_Id])
REFERENCES [dbo].[Restaurants] ([Id])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Restaurants]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Employees] FOREIGN KEY([Employee_id])
REFERENCES [dbo].[Employees] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Employees]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Requests] FOREIGN KEY([Request_Id])
REFERENCES [dbo].[Requests] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Requests]
GO
ALTER TABLE [dbo].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_Requests_Restaurants] FOREIGN KEY([Restaurants_Id])
REFERENCES [dbo].[Restaurants] ([Id])
GO
ALTER TABLE [dbo].[Requests] CHECK CONSTRAINT [FK_Requests_Restaurants]
GO
USE [master]
GO
ALTER DATABASE [ZeroHunger] SET  READ_WRITE 
GO
