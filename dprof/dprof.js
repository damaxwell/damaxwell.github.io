let g_prob_num = 0

function setup(problem) {
  
  let ivar = problem.ivar
  greek_ivar = greek_to_latex[ivar]
  if( greek_ivar != undefined ) {
    ivar = greek_ivar
  }

  let q_latex = "\\frac{d}{d"+ivar+"}" + problem.question
  console.log(q_latex)
  questionField.latex(q_latex)
  mathField.latex('')
  tf.innerHTML = ''
}

const greek_to_latex = {
    'θ' : '\\theta',
    'alpha' : '\\alpha',
}

var MQ = MathQuill.getInterface(2); // for backcompat

var questionSpan = document.getElementById('question');
var questionField = MQ.StaticMath(questionSpan);

var tf = document.getElementById('response')
var mathFieldSpan = document.getElementById('answer');
var mathField = MQ.MathField(mathFieldSpan, 
{
  spaceBehavesLikeTab: true, // configurable
  autoCommands: 'sqrt nthroot alpha beta gamma delta epsilon eta theta iota kappa lambda mu nu pi xi',
  autoOperatorNames: 'exp log ln sin cos tan sec csc cot asin acos atan asec acsc acot arctan arcsin arccos arcsec arccsc arccot',  
  supSubsRequireOperand: true,
  handlers: {
    enter: function() { // useful event handlers
      document.getElementById('error-message').innerHTML = ""

      let response = mathField.latex()
      document.getElementById('debug-latex').innerHTML = response
      if( response.length == 0 ) {
        tf.innerHTML = ""
        return
      }

      let answer = problems[g_prob_num].answer

      try {
        var is_correct = compare(response, answer)
      } catch(err) {
        document.getElementById('error-message').innerHTML = err.message
        setTimeout(() => {
          tf.innerHTML = "<b>Input Error</b>"}, "50")        
        return
      }
      console.log(is_correct)
      if( is_correct ) {
        tf.innerHTML = ""
        setTimeout(() => {
          tf.innerHTML = "<b>You got it!</b>"}, "200")        
      } else {        
        tf.innerHTML = ""
        setTimeout(() => {
          tf.innerHTML = "<b>Bummer</b>"}, "200")        
      }
    }
  }
} )

setup(problems[0])

document.getElementById('reset').addEventListener('click', (ev) => {
  setup(problems[g_prob_num])
})

document.getElementById('next').addEventListener('click', (ev) => {
  g_prob_num += 1
  if( g_prob_num >= problems.length ){
    g_prob_num = 0
  }
  setup(problems[g_prob_num])
})

document.getElementById('prev').addEventListener('click', (ev) => {
  g_prob_num -= 1
  if( g_prob_num < 0 ){
    g_prob_num = problems.length - 1
  }
  setup(problems[g_prob_num])
})
