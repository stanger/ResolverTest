using System.Runtime.InteropServices;

namespace ResolverSample.Interop;

// All the code in this file is included in all platforms.
public class SayHello
{
    [DllImport("__Internal")]
    public static extern int say_hello();
}
