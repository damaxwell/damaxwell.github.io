#import "math641.typ": *

#show: doc => homework(
    title: [Homework 1],
    date: [Due: September 6, 2023],
    //author: [Your Name Here],

    // Delete this next line for your solutions; it changes some spacing.
    assign-only: true, 

    doc
)

#problem[Carothers 1.4] 

#problem[Carothers 1.11]

#problem[Carothers 1.15]
#problem[Carothers 1.21]
#problem[Carothers 1.24]

#let limover = mathop($overline("lim")$)
#problem[
    Suppose $limsup_(n->oo) x_n = -oo$, as defined in 
    terms of eventual upper bounds.  Show that 
    $
    limover_(n->oo) x_n = -oo
    $
    as defined in the text.
]

#problem[
    Let $(r_n)$ be an enumeration of $QQ sect [0,1]$. 
    Show that $limits(limsup)_(n->oo) r_n = 1$.
]

#problem[
    Prove that
    $
    limsup x_n + liminf y_n <= limsup (x_n+y_n) <= limsup x_n + limsup y_n
    $
    so long as neither of the right- or left-hand sides are 
    of the form $oo - oo$.
]

#problem[Carothers 1.36]
