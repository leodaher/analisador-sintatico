#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hash.h"

#define TABLE_SIZE 5000

/*
Para as operacoes com as strings sera utilizado os seus valores inteiros, ou seja, a representacao em inteiro na table ASCII 
correspondente ao char passado.
Sera feita a soma dos valores de cada uma das palavras reservadas e, dado que nao sao muitas, sera possivel garantir a sua unicidade na table Hash
*/

int * initHash() {
	int * table = (int *) calloc(sizeof(int), TABLE_SIZE);
	char * reserved_words[] = {
		"end", "read", "write",
		"for", "to", "begin",
		"const", "do", "else",
		"if", "procedure", "program",
		"then", "var", "while", "integer", "real"
	};

	for(int i = 0; i < 17; i++) {
		table[hash(reserved_words[i])] = 1;
	}
	
	return table;	
}


int hash(char *palavra){
	int numLetras = strlen(palavra);
	int valorHash = 0;

	for(int j = 0; j < numLetras; j++){
		valorHash = valorHash + palavra[j]*j;
	}
	
	return valorHash;
}


//Palavras reservadas estruturadas na table Hash
int verifyTable(char * palavra, int * table){
	//verifica se o valor esta na table hash
	if (table[hash(palavra)] == 1) {
		return 1;
	}
	else {
		return 0;
	}
}