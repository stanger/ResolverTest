using System.Reflection;
using System.Runtime.InteropServices;
using ObjCRuntime;
using UIKit;

namespace ResolverSample;

public class Program
{
	// This is the main entry point of the application.
	static void Main(string[] args)
	{
        InitNativeLibraries();

        // if you want to use a different Application Delegate class from "AppDelegate"
        // you can specify it here.
        UIApplication.Main(args, null, typeof(AppDelegate));
	}

    public static void InitNativeLibraries()
    {
        NativeLibrary.SetDllImportResolver(Assembly.GetExecutingAssembly(), ResolveLibsayhello);
        NativeLibrary.SetDllImportResolver(typeof(SayHello.Lib.SayHello).Assembly, ResolveLibsayhello);
    }

    private static IntPtr ResolveLibsayhello(string libraryName, Assembly assembly, DllImportSearchPath? searchPath)
    {
        Console.WriteLine($"ResolveLibsayhello {libraryName} {assembly.FullName}");

        if (libraryName == "libsayhello")
        {
            var handle = NativeLibrary.GetMainProgramHandle();
            return handle;
        }

        return IntPtr.Zero;
    }
}
