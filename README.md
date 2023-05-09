DCOS (D-Core OS)
---------

Experimental project to learn more about OS theory, while
highlighting the benefits of developing with D, even in a
constrained environment.

### Current state

It's a complete crapshow right now with basic i386/CGA support.
I'll start working towards x86_64 support and enforce use of
framebuffers, including the GOP FB from UEFI.

Don't expect anything from this project, it's scratching a
personal itch!

### Testing

Currently we boot using the legacy Multiboot spec so it is possible to
directly boot the kernel using the `-kernel` parameter in Qemu. In future
we'll support different modes.

    meson setup build
    ninja -C build -v
    qemu-system-i386 -kernel build/source/dcos/kernel/dcos_kernel -m 128 -enable-kvm

### License

Copyright © 2023 Ikey Doherty

Available under the terms of the [Zlib](https://spdx.org/licenses/Zlib.html) license