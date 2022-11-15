%{
    #include <stdio.h>
    #include "y.tab.h"
    int yylex(void);
    void yyerror(char *msg);
    char p='A'-1;
%}

%union
{
    char dval;
}
%token NUM
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS
%start S

%%

S : E  {printf("\nx = %c\n",$<dval>$);}
;
E : NUM { p++; printf("\n%c = %d", p,$<dval>1); $<dval>$=p; }
| E '+' E {p++;printf("\n%c = %c + %c ",p,$<dval>1,$<dval>3);$<dval>$=p;}
| E '-' E {p++;printf("\n%c = %c - %c ",p,$<dval>1,$<dval>3);$<dval>$=p;}
| E '*' E {p++;printf("\n%c = %c * %c ",p,$<dval>1,$<dval>3);$<dval>$=p;}
| E '/' E {p++;printf("\n%c = %c / %c ",p,$<dval>1,$<dval>3);$<dval>$=p;}
| '('E')' { $<dval>$ = p; }
| '-' E %prec UMINUS { p++; printf("\n%c = - %c ",p, $<dval>2); $<dval>$ = p;}
;
%%

void yyerror(char *msg) {
    fprintf(stderr,"error %s", msg);
}

int main () {
    printf("Enter expr: ");
    yyparse();
}
