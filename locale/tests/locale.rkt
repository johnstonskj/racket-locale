#lang racket/base
;;
;; racket-locale - tests/locale.
;;   More locale tools for Racket
;;
;; Copyright (c) 2018 Simon Johnston (johnstonskj@gmail.com).

;; ---------- Requirements

(require rackunit
         ; ---------
         locale)

;; ---------- Test Fixtures

;; ---------- Internal procedures

;; ---------- Test Cases

(test-case
 "get-locale-conventions: check conventions for known locale"
 (define locale (make-locale-string "en" "GB" #:code-page (normalize-code-page 'utf-8)))
 (check-equal? (set-numeric-locale locale) locale)
 (define conventions (get-locale-conventions))
 (check-equal? (locale-decimal-point conventions) ".")
 (check-equal? (locale-thousands-separator conventions) ","))

