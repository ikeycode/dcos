DCOS (D-Core OS)
---------------

Pet project to help me learn more about OS theory, so that I can
build out more optimal tooling solutions for Serpent OS. This is
only a research project and there are no plans to incorporate it
into Serpent OS.

### Current state

It's a complete crapshow right now with basic i386/CGA support.
I'll start working towards x86_64 support and enforce use of
framebuffers, including the GOP FB from UEFI.

Per issue 1, the plan is to start out modern and drop the legacy cruft
before it has a chance to build up.

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