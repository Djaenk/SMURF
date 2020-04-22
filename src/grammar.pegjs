{
  const AST = options.AST
}

start
  = code

identifier
  = [a-z][a-zA-Z0-9_]*

code
  = _ statements:statement+ _
    { return new AST.Block(statements) }

statement
  = _ "let" __ declaration:variable_declaration
    { return declaration }
  / assignment:assignment
    { return assignment }
  / expr:expr
    { return expr }

variable_declaration
  = _ left:variable_name _ "=" _ right:expr
    { return new AST.Assignment(left, right) }
  / left:variable_name
    { return new AST.Assignment(left, new AST.Integer(0)) }

variable_value
  = identifier:identifier
    { return new AST.VariableValue(identifier.join("")) }

variable_name
  = identifier:identifier
    { return new AST.VariableName(identifier.join("")) }

if_expression
  = _ condition:expr _ then_block:brace_block _ "else" _ else_block:brace_block
    { return new AST.IfExpression(condition, then_block, else_block) }
  / _ condition:expr _ then_block:brace_block
    { return new AST.IfExpression(condition, then_block, []) }

assignment
  = _ left:variable_name _ "=" _ right:expr
    { return new AST.Assignment(left, right) }

expr
  = _ "fn" _ definition:function_definition
    { return definition }
  / _ "if" _ expression:if_expression
    { return expression }
  / _ expression:boolean_expression
    { return expression }
  / _ expression:arithmetic_expression
    { return expression }

boolean_expression
  = _ head:arithmetic_expression _ rest:(relop _ arithmetic_expression)*
    { return rest.reduce(
        (result, [op, right]) => new AST.BinOp(result, op, right),
        head
      )
    }

arithmetic_expression
  = _ head:mult_term _ rest:(addop _ mult_term)*
    { return rest.reduce(
        (result, [op, right]) => new AST.BinOp(result, op, right),
        head
      )
    }

mult_term
  = _ head:primary _ rest:(mulop _ primary)*
    { return rest.reduce(
        (result, [op, right]) => new AST.BinOp(result, op, right),
        head
      )
    }

primary
  = integer
  / _ "(" _ expression:arithmetic_expression _ ")"
    {return expression}

integer
  = _ sign:[+-]? digits:digits
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

relop
  = "=="
  / "!="
  / ">="
  / ">"
  / "<="
  / "<"

function_call
  = _ value:variable_value _ "(" _ ")"
    { return new AST.FunctionCall(value, []) }

function_definition
  = _ parameters:param_list _ code:brace_block
    { return new AST.FunctionDefinition(parameters, code) }

param_list
  = _ "(" _ ")"

brace_block
  = _ "{" _ code:code _ "}"
    { return code }



eol
  = [\n\r\u2028\u2029]

whitespace
  = [ \t]
  / eol
_
  = whitespace*

__
  = whitespace+