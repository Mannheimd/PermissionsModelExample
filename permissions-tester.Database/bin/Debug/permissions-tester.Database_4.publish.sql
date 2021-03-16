﻿/*
Deployment script for PermissionsTest

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "PermissionsTest"
:setvar DefaultFilePrefix "PermissionsTest"
:setvar DefaultDataPath "C:\Users\chris.manders\AppData\Local\Microsoft\VisualStudio\SSDT\"
:setvar DefaultLogPath "C:\Users\chris.manders\AppData\Local\Microsoft\VisualStudio\SSDT\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'The following operation was generated from a refactoring log file 45fad4cb-b239-4fcf-a844-92577b49598b';

PRINT N'Rename [dbo].[Groups].[RoleId] to RoleName';


GO
EXECUTE sp_rename @objname = N'[dbo].[Groups].[RoleId]', @newname = N'RoleName', @objtype = N'COLUMN';


GO
PRINT N'Dropping unnamed constraint on [dbo].[Groups]...';


GO
ALTER TABLE [dbo].[Groups] DROP CONSTRAINT [DF__tmp_ms_xx_Gr__Id__35BCFE0A];


GO
PRINT N'Dropping [dbo].[FK_GroupRole]...';


GO
ALTER TABLE [dbo].[Groups] DROP CONSTRAINT [FK_GroupRole];


GO
PRINT N'Starting rebuilding table [dbo].[Groups]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Groups] (
    [Id]       UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
    [GroupId]  NVARCHAR (MAX)   NOT NULL,
    [RoleName] NVARCHAR (MAX)   NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Groups])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Groups] ([Id], [GroupId], [RoleName])
        SELECT   [Id],
                 [GroupId],
                 [RoleName]
        FROM     [dbo].[Groups]
        ORDER BY [Id] ASC;
    END

DROP TABLE [dbo].[Groups];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Groups]', N'Groups';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
-- Refactoring step to update target server with deployed transaction logs
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '45fad4cb-b239-4fcf-a844-92577b49598b')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('45fad4cb-b239-4fcf-a844-92577b49598b')

GO

GO
PRINT N'Update complete.';


GO