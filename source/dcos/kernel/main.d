/*
 * SPDX-FileCopyrightText: Copyright © 2023 Ikey Doherty
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * main
 *
 * Kernel main entry
 *
 * Authors: Copyright © 2023 Ikey Doherty
 * License: Zlib
 */
module main;

import dcos.kernel.vga;

/** 
 * Main entry into the DCOS kernel
 */
extern (C) void kmain(uint magic, uint addr)
{
    VGA.clear();
    VGA.put(" >> ", VGAColor(VGAColorCode.lightBrown));
    VGA.put("Initialising DCOS\n");

    while (true)
    {
        /* Suspend execution */
        asm @trusted
        {
            hlt;
        }
    }
}
