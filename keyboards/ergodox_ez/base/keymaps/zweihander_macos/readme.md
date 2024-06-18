# The Zweihänder layout

NB: the backtick (\`) is special in Markdown. If I write ⌘\` in this readme, I mean “Command-backtick”, not “Command-backslash-backtick”.

This README refers to two secondary layers:

- the Media Layer (hold `;`)
- the Symbol Layer (hold the tall keys between T and Y or tap the normal keys between 5 and 6)

The Media Layer has cursor-movement, window-management, and volume-adjustment keys on it.

The Symbol Layer has a 10-key keypad on the right side, parentheses and similar grouping punctuation on the left side, and F1–F12 across the top.

This layout is tuned for people who…

## use macOS

No sane person who primarily uses a Control-key-dominant system like Windows or your favorite UNIX windowing environment would put this many Windows keys on a keyboard layout.

That said, Print Screen, Scroll Lock, and Pause are available in their usual order on the Media Layer if you need them.

## also plug keyboards into their iPads

This layout overrides `USB_MAX_POWER_CONSUMPTION` to turn it down to 100 mA instead of the default of 500 mA. This is not what you want if your Ergodox EZ has the Shine (under-keyboard) or Glow (under-keycaps) lights, but it’s an improvement if you want to be able to plug your keyboard into your iPad’s Lightning port with a USB-to-Lightning adapter.

## use fn/🌐︎︎︎ shortcuts

macOS is convinced that Ergodoxen EZ have fn keys.

While the QMK project has considered — [and declined, for good reason][nofn] — to put an\* fn/🌐︎ key in its list of keys, you can go into System Settings, open the “Customize modifier keys” part of it, and [have Caps Lock work as the fn/🌐︎ key][caps as fn].

A thumb key is bound to Caps Lock so you can use keyboard shortcuts like 🌐︎F for fullscreening an app or 🌐︎E for bringing up the emoji picker.

[nofn]: https://github.com/qmk/qmk_firmware/issues/2179
[caps as fn]: https://github.com/qmk/qmk_firmware/issues/16651#issuecomment-1436093183

## mouse left-handed while doing other things with the right hand

I tend to have my mouse in my left hand, but I like to use my other hand to make things go faster. I’ve added a bunch of buttons to the Media Layer (hold `;`) to speed up browsing in applications like Safari and Finder:

- ⌘Z — Undo
- ⌘\[ — Back
- ⌘\] — Forward
- ⌥⌘↓ — Open Selection and Close Parent Folder
- ⌥⌘↑ — Go Up and Close Just-Left Folder

I also have a few keys dedicated to window management that I almost never use:

- ⌘W — Close Window
- ⌘\` — Move Focus to Next Window
- ⌘⇧\` — Move Focus to Previous Window

Cut, Copy, and Paste (⌘X, ⌘C, and ⌘V) are also available on the three bottommost right-thumb buttons if you hold ;.

## think left is up and right is down…except when it comes to volume

I never got into `vi`-style hjkl, so I think of leftwards being upwards and rightwards being downwards.

However, when I’m adjusting the volume, I want the “quieter” key on the left and the “louder” key on the right since all the volume bars I adjust on macOS, iPadOS, and GNOME 3 are oriented that way.

## use lots of modifier keys in macOS menu-item shortcuts

I wanted to preserve the feel of a number of shortcuts that involve pressing lots of modifier keys at once. This is why the bottom left of the keyboard has Shift, Control, Option, and Command in the usual spots. Further I’ve added affordances so some key combinations are easier to press with just the right hand.

I also put a second Backspace (⌫) key on the right half of the keyboard to make some particularly commonly-used keyboard shortcuts faster and more convenient for right-handed use:

- ⌘⌫ — Move to Trash / Delete
- ⇧⌥⌘⌫ — Empty Trash Without Asking for Confirmation

⇧⌥⌘⌫ is much more satisfying to press when you do it like on a normal keyboard: one left-hand finger on each of ⇧, ⌥, and ⌘, and the right index finger on ⌫.

Pressing and holding / will give you Option. This makes a number of keyboard shortcuts easy to press with just the right hand:

- ⌥↑ — Move Line Up   (in Visual Studio Code)
- ⌥↓ — Move Line Down (in Visual Studio Code)
- ⌥⇧↑ — Copy Line Up / Go To Previous Channel With Unread Messages
- ⌥⇧↓ — Copy Line Down / Go To Next Channel With Unread Messages

## use Siri

F16, accessed by holding ; and pressing the ' key next to it, is intended for Siri.

## know the ↑↓←→ fn-key shortcuts for MacBooks

Have you looked at the Page Up, Page Down, Home, and End bindings for the ESDF keys and wondered why they’re arranged that way? They’re arranged the same way as the fn-key shortcuts on Apple laptops’ arrow keys. On Apple keyboards with an fn key, if you press fn-↑, you’ll get Page Up; if you press fn-← you’ll get Home. Similarly, on Zweihänder, ;-E is Page Up and ;-S is Home.

## use Visual Studio Code

;-W and ;-R are bound to ⌥↑ and ⌥↓, respectively, for moving lines up and down in Visual Studio Code. In normal macOS applications, they’re used for moving the cursor to the beginning and end of a line, and then on to the previous/next line.

## use spreadsheets

In addition to a 10-key numpad, all the common spreadsheet operations (+-*/=) are on the right side of the Symbol Layer. Make-numbers-bigger operations (+, \*) are on the right; make-numbers-smaller operations (-, /) are on the left. There’s also a colon there for entering times and maybe IPv6 addresses.

## write a fair bit of Markdown

Symbol-' functions as a \` (backtick) key.

## use Emacs-style shortcuts

I press C-a, C-e, and C-k all the time. It’s difficult to press these key combinations with the Control key on the far left, so the innermost thumb buttons are Control keys. Above/inside them are Option keys.

## use the Compose key when not on macOS

While Caps Lock makes an excellent fn/🌐︎ key on macOS, it also makes an excellent Compose (⎄) key elsewhere. I’ve bound Caps Lock to Symbol-C for sequences like `⎄<"` (`“`) and `⎄>'` (`’`). There’s also a `-` right next door on Symbol-V for `⎄---` (`—`, an em dash).

Why Symbol-C? Because typing `csg` to get an apostrophe is more pleasant than typing `vsg` as each finger is responsible for only one letter each and the index finger doesn't have to scramble from `v` to `g`. I’d like to thank Suraj N. Kurapati for nudging me into thinking about how it should be pleasant to type [common sequences of punctuation][bigrams].

[bigrams]: https://sunaku.github.io/moergo-glove80-keyboard.html#inward-rolling-bigrams

\* I pronounce “fn” as “effin’”. Your mileage may vary.
