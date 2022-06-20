%option noyywrap

%{
int chars = 0;
int words = 0;
int lines = 0;

int totchars = 0;
int totwords = 0;
int totlines = 0;
%}

%%
[a-zA-Z]+ 	{words++; chars += strlen(yytext);} 
[\n] 		{chars++; lines++;}
.		{chars++;}

%%

int main(int argc, char ** argv){
	if(argc < 2){
		yylex();
		printf("%8d%8d%8d\n", lines, words, chars);
		return 0;
	}
	if(argc > 1) {
	//如果输入参数多于1，说明传入的第二个参数为文件名
		if(!(yyin = fopen(argv[1], "r"))){
			perror(argv[1]);
			return 1;
		}
	}
	for(int i = 1; i < argc; i++){
		FILE* f = fopen(argv[i], "r");
		if(!f){
			// 重新设置文件流指针
			perror(argv[i]);
			return 1;
		}
		yyrestart(f);
		yylex();
		fclose(f);
		printf("%8d%8d%8d %s\n", lines, words, chars, argv[i]);
		totchars += chars; chars = 0;
		totwords += words; words = 0;
		totlines += lines; lines = 0;
	}
	if(argc > 1)
		printf("%8d%8d%8d total\n", totlines, totwords, totchars);
	return 0;
}
