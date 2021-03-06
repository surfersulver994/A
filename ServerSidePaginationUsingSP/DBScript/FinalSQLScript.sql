USE [DBFirstDemo]
GO
/****** Object:  StoredProcedure [dbo].[GetEmployeeDetails]    Script Date: 10-08-2020 16:25:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEmployeeDetails] 	
@Pageno INT=1,	
@filter VARCHAR(500)='',	
@pagesize INT=20,		
@Sorting VARCHAR(500)='EmployeeID',	
@SortOrder VARCHAR(500)='desc' 	
AS
BEGIN
SET NOCOUNT ON;
DECLARE @SqlCount INT
DECLARE @From INT = @pageno
DECLARE @SQLQuery VARCHAR(5000)
IF(@filter !='')
BEGIN
SET @SqlCount= ( SELECT COUNT(*) FROM Employee as EMP WHERE EMP.Is_Active=1 AND (EMP.Name LIKE '%'+@filter+'%' OR EMP.Department LIKE '%'+ @filter+'%' OR EMP.Branch LIKE '%'+@filter+'%'))
SET @SQLQuery ='select emp.EmployeeID as EmployeeID,emp.Name,emp.Department,emp.Branch,'+CONVERT(VARCHAR,@SqlCount)+' as TotalRecords
from Employee as emp 
where emp.Is_Active=1 
and(emp.Name like ''%'+CONVERT(VARCHAR,@filter)+'%'') 
order by emp.'+ CONVERT(VARCHAR,@Sorting) +' '+ @SortOrder +'
OFFSET '+CONVERT(varchar,@From)+' ROWS
FETCH NEXT '+CONVERT(varchar,@pagesize)+' ROWS ONLY OPTION (RECOMPILE)'
END
ELSE
BEGIN
SET @SqlCount=( SELECT COUNT(*) FROM Employee as EMP WHERE EMP.Is_Active=1)

SET @SQLQuery ='select emp.EmployeeID as EmployeeID,emp.Name,emp.Department,emp.Branch,'+CONVERT(VARCHAR,@SqlCount)+' as TotalRecords
from Employee as emp
where emp.Is_Active=1	
order by emp.'+ CONVERT(VARCHAR,@Sorting) +' '+ @SortOrder +'
OFFSET '+CONVERT(varchar,@From)+' ROWS
FETCH NEXT '+CONVERT(varchar,@pagesize)+' ROWS ONLY OPTION (RECOMPILE)'
end

print @SQLQuery
exec (@SQLQuery)

END

GO
/****** Object:  StoredProcedure [dbo].[GetUserDetails]    Script Date: 10-08-2020 16:25:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserDetails] 
@Pageno INT=1,
@filter VARCHAR(500)='',
@pagesize INT=20,	
@Sorting VARCHAR(500)='UserId',
@SortOrder VARCHAR(500)='desc' 
AS
BEGIN
SET NOCOUNT ON;
DECLARE @SqlCount INT
DECLARE @From INT = @pageno
DECLARE @SQLQuery VARCHAR(5000)
IF(@filter !='')
BEGIN
SET @SqlCount= ( SELECT COUNT(*) FROM Users as USR WHERE USR.Is_Active=1 AND (USR.First_Name LIKE '%'+@filter+'%' OR USR.Last_Name LIKE '%'+ @filter+'%' OR USR.Email_Address LIKE '%'+@filter+'%' OR USR.Created_Date LIKE '%' + @filter+'%'))
SET @SQLQuery ='select usr.UserId as UserId,usr.First_Name,usr.Last_Name,usr.Email_Address,usr.Created_Date ,'+CONVERT(VARCHAR,@SqlCount)+' as TotalRecords
from Users as usr 
where usr.Is_Active=1 
and(usr.First_Name like ''%'+CONVERT(VARCHAR,@filter)+'%'' 
or usr.Last_Name like ''%'+CONVERT(VARCHAR,@filter)+'%'' 
or usr.Email_Address like ''%'+CONVERT(VARCHAR,@filter)+'%'') 
order by usr.'+ CONVERT(VARCHAR,@Sorting) +' '+ @SortOrder +'
OFFSET '+CONVERT(varchar,@From)+' ROWS
FETCH NEXT '+CONVERT(varchar,@pagesize)+' ROWS ONLY OPTION (RECOMPILE)'
END
ELSE
BEGIN
SET @SqlCount=( SELECT COUNT(*) FROM Users as USR WHERE USR.Is_Active=1)

SET @SQLQuery ='select usr.UserId as UserId,usr.First_Name,usr.Last_Name,usr.Email_Address,usr.Created_Date,'+CONVERT(VARCHAR,@SqlCount)+' as TotalRecords
from Users as usr
where usr.Is_Active=1	
order by usr.'+ CONVERT(VARCHAR,@Sorting) +' '+ @SortOrder +'
OFFSET '+CONVERT(varchar,@From)+' ROWS
FETCH NEXT '+CONVERT(varchar,@pagesize)+' ROWS ONLY OPTION (RECOMPILE)'
end

print @SQLQuery
exec (@SQLQuery)

END

GO
/****** Object:  Table [dbo].[Employee]    Script Date: 10-08-2020 16:25:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] NOT NULL,
	[Name] [varchar](50) NULL,
	[Department] [varchar](50) NULL,
	[Branch] [varchar](50) NULL,
	[Is_Locked] [bit] NULL,
	[Is_Active] [bit] NULL,
	[Edit_Date] [datetime] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Table_1]    Script Date: 10-08-2020 16:25:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Table_1](
	[EmployeeID] [int] NOT NULL,
	[Name] [varchar](50) NULL,
	[Department] [varchar](50) NULL,
	[Branch] [varchar](50) NULL,
	[Is_Locked] [bit] NULL,
	[Is_Active] [bit] NULL,
	[Edit_Date] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 10-08-2020 16:25:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[First_Name] [nvarchar](50) NULL,
	[Last_Name] [nvarchar](50) NULL,
	[Email_Address] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[Password] [nvarchar](300) NULL,
	[Created_Date] [datetime] NULL,
	[RoleId] [int] NULL,
	[Address] [nvarchar](500) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](10) NULL,
	[Zip] [nvarchar](10) NULL,
	[Company] [int] NULL,
	[Image_Path] [varchar](200) NULL,
	[Is_Locked] [bit] NULL,
	[Is_Active] [bit] NULL,
	[Edit_Date] [datetime] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
