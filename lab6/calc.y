%{
	#include<stdio.h>
	void yyerror(char *);
	int yylex(void);
%}

%token INTEGER
%left '+' '-'
%left '*' '/'
%union { int val; }
%type <val> expr

%%

program
	: expr '\n'	{ printf("%d\n",$1); return 0; }
	;

expr
  :	INTEGER				{ $$ = $<val>1; }
	| expr '+' expr	{ $$ = $1 + $3; }
	| expr '-' expr	{ $$ = $1 - $3; }
	| expr '*' expr	{ $$ = $1 * $3; }
	| expr '/' expr	{ $$ = $1 / $3; }
	| '(' expr ')'	{ $$ = $2; }
	;

%%

void yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
}
int main(void) {
	yyparse();
	return 0;
}