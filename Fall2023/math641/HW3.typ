#import "math641.typ": *

#show: doc => homework(
    title: [Homework 3],
    date: [Due: September 20, 2023],
    //author: [Your Name Here],

    // Delete this next line for your solutions; it changes some spacing.
    assign-only: true, 

    doc
)

#problem[Carothers 3.18]
#problem[Carothers 3.23]
#problem[
    *(Young's Inequality)*\
    Let $p in (1,oo)$ and define $q$ by 
    $1/p+1/q=1$.  Suppose $a,b >= 0$.  Show
    $
    a b <= (a^p)/p + (b^q)/q
    $
    and that the inequality is strict unless either $a^(p-1)=b$ or $b^(q-1)=a$
    (in which case both of these equalities hold!).

    *Hint:* If $a=0$ or $b=0$ the result is obvious. 
    Fix $b>0$ and
    consider $f(a)=a^p\/p+b^q\/q-a b$ on $(0,oo)$.  Your job is
    to show $f(a) >= 0$ with equality if and only if $a^p=b$.
    Sounds like an optimization problem! Look at the first and
    second derivatives of $f$.  

    *Remark:* You proof should clearly note the place where $p>1$ is used.
]
#problem[Carothers 3.34]
#problem[Carothers 3.36]
#problem[Carothers 3.39]
#problem[Carothers 4.3]
#problem[Carothers 4.11]
