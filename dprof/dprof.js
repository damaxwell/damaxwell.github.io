let g_prob_num = 0

function setup(prob_num) {
  g_prob_num = prob_num
  
  console.log("setup!")
  console.log(mathField.value)
  questionField.latex(problems[prob_num].question)
  mathField.latex('')
  tf.innerHTML = ''
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
  handlers: {
    enter: function() { // useful event handlers
      let response = mathField.latex()
      let answer = problems[g_prob_num].answer

      let is_correct = compare(response, answer)
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

setup(0)

document.getElementById('reset').addEventListener('click', (ev) => {
  setup(g_prob_num)
})

document.getElementById('next').addEventListener('click', (ev) => {
  g_prob_num += 1
  if( g_prob_num >= problems.length ){
    g_prob_num = 0
  }
  setup(g_prob_num)
})
