#lang racket/base
;;
;; racket-locale - language-info.
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
  (bytes->string/utf-8 (nl_langinfo CODESET)))

(define (get-datetime-format)
  (bytes->string/utf-8 (nl_langinfo D_T_FMT)))

(define (get-date-format)
  (bytes->string/utf-8 (nl_langinfo D_FMT)))

(define (get-time-format)
  (bytes->string/utf-8 (nl_langinfo T_FMT)))

(define (get-time-ampm-format)
  (bytes->string/utf-8 (nl_langinfo T_FMT_AMPM)))

(define (get-am-string)
  (bytes->string/utf-8 (nl_langinfo AM_STR)))

(define (get-pm-string)
  (bytes->string/utf-8 (nl_langinfo PM_STR)))

(define (get-weekday-name day)
  (if (and (>= day 1) (<= day 7))
    (bytes->string/utf-8 (nl_langinfo (+ DAY_1 (- day 1))))
    #f))

(define (get-abbrev-weekday-name day)
  (if (and (>= day 1) (<= day 7))
    (bytes->string/utf-8 (nl_langinfo (+ ABDAY_1 (- day 1))))
    #f))

(define (get-month-name month)
  (if (and (>= month 1) (<= month 12))
    (bytes->string/utf-8 (nl_langinfo (+ MON_1 (- month 1))))
    #f))

(define (get-abbrev-month-name month)
  (if (and (>= month 1) (<= month 12))
    (bytes->string/utf-8 (nl_langinfo (+ MON_1 (- month 1))))
    #f))

(define (get-era-description)
  (bytes->string/utf-8 (nl_langinfo ERA)))

(define (get-era-date-format)
  (bytes->string/utf-8 (nl_langinfo ERA_D_FMT)))

(define (get-era-datetime-format)
  (bytes->string/utf-8 (nl_langinfo ERA_D_T_FMT)))

(define (get-era-time-format)
  (bytes->string/utf-8 (nl_langinfo ERA_T_FMT)))

(define (get-alt-digit-symbol)
  (bytes->string/utf-8 (nl_langinfo ALT_DIGITS)))

(define (get-radix-character)
  (bytes->string/utf-8 (nl_langinfo RADIXCHAR)))

(define (get-thousands-separator)
  (bytes->string/utf-8 (nl_langinfo THOUSEP)))

(define (get-yes-expression)
  (bytes->string/utf-8 (nl_langinfo YESEXPR)))

(define (get-no-expression)
  (bytes->string/utf-8 (nl_langinfo NOEXPR)))

(define (get-currency-symbol)
  (bytes->string/fallback (nl_langinfo CRNCYSTR)))
