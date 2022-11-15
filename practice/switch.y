%{
  #include <stdio.h>
  #include <stdlib.h>
  extern int yylex();
  extern FILE *yyin;
  void yyerror(char *p) {
    fprintf(stderr, "%s\n", "while syntax error");
  }

%}
%token ID NUM SWITCH CASE DEFAULT BREAK LE GE EQ NE OR AND
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE
%left '+''-'
%left '*''/'
%left '!'
%%

S       : ST {printf("Input accepted.\n");exit(0);}
         ;
ST     :    SWITCH '(' ID ')' '{' B '}'
         ;
   
B       :    C
         |    C    D
        ;
   
C      :    C    C
        |    CASE NUM ':' E ';'
        | BREAK ';'
        ;

D      :    DEFAULT    ':' E ';' BREAK ';'
        ;
    
E    : ID'='E
    | E'+'E
    | E'-'E
    | E'*'E
    | E'/'E
    | E'<'E
    | E'>'E
    | E LE E
    | E GE E
    | E EQ E
    | E NE E
    | E OR E
    | E AND E
    | ID
    | NUM
    ;

%%

int main()
{
  yyin = fopen("sw.c", "r");
printf("Enter the exp: ");
yyparse();
}