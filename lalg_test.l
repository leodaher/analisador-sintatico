%{
#include <stdio.h>
#include "y.tab.h"
#include "hash.h"

int reserved_words_dict(char * word) {
	if (!strcmp(word, "end"))
		return SIMB_END;
	if (!strcmp(word, "read"))
		return SIMB_READ;
	if (!strcmp(word, "write"))
		return SIMB_WRITE;
	if (!strcmp(word, "for"))
		return SIMB_FOR;
	if (!strcmp(word, "to"))
		return SIMB_TO;
	if (!strcmp(word, "begin"))
		return SIMB_BEGIN;
	if (!strcmp(word, "const"))
		return SIMB_CONST;
	if (!strcmp(word, "do"))
		return SIMB_DO;
	if (!strcmp(word, "else"))
		return SIMB_ELSE;
	if (!strcmp(word, "if"))
		return SIMB_IF;
	if (!strcmp(word, "procedure"))
		return SIMB_PROCEDURE;
	if (!strcmp(word, "program")) 
		return SIMB_PROGRAM; 
	if (!strcmp(word, "then"))
		return SIMB_THEN;
	if (!strcmp(word, "var"))
		return SIMB_VAR;
	if (!strcmp(word, "while"))
		return SIMB_WHILE;
	if (!strcmp(word, "integer"))
		return SIMB_INTEGER;
	if (!strcmp(word, "real"))
		return SIMB_REAL; 
	return 0;
}

int check_reserved_words(char * word, int length) {
	int * table = initHash();
	if(verifyTable(word, table)) {
		return reserved_words_dict(word);
	} else {
		return ID;
	}
}
%}

digit [0-9]
letter [a-zA-Z]
num_int -?{digit}({digit})*
num_real -?{digit}+"."{digit}+
malform_num_real -?{digit}+"."{letter}{digit}*
word [a-zA-Z][a-zA-Z0-9]*
comment "{".*"}"
special_character [;\.,:\(\)=\>\<\+\-\*\/]

%%
{word} {return check_reserved_words(yytext, yyleng);}
{num_int} {
	printf("NUM_INT\n");
	return NUM_INT;
}
{num_real} return NUM_REAL;
{comment} ;
{special_character} return yytext[0];
\n	;
[ \t]+ ;
%%
