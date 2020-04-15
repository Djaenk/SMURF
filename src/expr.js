import * as AST from "./ast.js"

let ast = grammar.parse(process.argv[2], {AST: AST})
let interpreter  = new Interpreter()
let result = interpreter.visit(ast)