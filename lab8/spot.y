%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
FILE *yyin;
void yyerror(char *p) {
fprintf(stderr, "%s\n", "while syntax error");
}
%}

%token RESTBODY WHILE ID NUMBER GE LE EQ NE AND OR INC DEC
%left OR AND
%left '<' '>' LE GE NE EQ
%left INC DEC
%left '+' '-'
%left '*' '/'
%left '!'

%%

program : expr { printf("while accepted!\n"); };

expr : WHILE '(' condn ')' '{' update '}'
     | WHILE '(' condn ')' '{' update expr '}' {printf("nested while loop detected\n");}
     | WHILE '(' condn ')' ';' {printf("infinite loop without curly braces\n");}
     ;
update : ID INC ';'
| ID DEC ';'
| {printf("infinite loop\n");};
condn : E '<' E
| E '>' E
| E LE E
| E GE E
| E EQ E
| E NE E
| '!' E
| E AND E
| E OR E
| NUMBER
| ID
;
E : E '<' E
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
