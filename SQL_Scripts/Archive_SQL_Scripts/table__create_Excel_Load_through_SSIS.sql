--Creating a table with NVARCHAR to load data from Excel Using SSIS
	--SSIS requires the NVARCHAR datatype

CREATE TABLE [IAACE1].[dbo].[JKJ_InputX] (
    [CustomerID]   NVARCHAR      NOT NULL,
    [NameStyle]    NVARCHAR      NOT NULL,
    [Title]        NVARCHAR (4)  NULL,
    [FirstName]    NVARCHAR (24) NOT NULL,
    [LastName]     NVARCHAR (22) NOT NULL,
    [CompanyName]  NVARCHAR (41) NOT NULL,
    [SalesPerson]  NVARCHAR (24) NOT NULL,
    [EmailAddress] NVARCHAR (43) NOT NULL,
    [Phone]        NVARCHAR (19) NOT NULL
);