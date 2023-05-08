project(
        'dcos',
        ['d'],
        version: '0.0.0',
        license: [
                'Zlib',
        ]
)

# Currently, we just support i386. Eventually
# We'll drop this and have x86_64 / aarch64 / etc.
target_arch = 'i386'
nasm_arch = 'elf'
linker_arch = 'elf_i386'
build_arch = '-m32'
build_opt_level = '-O2'

# Toolchain for the kernel itself
ldc2 = find_program('ldc2')
nasm = find_program('nasm')
linker = find_program('ld.lld')

top_root = meson.current_source_dir() / 'source'

# Compile assembly 
nasm_generator = generator(nasm,
    output: '@BASENAME@.o',
    arguments: [
        '-f@0@'.format(nasm_arch),
        '@INPUT@',
        '-o',
        '@OUTPUT@'
    ]
)

# meson makes some opinionated decisions with ldc, bypass them
ldc_generator = generator(ldc2,
    output: '@BASENAME@.o',
    arguments: [
        build_arch,
        build_opt_level,
        '-defaultlib=',
        '@INPUT@',
        '-of=@OUTPUT@',
        '-g',
        '-c',
        '-I',
        top_root,
    ]
)

subdir('source' / 'dcos')