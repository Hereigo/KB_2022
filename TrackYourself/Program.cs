namespace TrackYourself
{
    internal static class Program
    {
        [STAThread]
        static void Main()
        {
            ApplicationConfiguration.Initialize();

            using (var db = new Data.ApplicationContext())
            {
                if(!db.RecordCategories.Any())
                {
                    db.Add(new Data.RecordCategory() { Name = "WOK" });
                    db.SaveChanges();
                }
            }
            Application.Run(new Form1());
        }
    }
}