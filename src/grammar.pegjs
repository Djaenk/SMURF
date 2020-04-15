{
  const AST = options.AST
}

expr
  = _ head:term _ rest:(addop term)* _
    { return rest.reduce(
        (result, [op, right]) => new AST.BinOp(result, op, right),
        head
      )
    }

term
  = _ head:primary _ rest:(mulop primary)* _
    { return rest.reduce(
        (result, [op, right]) => new AST.BinOp(result, op, right),
        head
      )
    }

primary
  = integer
  / _ "(" _ expression:expr _ ")" _
    {return expression}

integer
  = _ sign:[+-]? digits:digits _
    { if (sign == '-') {
        return new AST.Integer(parseInt(digits.join(""), 10) * -1);
      }
      else {
        return new AST.Integer(parseInt(digits.join(""), 10));
      }
    }

digits
  = [0-9]+

addop
  = [+-]

mulop
  = [*/]

eol
  = [\n\r\u2028\u2029]

whitespace
  = [ \t]
  / eol
_
  = whitespace*

__
  = whitespace+