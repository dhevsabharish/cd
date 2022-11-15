%{
    #include <stdio.h>
    #include "y.tab.h"
%}
%option noyywrap

%%

[0-9]+ { yylval.dval = atoi(yytext);
          return NUM;
       }
[\t ] ;
\n { return 0; }
. { return yytext[0]; }

%%
