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
         locale/format)

;; ---------- Test Cases

(test-case
 "format-number: success cases"
 (define us-locale (make-locale-string "en" "US" #:code-page (normalize-code-page 'utf-8)))
 (check-equal? (set-numeric-locale us-locale) us-locale)
 (check-equal? (format-number 1) "1")
 (check-equal? (format-number 0.1) "0.1")
 (check-equal? (format-number 1024.42) "1,024.42")
 (check-equal? (format-number -1024.42) "-1,024.42")
 (check-equal? (format-number 8262555122.45) "8,262,555,122.45"))
