# -*- coding: utf-8 -*-
############ 未柯里化的函数 ###########
def foldr(Func, zero, xs):
    if Null(xs):
        return zero
    else:
        return Func (Head(xs)) (Foldr (Func) (zero) (Tail(xs)))
def cons(x, xs):
    return [x] + xs
################# Python 的匿名函数不支持多行真是＊了狗了 #################
Head = lambda xs: xs[0]
Tail = lambda xs: xs[1:]
Null = lambda xs: len(xs) == 0
Cons = lambda x : lambda xs: cons(x, xs)
Nil  = []
Id   = lambda x: x
Square = lambda x: x * x

Foldr = lambda F: lambda zero: lambda xs: foldr(F, zero, xs)
Foldl = lambda F: lambda zero: lambda xs: Foldr (lambda x: lambda G: lambda A: G (F(A)(x))) (Id) (xs) (zero)
Map   = lambda Proc: lambda xs: Foldr (lambda x: lambda ac: Cons(Proc(x))(ac)) (Nil) (xs)
Filter = lambda Pred: lambda xs: Foldr (lambda x: lambda ac: Cons(x)(ac) if Pred(x) else ac) (Nil) (xs)

print "1 ==>\t",  Map    (Square)                       ([1,2,3,4,5])
print "2 ==>\t",  Foldl  (lambda a: lambda b: a/b) (60) ([3, 5, 0.5])
print "3 ==>\t",  Foldr  (lambda a: lambda b: a/b) (60) ([3, 5, 0.5])
print "4 ==>\t",  Filter (lambda x: x % 3 == 0)         ([1,2,3,4,5,6,7,8,9])
