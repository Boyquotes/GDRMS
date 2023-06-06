#!/usr/bin/env python
import os
import sys

# Godot-cpp gives us the base SConscript to include
env = SConscript("../godot-cpp/SConstruct")
env.Append(CPPPATH=['.', 'src/'])

# outpath defines the path we'll use for producing our library
out_path = ("bin/")

# Common sources
sources = []
sources = Glob("src/*.cpp")

# storing in local variables for later :
platform = env["platform"]
target = env["target"]
suffix = env["suffix"]
shlib  = env["SHLIBSUFFIX"]

# Linux Build
if platform in ["linuxbsd", "linux"]:
    env.Append(CCFLAGS = ['-fPIC', '-g','-O3', '-std=c++17'])
    library = env.SharedLibrary( f"{out_path}/libgdrms{suffix}{shlib}", source=sources)
# MacOS build (not called darwin for some reason !)
elif platform  == "macos":
    # these flags won't work on aarch64
    # TODO : aarch64 build and maybe move to a newer std (c++20 ?) 
    env.Append(CCFLAGS = ['-g','-O3', '-arch', 'x86_64', '-std=c++17'])
    env.Append(LINKFLAGS = ['-arch', 'x86_64'])
    library = env.SharedLibrary(f"{out_path}/libgdrms.{platform}.{target}.framework/libgdrms.{platform}.{target}", source=sources)

else: # platform  == "windows":
    if target == "debug":
        env.Append(CCFLAGS = ['-EHsc', '-D_DEBUG', '/MDd', '-DOSC_HOST_LITTLE_ENDIAN'])
    else:
        env.Append(CCFLAGS = ['-O2', '-EHsc', '-DNDEBUG', '/MD', '-DOSC_HOST_LITTLE_ENDIAN'])\
    # add libraries :
    library = env.SharedLibrary(
        f"{out_path}/libgdrms{suffix}{shlib}",
        source=sources
    )

# Just build !
Default(library)