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

version (X86)
{
    public import dcos.kernel.arch.i386.vga;
}
else
{
    static assert(0, "Unsupported VGA architecture");
}
