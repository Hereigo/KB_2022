using TrackYourself.Data;

namespace TrackYourself
{
    public partial class Form1 : Form
    {
        private const int bigHeight = 336;
        private const int bigWidth = 795;
        private const int smallHeight = 85;
        private const int smallWidth = 196;

        private static DateTime selectedStart;
        private static int hours;
        private static int minutes;
        private static int seconds;
        private static string selectedPrev = string.Empty;

        public Form1()
        {
            InitializeComponent();
            // this.ControlBox = false; // Disable CloseButton.
            Width = smallWidth;
            Height = smallHeight;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            comboBox1.DataSource = AppDbAccessor.GetCategoriesNames();

            var MyTimer = new System.Windows.Forms.Timer();
            MyTimer.Interval = 1000;
            MyTimer.Tick += (sndr, evnt) => MyTimer_Tick(sndr, evnt);
            MyTimer.Start();
        }

        private void MyTimer_Tick(object sender, EventArgs e)
        {
            if (selectedPrev != (string)comboBox1.SelectedValue)
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

                Text = $"{DateTime.Now:HH:mm} - {selectedPrev} - {hours}:{zerosMinutes}:{zerosSeconds}";

                seconds++;
            }
        }

        private void ComboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(selectedPrev)) // TEMPORARY !!!!!!!!!!!!!!!! && (hours > 0 || minutes > 1)) !!!!!!!!!!!!!!!!!!!!!!
            {
                AppDbAccessor.RecordSave2(selectedPrev, selectedStart, new TimeSpan(hours, minutes, seconds));
            }

            hours = 0;
            minutes = 0;
            seconds = 0;
            selectedPrev = (string)comboBox1.SelectedValue;
            selectedStart = DateTime.Now;
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            var changeSize = bigWidth - smallWidth;

            if (Height == smallHeight)
            {
                Height = bigHeight;
                Width = bigWidth;
                Location = DecreaseX(Location, changeSize);
                button1.Location = IncreaseX(button1.Location, changeSize);
                comboBox1.Location = IncreaseX(comboBox1.Location, changeSize);
            }
            else
            {
                Height = smallHeight;
                Width = smallWidth;
                Location = IncreaseX(Location, changeSize);
                button1.Location = DecreaseX(button1.Location, changeSize);
                comboBox1.Location = DecreaseX(comboBox1.Location, changeSize);
            }
        }

        private static Point DecreaseX(Point location, int changeSize)
        {
            return new Point(location.X - changeSize, location.Y);
        }

        private static Point IncreaseX(Point location, int changeSize)
        {
            return new Point(location.X + changeSize, location.Y);
        }
    }
}