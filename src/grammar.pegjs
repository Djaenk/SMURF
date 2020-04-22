{
  const AST = options.AST
}

start
  = code

identifier
  = [a-z][a-zA-Z0-9_]*

code
  = statements:statement+
    { return new AST.Block(statements) }

statement
  = _ "let" _ declaration:variable_declaration
    { return declaration }
  / assignment:assignment
    { return assignment }
  / expr:expr
    { return expr }

variable_declaration
  = left:variable_name _ "=" _ right:expr
    { return new AST.Assignment(left, right) }
  / left:variable_name
    { return new AST.Assignment(left, new AST.Integer(0)) }

variable_value
  = _ identifier:identifier _
    { return new AST.VariableValue(identifier.join("")) }

variable_name
  = _ identifier:identifier _
    { return new AST.VariableName(identifier.join("")) }

if_expression
  = condition:expr then_block:brace_block _ "else" _ else_block:brace_block
    { return new AST.IfExpression(condition, then_block, else_block) }
  / condition:expr then_block:brace_block
    { return new AST.IfExpression(condition, then_block, "") }

assignment
  = left:variable_name _ "=" _ right:expr
    { return new AST.Assignment(left, right) }

expr
  = _ "fn" _ definition:function_definition
    { return definition }
  / _ "if" _ expression:if_expression
    { return expression }
  / expression:boolean_expression
    { return expression }
  / expression:arithmetic_expression
    { return expression }

boolean_expression
  = _ head:arithmetic_expression rest:(relop arithmetic_expression)*
    { return rest.reduce(
        (result, [op, right]) => new AST.BinOp(result, op, right),
        head
      )
    }

arithmetic_expression
  = head:mult_term rest:(addop mult_term)*
    { return rest.reduce(
        (result, [op, right]) => new AST.BinOp(result, op, right),
        head
      )
    }

mult_term
  = head:primary rest:(mulop primary)*
    { return rest.reduce(
        (result, [op, right]) => new AST.BinOp(result, op, right),
        head
      )
    }

primary
  = integer
  / call:function_call
    { return call }
  / value:variable_value
    { return value }
  / _ "(" _ expression:arithmetic_expression _ ")" _
    { return expression }

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

relop
  = "=="
  / "!="
  / ">="
  / ">"
  / "<="
  / "<"

function_call
  = value:variable_value _ "(" _ ")" _
    { return new AST.FunctionCall(value, "") }

function_definition
  = parameters:param_list code:brace_block
    { return new AST.FunctionDefinition(parameters, code) }

param_list
  = _ "(" _ ")" _

brace_block
  = _ "{" _ code:code _ "}" _
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