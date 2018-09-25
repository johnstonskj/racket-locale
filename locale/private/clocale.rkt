#lang racket/base
;;
;; racket-locale - private/clocale.
;;   More locale tools for Racket
;;
;; Copyright (c) 2018 Simon Johnston (johnstonskj@gmail.com).

;; Racket Style Guide: http://docs.racket-lang.org/style/index.html


(provide
 (except-out (all-defined-out)
             define-libc))

;; ---------- Requirements

(require racket/bool
         ffi/unsafe
         ffi/unsafe/define)

;; ---------- Internal types

(define-ffi-definer define-libc (ffi-lib "libc")
  #:default-make-fail make-not-available)

;; ---------- Implementation

;; ***** The following are from <locale.h>

(define LC_ALL             0)
(define LC_COLLATE         1)
(define LC_CTYPE           2)
(define LC_MONETARY        3)
(define LC_NUMERIC         4)
(define LC_TIME            5)
(define LC_MESSAGES        6)
(define _LC_LAST           (+ LC_MESSAGES 1))

(define VALUE_UNAVAILABLE  127)

(define END_GROUP_REPEAT   127)

(define MINIMAL_LOCALE     "C")
(define USER_LOCALE        "")

(define-libc setlocale (_fun _int _string -> _string))

;; ***** The following are from <_locale.h>
;; descriptions from http://www.cplusplus.com/reference/clocale/lconv/

(define-cstruct _lconv ([decimal-point _string]
                        [thousands-separator _string]
                        [grouping _bytes]
                        [international-currency-symbol _string]
                        [currency-symbol _string]
                        [monetary-decimal-point _string]
                        [monetary-thousands-separator _string]
                        [monetary-grouping _bytes]
                        [positive-sign _string]
                        [negative-sign _string]
                        [international-fractional-digits _ubyte]
                        [fractional-digits _ubyte]
                        [pos-cs-precedes _ubyte]
                        [neg-cs-precedes _ubyte]
                        [pos-sep-by-space _ubyte]
                        [neg-sep-by-space _ubyte]
                        [pos-sign-posn _ubyte]
                        [neg-sign-posn _ubyte]
                        [international-pos-cs-precedes _ubyte]
                        [international-neg-cs-precedes _ubyte]
                        [international-pos-sep-by-space _ubyte]
                        [international-neg-sep-by-space _ubyte]
                        [international-pos-sign-posn _ubyte]
                        [international-neg-sign-posn _ubyte]))

(define-libc localeconv (_fun -> _lconv-pointer))

;; ***** The following are from <langinfo.h>
(define CODESET         0)       ;; codeset name 
(define D_T_FMT         1)       ;; string for formatting date and time 
(define D_FMT           2)       ;; date format string 
(define T_FMT           3)       ;; time format string 
(define T_FMT_AMPM      4)       ;; a.m. or p.m. time formatting string 
(define AM_STR          5)       ;; Ante Meridian affix 
(define PM_STR          6)       ;; Post Meridian affix 

;; week day names 
(define DAY_1           7)
(define DAY_2           8)
(define DAY_3           9)
(define DAY_4           10)
(define DAY_5           11)
(define DAY_6           12)
(define DAY_7           13)

;; abbreviated week day names 
(define ABDAY_1         14)
(define ABDAY_2         15)
(define ABDAY_3         16)
(define ABDAY_4         17)
(define ABDAY_5         18)
(define ABDAY_6         19)
(define ABDAY_7         20)

;; month names 
(define MON_1           21)
(define MON_2           22)
(define MON_3           23)
(define MON_4           24)
(define MON_5           25)
(define MON_6           26)
(define MON_7           27)
(define MON_8           28)
(define MON_9           29)
(define MON_10          30)
(define MON_11          31)
(define MON_12          32)

;; abbreviated month names 
(define ABMON_1         33)
(define ABMON_2         34)
(define ABMON_3         35)
(define ABMON_4         36)
(define ABMON_5         37)
(define ABMON_6         38)
(define ABMON_7         39)
(define ABMON_8         40)
(define ABMON_9         41)
(define ABMON_10        42)
(define ABMON_11        43)
(define ABMON_12        44)

(define ERA             45)      ;; era description segments 
(define ERA_D_FMT       46)      ;; era date format string 
(define ERA_D_T_FMT     47)      ;; era date and time format string 
(define ERA_T_FMT       48)      ;; era time format string 
(define ALT_DIGITS      49)      ;; alternative symbols for digits 

(define RADIXCHAR       50)      ;; radix char 
(define THOUSEP         51)      ;; separator for thousands 

(define YESEXPR         52)      ;; affirmative response expression 
(define NOEXPR          53)      ;; negative response expression 

(define YESSTR          54)      ;; affirmative response for yes/no queries 
(define NOSTR           55)      ;; negative response for yes/no queries 

(define CRNCYSTR        56)      ;; currency symbol 

(define D_MD_ORDER      57)      ;; month/day order (local extension)

(define _NL_LAST        (+ D_MD_ORDER 1))

(define-libc nl_langinfo (_fun _int -> _string))


;; ***** The following is from <localcharset.h>
;;
;; Note:  that this is not always linked in, it is possible calling
;;   this will result in an "implementation not found" error.

(define-libc locale_charset (_fun -> _string))