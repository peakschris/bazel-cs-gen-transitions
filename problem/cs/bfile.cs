using System;

public class Program
{
    public static void Main()
    {
        if (A.AFunction() == 3)
        {
            Console.WriteLine("Program successful!");
            return;
        }

        Console.WriteLine("ERROR: Failed to call function");
        Environment.Exit(1);
    }
}
