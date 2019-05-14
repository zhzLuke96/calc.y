# calc.y
goyacc example.

> fork by <br>
> (https://github.com/golang-samples/yacc/blob/master/simple/calc.y)https://github.com/golang-samples/yacc/blob/master/simple/calc.y

# fif_calc.y
input
```
a1  + 9 * ( c2 / g3 + 1)
```
output
```
'a1' load 9 'c2' load 'g3' load div 1 add mul add
```

input
```
a = f + g * ( 9 - 5 )
```
output
```
'f' load 'g' load 9 5 sub mul add 'a' swap store
```

# LICENSE
GPL-3.0
