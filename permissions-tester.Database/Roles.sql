CREATE TABLE [dbo].[Roles]
(
	[Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID() PRIMARY KEY, 
    [RoleName] NVARCHAR(MAX) NOT NULL, 
    [AllowsClaim] UNIQUEIDENTIFIER NOT NULL
    CONSTRAINT [FK_RoleClaim] FOREIGN KEY (AllowsClaim) REFERENCES Claims(Id)
)
