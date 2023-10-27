#import "ams.typ"
#import "numbering.typ": *


#let number-styles = state("proofy-number-styles", (:))

#let show-rules() = it => {
  show ref: it => {
      let el = it.element
      if el != none and el.func() == figure and el.kind.starts-with("proofy") {

         if el.numbering == none {
              panic("Unable to reference un-numbered theorem. Set `numbering` field.")
          }
 
          let supplement = el.supplement
          let ref-supplement = it.citation.supplement
          if ref-supplement != none {
            if type(ref-supplement) == "function" {
              supplement = (ref-supplement)(el)
            } else {
              supplement = ref-supplement
            }
          }

          if supplement != none {
              [#supplement ]
          }

          let loc = el.location()
          let ns = number-styles.at(loc)
          if ns.keys().contains(el.kind) {
            let c = counter(figure.where(kind: el.kind))
            (number-styles.at(loc).at(el.kind).display)(loc, el.numbering, c)
          } else {
            [Missing]
          }

      } else {
          it
      }
  }

  it
}

#let generic-theorem( 
  ..args,
  species: none,
  alt: none,
  numbering: none,
  number-style: none,
  display: ams.display,
  group: "proofy"
) = {
  if args.named().len() != 0 {
    panic("Unexpected named arguments " + args.named())
  }

  let args = args.pos()
  if args.len() == 0 or args.len() > 2 {
    panic("Wrong number of arguments. Expected 1 or 2 (body and optional label), found " + args.len() + ".")
  }

  let label = none;
  let (body, label) = if args.len() == 1 {
    (args.at(0), none)
  } else {
    (args.at(1), args.at(0))
  }

  let thm-group = group

  let number-style = if (number-style == none or number-style == "document") {
      basic-numbering
    } else if number-style == "section" {
      section-numbering
    } else {
      // TODO
      // Check is a dictionary with `prep` and `display` keys
      number-style
    }

  let counter = counter(figure.where(kind: thm-group));

  if numbering != none {
    locate(loc=> {
      // Update `number-styles` at this location
      let ns-dict = number-styles.at(loc)
      ns-dict.insert(thm-group, number-style)
      number-styles.update(ns-dict)

      // Prep the counter.
      (number-style.prep)(loc, counter)
    })
  }

  show figure.where(kind: thm-group): it => {
    let number = none
    if numbering != none {
      number = locate(loc => {
        (number-style.display)(loc, numbering, counter)
      })
    }

    display(species, number, alt, body)
  }

  [#figure( none, kind: thm-group, supplement: species, numbering: numbering)#label]
}

#let qed-needed = state("proofy-qed-needed")
#let qed-symbol-cache = state("proofy-qed-symbol")

#let qedhere() = {
  qed-needed.update(false)
  locate(loc => {
    qed-symbol-cache.at(loc)
  })
}

#let proof(
  body,
  title: "Proof",
  display-title: ams.proof-title,
  display-body: body => { body },
  display-qed: qed => {
    h(1fr)
    qed
  },
  qed-symbol: $square.stroked.medium$,
  space-below: 1em
) = {
  qed-needed.update(true)
  qed-symbol-cache.update(qed-symbol)
  display-title(title)
  display-body(body)
  if qed-symbol != none {
    locate(loc => {
      if qed-needed.at(loc) {
        display-qed(qed-symbol)
      }
    })
  }
  v(space-below, weak:true)
}

#let new( 
  species,
  numbering: "1",
  display: ams.display,
  number-style: "section",
  group: auto
) = {
  if group == auto {
    group = "proofy"
  } else if group == none {
    group = "proofy-" + species
  } else {
    group = "proofy-" + group
  }

  generic-theorem.with(
    species: species,
    numbering: numbering,
    display: display,
    number-style: number-style,
    group: group
  )
}
