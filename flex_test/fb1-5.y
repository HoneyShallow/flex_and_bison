%{
#include <stdio.h> /*头文件*/
%}

/*declare tokens*/
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL

%%

calclist: /*无规则*/
	| calclist exp EOL { printf("- % d\n", $2); }
	;

exp: factor default $$ = $1
   	| exp ADD factor { $$ = $1 + $3; }
	| exp SUB factor { $$ = $1 - $3; }
	;
factor: term default $$ = $1
   	| factor MUL factor { $$ = $1 + $3; }
	| exp DIV factor { $$ = $1 - $3; }
	;
term: NUMBER default $$ = $1
   	| ABS term { $$ = $2 >= 0 ? $2 : - $2; }
	;
%%
void main(int argc, char ** argv){
	yyparse();
}
void yyerror(char * s){
	fprintf(stderr, "error : %s\n", s);
}
