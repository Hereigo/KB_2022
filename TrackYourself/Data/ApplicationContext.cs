using Microsoft.EntityFrameworkCore;

namespace TrackYourself.Data
{
    public class ApplicationContext : DbContext
    {
        public DbSet<RecordCategory> RecordCategories => Set<RecordCategory>();

        public DbSet<Record> Records => Set<Record>();

        public ApplicationContext() => Database.EnsureCreated();

        protected override void OnConfiguring(DbContextOptionsBuilder optionBuilder)
        {
            optionBuilder.UseSqlite("Data Source=TrackYoursefl.db");
        }
    }
}


// DOT - ???
// ENJ
// FAM
// HLS
// RLX
// WIF
// WOK
// STU
// 