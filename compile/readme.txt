词法分析器


flex calc.l 
gcc lex.yy.c -o calc
echo "3.14 * (x + 5)" | ./calc

输出
浮点数: 3.14
乘号: *
左括号
变量: x
加号: +
整数: 5
右括号


