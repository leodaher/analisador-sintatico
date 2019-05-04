digit [0-9]
letter [a-zA-Z]
%%
";" {printf("; - simb_ponto_virgula\n");}
"." {printf(". - simb_ponto\n");}
"," {printf(", - simb_virgula\n");}
":" {printf(": - simb_dois_ponto\n");}
"(" {printf("( - simb_abre_parentese\n");}
")" {printf(") - simb_fecha_parentese\n");}






%%

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int Hashing(char *palavra);
int verificaTabela(int value, int table[5000]);


int main()
{
	yylex();
	return 0;
}


int Hashing(char *palavra){
	int j;
	int numLetras;
	int valorHash;

	numLetras = strlen(palavra);
	valorHash = 0;
	for(j = 0; j < numLetras; j++){
		//printf("jj: %d\n", j);
		valorHash = valorHash + palavra[j]*j;
	}
	//printf("(%d)\n", valorHash);
	return valorHash;
}


//Palavras reservadas estruturadas na tabela Hash
int verificaTabela(int value, int table[5000]){
	int i;
		
	//verifica se o valor esta na tabela hash
	if(table[value] == 1){
		printf("Palavra reservada.\n");
		return 1;
	}
	else{
		printf("Nao eh palavra reservada.\n");
		return 0;
	}
}