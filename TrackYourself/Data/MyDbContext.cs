using Microsoft.EntityFrameworkCore;

namespace TrackYourself.Data
{
    public class MyDbContext : DbContext
    {
        public DbSet<RecordCategory> RecordCategories => Set<RecordCategory>();

        public DbSet<Record> Records => Set<Record>();

        public MyDbContext() => Database.EnsureCreated();

        protected override void OnConfiguring(DbContextOptionsBuilder optionBuilder)
        {
            optionBuilder.UseSqlite("Data Source=TrackYoursefl.db");
        }
    }
}