%{
#include <stdio.h>
#include <stdlib.h>

int yyerror(char * msg) {
	printf("Erro na análise sintática");
	return 0;
}

int yywrap() {
	return 0;
}

int yylex();
%}

%token NUM_INT NUM_REAL SIMB_END SIMB_READ SIMB_WRITE SIMB_FOR SIMB_TO
%token SIMB_BEGIN SIMB_CONST SIMB_DO SIMB_ELSE SIMB_IF SIMB_PROCEDURE SIMB_PROGRAM
%token SIMB_THEN SIMB_VAR SIMB_WHILE SIMB_INTEGER SIMB_REAL ID
%%
programa:	SIMB_PROGRAM ID ';' corpo '.'					;
corpo:		dc SIMB_BEGIN comandos SIMB_END					;
dc:			dc_c dc_v dc_p									;
dc_c:		SIMB_CONST ID '=' numero ';' dc_c |				;
dc_v:		SIMB_VAR variaveis ':' tipo_var ';' dc_v |		;
tipo_var:	SIMB_REAL | SIMB_INTEGER						;
variaveis:	ID mais_var										;
mais_var:	',' variaveis |									;
dc_p:		SIMB_PROCEDURE ID parametros ';' corpo_p dc_p | ;
parametros:	'(' lista_par ')' |								;
lista_par:	variaveis ':' tipo_var mais_par					;
mais_par:	';' lista_par |									;
corpo_p:	dc_loc SIMB_BEGIN comandos SIMB_END ';'			;
dc_loc:		dc_v											;
lista_arg:	'(' argumentos ')' |							;
argumentos:	ID mais_ident									;
mais_ident:	';' argumentos |								;
pfalsa:		SIMB_ELSE cmd |									;
comandos:	cmd ';' comandos |								;
cmd:		SIMB_READ '(' variaveis ')' |
			SIMB_WRITE '(' variaveis ')' |
			SIMB_WHILE '(' condicao ')' SIMB_DO cmd |
			SIMB_IF condicao SIMB_THEN cmd pfalsa |
			ID ':' '=' expressao |
			ID lista_arg |
			SIMB_BEGIN comandos SIMB_END					;
condicao:	expressao relacao expressao						;
relacao:	'=' | '<' '>' | '>' '=' | '<' '=' | '>' | '<'	;
expressao:	termo outros_termos								;
op_un:		'+' | '-' |										;
outros_termos:	op_ad termo outros_termos |					;
op_ad:		'+' | '-'										;
termo:		op_un fator mais_fatores						;
mais_fatores:	op_mul fator mais_fatores |					;
op_mul:		'*' | '/'										;
fator:		ID | numero | '(' expressao ')'					;
numero:		NUM_INT | NUM_REAL								;
%%

int main() {
	yyparse();
}
