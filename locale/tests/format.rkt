#lang racket/base
;;
;; racket-locale - format.
;;   More locale tools for Racket
;;   
;;
;; Copyright (c) 2018 Simon Johnston (simonjo@amazon.com).

;; ---------- Requirements

(require racket/bool
         racket/date
         racket/list
         rackunit
         ; ---------
         locale
         locale/format)

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

;; ---------- Test Fixtures

(define test-seconds 1537888395)
(define test-date (seconds->date test-seconds))

;; ---------- Test Cases

(test-case
 "format-number: success cases"
  (check-equal? (set-locale "en_US") "en_US")
  (check-equal? (format-number 1) "1")
  (check-equal? (format-number 0.1) "0.1")
  (check-equal? (format-number 1024.42) "1024.42")
  (check-equal? (format-number -1024.42) "-1024.42")
  (check-equal? (format-number 8262555122.45) "8262555122.45"))

(test-case
 "format-datetime: success"
  (check-equal? (set-locale "en_GB") "en_GB")
  (check-equal? (format-datetime test-seconds) "Tue 25 October 8:13:15 2018")
  (check-equal? (format-datetime test-date) "Tue 25 October 8:13:15 2018")
  (check-equal? (set-locale "fr_FR.UTF-8") "fr_FR.UTF-8")
  (check-equal? (format-datetime test-seconds) "Mar 25 octobre 8:13:15 2018")
  (check-equal? (format-datetime test-date) "Mar 25 octobre 8:13:15 2018"))
  
(test-case
 "format-date: success"
  (check-equal? (set-locale "en_GB") "en_GB")
  (check-equal? (format-date test-seconds) "25/9/2018")
  (check-equal? (format-date test-date) "25/9/2018")
  (check-equal? (set-locale "fr_FR.UTF-8") "fr_FR.UTF-8")
  (check-equal? (format-date test-seconds) "25.9.2018")
  (check-equal? (format-date test-date) "25.9.2018"))
  
(test-case
 "format-time: success"
  (check-equal? (set-locale "en_GB") "en_GB")
  (check-equal? (format-time test-seconds #f) "8:13:15")
  (check-equal? (format-time test-date #f) "8:13:15")
  (check-equal? (format-time test-seconds #t) "8:13:15 am")
  (check-equal? (format-time test-date #t) "8:13:15 am")
  (check-equal? (set-locale "fr_FR.UTF-8") "fr_FR.UTF-8")
  (check-equal? (format-time test-seconds #f) "8:13:15")
  (check-equal? (format-time test-date #f) "8:13:15")
  (check-equal? (format-time test-seconds #t) "8:13:15 AM")
  (check-equal? (format-time test-date #t) "8:13:15 AM"))