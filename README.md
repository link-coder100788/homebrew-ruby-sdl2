# Homebrew tap for python_sdl2

Cross-language SDL2 and OpenAL bindings that expose the same core engine-style API to both Python and Ruby.

## Overview

This project provides native extension modules for:

- **Python** as `python_sdl2`
- **Ruby** as `RubySDL2`

It is designed around a small set of shared concepts:

- `Window` for rendering and event handling.
- `Sprite` for drawable objects.
- `ScreenCoordinate` for 2D positions.
- `OpenALPlayer` for audio playback.

The Python binding uses a generated reflection layer, while the Ruby binding is implemented directly against the shared core code.

## Features

- SDL2 window creation and management.
- Event polling and key input helpers.
- Sprite drawing support.
- Screen clearing and buffer presentation.
- OpenAL sound playback.
- Shared SDL2/OpenAL core logic across both language bindings.

## Requirements

- CMake 4.3 or newer.
- A C++14-compatible compiler.
- Python 3 with development headers.
- Ruby with development headers.
- SDL2.
- OpenAL.
- LLVM and Clang for the Python reflection tool.

## Installation

### macOS

Install the dependencies with Homebrew:

```bash
brew install sdl2 openal-soft llvm python ruby cmake
```

If CMake cannot find LLVM, you may need to point it at Homebrew's LLVM installation:

```bash
cmake -S . -B build -DLLVM_DIR="$(brew --prefix llvm)/lib/cmake/llvm"
```

### Linux

On Debian or Ubuntu, install the dependencies with apt:

```bash
sudo apt update
sudo apt install build-essential cmake python3-dev ruby-dev libsdl2-dev libopenal-dev llvm-dev clang
```

If your distribution packages LLVM and Clang separately, install both.

### Windows

Use a package manager such as vcpkg or install the dependencies manually, then configure CMake so it can find Python, Ruby, SDL2, OpenAL, and LLVM.

## Build

```bash
cmake -S . -B build
cmake --build build
```

The project builds both bindings by default. If you want to build only one binding, use the CMake options provided by the project as needed.

## Generated artifacts

The build creates a small reflection generator executable and uses it to produce the Python binding glue code at build time.

Expected outputs include:

- `python_sdl2` Python extension with the correct platform suffix.
- `ruby_sdl2.bundle` Ruby extension.
- `reflect_tool` helper executable.

## Python usage

```python
import python_sdl2

print(python_sdl2.version())
python_sdl2.init()
window = python_sdl2.create_window(...)
```

### Python types

- `python_sdl2.Window`
- `python_sdl2.OpenALPlayer`
- `python_sdl2.Sprite`
- `python_sdl2.ScreenCoordinate`

### Python functions

- `version()`
- `init()`
- `quit()`
- `create_window(...)`
- `pump_window()`
- `get_ticks()`
- `help()`
- `play_sound(...)`
- `_debug()`
- `get_keycode_from_name(...)`

## Ruby usage

```ruby
require 'ruby_sdl2'

puts RubySDL2.version
RubySDL2.init
window = RubySDL2::Window.new(...)
```

### Ruby classes

- `RubySDL2::Window`
- `RubySDL2::OpenALPlayer`
- `RubySDL2::Sprite`
- `RubySDL2::ScreenCoordinate`

### Ruby module functions

- `version`
- `init`
- `quit`
- `get_ticks`
- `help`
- `_debug`
- `get_keycode_from_name(...)`
- `play_sound(...)`

## Error handling

Both bindings expose the same custom errors:

- `SDLError`
- `OpenALError`
- `ArgumentError`

## Project layout

- `src/bindings/` — Python and Ruby binding entry points.
- `src/core/` — shared SDL2/OpenAL core implementation.
- `tools/reflector.cpp` — reflection generator used for Python bindings.
- `generated/` — build-time generated reflection files.

## Notes

- The Python module name is `python_sdl2.cpython-314-darwin.so`.
- The Ruby extension name is `ruby_sdl2.bundle`.
- The build treats warnings as errors.

## License

MIT Licence
