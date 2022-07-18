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


class DProblem {
  constructor(document){
    this.element = document.createElement("div")

    let prompt = document.createElement("p")
    prompt.stype = "font-size:125%"
    prompt.innerHTML = "Compute the following derivative: &nbsp;"

    this.q_field = document.createElement("span")
    prompt.appendChild(this.q_field)
    this.element.appendChild(prompt)


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
      var is_correct = compare(response, answer)
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

  setup(problem) {
    this.problem = problem

    let ivar = problem.ivar
    let greek_ivar = greek_to_latex[ivar]
    if( greek_ivar != undefined ) {
      ivar = greek_ivar
    }

    let q_latex = "\\frac{d}{d"+ivar+"}" + problem.question
    this.q_field.innerHTML = "$" + q_latex + "$"
    if(MathJax.typeset != undefined) {
      MathJax.typeset([this.q_field]);
    }

    this.mathField.latex('')
    this.feedback.style.backgroundColor = color.relax;
    this.feedback.innerHTML = ""
  }
}

