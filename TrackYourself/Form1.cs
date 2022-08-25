namespace TrackYourself
{
    public partial class Form1 : Form
    {
        private const int _width = 251;
        private const int _bigHeight = 314;
        private const int _smallHeight = 73;

        public Form1()
        {
            InitializeComponent();
            panel1.Visible = false;
            // this.ControlBox = false; // Disable CloseButton.
            Width = _width;
            Height = _smallHeight;
        }

        private void MyTimer_Tick(object sender, EventArgs e)
        {
            Text = DateTime.Now.ToString("HH:mm:ss");
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            panel1.Visible = !panel1.Visible;
            Height = Height == _smallHeight ? _bigHeight : _smallHeight;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            var MyTimer = new System.Windows.Forms.Timer();
            MyTimer.Interval = 1000;
            MyTimer.Tick += (sndr, evnt) => MyTimer_Tick(sndr, evnt);
            MyTimer.Start();
        }
    }
}