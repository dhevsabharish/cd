%{
  #include <stdio.h>
  #include <stdlib.h>
%}

%%

[0-9]{3}+ {
  printf("-%s-", yytext);
}

. ;

%%
int yywrap(void) {return 0;}
int main(void) {
  yylex();
  return 0;
}
