# cpp42-gen

`cpp42-gen` is a command-line utility for quickly generating starter files for C++ 42 projects. It helps you scaffold `main.cpp`, a `Makefile`, and class files (`.cpp` and `.hpp`) for each class name you provide.

## Features

- Generate `main.cpp` and `Makefile` for your 42 project.
- Create class files for each provided class name.
- Optionally regenerate files by deleting existing ones.
- Specify destination folder for generated files.

## Usage

```sh
# Basic usage: generate files for your classes
./cppgen ClapTrap ScavTrap

# This creates:
# - main.cpp
# - Makefile
# - ClapTrap.cpp and ClapTrap.hpp
# - ScavTrap.cpp and ScavTrap.hpp

# Regenerate usage: delete previous files and recreate them
./cppgen -re ClapTrap ScavTrap

# Specify destination folder for generated files
./cppgen -d <folder_path> ClapTrap ScavTrap

# Combine with -re (overwrite, specify destination)
./cppgen -d <folder_path> -re ClapTrap ScavTrap
```

## Notes

- Make sure you have the necessary permissions to execute `cppgen`.
- Existing files will be overwritten when using `-re`.
- The `-d <folder_path>` option lets you specify where generated files are created.
- If using both `-d` and `-re` together, always write `-re` after `-d`. (e.g., `./cppgen -d <folder_path> -re ...`). Putting `-re` before `-d` will result in an error.

## License

This project is intended for use in 42 school projects. Use it freely!
