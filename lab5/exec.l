%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	enum { KEYWORD, CLASS, BODY };
	int flag = KEYWORD;
	char *className;
%}
%%

^struct {
	if (flag == KEYWORD)
		flag++;
	else {
		printf("Syntax Error\n");
		return 1;
	}
}

[a-zA-Z]+ {
	if (flag == CLASS) {
		className = strdup(yytext);
		flag++;
	} else {
		printf("Syntax Error\n");
		return 1;
	}
}

"{"[\t\n ]+(.|\n)+"}" {
	if (flag == BODY) {
		printf("\nclass %s %s",className, yytext);
		flag = KEYWORD;
	} else {
		printf("Syntax Error\n");
		return 1;
	}
}

%%

int yywrap (void) { return 1; }

void main () {
	FILE *fp = fopen("struct.txt","r");
	yyin = fp;
	yylex();
}