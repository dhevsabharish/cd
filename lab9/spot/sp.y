%{
#include <stdio.h>
#include <string.h>
void yyerror(char *);
void insert(char *, char type);
int lookup(char *);
int lookup_length(char *id);
void compute_length(int length[][20], int length_size);
int n=1;
char tmp[20];
char symbol[30][2];
char stack[20];
char* myid;
int length[20][20];
int computed[20][20];
int length_flag=0;
int flag=0;
int size=0;
int stop=1;
%}


%union{
  char* str;
  char type;
}

%left '+' '-'
%left '*' '/'
%right UMINUS
%token <str>DIGIT
%token <str>ID
%token <type>INT
%token <type>FLOAT
%token <type>CHAR
%token <type>DOUBLE
%type <str>E
%type <str>decl
%type <str>L_const
%type <str>expr
%type <str>L
%type <type>type
%type <str>S

%%

S_list	: S_list stmt '\n'
	|
	;
stmt	: decl
	| assign
	;

decl	: type L_const ';' { length[flag][length_flag]=1; compute_length(length, length_flag);
			     insert($2, $1); length_flag=0; }
	;
type	: INT { $$ = yylval.type; }
	| FLOAT { $$ = yylval.type; }
	| CHAR { $$ = yylval.type; }
	| DOUBLE { $$ = yylval.type; }
	;
L_const	: L_const '[' DIGIT ']' { length[flag][length_flag++] = atoi($3); }
	| ID { $$ = yylval.str; }
	;

assign	: expr ';'
	;
expr	: L '=' S { printf("%s = %s\n", $1, $3); }
	| ID '=' S { printf("%s = %s\n", $1, $3); }
	;
S	: S ID '=' E { printf("%s = %s\n", $2, $4); sprintf(tmp, "t%d", n-1); $$=strdup(tmp); }
	| S E  { sprintf(tmp, "t%d", n-1); $$=strdup(tmp); }
	| 
	;
E	: DIGIT { $$ = yylval.str; }
	| ID { $$ = yylval.str; }
	| E '+' E { printf("t%d = %s + %s\n", n, $1, $3); sprintf(tmp, "t%d", n++); $$=strdup(tmp); }
	| E '-' E { printf("t%d = %s - %s\n", n, $1, $3); sprintf(tmp, "t%d", n++); $$=strdup(tmp); }
	| E '*' E { printf("t%d = %s * %s\n", n, $1, $3); sprintf(tmp, "t%d", n++); $$=strdup(tmp); }
	| E '/' E { printf("t%d = %s / %s\n", n, $1, $3); sprintf(tmp, "t%d", n++); $$=strdup(tmp); }
	| '-' E %prec UMINUS { printf("t%d = minus %s\n", n, $2); sprintf(tmp, "t%d", n++); $$=strdup(tmp);}
	| '(' E ')'{ $$ = $2; }
	| L { if(stop==0){ // if it is 1-Dimension
	        printf("t%d = %s\n", n, $1); sprintf(tmp, "t%d", n++); $$=strdup(tmp);
	      }else{ // if not
		printf("t%d = %s[t%d]\n", n, myid, n-1); sprintf(tmp, "t%d", n++); $$=strdup(tmp);
	      } 
	    } 
	;
L	: L '[' E ']' { int leng = lookup_length(myid); 
			printf("t%d = %s * %d\n", n++, $3, size*leng);
			printf("t%d = t%d + t%d\n", n++, n-2, n-1); 
			//printf("t%d = %s[t%d]\n", n++, myid, n-1);
			sprintf(tmp, "%s[t%d]", myid, n-1); $$=strdup(tmp);
			stop=1;
                      }
	| ID '[' E ']' { length_flag=1; size=0; stop=0;
			 size = lookup($1);
			 int leng = lookup_length($1); 
			 myid = $1;
			 printf("t%d = %s * %d\n", n, $3, size*leng);
			 sprintf(tmp, "%s[t%d]", $1, n++); $$=strdup(tmp);
		        }
	;

%%

void insert(char *id, char type){
  symbol[flag][0] = *id;
  symbol[flag][1] = type;
  flag++;
}
int lookup(char *id){
  char type;
  int i;
  for(i=0; i<flag+1; i++){
    if( symbol[i][0] == *id )
	type = symbol[i][1];
  }

  switch(type){
    case 'i':   // int
      return 4;
    case 'f':   // float
      return 4;
    case 'c':	// char
      return 1;
    case 'd':	// double
      return 8;
    default:
      return -1;
      break;
  }
}
int lookup_length(char *id){ 
  int i; 
  for(i=0; i<flag; i++){
    if( symbol[i][0] == *id ){
      //printf("for debugging\n");
      return computed[i][++length_flag];
    }
  }
  return -1;
}

void compute_length(int length[][20], int length_size){
  int i; int result=1;
  computed[flag][0] = flag;
  for(i=length_size+1; i>0; i--){
    result = result*length[flag][length_size--];
    computed[flag][i] = result;
  }
}

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}


