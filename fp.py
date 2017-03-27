#!/usr/bin/env python3
# -*- coding: utf-8 -*-

cons = lambda x: lambda y: lambda isCar: x if isCar else y
car = lambda node: node(True)
cdr = lambda node: node(False)

null = lambda obj: obj == None
number = lambda obj: isinstance(obj, (int, float, complex))

id = lambda x: x

foldr = lambda f: lambda zero: lambda xs:\
        zero if null(xs) else f (car(xs)) (foldr (f) (zero) (cdr(xs)))
foldl = lambda f: lambda zero: lambda xs:\
        foldr (lambda x: lambda g: lambda a: g (f(a)(x))) (id) (xs) (zero)

display = lambda xs: print() if null(xs) else\
          (print(car(xs), end=' '), display(cdr(xs)))

map = lambda proc: lambda xs:\
        foldr (lambda x: lambda ac: cons(proc(x))(ac)) (None) (xs)
filter = lambda pred: lambda xs:\
         foldr (lambda x: lambda ac:\
                cons(x)(ac) if pred(x) else ac) (None) (xs)

range = lambda a: lambda b: None if a > b else cons(a)(range(a + 1)(b))

#display (map (lambda x: x * x) (range(1)(10)))
#print(foldr (lambda a: lambda b: a - b) (0) (range(1)(3)))

sum = lambda xs: foldr (lambda a: lambda b: a + b) (0) (xs)
print(sum(map (lambda x: x * x) (range(1)(3))))
