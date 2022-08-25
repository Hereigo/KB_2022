using TrackYourself.Data;

namespace TrackYourself
{
    internal static class Program
    {
        [STAThread]
        static void Main()
        {
            ApplicationConfiguration.Initialize();

            AppDbAccessor.SeedDatabase();

            Application.Run(new Form1());
        }
    }
}