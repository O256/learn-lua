/*
** $Id: llex.h $
** 词法分析
** See Copyright Notice in lua.h
*/

#ifndef llex_h
#define llex_h

#include <limits.h>

#include "lobject.h"
#include "lzio.h"

/*
** 单字符的token（终结符号）用它们自己的数字代码表示。
** 其他token从以下值开始。
*/
#define FIRST_RESERVED (UCHAR_MAX + 1)

#if !defined(LUA_ENV)
#define LUA_ENV "_ENV"
#endif

/*
** 警告：如果更改此枚举的顺序，请搜索“ORDER RESERVED”
*/
enum RESERVED {
  /* 终结符号用保留字表示 */
  TK_AND = FIRST_RESERVED,
  TK_BREAK,
  TK_DO,
  TK_ELSE,
  TK_ELSEIF,
  TK_END,
  TK_FALSE,
  TK_FOR,
  TK_FUNCTION,
  TK_GOTO,
  TK_IF,
  TK_IN,
  TK_LOCAL,
  TK_NIL,
  TK_NOT,
  TK_OR,
  TK_REPEAT,
  TK_RETURN,
  TK_THEN,
  TK_TRUE,
  TK_UNTIL,
  TK_WHILE,
  /* 其他终结符号 */
  TK_IDIV,
  TK_CONCAT,
  TK_DOTS,
  TK_EQ,
  TK_GE,
  TK_LE,
  TK_NE,
  TK_SHL,
  TK_SHR,
  TK_DBCOLON,
  TK_EOS,
  TK_FLT,
  TK_INT,
  TK_NAME,
  TK_STRING
};

/* 保留字数量 */
#define NUM_RESERVED (cast_int(TK_WHILE - FIRST_RESERVED + 1))

typedef union {
  lua_Number r;
  lua_Integer i;
  TString *ts;
} SemInfo; /* 语义信息 */

typedef struct Token {
  int token;
  SemInfo seminfo; /* 语义信息 */
} Token;

/* 词法分析器的状态加上解析器的状态，当所有函数共享时 */
typedef struct LexState {
  int current;          /* 当前字符（charint） */
  int linenumber;       /* 输入行计数器 */
  int lastline;         /* 最后一个token 'consumed'的行 */
  Token t;              /* 当前token */
  Token lookahead;      /* 预览token */
  struct FuncState *fs; /* 当前函数（解析器） */
  struct lua_State *L;
  ZIO *z;              /* 输入流 */
  Mbuffer *buff;       /* 用于token的缓冲区 */
  Table *h;            /* 避免收集/重用字符串 */
  struct Dyndata *dyd; /* 解析器使用的动态结构 */
  TString *source;     /* 当前源文件名 */
  TString *envn;       /* 环境变量名 */
} LexState;

LUAI_FUNC void luaX_init(lua_State *L); /* 初始化词法分析器 */
LUAI_FUNC void luaX_setinput(lua_State *L, LexState *ls, ZIO *z,
                             TString *source, int firstchar); /* 设置输入流 */
LUAI_FUNC TString *luaX_newstring(LexState *ls, const char *str,
                                  size_t l); /* 创建新字符串 */
LUAI_FUNC void luaX_next(LexState *ls);      /* 获取下一个token */
LUAI_FUNC int luaX_lookahead(LexState *ls);  /* 预览下一个token */
LUAI_FUNC l_noret luaX_syntaxerror(LexState *ls, const char *s); /* 语法错误 */
LUAI_FUNC const char *luaX_token2str(LexState *ls,
                                     int token); /* 将token转换为字符串 */

#endif
