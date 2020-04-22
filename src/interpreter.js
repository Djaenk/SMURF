export default class Interpreter{
  constructor(target, printFunction) {
    this.binding = new Map()
  }

  getValue(name) {
    let value = this.binding.get(name)
    if(value) {
      return value
    }
    else {
      return 0
    }
  }

  setValue(name, value) {
    this.binding.set(name, value)
  }

  visit(node) {
    return node.accept(this)
  }

  Block(node) {
    let statements = node.statements
    var retval = 0
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
    return this.getValue(node.value)
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
      return node.then_code.accept(this)
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
        return left == right
      case "!=":
        return left != right
      case ">=":
        return left >= right
      case ">":
        return left > right
      case "<=":
        return left <= right
      case "<":
        return left < right
    }
  }

  Integer(node) {
    return node.value
  }

  FunctionCall(node) {
    return node.name.accept(this).accept(this)
  }

  FunctionDefinition(node) {
    return node.code
  }
}