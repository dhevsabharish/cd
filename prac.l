%option noyywrap
%{
        //Trying yymore() ...
        #include <stdio.h>
%}

%%

[a-z] { printf("--LETTER--\n"); yymore();  ECHO ; puts(""); }

[0-9] { printf("--DIGIT--\n"); yymore(); ECHO; puts(""); }

.|\n;

%%

int main ()
{
  yylex();
}