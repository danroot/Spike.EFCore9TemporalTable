BEGIN TRANSACTION;
DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Persons]') AND [c].[name] = N'LastName');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Persons] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [Persons] ALTER COLUMN [LastName] nvarchar(100) NOT NULL;

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Persons]') AND [c].[name] = N'FirstName');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Persons] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [Persons] ALTER COLUMN [FirstName] nvarchar(100) NOT NULL;

DECLARE @var2 sysname;
SELECT @var2 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Persons]') AND [c].[name] = N'Id');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [Persons] DROP CONSTRAINT [' + @var2 + '];');
ALTER TABLE [Persons] ALTER COLUMN [Id] int NOT NULL;

ALTER TABLE [Persons] ADD [PeriodEnd] datetime2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL DEFAULT '9999-12-31T23:59:59.9999999';

ALTER TABLE [Persons] ADD [PeriodStart] datetime2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';

DECLARE @var3 sysname;
SELECT @var3 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Contacts]') AND [c].[name] = N'Phone');
IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [Contacts] DROP CONSTRAINT [' + @var3 + '];');
ALTER TABLE [Contacts] ALTER COLUMN [Phone] nvarchar(20) NOT NULL;

DECLARE @var4 sysname;
SELECT @var4 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Contacts]') AND [c].[name] = N'PersonId');
IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [Contacts] DROP CONSTRAINT [' + @var4 + '];');
ALTER TABLE [Contacts] ALTER COLUMN [PersonId] int NULL;

DECLARE @var5 sysname;
SELECT @var5 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Contacts]') AND [c].[name] = N'Name');
IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [Contacts] DROP CONSTRAINT [' + @var5 + '];');
ALTER TABLE [Contacts] ALTER COLUMN [Name] nvarchar(100) NOT NULL;

DECLARE @var6 sysname;
SELECT @var6 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Contacts]') AND [c].[name] = N'Email');
IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [Contacts] DROP CONSTRAINT [' + @var6 + '];');
ALTER TABLE [Contacts] ALTER COLUMN [Email] nvarchar(100) NOT NULL;

DECLARE @var7 sysname;
SELECT @var7 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Contacts]') AND [c].[name] = N'Id');
IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [Contacts] DROP CONSTRAINT [' + @var7 + '];');
ALTER TABLE [Contacts] ALTER COLUMN [Id] int NOT NULL;

ALTER TABLE [Contacts] ADD [PeriodEnd] datetime2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL DEFAULT '9999-12-31T23:59:59.9999999';

ALTER TABLE [Contacts] ADD [PeriodStart] datetime2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';

ALTER TABLE [Persons] ADD PERIOD FOR SYSTEM_TIME ([PeriodStart], [PeriodEnd])

ALTER TABLE [Persons] ALTER COLUMN [PeriodStart] ADD HIDDEN

ALTER TABLE [Persons] ALTER COLUMN [PeriodEnd] ADD HIDDEN

ALTER TABLE [Contacts] ADD PERIOD FOR SYSTEM_TIME ([PeriodStart], [PeriodEnd])

ALTER TABLE [Contacts] ALTER COLUMN [PeriodStart] ADD HIDDEN

ALTER TABLE [Contacts] ALTER COLUMN [PeriodEnd] ADD HIDDEN

DECLARE @historyTableSchema sysname = SCHEMA_NAME()
EXEC(N'ALTER TABLE [Persons] SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = [' + @historyTableSchema + '].[PersonsHistory]))')


DECLARE @historyTableSchema sysname = SCHEMA_NAME()
EXEC(N'ALTER TABLE [Contacts] SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = [' + @historyTableSchema + '].[ContactsHistory]))')


INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241121163049_Temporal', N'9.0.0');

COMMIT;
GO

