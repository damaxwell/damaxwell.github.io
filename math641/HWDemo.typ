// The import statement below imports the following commands:
//  homework: structures the entire document
//  problem: a  problem statement
//  subproblems: sets up a list for stating multi-part problems.
//  solution: the solution of a one-part problem
//  subsol: one solution of a multi-part problem
//  inset-material: offset a block of a solution to the left.  Handy for 
//                  extras like a Lemma/proof to indicate the beginning/end.
//  lemma: for adding a lemma to a solution
//  proof: contains the proof of a lemma
//  solver: mostly for official solutions, indicates the author 
//  of a solution
#import "math641.typ": *

// Pass the entire document through the `homework` template with the given
// parameters
#show: doc => homework(
    title: [Demo Homework],
    date: [Due: September 2, 2023],
    author: [Your Name Here],
    doc
)

// State a problem.
#problem[Exercise 3.14149 #solver[John Gimbel]

    If $a$ and $b$ are even integers, then so is $a + b$.
]
// Solve a problem.  The indentation is not require, but helps
// with readability.
#solution[
    Let $a$ and $b$ be even integers.  Then there exist integers
    $j$ and $k$ such that $a = 2j$ and $b = 2k$.  But then
    $
        a + b = 2j + 2k = 2(j + k).
    $
    Since $j + k in NN$, $a + b$ is even.
]


#problem[Exercise 2.718 #solver[Jill Faudree]
    Let $X$ be a set.
    #subproblems[
        + An intersection of topologies on $X$ is a topology on $X$.
        + A union of topologies on $X$ need not be a topology.
    ]
]
// A helpful definition to save typing.
#let top = $cal(T)$
#subsol[
    Let ${top_alpha}$ be a family of topologies and let $top= sect_alpha 
    top_alpha$.  Observe that $emptyset$ and $X$ belong to $top$ as they belong 
    to each $top_alpha$.

    Suppose ${U_beta}$ is a family of sets in $top$ and let $U = union_beta 
    U_beta$. Fix $alpha$ and observe that each $U_beta in top_alpha$. Since 
    $top_alpha$ is a topology, $U in top_alpha$.  Since $alpha$ is arbitrary, $U 
    in sect top_alpha=top$.

    The proof that a finite intersection of sets in $top$ belongs to $top$ is 
    essentially similar.
]

#subsol[
    Let $X={1,2,3}$.  Let $top_1 = {emptyset, {1, X}}$ and let 
    $top_2 = {emptyset, {2}, X}$. It is easy to see that these are topologies.
    Let $top=top_1 union top_2 = {emptyset, {1}, {2}, X}$. Observe that $top$ is not 
    closed under taking unions as ${1}$ and ${2}$ are elements of $top$ but 
    ${1,2}$ is not.
]

#problem[Exercise 9 #solver[Elizabeth Allman]
    Let $X$ be a metric space.  Show that the collection of open balls
    in $X$ forms the basis of a topology.
]
#solution[
We start with a technical lemma.
    #inset-material[
        #lemma(<lem-refine>)[
            Suppose $B_1=B_(r_1)(x_1)$ and $B_2=B_(r_2)(x_2)$ are 
            open balls in $X$ and $x_3 in B_1 sect B_2$.  Then there is an $r>0$ such
            that $B_r(x_3) subset.eq B_1 sect B_2$.
        ]
        #proof[
            Let $r = min(r_1-d(x_3,x_1),r_2-d(x_3,x_2))$ and observe that $r>0$.  
            Now suppose $z in B_r(x_3)$.  The triangle inequality implies
            $
                d(x_1,z) & <= d(x_1,x_3) + d(x_3,z) \
                         & < d(x_1,x_3) + r \
                         & <= d(x_1,x_3) + ( r_1-d(x_3,x_1) ) \
                         & = r_1
            $
            Hence $z in B_{r_1}(x_1)=x_1$.  Similarly $z in B_2$, and hence 
            $B_r(z) subset.eq B_1 sect B_2$.
        ]
    ]
    Continuing with the solution of the problem, 
    let $cal(B)$ be the collection of open balls in $X$.  Fix $x in X$ and note
    that $union_(r>0) B_r(x)=X$.  Hence $cal(B)$ covers $X$.  Moreover, by 
    @lem-refine, $cal(B)$ satisfies the refinement property.  Hence
    by the topology construction lemma, $cal(B)$ generates a topology on $X$,
    and the open sets are simply the unions of open balls.
]