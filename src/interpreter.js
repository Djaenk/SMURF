export default class Interpreter{
  constructor(target, printFunction) {
    this.binding = new Map()
  }

  getVariable(name) {
    let value = this.binding.get(name)
    if(value) {
      return value
    }
    else {
      return 0
    }
  }

  setVariable(name, value) {
    this.binding.set(name, value)
  }

  visit(node) {
    return node.accept(this)
  }

  Block(node) {
    let statements = node.statements
    var retval
    for(let statement of statements) {
      retval = statement.accept(this)
    }
    return retval
  }

  Assignment(node) {
    let lvalue = node.lvalue.accept(this)
    let rvalue = node.rvalue.accept(this)
    this.setVariable(lvalue, rvalue)
    return rvalue
  }

  VariableValue(node) {
    return this.getVariable(node.value)
  }

  VariableName(node) {
    return node.name
  }

  IfExpression(node) {
    let boolean = node.condition.accept(this)
    if(boolean) {
      return node.then_code.accept(this)
    }
    else {
      return node.else_code.accept(this)
    }
  }

  BinOp(node) {
    let left = node.left.accept(this)
    let right = node.right.accept(this)
    switch(node.op){
      case "-":
        return left - right
      case "+":
        return left + right
      case "/":
        return Math.round(left / right)
      case "*":
        return left * right
      case "==":
        return left == right === true ? 1 : 0
      case "!=":
        return left != right === true ? 1 : 0
      case ">=":
        return left >= right === true ? 1 : 0
      case ">":
        return left > right === true ? 1 : 0
      case "<=":
        return left <= right === true ? 1 : 0
      case "<":
        return left < right === true ? 1 : 0
    }
  }

  Integer(node) {
    return node.value
  }

  FunctionCall(node) {
    let name = node.name.accept(this)
    return name.accept(this)
  }

  FunctionDefinition(node) {
    return node.code
  }
}