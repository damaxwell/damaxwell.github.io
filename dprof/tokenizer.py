class Error:
  def __str__(self):
    return "Error"

class Operator:
  def __init__(self, c):
    self.op = c
  def __str__(self):
    return "Operator[%c]" % self.op

class Number:
  def __init__(self,text):
    self.text = text

  def value(self):
    if self.text.find('.') >= 0:
      return float(self.text)
    return int(self.text)
  def __str__(self):
    return "Number[%s]" % self.text

class Variable:
  def __init__(self,name):
    self.name = name
  def __str__(self):
    return "Variable[%s]" % self.name

class Command:
  def __init__(self,name):
    self.name = name
  def __str__(self):
    return "Command[%s]" % self.name

class OpenBrace:
  def __init__(self,b):
    self.brace = b
  def __str__(self):
    return "OpenBrace[%s]" % self.brace

class CloseBrace:
  def __init__(self,b):
    self.brace = b
  def __str__(self):
    return "CloseBrace[%s]" % self.brace

class BeginGroup:
  def __init__(self):
    pass

  def __str__(self):
    return "BeginGroup"

class EndGroup:
  def __init__(self):
    pass
  def __str__(self):
    return "EndGroup"

class Subscript:
  def __str__(self):
    return "Subscript"


class Tokenizer:
  def __init__(self, text):
    self.text = text
    self.position = 0
    self.error = None

  def next(self):
    if self.position >= len(self.text):
      self.position += 1
      return '\0'
    c = self.text[self.position]
    self.position += 1
    return c

  def nexttoken(self):
    if self.error is not None:
      return None

    c = self.next()
    while c.isspace():
      c = self.next()

    num = ""
    while c.isdigit():
      num += c
      c = self.next()
    if c == '.':
      num += c
      c = self.next()
    while c.isdigit():
      num += c
      c = self.next()

    if len(num) > 0:
      self.position -= 1
      if num == "-.":
        self.error = "-."
        return Error()
      return Number(num)

    if c == '_':
      return Subscript()

    if c in {'+', '-', '*', '/', '^'}:
      return Operator( c )

    if c == '{':
      return BeginGroup()

    if c == '}':
      return EndGroup()

    if c in { '(', '[' }:
      return OpenBrace(c)

    if c in { ')', ']' }:
      return CloseBrace(c)


    name = ''
    if c == '\\':
      c = self.next()
      if c == ' ':
        return Command(' ')
      while c.isalpha():
        name += c
        c = self.next()
      self.position -= 1

      if len(name) == 0:
        self.error = "empty command name"
        return Error()
      else:
        return Command(name)

    if c.isalpha():
      return Variable(c)

    if c == '\0':
      return None

    self.error = str(c)
    return Error()



# Expression -> Addition
# Addition -> Multiplication [ (+|-) Multiplication ]*
# Multiplication -> Power [ (*|/) Power ]*
# Power -> Func | Func ^ Func
# Func -> Command \left( Unary \right) | Command { Unary } | Command Argument | Unary
# Unary -> (+/-) Unary | Primary
# Argument -> + Argument | Primary
# Primary -> Variable | Number | | { Expression } | \left( Expression \right)

# Expression -> Addition
# Addition -> Multiplication [ (+|-) Multiplication ]*
# Multiplication -> Unary [ (*|/) Unary]
# Unary -> (+/-) Unary | Primary
# Argument -> + Argument | Primary
# Primary -> Variable | Number | | { Expression } | \left( Expression \right)

# Unary [ Primary | (*|/) Unary ]*


class Node:
  def __init__(self,value,lhs,rhs):
    self.kind = value
    self.lhs = lhs
    self.rhs = rhs
  def __str__(self):
    value = "%s[" % self.kind
    value += str(self.lhs)
    if self.rhs is not None:
      value += "," + str(self.rhs)
    value += "]"
    return value

greek_letters = { 'alpha': 'α', 'theta': 'θ', 'pi': 'π' }


class TokenFilter:
  def __init__(self,tokenizer):
    self.tokenizer = tokenizer

  def nexttoken(self):
    t = self.tokenizer.nexttoken()

    if type(t) == Command:
      if t.name in {'left', 'right', ' ' }:
        return self.nexttoken()

      if t.name in greek_letters:
        return Variable(greek_letters[t.name])

      if t.name == 'cdot':
        return Operator('*')

      if t.name == 'operatorname':
        if type(self.tokenizer.nexttoken()) != BeginGroup:
          raise Exception("Malformed operator name")
        opname = ""
        t = self.tokenizer.nexttoken()
        while type(t) == Variable:
          opname = opname + t.name
          t = self.tokenizer.nexttoken()
        if type(t) != EndGroup:
          raise Exception("Malformed operator name")
        return Command(opname)

    return t

known_functions = { 'sin', 'cos', 'tan', 'cot', 'sec', 'csc',
'arctan', 'arccos', 'arcsin', 'arcsec', 'arccsc', 
'atan', 'acos', 'asin', 'asec', 'acsc', 
'exp', 'sqrt', 'log', 'ln' }
  
class Parser:
  def __init__(self, text):
    self.t = TokenFilter(Tokenizer(text))
    self.token_cache = None

  def nexttoken(self):
    if self.token_cache is None:
      self.token_cache = self.t.nexttoken()
    return self.token_cache

  def consume(self):
    self.token_cache = None

  def parse(self):
    return self.expression()

  def expression(self):
    val =  self.addition()
    return val

  def addition(self):
    print("enter add")
    lhs = self.multiplication();

    while True:
      next = self.nexttoken()
      print("seek")
      print(next)
      if type(next) == Operator:
        op = next.op
        if op == '+' or op == '-':
          self.consume()
          rhs = self.multiplication()
          lhs =  Node(op,lhs,rhs)
        else:
          raise Exception("Unexpected operator %s" % op)
      else:
        print("breakings")
        break

    return lhs

  def multiplication(self):
    print("enter mult")
    lhs = self.power();

    while True:
      next = self.nexttoken()

      print("next %s" % next)
      if type(next) == Operator:
        op = next.op
        if op == '*' or op == '/':
          self.consume()
          rhs = self.power()
          lhs =  Node(op,lhs,rhs)
        else:
          break
      else:
        print("mult lookahead %s" % type(next))
        if type(next) == Command or type(next) == OpenBrace or type(next) == Variable or type(next) == Number:
          rhs = self.ppower()
          lhs = Node('*',lhs,rhs)          
        else:
          break
    return lhs

  def pmultiplication(self):
    lhs = self.ppower();

    while True:
      next = self.nexttoken()

      if type(next) == Operator:
        op = next.op
        if op == '*' or op == '/':
          self.consume()
          rhs = self.unary()
          lhs =  Node(op,lhs,rhs)
        else:
          break
      else:
        if type(next) == Command or type(next) == OpenBrace or type(next) == Variable or type(next) == Number:
          rhs = self.ppower()
          lhs = Node('*',lhs,rhs)          
        else:
          break
    return lhs

  def power(self):
    lhs = self.unary()

    next = self.nexttoken()
    if type(next) == Operator:
      op = next.op
      if op == '^':
        print("power")
        self.consume()
        rhs = self.unary()
        return Node('^',lhs,rhs)

    return lhs

  def ppower(self):
    lhs = self.funcapply()

    next = self.nexttoken()
    if type(next) == Operator:
      op = next.op
      if op == '^':
        self.consume()
        rhs = self.unary()
        return Node('^',lhs,rhs)

    return lhs


  def unary(self):
    t = self.nexttoken()
    if type(t) == Operator:
      op = t.op
      print(op)
      if op == '+' or op == '-':
        self.consume()
        if op == '-':
          lhs = self.unary();
          return Node('neg',lhs,None)
        else:
          return unary()
      else:
        raise Exception("Unexpected operator %s" % op)
    else:
      return self.funcapply()

  def funcapply(self):
    t = self.nexttoken()
    if type(t) == Command:
      if t.name in known_functions:
        self.consume()
        fname = t.name
        sup = None
        sub = None

        t = self.nexttoken()
        if type(t) == OpenBrace and t.brace == '[':
          self.consume()
          sub = self.expression()
          t = self.nexttoken()
          if not(type(t) == CloseBrace and t.brace == ']'):
            raise Exception("Malformed function modfier")
          self.consume();

        t = self.nexttoken()
        if type(t) == Operator and t.op == '^':
          self.consume()
          sup = self.funcsup()

        if sub is None:
          t = self.nexttoken()
          if type(t) == Subscript:
            self.consume()
            sub = self.funcsub()

        if sup is None:
          t = self.nexttoken()
          if type(t) == Operator and t.op == '^':
              self.consume()
              sup = self.funcsup()

        t = self.nexttoken()
        if type(t) == OpenBrace:
          self.consume()
          arg = self.expression();
          t = self.nexttoken();
          if not type(t) == CloseBrace:
            raise Exception("Missing function closing brace")
        elif type(t) == BeginGroup:
          self.consume()
          arg = self.expression();
          t = self.nexttoken();
          if not type(t) == EndGroup:
            raise Exception("Missing end group")
        else:
          arg = self.pmultiplication()

        base = Node(fname,arg,None)
        if sub is not None:
          base.rhs = base.lhs
          base.lhs = sub

        if sup == -1:
          return Node('funcinv',base,None)
        if sup is not None:
          return Node('^',base,sup)
        return base
      else:
        raise Exception("Unknown function %s" % t.name)
    else:
      return self.primary()

  def funcsup(self):
    t = self.nexttoken()

    neg = False    
    if type(t) is Operator and t.op == '-':
      neg = True
      self.consume()

    t = self.nexttoken()
    if type(t) is Number:
      self.consume()
      if neg:
        if t.value() != 1:
          raise Exception("Function power must be -1 or a positive number")
        return -1
      return t.value()
    raise Exception("Function power must be -1 or a positive number")

  def funcsub(self):
    t = self.nexttoken()
    needs_close = False
    print(t)
    if type(t) is BeginGroup:
      self.consume()
      needs_close = True

    t = self.nexttoken()
    if type(t) is Number:
      sub = t
      self.consume()

      if needs_close:
        t = self.nexttoken()
        if type(t) is EndGroup:
          self.consume()
        else:
          raise Exception("Missing closing brace in subscript")

      return sub


    raise Exception("Function subscript must be a positive number")


  def primary(self):
    t = self.nexttoken()
    print("enter primary %s" % t)

    if type(t) == OpenBrace:
      self.consume()
      inner = self.expression()

      found_close = False
      t = self.nexttoken()
      if type(t) == CloseBrace:
        found_close = True
        self.consume()

      if found_close:
        return inner
      else:
        raise Exception("Missing closing brace")

    if type(t) == BeginGroup:
      self.consume()
      inner = self.expression()

      found_close = False
      t = self.nexttoken()
      if type(t) == EndGroup:
        found_close = True
        self.consume()

      if found_close:
        return inner
      else:
        raise Exception("Missing closing brace")


    if type(t) == Variable:
      self.consume()
      print("found variable %s" % t.name)
      print(self.token_cache)
      return Node('variable',t.name,None)

    if type(t) == Number:
      self.consume();
      return Node('number',t.value(),None)

    if t is None:
      raise Exception("Unexpected end of expression.")

    raise Exception("Unexpected token %s" % t)

