%{
#include <stdio.h>
char stack[200];
int top = -1, f = 0;
%}

%%

[a-zA-Z0-9] {
        	printf("%s", yytext);
        	if (f == 3) printf("%c", stack[top--]);
        	f = 1;
	}

"^" |
"("     {
		stack[++top] = yytext[0];
		f = 2; 
	}


"*" |
"/" |
"%" {
        if(top==-1 || stack[top]=='+' ||stack[top]=='-'){
                stack[++top]=yytext[0];
                f=2;
        }
        else{
                while(top>=0 && stack[top]!='+' && stack[top]!='-' && stack[top]!='(') printf("%c",stack[top--]);
                stack[++top]=yytext[0];
                f=2;
        }
}

"+"  {
        if(top==-1 || stack[top]=='('){
                stack[++top]=yytext[0];
                f=2;
        }
        else{
                while(top>=0 && stack[top]!='(') printf("%c",stack[top--]);
                stack[++top]=yytext[0];
                f=2;
        }
}

"-" {
        if(f==0 || f==2){
                stack[++top]=yytext[0];
                f=3;
        }
        else if(top==-1 || stack[top]=='(')
                stack[++top]=yytext[0];
        else{
                while(top>=0 && stack[top]!='(') printf("%c",stack[top--]);
                stack[++top]=yytext[0];
        }
}

")" {
        while(top>=0 && stack[top]!='(') printf("%c",stack[top--]);
        top--;
}
. {}
\n { return 0;}


%%

int yywrap(void) {}

int main() {
        yylex();
        while(top!=-1) printf("%c",stack[top--]);
        printf("\n\n");
        return 0;
}