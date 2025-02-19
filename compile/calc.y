%{
    #include <stdio.h>
    int yylex (void);
    void yyerror (const char *);
%}

/* declare tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token OP CP
%token EOL

%%
calclist: /* nothing */
    | calclist exp EOL { 
        print_node("calclist -> exp EOL", 0);
        printf("= %d\n> ", $2); 
    }
    | calclist EOL { 
        print_node("calclist -> EOL", 0);
        printf("> "); 
    } /* blank line or a comment */
    ;

exp:
    factor { 
        print_node("exp -> factor", 1);
        $$ = $1; 
    }
    | exp ADD exp { 
        print_node("exp -> exp ADD exp", 1);
        $$ = $1 + $3; 
    }
    | exp SUB factor { 
        print_node("exp -> exp SUB factor", 1);
        $$ = $1 - $3; 
    }
    | exp ABS factor { 
        print_node("exp -> exp ABS factor", 1);
        $$ = $1 | $3; 
    }
    ;

factor:
    term { 
        print_node("factor -> term", 2);
        $$ = $1; 
    }
    | factor MUL term { 
        print_node("factor -> factor MUL term", 2);
        $$ = $1 * $3; 
    }
    | factor DIV term { 
        print_node("factor -> factor DIV term", 2);
        $$ = $1 / $3; 
    }
    ;

term:
    NUMBER { 
        print_node("term -> NUMBER", 3);
        $$ = $1; 
    }
    | ABS term { 
        print_node("term -> ABS term", 3);
        $$ = $2 >= 0 ? $2 : -$2; 
    }
    | OP exp CP { 
        print_node("term -> OP exp CP", 3);
        $$ = $2; 
    }
    ;

%%
int main()
{
  printf("> "); 
  return yyparse();
}

void yyerror(const char *s)
{
  fprintf(stderr, "error: %s\n", s);
}

// 定义一个函数来打印节点信息
void print_node(const char* rule_name, int depth) {
    for (int i = 0; i < depth; ++i) {
        printf("  "); // 缩进
    }
    printf("%s\n", rule_name);
}

%left ADD SUB
%left MUL DIV
%left ABS
