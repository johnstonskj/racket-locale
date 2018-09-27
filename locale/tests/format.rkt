#lang racket/base
;;
;; racket-locale - format.
;;   More locale tools for Racket
;;   
;;
;; Copyright (c) 2018 Simon Johnston (simonjo@amazon.com).

;; ---------- Requirements

(require racket/list
         rackunit
         ; ---------
         locale
         locale/format
         locale/tests/utils)

; we do this to debug builds, is it failing because of defects in test
; cases or because certain, assumed, locales are not present on the
; test system.
(begin
  (define known-locales (get-known-locales))
  (displayln "Known locales:")
  (displayln
   (sort
    (flatten
     (for/list ([language (hash-keys known-locales)])
       (for/list ([country (hash-keys (hash-ref known-locales language))])
         (format "~a_~a" language country))))
    string<?)))

;; ---------- Test Cases

(test-case
 "format-number: success cases"
 (define us-locale (make-locale-string "en" "US" #:code-page (get-code-page 'utf-8)))
 (check-equal? (set-numeric-locale us-locale) us-locale)
 (check-equal? (format-number 1) "1")
 (check-equal? (format-number 0.1) "0.1")
 (check-equal? (format-number 1024.42) "1024.42")
 (check-equal? (format-number -1024.42) "-1024.42")
 (check-equal? (format-number 8262555122.45) "8262555122.45"))
