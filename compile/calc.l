%{
#include <stdio.h>
%}

%%
/* 正则表达式规则 */
[ \t\n]+   { /* 忽略空白符 */ }

/* 数字 */
[0-9]+          { printf("整数: %s\n", yytext); }
[0-9]+\.[0-9]* { printf("浮点数: %s\n", yytext); }

/* 变量 */
[a-zA-Z_][a-zA-Z0-9_]* { printf("变量: %s\n", yytext); }

/* 运算符 */
"+"    { printf("加号: +\n"); }
"-"    { printf("减号: -\n"); }
"*"    { printf("乘号: *\n"); }
"/"    { printf("除号: /\n"); }

/* 括号 */
"("    { printf("左括号\n"); }
")"    { printf("右括号\n"); }

/* 错误处理 */
.      { printf("无法识别的字符: %s\n", yytext); }
%%

int main() {
    yylex();
    return 0;
}
