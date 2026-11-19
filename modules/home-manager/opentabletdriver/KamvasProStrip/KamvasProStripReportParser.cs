using System;
using System.Numerics;
using OpenTabletDriver.Plugin.Tablet;
using OpenTabletDriver.Plugin.Tablet.Wheel;

namespace KamvasProStrip
{
    // Report parser for the Huion Kamvas Pro 16 (2018, PID 0x006d) that
    // exposes its touch strip as an absolute wheel.
    //
    // The stock GianoReportParser routes every report with bit 5 and 6 set
    // in byte 1 to the aux-button report, which includes the 0xF0 reports
    // the touch strip sends: `08 F0 01 01 00 <pos> ...` with pos = 1 (top)
    // .. 7 (bottom), 0 on release. This parser is the same except that 0xF0
    // becomes an IAbsoluteWheelReport, the format HuionWheelReport uses for
    // the HS610 ring. Pair with a tablet configuration declaring
    // "Wheels": [{ "AbsoluteWheelMax": 6 }].
    public class KamvasProStripReportParser : IReportParser<IDeviceReport>
    {
        public IDeviceReport Parse(byte[] data)
        {
            if (data[1] == 0xF0)
                return new StripReport(data);
            if (data[1].IsBitSet(5) && data[1].IsBitSet(6))
                return new AuxReport(data);
            return new PenReport(data);
        }
    }

    public struct StripReport : IAbsoluteWheelReport
    {
        public StripReport(byte[] report)
        {
            Raw = report;
            var pos = report[5];
            AnalogPositions = [pos != 0 ? pos - 1u : null];
        }

        public byte[] Raw { get; set; }
        public uint?[] AnalogPositions { get; set; }
    }

    // Same as OpenTabletDriver.Configurations.Parsers.UCLogic.UCLogicAuxReport.
    public struct AuxReport : IAuxReport
    {
        public AuxReport(byte[] report)
        {
            Raw = report;
            AuxButtons = new bool[20];
            for (int i = 0; i < 20; i++)
                AuxButtons[i] = report[4 + i / 8].IsBitSet(i % 8);
        }

        public byte[] Raw { get; set; }
        public bool[] AuxButtons { get; set; }
    }

    // Same as OpenTabletDriver.Configurations.Parsers.Huion.GianoReport
    // (whose constructor is internal, hence the copy).
    public struct PenReport : ITabletReport, ITiltReport
    {
        public PenReport(byte[] report)
        {
            Raw = report;
            Position = new Vector2
            {
                X = BitConverter.ToUInt16(report, 2) | ((report[8] & 1) << 16),
                Y = BitConverter.ToUInt16(report, 4) | ((report[9] & 1) << 16),
            };
            Tilt = new Vector2
            {
                X = (sbyte)report[10] * -1,
                Y = (sbyte)report[11] * -1,
            };
            Pressure = BitConverter.ToUInt16(report, 6);
            PenButtons =
            [
                report[1].IsBitSet(1),
                report[1].IsBitSet(2),
                report[1].IsBitSet(3),
            ];
        }

        public byte[] Raw { get; set; }
        public Vector2 Position { get; set; }
        public Vector2 Tilt { get; set; }
        public uint Pressure { get; set; }
        public bool[] PenButtons { get; set; }
    }
}
