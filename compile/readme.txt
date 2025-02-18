



bison -d calc.y 
flex calc.l 
gcc lex.yy.c y.tab.c -o calc

./calc
> 3.14 * (x + 5)
= 17.7
> 

