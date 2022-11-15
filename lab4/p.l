%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
void convertWhile(char str[]){
        printf("\nYour While Loop : \n\n");
        int i=0,j=0,t=0;
        char temp[10];
        for(;str[i]!='(';i++);
        i++;
        for(;str[i]!=';';i++){
                printf("%c",str[i]);
        }
        printf(";\n");
        i++;
        printf("while(");
        for(;str[i]!=';';i++){
                printf("%c",str[i]);
        }
        printf(")\n");
        i++;
        for(;str[i]!='{';i++){
                temp[j++]=str[i];
        }
        printf("%c\n",str[i++]);
        for(;str[i]!='}';i++){
                printf("%c",str[i]);
                if(str[i]==';'){
                printf("\n");
                }
        }
        for(;t<=j;t++){
                printf("%c",temp[t]);
        }
        printf(";\n");
        printf("}");
}
void convertFor(char str[]){
        printf("\nYour For Loop : \n");
        int i=0;
        printf("for(int i=0");
        for(;str[i]!='(';i++);
        i++;
        for(;str[i]!=')';i++){
                printf("%c",str[i]);
        }
        printf(";){\n");
        i++;
        for(;str[i]!='\0';i++){
                printf("%c",str[i]);
                if(str[i]==';'||str[i]=='{'){
                printf("\n");
                }
        }
}
%}
%%
^(for)("(")((int)(" ")[a-zA-Z0-9]*("=")[0-9]+)?(";")([a-zA-Z0-9]*)(("<")|(">")|("<=")|(">="))([0-9]+)(";")[a-zA-Z0-9](("++")|("--"))(")")("{")(.*)("}") {
                convertWhile(yytext);
        }
^(for)("(")((float)(" ")[a-zA-Z0-9]*("=")[0-9]+)?(";")([a-zA-Z0-9]*)(("<")|(">")|("<=")|(">="))([0-9]+)(";")[a-zA-Z0-9](("++")|("--"))(")")("{")(.*)("}") {
                convertWhile(yytext);
        }
^(for)("(")((double)(" ")[a-zA-Z0-9]*("=")[0-9]+)?(";")([a-zA-Z0-9]*)(("<")|(">")|("<=")|(">="))([0-9]+)(";")[a-zA-Z0-9](("++")|("--"))(")")("{")(.*)("}") {
                convertWhile(yytext);
        }

^(while)("(")([a-zA-Z0-9])*(("<")|(">")|("<=")|(">="))[0-9]*(")")("{")(.*)([a-zA-Z0-9])("++;")|("--;")("}") {
                convertFor(yytext);
        }
exit {
        return 0;
}
%%
int yywrap() {
        return 1;
}
void main() {
        printf("Enter The Expression : \n");
        yylex();
}
