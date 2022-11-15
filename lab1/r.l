%{
 int count = 0;
%}
%option noyywrap
%%
end return 1;
[a-zA-Z]+ count++;
. ;
%%
int main(void) {
 yylex();
 printf("number of words = %d\n", count);
 return 0;
}