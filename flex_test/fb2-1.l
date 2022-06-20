%option noyywrap
%{
int chars = 0;
int words = 0;
int lines = 0;
%}

%%
[a-zA-Z]+ 	{words++; chars += strlen(yytext);} 
[\n] 		{chars++; lines++;}
.		{chars++;}

%%

int main(int argc, char ** argv){
	if(argc > 1) {
	//如果输入参数多于1，说明传入的第二个参数为文件名
		if(!(yyin = fopen(argv[1], "r"))){
			perror(argv[1]);
			return 1;
		}
	}
	yylex();
	printf("%8d%8d%8d\n", lines, words, chars);
	return 0;
}
