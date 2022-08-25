namespace TrackYourself
{
    public partial class Form1 : Form
    {
        private const int _width = 243;
        private const int _bigHeight = 260;
        private const int _smallHeight = 85;
        private static string _selected = string.Empty;

        public Form1()
        {
            InitializeComponent();
            // this.ControlBox = false; // Disable CloseButton.
            Width = _width;
            Height = _smallHeight;
        }

        private void MyTimer_Tick(object sender, EventArgs e)
        {
            Text = _selected + " - " + DateTime.Now.ToString("HH:mm:ss");
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            Height = Height == _smallHeight ? _bigHeight : _smallHeight;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            var MyTimer = new System.Windows.Forms.Timer();
            MyTimer.Interval = 1000;
            MyTimer.Tick += (sndr, evnt) => MyTimer_Tick(sndr, evnt);
            MyTimer.Start();

            comboBox1.DataSource = Data.AppDbAccessor.GetCategories();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            _selected = (string)comboBox1.SelectedValue;
        }
    }
}