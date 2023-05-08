/*
 * SPDX-FileCopyrightText: Copyright © 2023 Ikey Doherty
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * dcos.kernel.vga
 *
 * Forward to architecture specific VGA implementation
 *
 * Authors: Copyright © 2023 Ikey Doherty
 * License: Zlib
 */

module dcos.kernel.vga;

/** 
 * Used to control colour sequences in output
 */
public enum VGAColorCode : ubyte
{
    black,
    blue,
    green,
    cyan,
    red,
    magenta,
    brown,
    lightGrey,
    darkGrey,
    lightBlue,
    lightGreen,
    lightCyan,
    lightRed,
    lightMagenta,
    lightBrown,
    white
}

/** 
 * Combination of foreground and background VGAColorCode
 */
public struct VGAColor
{
align(1):

    /** 
     * Foreground colour
     */
    VGAColorCode fg = VGAColorCode.white;

    /** 
     * Background colour
     */
    VGAColorCode bg = VGAColorCode.black;
}

version (X86)
{
    public import dcos.kernel.arch.i386.vga;
}
else
{
    static assert(0, "Unsupported VGA architecture");
}
