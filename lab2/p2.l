%{
#include <stdio.h>
%}

%%

a|e|i|o|u { printf("vowels: %s\n", yytext); }
\n|. {}

%%

int yywrap() {}
void main() { yylex(); }
