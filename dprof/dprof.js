
let color = {
  relax: "#ADD8E6",
  error: "#EA3549",
  correct: "#4CF565",
  warn: "#FEFC8B"
}
const greek_to_latex = {
    'θ' : '\\theta',
    'alpha' : '\\alpha',
}

function compare(latex,answer,problem) {
  let guess = (new Parser(latex)).parse()
  console.log("Guess is")
  console.log(guess)
  guess = math.parse( guess.toMathJS() )

  answer = (new Parser(answer)).parse()
  console.log("Answer is")
  console.log(answer)
  answer = math.parse( answer.toMathJS() )

  if( math.symbolicEqual(guess,answer) ) {
    return true
  }
  console.log("Symbolic failed")
  let diff = new math.OperatorNode('-', 'subtract', [guess, answer]);
  ivar_val = [ 0.1, 1.2, 0.234567382, 0.66663 ]
  const_val = [0.3, 0.1, 1.2, 0.96]
  tol = 1e-12
  for( z in ivar_val) {
    console.log("test at " + ivar_val[z])
    let arg = {
      π:  3.141592653589793
    }
    arg[problem.ivar] = ivar_val[z]
    if(  problem.const != undefined ) {
      arg[problem.const] = const_val[z]
    }
    try {
      small = math.abs(diff.evaluate(arg))
    } catch (error) {
      console.log(error)
      return false
    }
    console.log(small)
    if(small > 1e-6) {
      return false
    }
  }
  return true
}


class DProblem {
  constructor(document){
    this.element = document.createElement("div")
    this.element.className = "problem-container"

    this.problem_label = document.createElement("p")
    this.problem_label.className = "problem-label"
    this.element.appendChild(this.problem_label)

    let q_field = document.createElement("p")
    q_field.class = "question-statement"
    q_field.innerHTML = ""
    this.q_field = q_field
    this.element.appendChild(q_field)

    let answer_block = document.createElement("div")
    answer_block.className = "container"
    
    this.feedback = document.createElement("div")
    this.feedback.className = "left"
    answer_block.appendChild( this.feedback )

    var answerDiv = document.createElement("div")
    answerDiv.className = "right"
    answer_block.appendChild( answerDiv)

    this.element.appendChild(answer_block)

    var MQ = MathQuill.getInterface(2); // for backcompat

    var handlers = {
      parent: this,
      edit: function() { this.parent.on_edit() },
      enter: function() { this.parent.on_enter() }
    }

    var args =     {
      spaceBehavesLikeTab: true, // configurable
      autoCommands: 'sqrt nthroot alpha beta gamma delta epsilon eta theta iota kappa lambda mu nu pi xi',
      autoOperatorNames: 'exp log ln sin cos tan sec csc cot asin acos atan asec acsc acot arctan arcsin arccos arcsec arccsc arccot',  
      supSubsRequireOperand: true,
    }
    args.handlers = handlers

    this.mathField = MQ.MathField(answerDiv, args )

  }

  on_edit() {
    this.feedback.style.backgroundColor = color.relax
    this.feedback.innerHTML = ""
    this.feedback.classList = ["left"]
  }

  on_enter() {
    this.feedback.style.backgroundColor = color.relax;
    this.feedback.innerHTML = ""
    this.feedback.classList = ["left"]

    let response = this.mathField.latex()
    console.log("Generated answer: " + response)

    let answer = this.problem.answer

    try {
      var is_correct = compare(response, answer, this.problem)
    } catch(err) {
      this.feedback.style.backgroundColor = color.warn;
      this.feedback.innerHTML="<img src='warn.svg' width=35px>"
      this.feedback.classList.add( "hovertext")
      this.feedback.setAttribute("data-hover",err.message)
      return
    }

    this.feedback.innerHTML = ""
    if( is_correct ) {
      this.feedback.style.backgroundColor = color.correct;
      this.feedback.innerHTML="<img src='check.svg' width=35px>"
    } else {        
      this.feedback.style.backgroundColor = color.error;
      this.feedback.innerHTML="<img src='ex.svg' width=25px>"
    }
  }

  setup(problem, number) {
    this.problem = problem

    if( problem.label == undefined) {
      this.problem_label.innerHTML = (parseFloat(number) + 1) +")"
    } else {
      this.problem_label.innerHTML = problem.label
    }

    let ivar = problem.ivar
    let greek_ivar = greek_to_latex[ivar]
    if( greek_ivar != undefined ) {
      ivar = greek_ivar
    }

    this.q_field.innerHTML = problem.question
    if(MathJax.typeset != undefined) {
      MathJax.typeset([this.q_field]);
    }

    this.mathField.latex('')
    this.feedback.style.backgroundColor = color.relax;
    this.feedback.innerHTML = ""
  }
}

