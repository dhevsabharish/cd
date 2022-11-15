%{
  #include <stdio.h>
%}

%x COMMENT
%option noyywrap

%%

"/*" {BEGIN(COMMENT);}
<COMMENT>"*/"  {BEGIN(0);}
<COMMENT>. ;

%%

void main() {yyin=fopen("input.c", "r");yylex();}