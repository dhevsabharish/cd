%{
  #include <stdio.h>
  #include <string.h>
  #include <stdlib.h>
  int flag = 0;
  char *className;
%}

%%

^struct {
  if (flag == 0)
    flag++;
  else
  {
    printf("Syntax Error1\n");
    return 1;
  }
}

int(.*)(";") {
  printf("\t\t");
  for(int j=4;yytext[j]!=';';j++)
    printf("%c",yytext[j]);
  printf("=0;");
}

char(.*)(";") {
  printf("\t\t");
  for(int j=5;yytext[j]!=';';j++)
    printf("%c",yytext[j]);
  printf("='\\0';");
}

("}")(";") {
  printf("\t}\n\t~%s();\n",className);
  yyless(yyleng);
  ECHO;
}

[a-zA-Z]+ {
  if (flag == 1) {
    className = strdup(yytext);
    flag++;
  }
  else {
    printf("Syntax Error2\n");
    return 1;
  }
}

"{"[\t|\n|(" ")]+(.|\n)+"}"";" {

  int j;
  if (flag == 2) {
    printf("\nclass %s{\nprivate:",className);
    if(yytext[1]=='\n')
      printf("\t");
    else printf("\n\t");
    for(j=0; j<(yyleng-3); j++)
    {
      if(yytext[j]!='{' && yytext[j]!='}')
        printf("%c",yytext[j]);
      if(yytext[j]=='\n' && yytext[j+1]!='}')
        printf("\t");
    }
    printf("\npublic:\n\t%s()\n\t",className);
    yyless(1);
    ECHO;
    flag = 4;
  } else {
    printf("Syntax Error3\n");
    return 1;
  }
}

%%

int yywrap (void) { return 1;}

void main ()
{
  FILE *fp = fopen("struct.txt","r");
  yyin = fp;
  yylex();
  fclose(fp);
}
