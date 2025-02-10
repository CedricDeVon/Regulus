%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <Regex.h>

#include "parser.tab.h"

Regex regex;
Matcher matcher;
int current_line_number = 1;

%}

%%

\n                               { ++current_line_number; }
"//".*                           { /* Ignore comments */ }
[ \t\r\n]+                       { /* Ignore whitespace and newlines */ }
"PRINT"                          { return PRINT; }
"PRINT_WITH_NEW_LINE"            { return PRINT_WITH_NEW_LINE; }
"REGEX"                          { return REGEX; }
","                              { return PARAMETER_DELIMETER; }
\"([^"\\]|\\["\\nt\\])*\"        { 
    char *string = yytext + 1;  
    int length = strlen(string);
    if (length > 0) string[length - 1] = '\0';  

    char *string_pointer = string, *current_pointer; 
    for (current_pointer = string; *current_pointer; ++current_pointer)
    {
        if (*current_pointer == '\\' && *(current_pointer + 1))
        {
            switch (*(current_pointer + 1))
            {
                case 'n': *string_pointer++ = '\n'; ++current_pointer; break;
                case 't': *string_pointer++ = '\t'; ++current_pointer; break;
                case '"': *string_pointer++ = '"'; ++current_pointer; break;
                case '\\': *string_pointer++ = '\\'; ++current_pointer; break;
                default: *string_pointer++ = *current_pointer;
            }
        }
        else
        {
            *string_pointer++ = *current_pointer;
        }
    }
    *string_pointer = '\0';

    yylval.string = strdup(string);  
    return STRING; 
}
.                                { return yytext[0]; }

%%

int yywrap() { return 1; }
