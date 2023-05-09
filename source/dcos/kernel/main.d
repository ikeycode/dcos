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

import dcos.kernel.cga;

/** 
 * Main entry into the DCOS kernel
 */
extern (C) void kmain(uint magic, uint addr)
{
    CGA.clear();
    CGA.put(" >> ", CGAColor(CGAColorCode.lightBrown));
    CGA.put("Initialising DCOS\n");

    CGA.put(import("intro.txt"), CGAColor(CGAColorCode.lightGrey));

    while (true)
    {
        /* Suspend execution */
        asm @trusted
        {
            hlt;
        }
    }
}
