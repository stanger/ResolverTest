using System.Runtime.InteropServices;

namespace SayHello.Lib;

// All the code in this file is included in all platforms.
public class SayHello
{
    [DllImport("libsayhello")]
    public static extern int say_hello();
}
