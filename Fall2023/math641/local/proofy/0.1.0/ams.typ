#let title(species, number, alt, swap-numbers: false) = {
  set text(weight:"bold")
  if swap-numbers {
    if number != none {
      [#number ]
    }
    species
  } else {
    species
    if number != none {
      [ #number]
    }
  }
  [.]
  if alt != none {
    [ (#alt).]
  }
}

#let body(body) = {
  set text(style:"italic")
  body
}

#let display(
  species, 
  number, 
  alt, 
  body,
  space-above: 1em,
  space-below: 1em,
  title-indent: 0pt,
  title-sep: h(0.5em, weak:true),
  display-title:  title,
  display-body: body,
  ) = {
    v(space-above, weak: true)
    block(width: 100%, {
      h(title-indent)
      display-title(species, number, alt)
      title-sep
      display-body( body )
    })
    v(space-below, weak: true)
}

#let proof-title(
  title,
  style: (style: "italic"),
  punctuation: ".",
  sep: h(0.5em, weak: true),
) = {
  {
    set text( ..style )
    title
    punctuation
    sep
  }
}
