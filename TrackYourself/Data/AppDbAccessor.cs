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

        internal static List<string>? GetCategories()
        {
            using (var db = new Data.AppDbContext())
                return 
                    db.RecordCategories?.Select(c => c.Name)?.ToList();
        }
    }
}
