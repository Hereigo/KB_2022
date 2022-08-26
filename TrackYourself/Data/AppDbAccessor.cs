using Microsoft.EntityFrameworkCore;

namespace TrackYourself.Data
{
    internal static class AppDbAccessor
    {
        internal static void SeedDatabase()
        {
            using var db = new AppDbContext();
            if (!db.RecordCategories.Any())
            {
                var catList = new List<RecordCategory>();

                foreach (var cat in (CategoriesEnum[])Enum.GetValues(typeof(CategoriesEnum)))
                    catList.Add(new RecordCategory() { Name = cat.ToString() });

                db.AddRange(catList);
                db.SaveChanges();
            }
        }

        internal static List<string>? GetCategoriesNames()
        {
            using var db = new AppDbContext();
            return
                db.RecordCategories?.Select(c => c.Name)?.ToList();
        }

        internal static void RecordSave(Record rec)
        {
            using var db = new AppDbContext();
            db.Records.Add(rec);
            db.SaveChanges();
        }

        internal static void RecordSave2(string selected, DateTime selectedStart, TimeSpan timeSpan)
        {
            using var db = new AppDbContext();
            var cat = db.RecordCategories.First(c => c.Name == selected);
            var rec = new Record
            {
                RecordCategory = cat,
                StartTime = selectedStart,
                TimeSpent = timeSpan
            };
            db.Records.Add(rec);
            db.SaveChanges();
        }
    }
}
