%{
#include <stdio.h>
#include <string.h>
%}

%%

[a-zA-Z]* {
	int len = yyleng;
	for(int k = 0; k < len; k++) {
		int flag = 1;
		for(int i = k + 1; i < k + 5; i++)
			if(yytext[i] != yytext[i - 1])
				flag = 0;
		if (flag == 1) {
			for(int m = k; m < k + 5; m++)
				printf("%c", yytext[k]);
			printf(" is valid\n");
		}
	}
}

\n|.	{}

%%

int yywrap() {}
void main() { yylex(); }