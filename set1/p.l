%{
  #include <stdio.h>
%}
%option noyywrap
%%
[-+*/]?[0-9]+ {printf("scanned no.: %s\n", yytext);}
. ;
%%
void main() {yylex();}