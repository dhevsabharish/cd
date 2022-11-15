%{
#include<stdio.h>
#include<stdlib.h>
#include "y.tab.h"
%}

identifier [_a-zA-Z][_a-zA-Z0-9]*
digit [0-9]+

%%

[ \t\n] ;
"while" {return WHILE; }
{identifier} { return ID; }
{digit} { return NUMBER; }
">=" { return GE; }
"<=" { return LE; }
"==" { return EQ; }
"!=" { return NE; }
"&&" { return AND; }
"||" { return OR; }
"++" { return INC; }
"--" { return DEC; }
. { return yytext[0]; }

%%

int yywrap() { return 1; }
