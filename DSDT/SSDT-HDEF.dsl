// Automatic injection of HDEF properties

DefinitionBlock("", "SSDT", 2, "hack", "HDEF", 0)
{
    External(_SB.PCI0.HDEF, DeviceObj)
    External(_SB.PCI0.HDEF.XDSM, MethodObj)
    External(RMCF.AUDL, IntObj)

    // Note: If your ACPI set (DSDT+SSDTs) does not define HDEF (or AZAL or HDAS)
    // add this Device definition (by uncommenting it)
    //
    //Device(_SB.PCI0.HDEF)
    //{
    //    Name(_ADR, 0x001b0000)
    //    Name(_PRW, Package() { 0x0d, 0x05 }) // may need tweaking (or not needed)
    //}

    // inject properties for audio
    Method(_SB.PCI0.HDEF._DSM, 4)
    {
        // Pass call to original _DSM first
        \_SB.PCI0.HDEF.XDSM(Arg0, Arg1, Arg2, Arg3)

        If (CondRefOf(\RMCF.AUDL)) { If (Ones == \RMCF.AUDL) { Return(0) } }
        If (!Arg2) { Return (Buffer() { 0x03 } ) }
        Local0 = Package()
        {
            "layout-id", Buffer(4) { 3, 0, 0, 0 },
            "built-in", Buffer() { 0x00 },
            "hda-gfx", Buffer() { "onboard-1" },
            "RM,device-id", Buffer(4) { 0x70, 0x9d, 0x00, 0x00 },
            "PinConfigurations", Buffer() { 0x00 },
        }
        If (CondRefOf(\RMCF.AUDL))
        {
            CreateDWordField(DerefOf(Local0[1]), 0, AUDL)
            AUDL = \RMCF.AUDL
        }
        Return(Local0)
    }
}
//EOF
