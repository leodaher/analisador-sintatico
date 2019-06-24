all: main

main: yacc lalg.y lex lalg.l
	gcc hash.c y.tab.c lex.yy.c -o main
	
lex: lalg.l
	lex lalg.l

yacc: lalg.y
	yacc -d lalg.y

run: 
	./main < input.txt
