// ErgoDox EZ — Zweihander (macOS) cheat sheet
// Compile: typst compile keymap.typ

#set page(width: 11in, height: 8.5in, margin: 0.4in)
#set text(font: ((name: "STIX Two Math", covers: regex("[⏭⏮⏯⏸⎊⎙]")), "Lucida Grande", "Apple Symbols"), size: 7pt)

#let u = 15.5mm
#let kh = 7.75mm
#let gap = 6mm
#let thumb-gap = 2pt

// ── Key rendering ───────────────────────────────────────────────────────────

#let key(body, w: 1, h: 1, bg: white, fg: black, bld: false, sub: none) = {
  let padding = 1pt
  let ref-size = 10pt
  let max-size = 14pt
  let sub-size = 4pt
  let sub-reserve = 5pt

  rect(
    width: u * w, height: kh * h,
    radius: 1.5pt, stroke: 0.4pt + luma(60%), fill: bg, inset: padding,
    context {
      let avail-w = u * w - 2 * padding
      let avail-h = kh * h - 2 * padding
      if sub != none { avail-h = avail-h - sub-reserve }
      let m = measure(text(size: ref-size, body))
      let scale-w = avail-w / m.width
      let scale-h = avail-h / m.height
      let scale = calc.min(scale-w, scale-h)
      let final-size = calc.min(scale * ref-size, max-size)
      let wt = if bld { "bold" } else { "regular" }

      if sub != none {
        align(center + horizon, text(size: final-size, weight: wt, fill: fg, body))
        place(bottom + right, dy: -1pt, dx: -1pt, text(size: sub-size, fill: luma(50%), sub))
      } else {
        align(center + horizon, text(size: final-size, weight: wt, fill: fg, body))
      }
    },
  )
}

// ── Style shortcuts ─────────────────────────────────────────────────────────

#let mbg = luma(90%)
#let lbg = luma(75%)
#let xbg = luma(97%)
#let xfg = luma(85%)

#let K(l) = key(l)
#let M(l) = key(l, bg: mbg)
#let Ly(l) = key(l, bg: lbg)
#let D(tap, hold) = key(tap, bg: mbg, sub: hold)
#let X(l) = key(l, bg: xbg, fg: xfg)

#let Ly2(l) = key(l, h: 2, bg: lbg)
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
  let half-h = 5 * kh + thumb-gap + 3 * kh
  align(center, stack(dir: ltr, spacing: gap,
    box(height: half-h, align(top,
      rotate(90deg, reflow: true,
        block(fill: luma(30%), radius: 1.5pt, inset: (x: 3pt, y: 2pt),
          text(size: 9pt, weight: "bold", fill: white, title))))),
    draw-half(l-rows, l-inner, l-thumb, false),
    draw-half(r-rows, r-inner, r-thumb, true),
  ))
}

// ── BASE ────────────────────────────────────────────────────────────────────

#let bl = (
  (K("="), K("1"), K("2"), K("3"), K("4"), K("5")),
  (K("⌦"), K("Q"), K("W"), K("E"), K("R"), K("T")),
  (K("⌫"), K("A"), K("S"), K("D"), K("F"), K("G")),
  (K("L⇧"), K("Z"), K("X"), K("C"), K("V"), K("B")),
  (K("L⌃"), K("L⌥"), K("L⌘"), K("←"), K("→")),
)
#let bli = (K("L1"), K2("~L1"), K("L⌘"))
#let blt = (K("`~"), K("⇪"), K2("↩\u{FE0E}"), K2("⇥"), K("L⌥"), K("L⌃"))

#let br = (
  (K("6"), K("7"), K("8"), K("9"), K("0"), K("-")),
  (K("Y"), K("U"), K("I"), K("O"), K("P"), K("\\")),
  (K("H"), K("J"), K("K"), K("L"), key(";", sub: "L2"), key("'", sub: "R⌘")),
  (K("N"), K("M"), K(","), K("."), key("/", sub: "R⌥"), K("R⇧")),
  (K("↑"), K("↓"), K("["), K("]"), K("↩\u{FE0E}")),
)
#let bri = (K("L1"), K2("~L1"), K("R⌘"))
#let brt = (K("⎋"), K("⌫"), K2("⇥"), K2("␣"), K("R⌥"), K("R⌃"))

// ── SYMB ────────────────────────────────────────────────────────────────────

#let sl = (
  (X("="), K("F1"), K("F2"), K("F3"), K("F4"), K("F5")),
  (X("⌦"), K("["), K("]"), K("{"), K("}"), K("\"")),
  (X("⌫"), K("<"), K(">"), K("("), K(")"), K("'")),
  (X("L⇧"), K("%"), K("/"), K("⇪"), K("-"), K("=")),
  (X("L⌃"), X("L⌥"), X("L⌘"), X("←"), X("→")),
)
#let sli = (X("L1"), X2("~L1"), X("L⌘"))
#let slt = (X("`~"), X("⇪"), X2("↩\u{FE0E}"), X2("⇥"), X("L⌥"), X("L⌃"))

#let sr = (
  (K("F6"), K("F7"), K("F8"), K("F9"), K("F10"), K("F11")),
  (K("/"), K("7"), K("8"), K("9"), K("*"), K("F12")),
  (K("-"), K("4"), K("5"), K("6"), K("+"), K("`~")),
  (K(":"), K("1"), K("2"), K("3"), K("="), X("R⇧")),
  (K("0"), K("."), K("←"), K("→"), X("↩\u{FE0E}")),
)
#let sri = (X("L1"), X2("~L1"), X("R⌘"))
#let srt = (X("⎋"), X("⌫"), X2("⇥"), X2("␣"), X("R⌥"), X("R⌃"))

// ── MDIA ────────────────────────────────────────────────────────────────────

#let ml = (
  (X("="), K("F14"), K("F15"), K("⎙"), K("ScrLk"), K("⏸\u{FE0E}⎊")),
  (X("⌦"), X("Q"), K("⌥↑"), K("⇞"), K("⌥↓"), X("T")),
  (X("⌫"), K("⌃⇧←"), K("↖"), K("⇟"), K("↘"), K("⌃⇧→")),
  (X("L⇧"), X("Z"), X("X"), X("C"), X("V"), X("B")),
  (X("L⌃"), X("L⌥"), X("L⌘"), X("←"), X("→")),
)
#let mli = (X("L1"), X2("~L1"), X("L⌘"))
#let mlt = (X("`~"), X("⇪"), X2("↩\u{FE0E}"), X2("⇥"), X("L⌥"), X("L⌃"))

#let mr = (
  (K("⌘W"), K("⌘⇧`"), K("⌘S"), K("⌘`"), K(text(font: "Apple Symbols", "⏏\u{FE0E}")), K("⏻\u{FE0E}")),
  (K("⌘]"), K("⌥⌘↑"), K("↑"), K("⌥⌘↓"), X("P"), X("\\")),
  (K("⌘["), K("←"), K("↓"), K("→"), X(";"), K("F16")),
  (K("⌘Z"), K("⏯\u{FE0E}"), K("⏮\u{FE0E}"), K("⏭\u{FE0E}"), X("/"), X("R⇧")),
  (K("Vol−"), K("Vol+"), K("Mute"), X("]"), X("↩\u{FE0E}")),
)
#let mri = (X("L1"), X2("~L1"), X("R⌘"))
#let mrt = (X("⎋"), X("⌫"), K2("⌘C"), K2("⌘V"), X("R⌥"), K("⌘X"))

// ── Render ──────────────────────────────────────────────────────────────────

#draw-layer("MDIA — Media + Navigation", ml, mli, mlt, mr, mri, mrt)
#v(2pt)
#draw-layer("SYMB — Symbols + Numpad", sl, sli, slt, sr, sri, srt)
#v(2pt)
#draw-layer("BASE", bl, bli, blt, br, bri, brt)
