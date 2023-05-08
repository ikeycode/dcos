/*
 * SPDX-FileCopyrightText: Copyright © 2023 Ikey Doherty
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * dcos.kernel.cga
 *
 * Forward to architecture specific CGA implementation
 *
 * Authors: Copyright © 2023 Ikey Doherty
 * License: Zlib
 */

module dcos.kernel.cga;

@safe:

/** 
 * Used to control colour sequences in output
 */
public enum CGAColorCode : ubyte
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
 * Combination of foreground and background CGAColorCode
 */
public struct CGAColor
{
align(1):

    /** 
     * Foreground colour
     */
    CGAColorCode fg = CGAColorCode.white;

    /** 
     * Background colour
     */
    CGAColorCode bg = CGAColorCode.black;
}

version (X86)
{
    public import dcos.kernel.arch.i386.cga;
}
else
{
    static assert(0, "Unsupported CGA architecture");
}
