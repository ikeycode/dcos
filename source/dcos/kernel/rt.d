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

import dcos.kernel.cga;

@safe:
public:

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
    CGA.put(file, CGAColor(CGAColorCode.darkGrey));
    CGA.put(":: asserted!", CGAColor(CGAColorCode.red));
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
    CGA.put(file, CGAColor(CGAColorCode.darkGrey));
    CGA.put(":: assert: ", CGAColor(CGAColorCode.red));
    CGA.put(msg, CGAColor(CGAColorCode.lightGrey));
}
