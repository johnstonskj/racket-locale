#lang racket/base
;;
;; racket-locale - locale.
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
 (check-equal? (set-locale "en_GB") "en_GB")
 (define conventions (get-locale-conventions))
 (check-equal? (locale-decimal-point conventions) ".")
 (check-equal? (locale-thousands-separator conventions) ","))

