# Regulus

A Programming Language Which Utilizes Regex

## Author(s)

- [Vaughn Cedric L. Araneta](https://github.com/CedricDeVon)

## Usage

The most recent up-to-date compiler executable, `compiler.exe`, can be found within this repository. You can run this program by executing the following command in your CLI.

``` cmd
./compiler.exe main.reg
```
The `main.reg` represents a sample input file for running the Regulus compiler. The Regulus compiler can take in any file with any file extension as input, as long as no syntactial errors are discovered during compilation time.

## Development

### Pre-requisites

- Flex (Version 2.5.4)
- Bison (Version 2.4.1)
- GCC (Version 6.3.0)
- [Regex](https://github.com/ximtech/Regex/tree/main) (A Lightweight 3rd-party Regex Library for C-based Embedded Systems)

## Features

### Console Commands

For Building The Compiler
``` cmd
flex lexer.l | bison -d parser.y | gcc -o compiler lex.yy.c parser.tab.c -LC:\MinGW\lib -lRegex
```

For Running The Compiler With A Selected Input File
``` cmd
./compiler main.reg
```

## Language Syntax

### API Overview

| Identifier | Input(s) | Output |
| :- | :- | :- |
| PRINT() | [string] | string |
| PRINT_WITH_NEW_LINE() | [string] | string |
| REGEX() | [regexp], [string] | string  |

### Supported Regex Operators ([ximtech/Regex](https://github.com/ximtech/Regex/tree/main))

-   `.`        Dot, matches any character
-   `^`        Start anchor, matches beginning of string
-   `$`        End anchor, matches end of string
-   `*`        Asterisk, match zero or more (greedy)
-   `+`        Plus, match one or more (greedy)
-   `*?`       Asterisk, match zero or more (lazy)
-   `+?`       Plus, match one or more (lazy)
-   `?`        Question, match zero or one (lazy)
-   `{m,n}`    Quantifier, match min. 'm' and max. 'n' (greedy)
-   `{m}`      Exactly 'm'
-   `{m,}`     Match min 'm' and max.
-   `[abc]`    Character class, match if one of {'a', 'b', 'c'}
-   `[^abc]`   Inverted class, regexMatch if NOT one of {'a', 'b', 'c'}
-   `[a-zA-Z]` Character ranges, the character set of the ranges { a-z | A-Z }
-   `\s`       Whitespace, \t \f \r \n \v and spaces
-   `\S`       Non-whitespace
-   `\w`       Alphanumeric, [a-zA-Z0-9_]
-   `\W`       Non-alphanumeric
-   `\d`       Digits, [0-9]
-   `\D`       Non-digits

### Print Statements

``` c

PRINT("Print");

PRINT_WITH_NEW_LINE("Print With New Line");

PRINT_WITH_NEW_LINE("Print With New Line");

// Output:
// PrintPrint With New Line
// Print With New Line

```

### Comments

``` c

// A Single Line Comment

PRINT(REGEX("[0-9]{3,}", "12345")); // Another Comment

```

### Regex Expressions

``` c

PRINT_WITH_NEW_LINE(REGEX("^[A-Za-z0-9!@#$%^&*()\\-_+=]{8,}$", "HelloWorld_1234")); // true
PRINT_WITH_NEW_LINE(REGEX("^[0-9]{4}-[0-9]{2}-[0-9]{2}$", "2024-02-29")); // true
PRINT_WITH_NEW_LINE(REGEX("^[a-zA-Z0-9]?[a-zA-Z0-9\\._%+-]{0,63}@[a-zA-Z0-9\\.-]+\\.[a-zA-Z]{2,}$", "vaughn.cedric.lipardo.araneta@gmail.com")); // true

```

## References

- Flex. (n.d.). https://gnuwin32.sourceforge.net/packages/flex.htm
- BisOn - GNU Project - Free Software Foundation. (n.d.). https://www.gnu.org/software/bison/
- GCC, the GNU Compiler Collection - GNU Project. (n.d.). https://gcc.gnu.org/
- ximtech/Regex: Regular expression C library. (n.d.). https://github.com/ximtech/Regex/tree/main
- tiny-regex-c/README.md at master · kokke/tiny-regex-c. (n.d.). GitHub. https://github.com/kokke/tiny-regex-c/blob/master/README.md
- PCRE2Project/pcre2: PCRE2 development is based here. (n.d.). GitHub. https://github.com/PCRE2Project/pcre2
- lexxmark/winflexbison: Main winflexbision repository. (n.d.). GitHub. https://github.com/lexxmark/winflexbison
stackoverflow.com/questions/61956763/how-do-i-deal-with-undefined-reference-to-regcomp-error
- How can I use flex & bison in Visual Studio 2010? (n.d.). Stack Overflow. https://stackoverflow.com/questions/5868382/how-can-i-use-flex-bison-in-visual-studio-2010#6049009
- Colorizing text in the console with C++. (n.d.). Stack Overflow. https://stackoverflow.com/questions/4053837/colorizing-text-in-the-console-with-c
- GeeksforGeeks. (2025, January 10). C program to read content of a file. GeeksforGeeks. https://www.geeksforgeeks.org/c-program-to-read-contents-of-whole-file/
- How do I deal with “undefined reference to `regcomp’” error. (n.d.). Stack Overflow. https://
- GeeksforGeeks. (2023, November 1). Regular expressions in C. GeeksforGeeks. https://www.geeksforgeeks.org/regular-expressions-in-c/
