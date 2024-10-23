calc: lex.yy.c y.tab.c
	gcc -g lex.yy.c y.tab.c -o calc.out -lfl

lex.yy.c: y.tab.c calc.l
	flex calc.l

y.tab.c: calc.y
	yacc -d calc.y

clean: 
	rm -rf lex.yy.c y.tab.c y.tab.h calc.out calc.dSYM

