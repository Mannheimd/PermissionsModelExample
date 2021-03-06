/*
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
PRINT N'Creating [dbo].[FK_UserRole]...';


GO
ALTER TABLE [dbo].[UserRoleAssignments] WITH NOCHECK
    ADD CONSTRAINT [FK_UserRole] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[UserRoleAssignments] WITH CHECK CHECK CONSTRAINT [FK_UserRole];


GO
PRINT N'Update complete.';


GO
