export default class Interpreter{
  visit(node){
    return node.accept(this)
  }

  visitBinOp(node){
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
        return Math.round(left * right)
    }
  }

  visitInteger(node){
    return node.value
  }
}