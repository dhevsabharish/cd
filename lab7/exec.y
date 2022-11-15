%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  extern int yylex();
  int yyerror(const char *p) { printf("%s\n",p); return 1; }
%}
%union { char *exp; };
%token INTEGER IDENTIFIER OPR1 OPR2 OPR3 OPR4 OPR5 NEWLINE EXIT
%right OPR1 OPR2
%right OPR3 OPR4
%right OPR5

%start lines

%%

lines: /*empty*/
     | lines exp NEWLINE { printf("%s\n>> ",$<exp>2); }
     ;

exp   : exp OPR1 exp { $<exp>$ = strcat($<exp>2,strcat($<exp>1,$<exp>3)); }
      | exp OPR2 exp { $<exp>$ = strcat($<exp>2,strcat($<exp>1,$<exp>3)); }
      | exp OPR3 exp { $<exp>$ = strcat($<exp>2,strcat($<exp>1,$<exp>3)); }
      | exp OPR4 exp { $<exp>$ = strcat($<exp>2,strcat($<exp>1,$<exp>3)); }
      | exp OPR5 exp { $<exp>$ = strcat($<exp>2,strcat($<exp>1,$<exp>3)); }
      | '(' exp ')'  { $<exp>$ = $<exp>2; }
      | INTEGER      { $<exp>$ = $<exp>1; }
      | IDENTIFIER   { $<exp>$ = $<exp>1; }
      | EXIT { exit(0); }
      ;

%%

int yywrap()
{
  return 1;
}

int main()
{
  printf("(Enter exit to quit)\n");
  printf(">> ");
  yyparse();
}