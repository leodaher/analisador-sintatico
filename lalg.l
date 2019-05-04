%{
#include "hash.h"

int * table;

void check_reserved_words(char * word, int yyleng) {
	if(verifyTable(word, table)) {
		printf("%s - simb_%s\n", word, word);
	} else { 
		if (yyleng > 14) {
			printf("%s - erro\n", yytext);
		} else {
			printf("%s - id\n", word);
		}
	}
}

%}

digit [0-9]
letter [a-zA-Z]
num_int -?{digit}({digit})*
num_real -?{digit}+"."{digit}+
word [a-zA-Z][a-zA-Z0-9]*
comment "{".*"}"

%%
{word} {check_reserved_words(yytext, yyleng);}
{num_int} {printf("%s - num_int \n",yytext);} 
{num_real} {printf("%s - num_real \n",yytext);}
{comment} ;
";" {printf("; - simb_ponto_virgula\n");}
"." {printf(". - simb_ponto\n");}
"," {printf(", - simb_virgula\n");}
":" {printf(": - simb_dois_ponto\n");}
"(" {printf("( - simb_abre_parentese\n");}
")" {printf(") - simb_fecha_parentese\n");}
"=" {printf("= - simb_igual\n");}
">" {printf("> - simb_maior_que\n");}
"<" {printf("< - simb_menor_que\n");}
"+" {printf("+ - simb_mais\n");}
"-" {printf("- - simb_menos\n");}
"*" {printf("* - simb_mult\n");}
"/" {printf("/ - simb_div\n");}
[" "\n] ;
. {printf("%s - erro\n",yytext);}
%%

int yywrap(){ return 1; }
int main(int argc, char **argv) {	
	table = initHash();
	yylex();
	return 0;
}
