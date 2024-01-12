#import "math641.typ": *
#let Riem = $cal(R)$

#show: doc => homework(
    title: [Homework 7],
    date: [Due: October 18, 2023],
    //author: [Your Name Here],

    // Delete this next line for your solutions; it changes some spacing.
    assign-only: true, 

    doc
)

#problem[
    Carothers 11.65 and this followup:

    Show that if $integral_a^b |K(x,t)|thin d t <= 1$ for all $x in [a,b]$ then
    the Arzela-Ascoli Theorem implies that given any $f in C[a,b]$, 
    the sequence $(T^((n))f)_n$ has a subsequence that converges in $C[a,b]$.
]

#problem[
    Suppose $f in Riem[a,b]$ and $alpha in RR$. Show that $alpha f in Riem[a,b]$
    and 
    $
    integral_a^b alpha f = alpha integral_a^b f.
    $
]

#problem[
    Show that the uniform limit of Riemann integrable functions is Riemann integrable.
    Conclude that $Riem[a,b]$ is a closed subspace of $B[a,b]$.
]

#problem[
    Determine if $chi_Delta in Riem[0,1]$, where $Delta$ is the Cantor set.
]
