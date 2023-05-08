/*
 * SPDX-FileCopyrightText: Copyright © 2023 Ikey Doherty
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * dcos.kernel.rt
 *
 * Runtime hooks for making dlang features work in the kernel
 *
 * Authors: Copyright © 2023 Ikey Doherty
 * License: Zlib
 */

module dcos.kernel.rt;

import dcos.kernel.vga;

/** 
 * D assertion handling
 *
 * Params:
 *   file = What file it happened in
 *   line = The line it happened on
 */
extern (C) void _d_assert(string file, uint line)
{
    /* TODO: Use logging system! */
    VGA.put(file, VGAColor(VGAColorCode.darkGrey));
    VGA.put(":: asserted!", VGAColor(VGAColorCode.red));
}

/** 
 * D assertion handling
 *
 * Params:
 *   msg = Message in the assert()
 *   file = What file it happened in
 *   line = The line it happened on
 */
extern (C) void _d_assert_msg(string msg, string file, uint line,)
{
    /* TODO: Use logging system! */
    VGA.put(file, VGAColor(VGAColorCode.darkGrey));
    VGA.put(":: assert: ", VGAColor(VGAColorCode.red));
    VGA.put(msg, VGAColor(VGAColorCode.lightGrey));
}
