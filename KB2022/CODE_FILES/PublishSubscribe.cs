// PUBLISH SUBSCRIBE PATTERN (TO LOOSE COUPLING BETWEEN COMPONENTS)
public class MyEventArgs : EventArgs
{
    public int Value { get; set; }
    public MyEventArgs(int value)
    {
        Value = value;
    }
}

public class PublisherSimple
{
    // ON_CHANGE PROPERTY: containing all the list of subscribers callback methods
    public Action? OnChange_SubsList { get; set; }
    public void Raise()
    {
        OnChange_SubsList?.Invoke();
    }
}

public class PubEventHandle
{
    // SUBSCR <=> PUBLISH - BROKER:
    public event EventHandler<MyEventArgs> OnChange_SubsList = delegate { };
    public void Raise()
    {
        OnChange_SubsList(this, new MyEventArgs(33));
    }
}

public class PubExcepHandle
{
    public event EventHandler<MyEventArgs> OnChange_SubsList = delegate { };
    public void Raise()
    {
        MyEventArgs eventArgs = new MyEventArgs(33);
        List<Exception> exceptions = new List<Exception>();
        foreach (Delegate handler in OnChange_SubsList.GetInvocationList())
        {
            try
            {
                handler.DynamicInvoke(this, eventArgs);
            }
            catch (Exception e)
            {
                exceptions.Add(e);
            }
        }
        if (exceptions.Any())
        {
            // throw new AggregateException(exceptions);
            Console.WriteLine(
                "\r\nExceptions!!! (are processing out of Events-Handling) ...");
        }
    }
}

public static class Program
{
    static void Main()
    {
        PublisherSimple p = new();
        PubEventHandle peh = new();
        PubExcepHandle pxh = new();

        // REGISTER SUBSCRIBERS FOR EVENT:

        p.OnChange_SubsList += () => Console.WriteLine("Subscr.1!");
        p.OnChange_SubsList += () => Console.WriteLine("Subscr.2!");

        peh.OnChange_SubsList += (sender, eArgs) => Console.WriteLine("Subscr.21! Val:" + eArgs.Value);
        // peh.OnChange_SubsList += (sender, eArgs) => throw new Exception(); - THROW HERE !!!
        peh.OnChange_SubsList += (sender, eArgs) => Console.WriteLine("Subscr.23! Val:" + eArgs.Value);

        pxh.OnChange_SubsList += (sender, eArgs) => Console.WriteLine("Subscr.31! Val:" + eArgs.Value);
        pxh.OnChange_SubsList += (sender, eArgs) => throw new Exception(); // Exceptions Handled
        pxh.OnChange_SubsList += (sender, eArgs) => throw new Exception(); // ... by Publisger.
        pxh.OnChange_SubsList += (sender, eArgs) => Console.WriteLine("Subscr.34! Val:" + eArgs.Value);

        // RAISE THE EVENT:

        p.Raise();
        peh.Raise();
        pxh.Raise();

        Console.WriteLine("\r\nAll done.");
        Console.ReadLine();
    }
}