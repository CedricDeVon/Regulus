%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <Regex.h>

#define RESET "\033[0m"
#define BOLD "\033[1m"
#define BRIGHT_FOREGROUND_BLACK "\033[90m"
#define BACKGROUND_RED "\033[41m"
#define ERROR_MESSAGE_LABEL BACKGROUND_RED BRIGHT_FOREGROUND_BLACK BOLD " Error " RESET " "

extern FILE *yyin; 
extern Regex regex;
extern Matcher matcher;
extern int current_line_number;

extern int yylex();
int yyerror(const char *string);

%}

%union 
{
    char *string;
    char *regex_pattern;
}

%token PRINT PRINT_WITH_NEW_LINE REGEX PARAMETER_DELIMETER
%token <string> STRING

%type <string> string_expression

%%

prog:
    | statements
;

statements:
    | statement ';' statements

statement:
    PRINT '(' string_expression ')'
    {
        printf("%s", $3);
    }
    | PRINT_WITH_NEW_LINE '(' string_expression ')'
    {
        printf("%s\n", $3);
    }

string_expression:
    STRING
    {
        $$ = $1;
    }
    | REGEX '(' STRING PARAMETER_DELIMETER STRING ')'
    {
        regexCompile(&regex, $3);
        if (!regex.isPatternValid)
        {
            free($3);
            free($5);
            return EXIT_FAILURE;
        }

        matcher = regexMatch(&regex, $5);
        $$ = (matcher.isFound) ? "true" : "false";
        free($3);
        free($5);
    }
;

%%

int yyerror(const char *string)
{
	fprintf(stderr, ERROR_MESSAGE_LABEL "At line: %d - %s\n", current_line_number, string);
	return 0;
}

int main(const int argc, const char *argv[])
{
    if (argc < 2)
    {
        fprintf(stderr, ERROR_MESSAGE_LABEL "Compiler is properly used via [compiler-path] [file-path]\n", argv[0]);
        return EXIT_FAILURE;
    }
  
    yyin = fopen(argv[1], "r");
    if (!yyin)
    {
        perror(ERROR_MESSAGE_LABEL "File failed to open");
        return EXIT_FAILURE;
    }

    if (yyparse() != 0)
    {
        fclose(yyin);
        return EXIT_FAILURE;
    }

    fclose(yyin); 
    
    return EXIT_SUCCESS;
}
