using Microsoft.Maui.Accessibility;

namespace ResolverSample;

public partial class MainPage : ContentPage
{

	public MainPage()
	{
		InitializeComponent();
	}

	private void OnCounterClicked(object sender, EventArgs e)
	{
		try
		{
            var value = SayHello.Lib.SayHello.say_hello();

            CounterBtn.Text = $"After say_hello() call {value}";

            SemanticScreenReader.Announce(CounterBtn.Text);
        }
		catch (Exception ex)
		{
			Console.WriteLine(ex);
		}

	}
}

