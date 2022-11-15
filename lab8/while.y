%{
  #include<stdio.h>
  #include<stdlib.h>
  extern int yylex();
  extern FILE *yyin;
  void yyerror(char *p) {
    fprintf(stderr, "%s\n", "while syntax error");
  }
%}

%token WHILE ID NUMBER GE LE EQ NE AND OR INC DEC
%left OR AND
%left '<' '>' LE GE NE EQ
%left INC DEC
%left '+' '-'
%left '*' '/'
%left '!'

%%

program : expr { printf("while accepted!\n"); }
        ;
        
expr : WHILE '(' condn ')' '{' update '}'
     ;
        
update : ID INC ';'
       | ID DEC ';'
       | 
       ;
        
condn   : E '<' E
        | E '>' E
        | E LE E
        | E GE E
        | E EQ E
        | E NE E
        | '!' E
        | E AND E
        | E OR E
        | NUMBER
        | 
        ;

E       : E '<' E
        | E '>' E
        | E LE E
        | E GE E
        | E EQ E
        | E NE E
        | '!' E
        | E AND E
        | E OR E
        | ID
        | NUMBER
        | 
        ;

%%

int main() {
  yyin = fopen("while.txt", "r");
  yyparse();
  return 0;
}
