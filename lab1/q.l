%{
	int yylineno;
%}

%option noyywrap

%%
\n {fprintf(yyout, "\n%d. ", ++yylineno);} 
.* {fwrite(yytext, 1, yyleng, yyout);}
%%
int main(int argc, char *argv[]) {
	yyin = fopen(argv[1], "r");
	yyout = fopen("a.txt", "w");
	yylex();
	fclose(yyin);
}