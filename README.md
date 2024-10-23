# SimpleASN1Parser

A simple ASN1 parser to be used in the ASN1Sky project.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

## Dependencies

To build and run this project, you need the following tools installed on your system:

- **Flex**: A tool for generating scanners (tokenizers), which is required to process the `calc.l` file.
- **Yacc**: A parser generator that processes the `calc.y` file.
- **GCC**: A C compiler, like `gcc`, for compiling the generated source files.

# Build and Run Instructions

## To make:
```bash
make
```

## To run:
```bash
./calc.out < tests/numbers
```

## To make and run:
```bash
make && ./calc.out < tests/numbers
```

