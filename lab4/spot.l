%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	enum { FOR, COUNTER, CONDITION, STEP, BODY };
	int loopct = -1, flag = FOR;
	char *counter1, *counter2, *condition1, *condition2, *step1, *step2;
	void display ();
%}

variable [a-zA-Z_]+
logic_op ("=="|<|>|">="|"<=")
counter (int)[\t ]+{variable}[\t ]+=[\t ]+[0-9]+
condition {variable}[\t ]+{logic_op}[\t ]+[0-9]+
increment ({variable}("++"|"--"))|(("++"|"--"){variable})

%%

"for" {
	loopct++;
}

"(" {
  flag = COUNTER;
}

{counter} {
	printf("counter: %s\n",yytext);
  if (flag == COUNTER) {
		if (loopct == 0)
			counter1 = strdup(yytext);
		else
			counter2 = strdup(yytext);
  } else return 0;
}

{condition} {
	printf("condition: %s\n",yytext);
  if (flag == CONDITION) {
		if (loopct == 0)
			condition1 = strdup(yytext);
		else
			condition2 = strdup(yytext);
  } else return 0;
}

{increment} {
	printf("Step: %s\n", yytext);
  if (flag == STEP) {
		if (loopct == 0)
			step1 = strdup(yytext);
		else
			step2 = strdup(yytext);
  } else return 0;
}

; {
  if (flag != BODY)
    flag++;
}

. {}

%%

void display() {
	printf("%s;\n%s;\nwhile(%s) {\n\tif(%s) {\n\t\t%s;\n\t} else {\n\t\t%s;\n\t\t%s;\n\t}\n}\n",counter1, counter2, condition1, condition2, step2, step1, counter2);
}

int yywrap () { display();return 1; }

void main (int argc, char **argv) {
  FILE *fptr = fopen("for.c", "r");
  if (fptr) {
    yyin = fptr;
  }
  yylex();
	display();
}