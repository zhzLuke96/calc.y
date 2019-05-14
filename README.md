# calc.y
goyacc example.

> fork by <br>
> (https://github.com/golang-samples/yacc/blob/master/simple/calc.y)https://github.com/golang-samples/yacc/blob/master/simple/calc.y

# fif_calc.y
input
```
a  + 9 * ( c / g + 1)
```
output
```
'a' load 9 'c' load 'g' load div 1 add mul add
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
