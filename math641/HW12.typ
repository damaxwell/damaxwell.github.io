#import "math641.typ": *
#let Riem = $cal(R)$

#show: doc => homework(
    title: [Homework 11],
    date: [Due: December 1, 2023],
    //author: [Your Name Here],

    // Delete this next line for your solutions; it changes some spacing.
    assign-only: true, 

    doc
)

#problem[Carothers 18.1]
#problem[Carothers 18.3]
#problem[Carothers 18.4]
#problem[Carothers 18.6]
#problem[Carothers 18.9]
#problem[Carothers 18.11]
#problem[
Let $f >= 0$ be Riemann integrable. In this exercise you will show that $f$
is measurable and that its Riemann integral $(R)integral_a^b f$ equals its Lebesgue integral
$(L)integral_a^b f$.  In your work, you are welcome to use the obvious fact that the Riemann integral and the Lebesgue integral agree for step functions.
#subproblems[
  + Show that there exists a monotone increasing sequence of step functions 
        $phi_n$ and a monotone decreasing sequence of step functions $psi_n$ such that
        $phi_n <= f <= psi_n$ for each $n$ and such that
        $
(R)integral_a^b (psi_n-phi_n) arrow 0.
        $
  + Let $Phi= sup phi_n$ and $Psi= inf phi_n$.  Show that $ Psi - Phi=0$ almost everywhere.
  + Conclude that $f$ is measurable.
  + Conclude that $(R) integral_a^b f = (L) integral_a^b f.$
]
]
#problem[Carothers 18.16]
#problem[Carothers 18.17]

