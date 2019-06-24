all: main

main: yacc lalg.y lex lalg_test.l
	gcc hash.c y.tab.c lex.yy.c -o main
	
lex: lalg_test.l
	lex lalg_test.l

yacc: lalg.y
	yacc -d lalg.y

run: 
	./main < input.txt
