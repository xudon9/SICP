#!/usr/bin/env python3
n = 28
ls = [0,1]

for i in range(n - 2):
    ls.append(ls[-1] + ls[-2])

for i in range(len(ls)):
    print("fib.", i, " = ", ls[i], end = '\t' if (1+i)%4 != 0 else '\n', sep = '')
