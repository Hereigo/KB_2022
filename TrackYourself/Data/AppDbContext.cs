using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace TrackYourself.Data
{
    public class AppDbContext : DbContext
    {
        public DbSet<RecordCategory> RecordCategories => Set<RecordCategory>();

        public DbSet<Record> Records => Set<Record>();

        public AppDbContext() => Database.EnsureCreated();

        protected override void OnConfiguring(DbContextOptionsBuilder optionBuilder)
        {
            optionBuilder.UseSqlite("Data Source=TrackYoursefl.db");

            // optionBuilder.UseSql("Data Source=Server=(localdb)\\MSSQLLocalDB;Database=AAA_db_{DateTime.Now:MMddHHmmss};Trusted_Connection=True");

            // optionBuilder.UseSqlServer($"Server=(localdb)\\mssqllocaldb;Database=AAA_db_{DateTime.Now:MMddHHmmss};Trusted_Connection=True;MultipleActiveResultSets=true")
            // .UseInternalServiceProvider(serviceProvider);
        }
    }
}