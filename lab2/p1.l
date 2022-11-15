%{
#include <stdio.h>
%}

%%

([a-zA-Z]){5,5} { 
	int flag = 1;
	for(int i = 1; i < 5; i++)
		if(yytext[i] != yytext[i - 1])
			flag = 0;
	if (flag == 1) printf("%s is valid\n", yytext);
}

\n|.	{}

%%

int yywrap() {}
void main() { yylex(); }
