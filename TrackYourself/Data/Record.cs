using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace TrackYourself.Data
{
    public class Record
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        public DateTime StartTime { get; set; }

        public TimeSpan TimeSpent { get; internal set; }

        public RecordCategory? RecordCategory { get; set; }
    }
}
