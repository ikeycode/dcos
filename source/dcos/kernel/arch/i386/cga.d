/*
 * SPDX-FileCopyrightText: Copyright © 2023 Ikey Doherty
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * dcos.kernel.arch.i386.cga
 *
 * x86 implementation for CGA
 *
 * Authors: Copyright © 2023 Ikey Doherty
 * License: Zlib
 */

module dcos.kernel.arch.i386.cga;

@safe:

import core.volatile : volatileStore;
import std.traits : isSomeString, OriginalType;
import dcos.kernel.cga : CGAColor, CGAColorCode;

/** 
 * Namespace access to the CGA methods
 */
struct CGA
{

public static:

    /** 
     * Clear the terminal display
     */
    void clear() @trusted
    {
        foreach (idx; 0 .. width * height)
        {
            volatileStore(videoMemory + idx, 0);
        }
    }

    /** 
     * Render some text to the CGA display
     *
     * Params:
     *   text = Input text to render
     *   color = Colour to draw the text with
     */
    void put(String)(String text, CGAColor color = CGAColor.init)
            if (isSomeString!(OriginalType!String))
    {
        writer: foreach (elem; text)
        {
            const idx = y * width + x;

            switch (elem)
            {
            case '\n':
                x = 0;
                y = y + 1;
                continue writer;
            case '\0':
                break writer;
            default:
                immutable colorRepr = cgaColor(color.fg, color.bg);
                immutable repr = cgaRepresentation(elem, colorRepr);

                () @trusted { volatileStore(videoMemory + idx, repr); }();
                break;
            }

            /* Linewrap, cuz we're nice. */
            x = x + 1;
            if (x > width)
            {
                x = 0;
                y = y + 1;
            }
        }
    }

private:

    /** 
     * Convert CGA color sequence
     *
     * Params:
     *   fg = Foreground color ID
     *   bg = Background color ID
     *
     * Returns: CGA colour sequence
     */
    pragma(inline, true) pure static auto cgaColor(ushort fg, ushort bg) => cast(ushort)(fg | bg << 4);

    /** 
     * Convert char + colour into CGA reprensentation
     *
     * Params:
     *   c = Character to display
     *   color = CGA colour representation
     *
     * Returns: CGA representation of the character
     */
    pragma(inline, true) pure static auto cgaRepresentation(Char)(Char c, ushort color) => cast(
            ushort)(c | color << 8);

    pragma(inline, true) __gshared ushort* _videoMemory = () @trusted {
        return cast(ushort*) 0xB8000;
    }();

    pragma(inline, true) @property videoMemory() @trusted => _videoMemory;
    pragma(inline, true) @property x() @trusted => _x;
    pragma(inline, true) @property x(uint n) @trusted => _x = n;
    pragma(inline, true) @property y() @trusted => _y;
    pragma(inline, true) @property y(uint n) @trusted => _y = n;

    __gshared uint _x;
    __gshared uint _y;

    enum width = 80;
    enum height = 25;
}
