grammar Calc;

eval returns [double value]
    : exp=additionExpression {$value = $exp.value;}
    ;

additionExpression returns [double value]
   : m1=multiplyingExpression {$value = $m1.value;}
   ( PLUS m2=multiplyingExpression {$value += $m2.value;}
   | MINUS m2=multiplyingExpression {$value -= $m2.value;}
   )*
   ;

multiplyingExpression returns [double value]
   : a1=atom {$value = $a1.value;}
   ( TIMES a2=atom {$value *= $a2.value;}
   | DIV a2=atom {$value /= $a2.value;}
   )*
   ;

atom returns [double value]
   : n=number {$value = Double.parseDouble($n.text);}
   | LPAREN exp=additionExpression RPAREN {$value = $exp.value;}
   ;

number
   : MINUS? DIGIT + (POINT DIGIT +)?
   ;


LPAREN
   : '('
   ;


RPAREN
   : ')'
   ;


PLUS
   : '+'
   ;


MINUS
   : '-'
   ;


TIMES
   : '*'
   ;


DIV
   : '/'
   ;


POINT
   : '.'
   ;


DIGIT
   : ('0' .. '9')
   ;


WS
   : [ \r\n\t] + -> channel (HIDDEN)
   ;