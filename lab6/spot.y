%{

typedef char* string;
#include <stdio.h>
#define YYSTYPE char*

%}

%token NAME EQ SEMICOLON IDT FDT CDT IDATA FDATA CDATA

%%

file : record file
| record
;

record : IDT NAME EQ IDATA SEMICOLON  { printf("%s %s %s %s %s is a valid C statement", $1, $2, $3, $4, $5); }
        | FDT NAME EQ FDATA SEMICOLON { printf("%s %s %s %s %s is a valid C statement", $1, $2, $3, $4, $5); }
        | FDT NAME EQ IDATA SEMICOLON { printf("%s %s %s %s %s is a valid C statement", $1, $2, $3, $4, $5); }
        | CDT NAME EQ CDATA SEMICOLON { printf("%s %s %s %s %s is a valid C statement", $1, $2, $3, $4, $5); }
;

%%

int main()
{
        yyparse();
        return 0;
}

int yyerror(char *msg)
{
        printf("Not a valid C statement : %s \n", msg);
}
