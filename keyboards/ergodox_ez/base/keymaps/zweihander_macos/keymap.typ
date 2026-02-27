// ErgoDox EZ — Zweihander (macOS) cheat sheet
// Compile: typst compile keymap.typ

#set page(width: 11in, height: 8.5in, margin: 0.4in)
#set text(font: "Helvetica Neue", size: 7pt)

#let u = 13mm
#let kh = 6.5mm
#let gap = 6mm
#let thumb-gap = 3pt

// ── Key rendering ───────────────────────────────────────────────────────────

#let key(body, w: 1, h: 1, bg: white, fg: black, bld: false, sub: none) = {
  rect(
    width: u * w, height: kh * h,
    radius: 1.5pt, stroke: 0.4pt + luma(60%), fill: bg, inset: 1pt,
    align(center + horizon,
      if sub != none {
        stack(dir: ttb, spacing: 0.5pt,
          text(size: 5.5pt, weight: if bld { "bold" } else { "regular" }, fill: fg, body),
          text(size: 4pt, fill: luma(50%), sub),
        )
      } else {
        text(size: 5.5pt, weight: if bld { "bold" } else { "regular" }, fill: fg, body)
      }
    ),
  )
}

// ── Style shortcuts ─────────────────────────────────────────────────────────

#let mbg = luma(90%)
#let lbg = luma(75%)
#let xbg = luma(96%)
#let xfg = luma(70%)

#let K(l) = key(l)
#let M(l) = key(l, bg: mbg, bld: true)
#let Ly(l) = key(l, bg: lbg, bld: true)
#let D(tap, hold) = key(tap, bg: mbg, bld: true, sub: hold)
#let X(l) = key(l, bg: xbg, fg: xfg)

#let Ly2(l) = key(l, h: 2, bg: lbg, bld: true)
#let K2(l) = key(l, h: 2)
#let X2(l) = key(l, h: 2, bg: xbg, fg: xfg)

// ── Layout engine ───────────────────────────────────────────────────────────
// Each half:
//   rows: 5 arrays (rows 0-3 have 6 keys, row 4 has 5 keys — inset)
//   inner: (row0, rows1-2-tall, row3) — 3 entries; tall key is h:2
//   thumb: (top0, top1, big0, big1, sm0, sm1) — 6 entries; big keys are h:2
//
// Left thumb physical layout:       Right thumb (mirrored):
//         [top0] [top1]             [top0] [top1]
//  [big0] [big1] [sm0 ]            [sm0 ] [big0] [big1]
//                [sm1 ]            [sm1 ]

#let draw-half(rows, inner, thumb, is-right) = {
  let row-fn(keys) = stack(dir: ltr, spacing: 0pt, ..keys)

  let half-w = 7 * u
  let half-h = 5 * kh + thumb-gap + 3 * kh

  box(width: half-w, height: half-h, {
    let ix = if is-right { 0pt } else { 6 * u }
    let mx = if is-right { u } else { 0pt }

    for ri in range(4) {
      place(dx: mx, dy: kh * ri, row-fn(rows.at(ri)))
    }
    place(dx: ix, dy: 0pt, inner.at(0))
    place(dx: ix, dy: kh, inner.at(1))
    place(dx: ix, dy: 3 * kh, inner.at(2))

    place(dx: mx + u, dy: 4 * kh, row-fn(rows.at(4)))

    let ty = 5 * kh + thumb-gap

    if not is-right {
      let cx = 4 * u
      place(dx: cx + u, dy: ty, thumb.at(0))
      place(dx: cx + 2 * u, dy: ty, thumb.at(1))
      place(dx: cx, dy: ty + kh, thumb.at(2))
      place(dx: cx + u, dy: ty + kh, thumb.at(3))
      place(dx: cx + 2 * u, dy: ty + kh, thumb.at(4))
      place(dx: cx + 2 * u, dy: ty + 2 * kh, thumb.at(5))
    } else {
      let cx = 0pt
      place(dx: cx, dy: ty, thumb.at(0))
      place(dx: cx + u, dy: ty, thumb.at(1))
      place(dx: cx + u, dy: ty + kh, thumb.at(2))
      place(dx: cx + 2 * u, dy: ty + kh, thumb.at(3))
      place(dx: cx, dy: ty + kh, thumb.at(4))
      place(dx: cx, dy: ty + 2 * kh, thumb.at(5))
    }
  })
}

#let draw-layer(title, l-rows, l-inner, l-thumb, r-rows, r-inner, r-thumb) = {
  block(width: 100%, inset: (x: 4pt, y: 2pt), fill: luma(30%), radius: 2pt,
    text(size: 9pt, weight: "bold", fill: white, title))
  v(2pt)
  align(center, stack(dir: ltr, spacing: gap,
    draw-half(l-rows, l-inner, l-thumb, false),
    draw-half(r-rows, r-inner, r-thumb, true),
  ))
}

// ── BASE ────────────────────────────────────────────────────────────────────

#let bl = (
  (K("="), K("1"), K("2"), K("3"), K("4"), K("5")),
  (K("⌦"), K("Q"), K("W"), K("E"), K("R"), K("T")),
  (K("⌫"), K("A"), K("S"), K("D"), K("F"), K("G")),
  (M("L⇧"), K("Z"), K("X"), K("C"), K("V"), K("B")),
  (M("L⌃"), M("L⌥"), M("L⌘"), K("←"), K("→")),
)
#let bli = (Ly("L1"), Ly2("~L1"), M("L⌘"))
#let blt = (K("`~"), M("⇪"), K2("↩︎"), K2("⇥"), M("L⌥"), M("L⌃"))

#let br = (
  (K("6"), K("7"), K("8"), K("9"), K("0"), K("-")),
  (K("Y"), K("U"), K("I"), K("O"), K("P"), K("\\")),
  (K("H"), K("J"), K("K"), K("L"), D(";", "L2"), D("'", "R⌘")),
  (K("N"), K("M"), K(","), K("."), D("/", "R⌥"), M("R⇧")),
  (K("↑"), K("↓"), K("["), K("]"), K("↩︎")),
)
#let bri = (Ly("L1"), Ly2("~L1"), M("R⌘"))
#let brt = (K("⎋"), K("⌫"), K2("⇥"), K2("␣"), M("R⌥"), M("R⌃"))

// ── SYMB ────────────────────────────────────────────────────────────────────

#let sl = (
  (X("="), K("F1"), K("F2"), K("F3"), K("F4"), K("F5")),
  (X("⌦"), K("["), K("]"), K("{"), K("}"), K("\"")),
  (X("⌫"), K("<"), K(">"), K("("), K(")"), K("'")),
  (X("L⇧"), K("%"), K("/"), K("⇪"), K("-"), K("=")),
  (X("L⌃"), X("L⌥"), X("L⌘"), X("←"), X("→")),
)
#let sli = (X("L1"), X2("~L1"), X("L⌘"))
#let slt = (X("`~"), X("⇪"), X2("↩︎"), X2("⇥"), X("L⌥"), X("L⌃"))

#let sr = (
  (K("F6"), K("F7"), K("F8"), K("F9"), K("F10"), K("F11")),
  (K("/"), K("7"), K("8"), K("9"), K("*"), K("F12")),
  (K("-"), K("4"), K("5"), K("6"), K("+"), K("`~")),
  (K(":"), K("1"), K("2"), K("3"), K("="), X("R⇧")),
  (K("0"), K("."), K("←"), K("→"), X("↩︎")),
)
#let sri = (X("L1"), X2("~L1"), X("R⌘"))
#let srt = (X("⎋"), X("⌫"), X2("⇥"), X2("␣"), X("R⌥"), X("R⌃"))

// ── MDIA ────────────────────────────────────────────────────────────────────

#let ml = (
  (X("="), K("F14"), K("F15"), K("PrtSc"), K("ScrLk"), K("Pause")),
  (X("⌦"), X("Q"), K("⌥↑"), K("PgUp"), K("⌥↓"), X("T")),
  (X("⌫"), K("⌃⇧←"), K("Home"), K("PgDn"), K("End"), K("⌃⇧→")),
  (X("L⇧"), X("Z"), X("X"), X("C"), X("V"), X("B")),
  (X("L⌃"), X("L⌥"), X("L⌘"), X("←"), X("→")),
)
#let mli = (X("L1"), X2("~L1"), X("L⌘"))
#let mlt = (X("`~"), X("⇪"), X2("↩︎"), X2("⇥"), X("L⌥"), X("L⌃"))

#let mr = (
  (K("⌘W"), K("⌘⇧`"), K("⌘S"), K("⌘`"), K("Eject"), K("Power")),
  (K("⌘]"), K("⌥⌘↑"), K("↑"), K("⌥⌘↓"), X("P"), X("\\")),
  (K("⌘["), K("←"), K("↓"), K("→"), X(";"), K("F16")),
  (K("⌘Z"), K("Play"), K("Prev"), K("Next"), X("/"), X("R⇧")),
  (K("Vol-"), K("Vol+"), K("Mute"), X("]"), X("↩︎")),
)
#let mri = (X("L1"), X2("~L1"), X("R⌘"))
#let mrt = (X("⎋"), X("⌫"), K2("⌘C"), K2("⌘V"), X("R⌥"), K("⌘X"))

// ── Render ──────────────────────────────────────────────────────────────────

#draw-layer("BASE", bl, bli, blt, br, bri, brt)
#v(4pt)
#draw-layer("SYMB — Symbols + Numpad", sl, sli, slt, sr, sri, srt)
#v(4pt)
#draw-layer("MDIA — Media + Navigation", ml, mli, mlt, mr, mri, mrt)
