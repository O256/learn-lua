# 安装开发工具
dnf group install "Development Tools"

# 安装flex
dnf --enablerepo=devel install flex-devel

# 生成bison文件
bison -d calc.y 

# 生成flex文件
flex calc.l 

# 生成可执行文件
gcc lex.yy.c y.tab.c -o calc

# 运行可执行文件
./calc
> 3.14 * (x + 5)
= 17.7
> 

