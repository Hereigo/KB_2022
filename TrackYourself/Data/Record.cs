namespace TrackYourself.Data
{
    public class Record
    {
        public int Id { get; set; }

        public DateTime StartTime { get; set; }

        public int MinutesLength { get; set; }

        public RecordCategory? RecordCategory { get; set; }
    }
}
