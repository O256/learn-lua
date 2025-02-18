%{
#include <stdio.h>
%}
%option noyywrap
/* 正则表达式定义（可选） */
DIGIT    [0-9]
ID       [a-zA-Z_][a-zA-Z0-9_]*

%%
    /* 规则部分：模式 + 动作 */
    /* ---- 注意：规则必须顶格写，前面不能有空格 ---- */

    /* 忽略空白符 */
[ \t\n]+   { /* 无动作 */ }

    /* 数字 */
{DIGIT}+          { printf("整数: %s\n", yytext); }
{DIGIT}+\.{DIGIT}*  { printf("浮点数: %s\n", yytext); }

    /* 变量 */
{ID}       { printf("变量: %s\n", yytext); }

    /* 运算符 */
"+"        { printf("加号: +\n"); }
"-"        { printf("减号: -\n"); }
"*"        { printf("乘号: *\n"); }
"/"        { printf("除号: /\n"); }

    /* 括号 */
"("        { printf("左括号\n"); }
")"        { printf("右括号\n"); }

    /* 错误处理 */
.          { printf("无法识别的字符: %s\n", yytext); }

%%
int main() {
    yylex();
    return 0;
}
