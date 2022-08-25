namespace TrackYourself
{
    internal static class Program
    {
        [STAThread]
        static void Main()
        {
            ApplicationConfiguration.Initialize();

            using (var db = new Data.MyDbContext())
            {
                if (!db.RecordCategories.Any())
                {
                    db.AddRange(
                        new Data.RecordCategory() { Name = "DOT" },
                        new Data.RecordCategory() { Name = "ENJ" },
                        new Data.RecordCategory() { Name = "FAM" },
                        new Data.RecordCategory() { Name = "HLS" },
                        new Data.RecordCategory() { Name = "RLX" },
                        new Data.RecordCategory() { Name = "STU" },
                        new Data.RecordCategory() { Name = "WIF" },
                        new Data.RecordCategory() { Name = "WOK" }
                        );
                    db.SaveChanges();
                }
            }
            Application.Run(new Form1());
        }
    }
}