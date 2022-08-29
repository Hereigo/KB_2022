using Microsoft.EntityFrameworkCore;

namespace TrackYourself.Data
{
    public class AppDbContext : DbContext
    {
        public DbSet<RecordCategory> RecordCategories => Set<RecordCategory>();

        public DbSet<Record> Records => Set<Record>();

        public AppDbContext() => Database.EnsureCreated();

        protected override void OnConfiguring(DbContextOptionsBuilder optionBuilder)
        {
            optionBuilder.UseSqlServer(
                "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=20220829;Integrated Security=True;Pooling=False");
        }
    }
}