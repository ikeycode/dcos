/*
 * SPDX-FileCopyrightText: Copyright © 2023 Ikey Doherty
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * dcos.kernel.arch.i386.vga
 *
 * x86 implementation for VGA
 *
 * Authors: Copyright © 2023 Ikey Doherty
 * License: Zlib
 */

module dcos.kernel.arch.i386.vga;

@safe:

import core.volatile : volatileStore;

struct VGA
{

public static:

    /** 
     * Clear the terminal display
     */
    void clear()
    {
        foreach (i; 0 .. width * height)
        {
            () @trusted { volatileStore(videoMemory + i, 0); }();
        }
    }

private:

    __gshared ushort* _videoMemory = () @trusted { return cast(ushort*) 0xB8000; }();

    pragma(inline, true) @property auto videoMemory() @trusted => _videoMemory;
    pragma(inline, true) @property auto x() @trusted => _x;
    pragma(inline, true) @property auto x(uint n) @trusted => _x = n;
    pragma(inline, true) @property auto y() @trusted => _y;
    pragma(inline, true) @property auto y(uint n) @trusted => _y = n;

    __gshared uint _x;
    __gshared uint _y;

    enum width = 80;
    enum height = 25;
}
