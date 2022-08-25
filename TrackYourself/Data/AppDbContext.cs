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
            optionBuilder.UseSqlite("Data Source=TrackYoursefl.db");
        }
    }
}