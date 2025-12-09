# cpp42-gen

`cpp42-gen` is a command-line utility for quickly generating starter files for C++ 42 projects. It helps you scaffold `main.cpp`, a `Makefile`, and class files (`.cpp` and `.hpp`) for each class name you specify.

## Features

- Generate `main.cpp` and `Makefile` for your 42 project.
- Create class files for each provided class name.
- Optionally regenerate files by deleting existing ones.

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
```

## Notes

- Make sure you have the necessary permissions to execute `cppgen`.
- Existing files will be overwritten when using `-re`.

## License

This project is intended for use in 42 school projects. Use it freely!

