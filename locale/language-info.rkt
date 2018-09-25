#lang racket/base
;;
;; racket-locale - format.
;;   More locale tools for Racket
;;   
;;
;; Copyright (c) 2018 Simon Johnston (simonjo@amazon.com).

;; Racket Style Guide: http://docs.racket-lang.org/style/index.html

(require racket/contract)

(provide
 (all-defined-out))

;; ---------- Requirements

(require "private/clocale.rkt")

;; ---------- Implementation

(define (get-codeset)
  (nl_langinfo CODESET))

(define (get-datetime-format)
  (nl_langinfo D_T_FMT))

(define (get-date-format)
  (nl_langinfo D_FMT))

(define (get-time-format)
  (nl_langinfo T_FMT))

(define (get-time-ampm-format)
  (nl_langinfo T_FMT_AMPM))

(define (get-am-string)
  (nl_langinfo AM_STR))

(define (get-pm-string)
  (nl_langinfo PM_STR))

(define (get-weekday-name day)
  (if (and (>= day 1) (<= day 7))
    (nl_langinfo (+ DAY_1 (- day 1)))
    #f))

(define (get-abbrev-weekday-name day)
  (if (and (>= day 1) (<= day 7))
    (nl_langinfo (+ ABDAY_1 (- day 1)))
    #f))

(define (get-month-name month)
  (if (and (>= month 1) (<= month 12))
    (nl_langinfo (+ MON_1 (- month 1)))
    #f))

(define (get-abbrev-month-name month)
  (if (and (>= month 1) (<= month 12))
    (nl_langinfo (+ MON_1 (- month 1)))
    #f))

(define (get-era-description)
  (nl_langinfo ERA))

(define (get-era-date-format)
  (nl_langinfo ERA_D_FMT))

(define (get-era-datetime-format)
  (nl_langinfo ERA_D_T_FMT))

(define (get-era-time-format)
  (nl_langinfo ERA_T_FMT))

(define (get-alt-digit-symbol)
  (nl_langinfo ALT_DIGITS))

(define (get-radix-character)
  (nl_langinfo RADIXCHAR))

(define (get-thousands-separator)
  (nl_langinfo THOUSEP))

(define (get-yes-expression)
  (nl_langinfo YESEXPR))

(define (get-no-expression)
  (nl_langinfo NOEXPR))

(define (get-yes-response)
  (nl_langinfo YESSTR))

(define (get-no-response)
  (nl_langinfo NOSTR))

(define (get-currency-symbol)
  (nl_langinfo CRNCYSTR))

(define (get-month-day-order)
  (nl_langinfo D_MD_ORDER))
