This repo demonstrates a regression with EF Core 9 migrations as relates to temporal tables.  If the migration was created under EF Core 8, but then migration is run under EF Core 9, then the migration fails with the error "Cannot create generated always column when SYSTEM_TIME period is not defined".  For convenience, migrationscript.sql illustrates the sql that gets generated in this scenario.  In this repository, the migrations were generated under EF Core 8, then the Nuget packages updated to EF Core 9.

Steps to reproduce with this repo:
- be sure the connection string is correct in OnConfiguring.  Note the database will be dropped in the test.
- run the test
- observe test fails with "Cannot create generated always column when SYSTEM_TIME period is not defined"

Steps to reproduce from scratch:
- Create a EF Core 8 db context
- Add an initial migration
- Update the tables to use temporal tables in OnModelCreating of the db context:  modelBuilder.Entity<Contact>().ToTable("Contacts", b => b.IsTemporal());
- Add a migration for the db context
- Update the Microsoft.EntityFrameworkCore.* nuget packages to to EF Core 9 
- Run the migration by calling context.Database.Migrate or using dotnet ef database update
