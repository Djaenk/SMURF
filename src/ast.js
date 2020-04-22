export class Block {
  constructor(statements) {
    this.statements = statements
  }

  accept(visitor) {
    return visitor.Block(this)
  }
}

export class Assignment {
  constructor(l, r) {
    this.lvalue = l
    this.rvalue = r
  }

  accept(visitor) {
    return visitor.Assignment(this)
  }
}

export class VariableValue {
  constructor(value) {
    this.value = value
  }

  accept(visitor) {
    return visitor.VariableValue(this)
  }
}

export class VariableName {
  constructor(name) {
    this.name = name
  }

  accept(visitor) {
    return visitor.VariableName(this)
  }
}

export class IfExpression {
  constructor(condition, then_code, else_code) {
    this.condition = condition
    this.then_code = then_code
    this.else_code = else_code
  }

  accept(visitor) {
    return visitor.IfExpression(this)
  }
}

export class BinOp {
  constructor(l, op, r) {
    this.left = l
    this.op = op
    this.right = r
  }

  accept(visitor) {
    return visitor.BinOp(this)
  }
}

export class Integer {
  constructor(value) {
    this.value = value
  }

  accept(visitor) {
    return visitor.Integer(this)
  }
}

export class FunctionCall {
  constructor(name, args) {
    this.name = name
    this.args = args
  }

  accept(visitor) {
    return visitor.FunctionCall(this)
  }
}

export class FunctionDefinition {
  constructor(params, code) {
    this.params = params
    this.code = code
  }

  accept(visitor) {
    return visitor.FunctionDefinition(this)
  }
}