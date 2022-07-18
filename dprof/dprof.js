let color = {
  relax: "#ADD8E6",
  error: "#EA3549",
  correct: "#4CF565",
  warn: "#FEFC8B"
}


class DProblem {
  constructor(container) {
    this.err_msg = container.querySelector('[name="error-message"]')
    this.latex_debug = container.querySelector('[name="debug-latex"]')
    this.q_field = container.querySelector('[name="question-jax"]')

    this.feedback = container.querySelector('.left')
    console.log(container)
    console.log(this.feedback)

    var MQ = MathQuill.getInterface(2); // for backcompat
    var mathFieldSpan = container.querySelector('[name="answer"]');

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

    this.mathField = MQ.MathField(mathFieldSpan, args )
      //   enter: function() { // useful event handlers
      // }
  };

  on_edit() {
    this.feedback.style.backgroundColor = color.relax
  }

  on_enter() {
    this.err_msg.innerHTML = ""
    this.feedback.style.backgroundColor = color.relax;

    let response = this.mathField.latex()
    this. latex_debug.innerHTML = response

    let answer = this.problem.answer

    try {
      var is_correct = compare(response, answer)
    } catch(err) {

      this.feedback.style.backgroundColor = color.warn;
      this.feedback.innerHTML="<img src='warn.svg' width=35px>"
      this.err_msg.innerHTML = err.message
      return
    }

    this.feedback.innerHTML = ""
    if( is_correct ) {
      this.feedback.style.backgroundColor = color.correct;
      this.feedback.innerHTML="<img src='check.svg' width=35px>"
    } else {        
      this.feedback.style.backgroundColor = color.error;
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


let g_prob_num = 0


const greek_to_latex = {
    'θ' : '\\theta',
    'alpha' : '\\alpha',
}


// var questionSpan = document.getElementById('question');
// var questionField = MQ.StaticMath(questionSpan);

// var feedback = document.getElementById('feedback')
// var mathFieldSpan = document.getElementById('answer');

var the_problem = new DProblem(document.getElementById("problem1"))

the_problem.setup(problems[0])

document.getElementById('reset').addEventListener('click', (ev) => {
  the_problem.setup(problems[g_prob_num])
})

document.getElementById('next').addEventListener('click', (ev) => {
  g_prob_num += 1
  if( g_prob_num >= problems.length ){
    g_prob_num = 0
  }
  the_problem.setup(problems[g_prob_num])
})

document.getElementById('prev').addEventListener('click', (ev) => {
  g_prob_num -= 1
  if( g_prob_num < 0 ){
    g_prob_num = problems.length - 1
  }
  the_problem.setup(problems[g_prob_num])
})
