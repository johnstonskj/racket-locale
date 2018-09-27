#lang racket/base
;;
;; racket-locale - tests/format (linux-specific).
;;   More locale tools for Racket
;;   
;;
;; Copyright (c) 2018 Simon Johnston (simonjo@amazon.com).

;; ---------- Requirements

(require racket/bool
         rackunit
         ; ---------
         locale
         locale/format
         locale/language-info
         locale/private/system-type
         locale/tests/utils)

(when (equal? system-type-ext 'Linux)

  ;; ---------- Test Fixtures

  (define test-seconds 1537888395)
  (define test-date (seconds->date test-seconds))

  ;; ---------- Test Cases
  
  (test-case
   "format-datetime: success"
   (define us-locale (make-locale-string "en" "US" #:code-page (get-code-page 'utf-8)))
   (check-equal? (set-time-locale us-locale) us-locale)
   (log-info (format "Using ~a date-time format: ~s" (get-time-locale) (get-datetime-format)))
   (check-equal? (format-datetime test-seconds) "Tue 25 October 2018 3:13")
   (check-equal? (format-datetime test-date) "Tue 25 October 2018 3:13")
   (define fr-locale (make-locale-string "fr" "FR" #:code-page (get-code-page 'utf-8)))
   (check-equal? (set-time-locale fr-locale) fr-locale)
   (log-info (format "Using ~a date-time format: ~s" (get-time-locale) (get-datetime-format)))
   (check-equal? (format-datetime test-seconds) "mar. 25 octobre 2018 15:13:15")
   (check-equal? (format-datetime test-date) "mar. 25 octobre 2018 15:13:15"))

  (test-case
   "format-date: success"
   (define us-locale (make-locale-string "en" "US" #:code-page (get-code-page 'utf-8)))
   (check-equal? (set-time-locale us-locale) us-locale)
   (log-info (format "Using ~a date format: ~s"(get-time-locale)  (get-date-format)))
   (check-equal? (format-date test-seconds) "9/25/2018")
   (check-equal? (format-date test-date) "9/25/2018")
   (define fr-locale (make-locale-string "fr" "FR" #:code-page (get-code-page 'utf-8)))
   (check-equal? (set-time-locale fr-locale) fr-locale)
   (log-info (format "Using ~a date format: ~s"(get-time-locale)  (get-date-format)))
   (check-equal? (format-date test-seconds) "25/9/2018")
   (check-equal? (format-date test-date) "25/9/2018"))

  (test-case
   "format-time: success"
   (define us-locale (make-locale-string "en" "US" #:code-page (get-code-page 'utf-8)))
   (check-equal? (set-time-locale us-locale) us-locale)
   (log-info (format "Using ~a time format: ~s" (get-time-locale) (get-time-format)))
   (log-info (format "Using ~a am/pm time format: ~s" (get-locale) (get-time-ampm-format)))
   (check-equal? (format-time test-seconds #f) "3:13")
   (check-equal? (format-time test-date #f) "3:13")
   (check-equal? (format-time test-seconds #t) "3:13:15 PM")
   (check-equal? (format-time test-date #t) "3:13:15 PM")
   (define fr-locale (make-locale-string "fr" "FR" #:code-page (get-code-page 'utf-8)))
   (check-equal? (set-time-locale fr-locale) fr-locale)
   (log-info (format "Using ~a time format: ~s" (get-time-locale) (get-time-format)))
   (log-info (format "Using ~a am/pm time format: ~s" (get-time-locale) (get-time-ampm-format)))
   (check-equal? (format-time test-seconds #f) "15:13:15")
   (check-equal? (format-time test-date #f) "15:13:15")))
;   (check-equal? (format-time test-seconds #t) "8:13:15 AM")
;   (check-equal? (format-time test-date #t) "8:13:15 AM")))
