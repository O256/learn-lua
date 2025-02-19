# 安装开发工具
dnf group install "Development Tools"

# 安装flex
dnf --enablerepo=devel install flex-devel

# 生成bison文件
bison -d calc.y 

# 生成flex文件
flex calc.l 

# 生成可执行文件
gcc lex.yy.c calc.tab.c -o calc

# 运行可执行文件
./calc
> 3 * (1 + 5)
= 18
> 


# 生成
bison -v calc.y


bison采用LALR(1)分析方法，其中LALR(1)分析法是LA(1)LR(0)分析法的改进;
shift表示移入，reduce表示规约，accept表示接受，error表示错误;


3 * (1 + 5 + 2 * 2)