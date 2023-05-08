# Main compilation units. Slower to track all .d files rather than use
# -i, but incremental compilation may fail otherwise.
kernel_sources = [
    'main.d',
]

# Our entry hook
boot_code = nasm_generator.process(
    [meson.current_source_dir() / 'arch' / target_arch / 'boot.asm']
)

# Control linking properly
linker_script = meson.current_source_dir() / 'arch' / target_arch / 'linker.ld'

# Build .o from the .d files
kernel_objects = ldc_generator.process(kernel_sources)

# Build a kernel image
final_image = custom_target(
    'dcos_kernel',
    output: 'dcos_kernel',
    build_always: true,
    command: [
        linker,
        '-m@0@'.format(linker_arch),
        '-T', linker_script,
        '-o', '@OUTPUT@',
        '@INPUT@',
    ],
    input: [
        kernel_objects,
        boot_code,
    ]
)