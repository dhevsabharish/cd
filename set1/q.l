%{

  #include <stdio.h>
  int wc = 0, cc = 0;

%}

%option noyywrap

%%

[a-z] {printf("%c", yytext[0] - 32); cc++;}

[ ]  {printf("%c", yytext[0]);cc++; wc++;}

.     {printf("%c", yytext[0]);cc++;}

%%

void main() {
  yylex();
  printf("modified input is:\n");
  printf("word count is: %d\ncharacter count is: %d\n", wc, cc);
}