#lang racket/base
;;
;; racket-locale - tests/utils.
;;   More locale tools for Racket
;;
;; Copyright (c) 2018 Simon Johnston (johnstonskj@gmail.com).

(provide
 
 get-code-page)

;; ---------- Requirements

(require racket/match
         locale/private/system-type)

;; ---------- Test Utilities

(define (get-code-page cp)
  (cond
    [(equal? cp "") ""]
    [(equal? cp 'utf-8)
     (match system-type-ext
       ['macosx "UTF-8"]
       ['linux "utf8"]
       [else "utf-8"])]
    [(equal? cp 'ascii)
     (match system-type-ext
       ['macosx "US-ASCII"]
       ['linux ""]
       [else "ASCII"])]
    [equal? cp 'iso-8859-1
     (match system-type-ext
       ['macosx "ISO8859-1"]
       ['linux "iso88591"]
       [else ""])]
    [equal? cp 'iso-8859-15
     (match system-type-ext
       ['macosx "ISO8859-15"]
       ['linux "iso885915"]
       [else ""])]))
