-- Microsoft.EntityFrameworkCore.Infrastructure[10403]
-- Entity Framework Core 6.0.8 initialized 'ApplicationDbContext' using provider 'Microsoft.EntityFrameworkCore.SqlServer:6.0.8' with options: None


      CREATE DATABASE [aspnet-KB2022_2-09-13];


      IF SERVERPROPERTY('EngineEdition') <> 5
      BEGIN
          ALTER DATABASE [aspnet-KB2022_2-09-13] SET READ_COMMITTED_SNAPSHOT ON;
      END;


      SELECT 1


      CREATE TABLE [__EFMigrationsHistory] (
          [MigrationId] nvarchar(150) NOT NULL,
          [ProductVersion] nvarchar(32) NOT NULL,
          CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
      );


      SELECT 1


      SELECT OBJECT_ID(N'[__EFMigrationsHistory]');


      SELECT [MigrationId], [ProductVersion]
      FROM [__EFMigrationsHistory]
      ORDER BY [MigrationId];


-- Applying migration '00000000000000_CreateIdentitySchema'.


      CREATE TABLE [AspNetRoles] (
          [Id] nvarchar(450) NOT NULL,
          [Name] nvarchar(256) NULL,
          [NormalizedName] nvarchar(256) NULL,
          [ConcurrencyStamp] nvarchar(max) NULL,
          CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
      );


      CREATE TABLE [AspNetUsers] (
          [Id] nvarchar(450) NOT NULL,
          [UserName] nvarchar(256) NULL,
          [NormalizedUserName] nvarchar(256) NULL,
          [Email] nvarchar(256) NULL,
          [NormalizedEmail] nvarchar(256) NULL,
          [EmailConfirmed] bit NOT NULL,
          [PasswordHash] nvarchar(max) NULL,
          [SecurityStamp] nvarchar(max) NULL,
          [ConcurrencyStamp] nvarchar(max) NULL,
          [PhoneNumber] nvarchar(max) NULL,
          [PhoneNumberConfirmed] bit NOT NULL,
          [TwoFactorEnabled] bit NOT NULL,
          [LockoutEnd] datetimeoffset NULL,
          [LockoutEnabled] bit NOT NULL,
          [AccessFailedCount] int NOT NULL,
          CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
      );


      CREATE TABLE [AspNetRoleClaims] (
          [Id] int NOT NULL IDENTITY,
          [RoleId] nvarchar(450) NOT NULL,
          [ClaimType] nvarchar(max) NULL,
          [ClaimValue] nvarchar(max) NULL,
          CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
          CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
      );


      CREATE TABLE [AspNetUserClaims] (
          [Id] int NOT NULL IDENTITY,
          [UserId] nvarchar(450) NOT NULL,
          [ClaimType] nvarchar(max) NULL,
          [ClaimValue] nvarchar(max) NULL,
          CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
          CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
      );


      CREATE TABLE [AspNetUserLogins] (
          [LoginProvider] nvarchar(128) NOT NULL,
          [ProviderKey] nvarchar(128) NOT NULL,
          [ProviderDisplayName] nvarchar(max) NULL,
          [UserId] nvarchar(450) NOT NULL,
          CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
          CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
      );


      CREATE TABLE [AspNetUserRoles] (
          [UserId] nvarchar(450) NOT NULL,
          [RoleId] nvarchar(450) NOT NULL,
          CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
          CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
          CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
      );


      CREATE TABLE [AspNetUserTokens] (
          [UserId] nvarchar(450) NOT NULL,
          [LoginProvider] nvarchar(128) NOT NULL,
          [Name] nvarchar(128) NOT NULL,
          [Value] nvarchar(max) NULL,
          CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
          CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
      );


      CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);


      CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;


      CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);


      CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);


      CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);


      CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);


      CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL;


      INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
      VALUES (N'00000000000000_CreateIdentitySchema', N'6.0.8');


-- Microsoft.EntityFrameworkCore.Infrastructure[10403]
-- Entity Framework Core 6.0.8 initialized 'ApplicationDbContext' using provider 'Microsoft.EntityFrameworkCore.SqlServer:6.0.8' with options: None


--  (24ms) [Parameters=[@__normalizedUserName_0='?' (Size = 256)], CommandType='Text', CommandTimeout='30']
      SELECT TOP(1) [a].[Id], [a].[AccessFailedCount], [a].[ConcurrencyStamp], [a].[Email], [a].[EmailConfirmed], [a].[LockoutEnabled], [a].[LockoutEnd], [a].[NormalizedEmail], [a].[NormalizedUserName], [a].[PasswordHash], [a].[PhoneNumber], [a].[PhoneNumberConfirmed], [a].[SecurityStamp], [a].[TwoFactorEnabled], [a].[UserName]
      FROM [AspNetUsers] AS [a]
      WHERE [a].[NormalizedUserName] = @__normalizedUserName_0


--  (3ms) [Parameters=[@p0='?' (Size = 450), @p1='?' (DbType = Int32), @p2='?' (Size = 4000), @p3='?' (Size = 256), @p4='?' (DbType = Boolean), @p5='?' (DbType = Boolean), @p6='?' (DbType = DateTimeOffset), @p7='?' (Size = 256), @p8='?' (Size = 256), @p9='?' (Size = 4000), @p10='?' (Size = 4000), @p11='?' (DbType = Boolean), @p12='?' (Size = 4000), @p13='?' (DbType = Boolean), @p14='?' (Size = 256)], CommandType='Text', CommandTimeout='30']
      SET NOCOUNT ON;
      INSERT INTO [AspNetUsers] ([Id], [AccessFailedCount], [ConcurrencyStamp], [Email], [EmailConfirmed], [LockoutEnabled], [LockoutEnd], [NormalizedEmail], [NormalizedUserName], [PasswordHash], [PhoneNumber], [PhoneNumberConfirmed], [SecurityStamp], [TwoFactorEnabled], [UserName])
      VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11, @p12, @p13, @p14);


-- Microsoft.EntityFrameworkCore.Infrastructure[10403]
-- Entity Framework Core 6.0.8 initialized 'ApplicationDbContext' using provider 'Microsoft.EntityFrameworkCore.SqlServer:6.0.8' with options: None


--  (5ms) [Parameters=[@__normalizedEmail_0='?' (Size = 256)], CommandType='Text', CommandTimeout='30']
      SELECT TOP(2) [a].[Id], [a].[AccessFailedCount], [a].[ConcurrencyStamp], [a].[Email], [a].[EmailConfirmed], [a].[LockoutEnabled], [a].[LockoutEnd], [a].[NormalizedEmail], [a].[NormalizedUserName], [a].[PasswordHash], [a].[PhoneNumber], [a].[PhoneNumberConfirmed], [a].[SecurityStamp], [a].[TwoFactorEnabled], [a].[UserName]
      FROM [AspNetUsers] AS [a]
      WHERE [a].[NormalizedEmail] = @__normalizedEmail_0


-- Microsoft.EntityFrameworkCore.Infrastructure[10403]
-- Entity Framework Core 6.0.8 initialized 'ApplicationDbContext' using provider 'Microsoft.EntityFrameworkCore.SqlServer:6.0.8' with options: None


--  (1ms) [Parameters=[@__p_0='?' (Size = 450)], CommandType='Text', CommandTimeout='30']
      SELECT TOP(1) [a].[Id], [a].[AccessFailedCount], [a].[ConcurrencyStamp], [a].[Email], [a].[EmailConfirmed], [a].[LockoutEnabled], [a].[LockoutEnd], [a].[NormalizedEmail], [a].[NormalizedUserName], [a].[PasswordHash], [a].[PhoneNumber], [a].[PhoneNumberConfirmed], [a].[SecurityStamp], [a].[TwoFactorEnabled], [a].[UserName]
      FROM [AspNetUsers] AS [a]
      WHERE [a].[Id] = @__p_0


--  (4ms) [Parameters=[@__normalizedUserName_0='?' (Size = 256)], CommandType='Text', CommandTimeout='30']
      SELECT TOP(1) [a].[Id], [a].[AccessFailedCount], [a].[ConcurrencyStamp], [a].[Email], [a].[EmailConfirmed], [a].[LockoutEnabled], [a].[LockoutEnd], [a].[NormalizedEmail], [a].[NormalizedUserName], [a].[PasswordHash], [a].[PhoneNumber], [a].[PhoneNumberConfirmed], [a].[SecurityStamp], [a].[TwoFactorEnabled], [a].[UserName]
      FROM [AspNetUsers] AS [a]
      WHERE [a].[NormalizedUserName] = @__normalizedUserName_0


--  (5ms) [Parameters=[@p14='?' (Size = 450), @p0='?' (DbType = Int32), @p1='?' (Size = 4000), @p15='?' (Size = 4000), @p2='?' (Size = 256), @p3='?' (DbType = Boolean), @p4='?' (DbType = Boolean), @p5='?' (DbType = DateTimeOffset), @p6='?' (Size = 256), @p7='?' (Size = 256), @p8='?' (Size = 4000), @p9='?' (Size = 4000), @p10='?' (DbType = Boolean), @p11='?' (Size = 4000), @p12='?' (DbType = Boolean), @p13='?' (Size = 256)], CommandType='Text', CommandTimeout='30']
      SET NOCOUNT ON;
      UPDATE [AspNetUsers] SET [AccessFailedCount] = @p0, [ConcurrencyStamp] = @p1, [Email] = @p2, [EmailConfirmed] = @p3, [LockoutEnabled] = @p4, [LockoutEnd] = @p5, [NormalizedEmail] = @p6, [NormalizedUserName] = @p7, [PasswordHash] = @p8, [PhoneNumber] = @p9, [PhoneNumberConfirmed] = @p10, [SecurityStamp] = @p11, [TwoFactorEnabled] = @p12, [UserName] = @p13
      WHERE [Id] = @p14 AND [ConcurrencyStamp] = @p15;
      SELECT @@ROWCOUNT;
