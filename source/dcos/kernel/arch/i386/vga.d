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
import std.traits : isSomeString, OriginalType;

/** 
 * Namespace access to the VGA methods
 */
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

    /** 
     * Render some text to the VGA display
     * Params:
     *   text = Input text to render
     */
    void put(String)(String text) if (isSomeString!(OriginalType!String))
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
            default:
                /* TODO: Support colours */
                const colorRepr = vgaColor(3, 0);
                const repr = vgaRepresentation(elem, colorRepr);

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
     * Convert VGA color sequence
     *
     * Params:
     *   fg = Foreground color ID
     *   bg = Background color ID
     *
     * Returns: VGA colour sequence
     */
    static auto vgaColor(ushort fg, ushort bg) => cast(ushort)(fg | bg << 4);

    /** 
     * Convert char + color into VGA reprensentation
     *
     * Params:
     *   c = Character to display
     *   color = VGA color representation
     *
     * Returns: VGA representation of the character
     */
    static auto vgaRepresentation(Char)(Char c, ushort color) => cast(ushort)(c | color << 8);

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