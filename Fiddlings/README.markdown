Feature list:

- Import / eksport jsbin.com, jsfiddle.com, codepen.io
- Gist eksport
- HTML import
- Quick look support
- Webview erinevatel suurustel resizemine
- SCSS support
- Snapshots oleks hea et proovida erinevaid variante mingist asjast

Issues:

- Korralik koodieditor
- Skroll positsiooni tuleb webviews hoida
- Default akna suurus rakenduse laadimisel
- Includetud CSS / JS jm faili ei tohi iga muudatuse peale reloadida
- Webview skroll ei bounce ja on aeglasevõitu
- Rakenduse quit peab säilitama dokumendi

Koodieditor:

- http://parsekit.com/okudakit/ ja ParseKit võiksid olla variandid mida uurida
- http://www.noodlesoft.com/blog/2012/05/29/syntax-coloring-for-fun-and-profit/ mingi demo kuidas editori teha, basic editor oskab kommentaare highlightida näiteks
- http://stackoverflow.com/questions/2218415/nstextview-syntax-highlighting
- https://github.com/gampleman/GMCodeEditor See on päris hea näide
- https://developer.apple.com/LIBRARY/mac/documentation/TextFonts/Conceptual/CocoaTextArchitecture/TextEditing/TextEditing.html selle pean läbi lugema

Indenting:

- http://stackoverflow.com/questions/1291082/auto-indentation-in-a-nstextview "You can override insertNewline: in the NSTextView if that's what you have. You can also implement the delegate method textView:doCommandBySelector:, which will be called with the insertNewline: selector as an argument when the user presses return."

Notes:

- http://blog.jerodsanto.net/2010/12/bridging-the-gap-between-javascripts-console-log-and-cocoas-nslog/ siin peaks olema kirjas kuidas console.log teateid rakenduses kätte saab

Testing:

- http://blog.typpz.com/2014/04/27/xcode-5-test-uitableview-with-xctest-framework/ üks võimalik näide kuidas UI-d testida saab
- https://github.com/benzguo/BZGFormField/blob/master/BZGFormFieldTests/BZGFormFieldTests.m näide inputi testimisest
- https://gist.github.com/turowicz/e7746a9c035356f9483d dokument peaks sisaldama structi, mis oleks ise serialiseeritav. Sedasi oleks lihtsam testida.

Teenused veebis:

- http://jsfiddle.net
- http://codepen.io
- http://cssdeck.com
- http://jsbin.com
- http://dabblet.com

