// ATTRIBUTE USAGE
using System.Reflection;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Method)]
public class MyTestAttrAttribute : Attribute
{
    public int Version { get; set; }
    public string? Name { get; set; }
}

[MyTestAttr(Name = "MTA", Version = 1)]
public class JustClass
{
    [Required]
    // [MyTestAttr] => ERROR! --- has NO "AttributeTargets.Property" in "MyTestAttr"!
    public string MyStrProperty { get; set; }

    [MyTestAttr]
    public void MyMethod() { }
}

public static class Program
{
    static void Main()
    {
        var types = from t in Assembly.GetExecutingAssembly().GetTypes()
                    where t.GetCustomAttributes<MyTestAttrAttribute>().Any()
                    select t;

        foreach (var tp in types)
        {
            Console.WriteLine("Type : " + tp.Name);

            foreach (var prop in tp.GetProperties())
            {
                Console.WriteLine("Prop : " + prop.Name);
            }
        }
    }
}

[AttributeUsage(AttributeTargets.All, AllowMultiple = false)]
public class RequiredAttribute : Attribute
{
    public string ErrorMessage { get; set; }
    public RequiredAttribute()
    {
        ErrorMessage = "Field {0} can't be empty!";
    }
}

public static class Validation
{
    public static bool PropertyValueIsValid(Type type, string enteredValue, string elementName)
    {
        PropertyInfo propertyInfo = type.GetProperty(elementName);
        Attribute[] attributes = propertyInfo.GetCustomAttributes().ToArray();
        string errorMessage = "";
        foreach (var attr in attributes)
        {
            switch (attr)
            {
                case RequiredAttribute ra:
                    if (RequiredStringValidate(enteredValue))
                    {
                        errorMessage = ra.ErrorMessage;
                        return false;
                    }
                    break;
                    // case AnyAnotherAttribute ...
            }
        }
        return true;
    }

    public static bool RequiredStringValidate(string value)
    {
        return value != null && value.Length > 0;
    }
}