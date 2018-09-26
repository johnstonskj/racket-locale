#lang racket/base
;;
;; racket-locale - private/system-type.
;;   More locale tools for Racket
;;
;; Copyright (c) 2018 Simon Johnston (johnstonskj@gmail.com).

;; Racket Style Guide: http://docs.racket-lang.org/style/index.html


(provide
 (all-defined-out))

;; ---------- Requirements

(require racket/match
         racket/port
         racket/string
         racket/system)

;; ---------- Implementation

(define system-type-ext
  (let ([type (system-type)])
    (match type
      ['windows type]
      ['macosx type]
      ['unix
       (string->symbol (string-trim (with-output-to-string (lambda () (system "uname -s")))))]
      [else (error "unknown system type " type)])))
