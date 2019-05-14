%{

package main

import (
	"bufio"
	"fmt"
	"os"
	"unicode"
)

%}

%union{
	val int
    str string
}

%type <val> expr number
%type <str> string

%token <val> DIGIT LETTER

%left '|'
%left '&'
%left '+'  '-'
%left '*'  '/'  '%'
%left UMINUS      /*  supplies  precedence  for  unary  minus  */

%%

S	:	stmt
	|	stmt ";" stmt
	|	expr
	;

stmt:	string "=" expr				{ fmt.Printf("'%v' swap store ", $1) }

expr:   '(' expr ')'                { /* empty */ }
	|   expr '+' expr               { fmt.Print("add ") }
	|   expr '-' expr               { fmt.Print("sub ") }
	|   expr '*' expr               { fmt.Print("mul ") }
	|   expr '/' expr               { fmt.Print("div ") }
	|   expr '&' expr               { fmt.Print("and ") }
	|   expr '|' expr               { fmt.Print("or ") }
	|   expr '%' expr               { fmt.Print("mod ") }
	|   '-' expr %prec  UMINUS      { fmt.Print("-") }
	|   string                      { fmt.Printf("'%v' load ", $1) }
	|   number                      { fmt.Printf("%v ", $1) }
	;

number: DIGIT                       { $$ = $1 }
	|   number DIGIT                { $$ = 10 * $1 + $2 /* base 10 */ }
	;

string: LETTER						{ $$ = string($1) }
	|	string LETTER				{ $$ = $1 + string($2) }
	;

%%      /*  start  of  programs  */

type CalcLex struct {
	s string
	pos int
}


func (l *CalcLex) Lex(lval *CalcSymType) int {
	var c rune = ' '
	for c == ' ' {
		if l.pos == len(l.s) {
			return 0
		}
		c = rune(l.s[l.pos])
		l.pos += 1
	}

	if unicode.IsDigit(c) {
		lval.val = int(c) - '0'
		return DIGIT
	} else if unicode.IsLetter(c){
		lval.val = int(c)
		return LETTER
	}
	return int(c)
}

func (l *CalcLex) Error(s string) {
	fmt.Printf("syntax error: %s\n", s)
}

func main() {
	for {
		fmt.Printf("expr: ")
		reader := bufio.NewReader(os.Stdin)
		data, _, _ := reader.ReadLine()
		input := string(data) + "\000"

		CalcParse(&CalcLex{s: input})
		fmt.Print("\n")
	}
}