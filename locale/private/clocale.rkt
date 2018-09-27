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
         racket/match
         racket/port
         racket/string
         racket/system
         ffi/unsafe
         ffi/unsafe/define
         "./system-type.rkt")

;; ---------- Internal types

;  The obvious (ffi-lib "libc") doesn't work on linux, replaced with #f
(define-ffi-definer define-libc #f
  #:default-make-fail make-not-available)

;; ---------- Implementation

(define (bytes->string/fallback bstr)
  (with-handlers ([exn:fail?
                   (lambda (e) (bytes->string/latin-1 bstr))])
    (bytes->string/utf-8 bstr)))

;; ***** The following are from <locale.h>

(define LC_ALL             (match system-type-ext ['macosx 0] ['linux 6]))
(define LC_COLLATE         (match system-type-ext ['macosx 1] ['linux 3]))
(define LC_CTYPE           (match system-type-ext ['macosx 2] ['linux 0]))
(define LC_MONETARY        (match system-type-ext ['macosx 3] ['linux 4]))
(define LC_NUMERIC         (match system-type-ext ['macosx 4] ['linux 1]))
(define LC_TIME            (match system-type-ext ['macosx 5] ['linux 2]))
(define LC_MESSAGES        (match system-type-ext ['macosx 6] ['linux 5]))
(define LC_PAPER           (match system-type-ext ['macosx -1] ['linux 7]))
(define LC_NAME            (match system-type-ext ['macosx -1] ['linux 8]))
(define LC_ADDRESS         (match system-type-ext ['macosx -1] ['linux 9]))
(define LC_TELEPHONE       (match system-type-ext ['macosx -1] ['linux 10]))
(define LC_MEASUREMENT     (match system-type-ext ['macosx -1] ['linux 11]))
(define LC_IDENTIFICATION  (match system-type-ext ['macosx -1] ['linux 12]))

(define VALUE_UNAVAILABLE  127)

(define MINIMAL_LOCALE     "C")
(define USER_LOCALE        "")

(define-libc setlocale (_fun _int _string -> _string))

;; ***** The following are from <_locale.h>
;; descriptions from http://www.cplusplus.com/reference/clocale/lconv/

(define-cstruct _lconv ([decimal-point _string]
                        [thousands-separator _bytes]
                        [grouping _bytes]
                        [international-currency-symbol _string]
                        [currency-symbol _bytes]
                        [monetary-decimal-point _string]
                        [monetary-thousands-separator _bytes]
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
(define CODESET         (match system-type-ext ['macosx 0] ['linux 14]))
(define D_T_FMT         (match system-type-ext ['macosx 1] ['linux 131112]))
(define D_FMT           (match system-type-ext ['macosx 2] ['linux 131113]))
(define T_FMT           (match system-type-ext ['macosx 3] ['linux 131114]))
(define T_FMT_AMPM      (match system-type-ext ['macosx 4] ['linux 131115]))
(define AM_STR          (match system-type-ext ['macosx 5] ['linux 131110]))
(define PM_STR          (match system-type-ext ['macosx 6] ['linux 131111]))

;; week day names 
(define DAY_1           (match system-type-ext ['macosx 7]  ['linux 131079]))
(define DAY_2           (match system-type-ext ['macosx 8]  ['linux 131080]))
(define DAY_3           (match system-type-ext ['macosx 9]  ['linux 131081]))
(define DAY_4           (match system-type-ext ['macosx 10] ['linux 131082]))
(define DAY_5           (match system-type-ext ['macosx 11] ['linux 131083]))
(define DAY_6           (match system-type-ext ['macosx 12] ['linux 131084]))
(define DAY_7           (match system-type-ext ['macosx 13] ['linux 131085]))

;; abbreviated week day names 
(define ABDAY_1         (match system-type-ext ['macosx 14] ['linux 131072]))
(define ABDAY_2         (match system-type-ext ['macosx 15] ['linux 131073]))
(define ABDAY_3         (match system-type-ext ['macosx 16] ['linux 131074]))
(define ABDAY_4         (match system-type-ext ['macosx 17] ['linux 131075]))
(define ABDAY_5         (match system-type-ext ['macosx 18] ['linux 131076]))
(define ABDAY_6         (match system-type-ext ['macosx 19] ['linux 131077]))
(define ABDAY_7         (match system-type-ext ['macosx 20] ['linux 131078]))

;; month names 
(define MON_1           (match system-type-ext ['macosx 21] ['linux 131098]))
(define MON_2           (match system-type-ext ['macosx 22] ['linux 131099]))
(define MON_3           (match system-type-ext ['macosx 23] ['linux 131100]))
(define MON_4           (match system-type-ext ['macosx 24] ['linux 131101]))
(define MON_5           (match system-type-ext ['macosx 25] ['linux 131102]))
(define MON_6           (match system-type-ext ['macosx 26] ['linux 131103]))
(define MON_7           (match system-type-ext ['macosx 27] ['linux 131104]))
(define MON_8           (match system-type-ext ['macosx 28] ['linux 131105]))
(define MON_9           (match system-type-ext ['macosx 29] ['linux 131106]))
(define MON_10          (match system-type-ext ['macosx 30] ['linux 131107]))
(define MON_11          (match system-type-ext ['macosx 31] ['linux 131108]))
(define MON_12          (match system-type-ext ['macosx 32] ['linux 131109]))

;; abbreviated month names 
(define ABMON_1         (match system-type-ext ['macosx 33] ['linux 131086]))
(define ABMON_2         (match system-type-ext ['macosx 34] ['linux 131087]))
(define ABMON_3         (match system-type-ext ['macosx 35] ['linux 131088]))
(define ABMON_4         (match system-type-ext ['macosx 36] ['linux 131089]))
(define ABMON_5         (match system-type-ext ['macosx 37] ['linux 131090]))
(define ABMON_6         (match system-type-ext ['macosx 38] ['linux 131091]))
(define ABMON_7         (match system-type-ext ['macosx 39] ['linux 131092]))
(define ABMON_8         (match system-type-ext ['macosx 40] ['linux 131093]))
(define ABMON_9         (match system-type-ext ['macosx 41] ['linux 131094]))
(define ABMON_10        (match system-type-ext ['macosx 42] ['linux 131095]))
(define ABMON_11        (match system-type-ext ['macosx 43] ['linux 131096]))
(define ABMON_12        (match system-type-ext ['macosx 44] ['linux 131097]))

(define ERA             (match system-type-ext ['macosx 45] ['linux 131116]))
(define ERA_D_FMT       (match system-type-ext ['macosx 46] ['linux 131118]))
(define ERA_D_T_FMT     (match system-type-ext ['macosx 47] ['linux 131120]))
(define ERA_T_FMT       (match system-type-ext ['macosx 48] ['linux 131121]))

(define ALT_DIGITS      (match system-type-ext ['macosx 49] ['linux 131119]))
(define RADIXCHAR       (match system-type-ext ['macosx 50] ['linux 65536]))
(define THOUSEP         (match system-type-ext ['macosx 51] ['linux 65537]))

(define YESEXPR         (match system-type-ext ['macosx 52] ['linux 327680]))
(define NOEXPR          (match system-type-ext ['macosx 53] ['linux 327681]))

(define CRNCYSTR        (match system-type-ext ['macosx 56] ['linux 262159]))

(define-libc nl_langinfo (_fun _int -> _bytes))

;; ***** The following is from <localcharset.h>
;;
;; Note:  that this is not always linked in, it is possible calling
;;   this will result in an "implementation not found" error.

(define-libc locale_charset (_fun -> _string))
