%{
  #include <stdio.h>
  char stack[200];
  int top=-1;
%}

%option noyywrap

%%

[a-zA-Z0-9] { printf("%s",yytext); }

"^" | "(" { stack[++top]=yytext[0]; }
"*" |
"/" |
"%" {
      if(top == -1 || stack[top] == '+' || stack[top] == '-')
        stack[++top]=yytext[0];
      else {
        while (top >= 0 && stack[top] != '+' && stack[top] != '-' && stack[top] != '(') printf("%c", stack[top--]);
        stack[++top] = yytext[0];
      }
    }

"+" |
"-" {
      if(top == -1 || stack[top] == '(')
        stack[++top]=yytext[0];
      else {
        while(top>=0 && stack[top]!='(') printf("%c",stack[top--]);
        stack[++top]=yytext[0];
      }
    }

")" {
      while(top>=0 && stack[top]!='(') printf("%c",stack[top--]);
      top--;
    }

. ;

\n { return 0;}

%%

int main() {
  yylex();
  while(top!=-1) printf("%c",stack[top--]);
  printf("\n");
  return 0;
}