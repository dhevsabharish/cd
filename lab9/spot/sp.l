%{
#include <stdlib.h>
#include <string.h>
#include "sp.tab.h"
void yyerror(char *);
%}
num [0-9]
letter [A-Za-z_]

%%

int	    { yylval.type = 'i'; return INT; }
float       { yylval.type = 'f'; return FLOAT; }
char        { yylval.type = 'c'; return CHAR; }
double      { yylval.type = 'd'; return DOUBLE; }
{num}+      { yylval.str = strdup(yytext); return DIGIT; }
{letter}[A-Za-z0-9_]*   { yylval.str = strdup(yytext); return ID; }
[+-/*\n]    { return *yytext; }
[ \t]	    { }
.           { return yytext[0]; }

%%

int yywrap(void) {
	return 1;
}
