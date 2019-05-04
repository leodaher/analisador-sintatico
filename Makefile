all: main

main: lex lalg.l
	gcc hash.c lex.yy.c -o main
	
lex: lalg.l
	lex lalg.l

run: 
	./main input.txt
