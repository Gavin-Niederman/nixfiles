using System;
using OpenTabletDriver.Plugin;
using OpenTabletDriver.Plugin.Attributes;
using OpenTabletDriver.Plugin.DependencyInjection;
using OpenTabletDriver.Plugin.Platform.Pointer;
using OpenTabletDriver.Plugin.Tablet;

namespace KamvasProStrip
{
    // Like the stock "Mouse Scroll Binding", but scrolls through OTD's
    // virtual mouse (the relative-mode pointer device) instead of the
    // current output mode's pointer. Artist Mode's virtual tablet has no
    // scroll handler, so the stock binding logs "IMouseScrollHandler
    // unavailable" there; this one works in every output mode.
    //
    // One scroll per press, no repeat timer: meant for wheel bindings, where
    // each wheel step is one press.
    [PluginName(PLUGIN_NAME)]
    public class VirtualMouseScrollBinding : IStateBinding
    {
        private const string PLUGIN_NAME = "Virtual Mouse Scroll Binding";

        [Resolved]
        public IRelativePointer? Pointer { get; set; }

        [Property("Direction"), DefaultPropertyValue("Vertical"), PropertyValidated(nameof(ValidDirections))]
        public string Direction { get; set; } = "Vertical";

        [BooleanProperty("Invert", "Scroll Direction")]
        public bool Invert { get; set; }

        private int _amount = 120;

        [Property("Amount"), DefaultPropertyValue(120), ToolTip("How far to scroll per activation. 120 is one wheel notch.")]
        public int Amount
        {
            get => _amount;
            set => _amount = value != 0 ? value : 120;
        }

        public static string[] ValidDirections => ["Vertical", "Horizontal"];

        public void Press(TabletReference tablet, IDeviceReport report)
        {
            if (Pointer is not IMouseScrollHandler scroll)
            {
                Log.Write(PLUGIN_NAME, $"{nameof(IRelativePointer)} has no scroll support on this platform", LogLevel.Error);
                return;
            }

            // Same sign convention as the stock binding: not inverted scrolls
            // down / right.
            int amount = Invert ? Amount : -Amount;
            if (string.Equals(Direction, "Horizontal", StringComparison.OrdinalIgnoreCase))
                scroll.ScrollHorizontally(amount);
            else
                scroll.ScrollVertically(amount);

            if (Pointer is ISynchronousPointer sync)
                sync.Flush();
        }

        public void Release(TabletReference tablet, IDeviceReport report)
        {
        }

        public override string ToString() => $"{PLUGIN_NAME}: Direction: {Direction}, Amount: {Amount}, Invert: {Invert}";
    }
}
