#lang racket/base
;;
;; racket-locale - names.
;;   More locale tools for Racket
;;
;; Copied from https://docs.microsoft.com/en-us/cpp/c-runtime-library/language-strings
;;
;; Copyright (c) 2018 Simon Johnston (johnstonskj@gmail.com).

;; Racket Style Guide: http://docs.racket-lang.org/style/index.html

(require racket/contract)

(provide
 (contract-out))

;; ---------- Requirements

;; ---------- Implementation

(define language-strings
  (list
   (cons "american" "en-US")
   (cons "american english" "en-US")
   (cons "american-english" "en-US")
   (cons "australian" "en-AU")
   (cons "belgian" "nl-BE")
   (cons "canadian" "en-CA")
   (cons "chh" "zh-HK")
   (cons "chi" "zh-SG")
   (cons "chinese""zh")
   (cons "chinese-hongkong" "zh-HK")
   (cons "chinese-simplified" "zh-CN")
   (cons "chinese-singapore" "zh-SG")
   (cons "chinese-traditional" "zh-TW")
   (cons "dutch-belgian" "nl-BE")
   (cons "english-american" "en-US")
   (cons "english-aus" "en-AU")
   (cons "english-belize" "en-BZ")
   (cons "english-can" "en-CA")
   (cons "english-caribbean" "en-029")
   (cons "english-ire" "en-IE")
   (cons "english-jamaica" "en-JM")
   (cons "english-nz" "en-NZ")
   (cons "english-south africa" "en-ZA")
   (cons "english-trinidad y tobago" "en-TT")
   (cons "english-uk" "en-GB")
   (cons "english-us" "en-US")
   (cons "english-usa" "en-US")
   (cons "french-belgian" "fr-BE")
   (cons "french-canadian" "fr-CA")
   (cons "french-luxembourg" "fr-LU")
   (cons "french-swiss" "fr-CH")
   (cons "german-austrian" "de-AT")
   (cons "german-lichtenstein" "de-LI")
   (cons "german-luxembourg" "de-LU")
   (cons "german-swiss" "de-CH")
   (cons "irish-english" "en-IE")
   (cons "italian-swiss" "it-CH")
   (cons "norwegian" "no")
   (cons "norwegian-bokmal" "nb-NO")
   (cons "norwegian-nynorsk" "nn-NO")
   (cons "portuguese-brazilian" "pt-BR")
   (cons "spanish-argentina" "es-AR")
   (cons "spanish-bolivia" "es-BO")
   (cons "spanish-chile" "es-CL")
   (cons "spanish-colombia" "es-CO")
   (cons "spanish-costa rica" "es-CR")
   (cons "spanish-dominican republic" "es-DO")
   (cons "spanish-ecuador" "es-EC")
   (cons "spanish-el salvador" "es-SV")
   (cons "spanish-guatemala" "es-GT")
   (cons "spanish-honduras" "es-HN")
   (cons "spanish-mexican" "es-MX")
   (cons "spanish-modern" "es-ES")
   (cons "spanish-nicaragua" "es-NI")
   (cons "spanish-panama" "es-PA")
   (cons "spanish-paraguay" "es-PY")
   (cons "spanish-peru" "es-PE")
   (cons "spanish-puerto rico" "es-PR")
   (cons "spanish-uruguay" "es-UY")
   (cons "spanish-venezuela" "es-VE")
   (cons "swedish-finland" "sv-FI")
   (cons "swiss" "de-CH")
   (cons "uk" "en-GB")
   (cons "us" "en-US")
   (cons "usa" "en-US")))
      