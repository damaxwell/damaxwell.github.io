#let basic-numbering = (
  prep: (loc, counter) => {}, 
  display: (loc, thm-numbering, counter) => {
    numbering(thm-numbering, ..counter.at(loc))
  }
)

#let section-history  = state("proofy-section-history", (:))

#let section-numbering = (
  prep: (loc, counter) => {
    locate(loc => {
      let h1 = query(selector(heading.where(level:1)).before(loc), loc);

      if h1.len() > 0 {
        h1 = h1.last()

        if section-history.at(loc) != h1.location() {
          counter.update((0,))
          section-history.update(h1.location())
        }
      }
    })
  },

  display: (loc, thm-numbering, thm-counter) => {
    if thm-numbering == none {
      return
    }

    locate(loc-now => {
      let h = query(heading.where(level: 1).before(loc), loc-now);

      let h-ref = if h.len() > 0 {
        h.last()
      } else {
        // If there has never been a level 1 heading, the first 
        // heading of any kind.
        h = query(selector(heading).before(loc), loc);
        if h.len() > 0 {
          h.at(0)
        } else {
          none
        }
      }

      if h-ref != none {
        if h-ref.numbering != none {
          let h-counter = counter(heading).at(h-ref.location())
          numbering(h-ref.numbering, h-counter.at(0))
          "."
        }
      }
      numbering(thm-numbering, ..thm-counter.at(loc))
    })
  }
)
