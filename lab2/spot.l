%option noyywrap

%{
#include <stdio.h>
#include <string.h>
char intarr[80], floatarr[80];
%}

%%

end return 1;
"int "[a-zA-Z]+; {strcpy(intarr + strlen(intarr), yytext + 4);intarr[strlen(intarr) - 1] = ' ';}
"float "[a-zA-Z]+; {strcpy(floatarr + strlen(floatarr), yytext + 6);floatarr[strlen(floatarr) - 1] = ' ';}
.|\n ;

%%

int main() {
  yylex();
  printf("int: %s\n", intarr);
  printf("float: %s\n", floatarr);
}
