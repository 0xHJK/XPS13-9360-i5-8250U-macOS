/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20170929 (64-bit version)(RM)
 * Copyright (c) 2000 - 2017 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of ./CLOVER/ACPI/patched/SSDT-YTBT.aml, Thu Jul 25 09:48:26 2019
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x0000003D (61)
 *     Revision         0x02
 *     Checksum         0xEA
 *     OEM ID           "hack"
 *     OEM Table ID     "YTBT"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20170929 (538380585)
 */
DefinitionBlock ("", "SSDT", 2, "hack", "YTBT", 0x00000000)
{
    Scope (\_GPE)
    {
        Method (YTBT, 2, NotSerialized)
        {
            If ((Arg0 == Arg1))
            {
                Return (Zero)
            }
            Else
            {
                Return (Zero)
            }
        }
    }
}

