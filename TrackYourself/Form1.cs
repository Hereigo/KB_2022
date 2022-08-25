namespace TrackYourself
{
    public partial class Form1 : Form
    {
        private const int width = 196;
        private const int bigHeight = 336;
        private const int smallHeight = 85;

        private static string selected = string.Empty;
        private static int hours;
        private static int minutes;
        private static int seconds;

        public Form1()
        {
            InitializeComponent();
            // this.ControlBox = false; // Disable CloseButton.
            Width = width;
            Height = smallHeight;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            comboBox1.DataSource = Data.AppDbAccessor.GetCategories();

            var MyTimer = new System.Windows.Forms.Timer();
            MyTimer.Interval = 1000;
            MyTimer.Tick += (sndr, evnt) => MyTimer_Tick(sndr, evnt);
            MyTimer.Start();
        }

        private void MyTimer_Tick(object sender, EventArgs e)
        {
            if (seconds > 59)
            {
                seconds = 0;
                minutes++;
            }
            if (minutes > 59)
            {
                minutes = 0;
                hours++;
            }

            string zerosMinutes = minutes > 9 ? minutes.ToString() : $"0{minutes}";
            string zerosSeconds = seconds > 9 ? seconds.ToString() : $"0{seconds}";

            Text = $"{DateTime.Now:HH:mm} - {selected} - {hours}:{zerosMinutes}:{zerosSeconds}";

            seconds++;
        }

        private void ComboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            hours = 0;
            minutes = 0;
            seconds = 0;
            selected = (string)comboBox1.SelectedValue;
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            Height = Height == smallHeight ? bigHeight : smallHeight;
        }
    }
}