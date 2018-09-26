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
 (contract-out
  
  [format-number
   (-> number? string?)]

  [format-currency
   (-> number? string?)]
 
  [format-date
   (-> (or/c date? number?) string?)]

  [format-time
   (->* ((or/c date? number?)) (boolean?) string?)]

  [format-datetime
   (-> (or/c date? number?) string?)]))

;; ---------- Requirements

(require racket/bool
         racket/format
         racket/list
         racket/match
         racket/string
         locale
         locale/language-info
         "private/matches.rkt")

;; ---------- Internal types

;; ---------- Implementation

(define default-decimal ".")

(define default-thousands-separator ",")

(define default-pad-char " ")

(define (format-number num)
  (define defaults (string-split (number->string num) default-decimal))
  (if (= (length defaults) 2)
      (format "~a~a~a" (format-thousands (first defaults)) (decimal-point) (second defaults))
      (format-thousands (first defaults))))

(define (format-currency num [international #f])
  ;; http://www.cplusplus.com/reference/clocale/lconv/
  (define locale-conv (get-locale-conventions))
  (define defaults (string-split (number->string (abs num)) default-decimal))
  (define fractional (if international
                         (locale-international-fractional-digits locale-conv)
                         (locale-fractional-digits locale-conv)))
  (define basic (if (= (length defaults) 2)
                    (format "~a~a~a" (format-thousands (first defaults) #t)
                            (decimal-point #t)
                            (if (> (string-length (second defaults)) fractional)
                                (substring (second defaults) 0 fractional)
                                (second defaults)))
                    (format-thousands (first defaults) #t)))
  (define symbol (if international
                     (locale-international-currency-symbol locale-conv)
                     (locale-currency-symbol locale-conv)))
  (cond
    [(positive? num)
     (define symbol-precedes (if international
                                 (locale-international-pos-cs-precedes locale-conv)
                                 (locale-pos-cs-precedes locale-conv)))
     (define symbol-space (if international
                              (locale-international-pos-sep-by-space locale-conv)
                              (locale-pos-sep-by-space locale-conv)))
     (define sign (locale-positive-sign locale-conv))
     (define sign-position (if international
                               (locale-international-pos-sign-posn locale-conv)
                               (locale-pos-sign-posn locale-conv)))
     (format-currency-and-sign basic symbol symbol-precedes symbol-space sign sign-position)]
    [(negative? num)
     (define symbol-precedes (if international
                                 (locale-international-neg-cs-precedes locale-conv)
                                 (locale-neg-cs-precedes locale-conv)))
     (define symbol-space (if international
                              (locale-international-neg-sep-by-space locale-conv)
                              (locale-neg-sep-by-space locale-conv)))
     (define sign (locale-negative-sign locale-conv))
     (define sign-position (if international
                               (locale-international-neg-sign-posn locale-conv)
                               (locale-neg-sign-posn locale-conv)))
     (format-currency-and-sign basic symbol symbol-precedes symbol-space sign sign-position)]
  [else (error "what kind of number is this? ~a" num)]))

(define (format-date dt)
  (format-date-with (->date dt) (get-date-format)))

(define (format-time dt [am-pm #f])
  (format-date-with (->date dt) (if am-pm (get-time-ampm-format) (get-time-format))))

(define (format-datetime dt)
  (format-date-with (->date dt) (get-datetime-format)))

;; ---------- Internal procedures

(define (format-thousands str [currency #f])
  (define grouping (if currency
                       (locale-monetary-grouping (get-locale-conventions))
                       (locale-grouping (get-locale-conventions))))
  (define group (vector-ref grouping 0))
  (cond
    [(and (> group 0)    ; group repeat of nothing?
          (< group 127)  ; end of group repeat
          (> (string-length str) group))
     (define sep (thousands-separator currency))
     (define sep-lst (if (equal? sep "") '() (string->list sep)))
     (define (_take-threes lst)
       (if (> (length lst) group)
           ;; TODO: loop through groupings
           (append (take lst group) sep-lst (_take-threes (drop lst group)))
           lst))
     (list->string (reverse (_take-threes (reverse (string->list str)))))]
    [else str]))

(define (decimal-point [currency #f])
  (string-or (list (if currency
                       (locale-monetary-decimal-point (get-locale-conventions))
                       "")
                   (locale-decimal-point (get-locale-conventions))
                   (get-radix-character)
                   default-decimal)))

(define (thousands-separator [currency #t])
  (string-or (list (if currency
                       (locale-monetary-thousands-separator (get-locale-conventions))
                       "")
                   (locale-thousands-separator (get-locale-conventions))
                   (get-thousands-separator)
                   default-thousands-separator)))

(define (string-or lst)
  (findf non-empty-string? lst))

(define (format-currency-and-sign quantity symbol symbol-precedes symbol-space sign sign-position)
  (displayln (format "format-currency-and-sign ~s ~s ~s ~s ~s ~s" quantity symbol symbol-precedes symbol-space sign sign-position))
  (cond
    [(= symbol-precedes 0)
     (cond
       [(= sign-position 0)
        (cond
          [(= symbol-space 0)
           (format "(~a~a)" quantity symbol)]
          [(= symbol-space 1)
           (format "(~a ~a)" quantity symbol)]
          [(= symbol-space 2)
           (format "(~a ~a)" quantity symbol)])]
       [(= sign-position 1)
        (cond
          [(= symbol-space 0)
           (format "~a~a~a" sign quantity symbol)]
          [(= symbol-space 1)
           (format "~a~a ~a" sign quantity symbol)]
          [(= symbol-space 2)
           (format "~a~a ~a" sign quantity symbol)])]
       [(= sign-position 2)
        (cond
          [(= symbol-space 0)
           (format "~a~a~a" quantity symbol sign)]
          [(= symbol-space 1)
           (format "~a ~a~a" quantity symbol sign)]
          [(= symbol-space 2)
           (format "~a~a ~a" quantity symbol sign)])]
       [(= sign-position 3)
        (cond
          [(= symbol-space 0)
           (format "~a~a~a" quantity sign symbol)]
          [(= symbol-space 1)
           (format "~a ~a~a" quantity sign symbol)]
          [(= symbol-space 2)
           (format "~a~a ~a" quantity sign symbol)])]
       [(= sign-position 4)
        (cond
          [(= symbol-space 0)
           (format "~a~a~a" quantity symbol sign)]
          [(= symbol-space 1)
           (format "~a ~a~a" quantity symbol sign)]
          [(= symbol-space 2)
           (format "~a~a ~a" quantity symbol sign)])])]
    [(= symbol-precedes 1)
     (cond
       [(= sign-position 0)
        (cond
          [(= symbol-space 0)
           (format "(~a~a)" symbol quantity)]
          [(= symbol-space 1)
           (format "(~a ~a)" symbol quantity)]
          [(= symbol-space 2)
           (format "(~a ~a)" symbol quantity)])]
       [(= sign-position 1)
        (cond
          [(= symbol-space 0)
           (format "~a~a~a" sign symbol quantity)]
          [(= symbol-space 1)
           (format "~a~a ~a" sign symbol quantity)]
          [(= symbol-space 2)
           (format "~a ~a~a" sign symbol quantity)])]
       [(= sign-position 2)
        (cond
          [(= symbol-space 0)
           (format "~a~a~a" symbol quantity sign)]
          [(= symbol-space 1)
           (format "~a ~a~a" symbol quantity sign)]
          [(= symbol-space 2)
           (format "~a~a ~a" symbol quantity sign)])]
       [(= sign-position 3)
        (cond
          [(= symbol-space 0)
           (format "~a~a~a" sign symbol quantity)]
          [(= symbol-space 1)
           (format "~a~a ~a" sign symbol quantity)]
          [(= symbol-space 2)
           (format "~a ~a~a" sign symbol quantity)])]
       [(= sign-position 4)
        (cond
          [(= symbol-space 0)
           (format "~a~a~a" symbol sign quantity)]
          [(= symbol-space 1)
           (format "~a~a ~a" symbol sign quantity)]
          [(= symbol-space 2)
           (format "~a ~a~a" symbol sign quantity)])])]))

(define (->date v)
  (cond
    [(date? v) v]
    [(number? v) (seconds->date v)]
    [else (error "can't convert ~s to date")]))

(define (format-date-with dt format-str)
  (define out (open-output-string))
  (regex-replace #rx"%[a-zA-Z%]"
                 format-str
                 (λ (var) (display (replace-datetime-var dt format-str var) out))
                 (λ (str) (display str out)))
  (get-output-string out))

(define (replace-datetime-var dt format-str var)
  (match var
    ; Details from http://www.cplusplus.com/reference/ctime/strftime/
    ; Modiers, described below, are NOT supported.
    ;
    ; Modifier Meaning
    ; E        Uses the locale's alternative representation
    ;          Applies to: %Ec %EC %Ex %EX %Ey %EY
    ; O        Uses the locale's alternative numeric symbols
    ;          Applies to: %Od %Oe %OH %OI %Om %OM %OS %Ou %OU %OV %Ow %OW %Oy
    ["%a" (get-abbrev-weekday-name (add1 (date-week-day dt)))]
    ["%A" (get-weekday-name (add1 (date-week-day dt)))]
    ["%b" (get-abbrev-month-name (add1 (date-month dt)))]
    ["%B" (get-month-name (add1 (date-month dt)))]
    ["%c" (format-datetime dt)]
    ["%C" (~a (quotient (date-year dt) 100))]
    ["%d" (~a (date-day dt))]
    ["%D"
     (format "~a/~a/~a"
             (date-month dt)
             (date-day dt)
             (remainder (date-year dt) 100))]
    ["%e" (~r (date-day dt) #:min-width 2 #:pad-string default-pad-char)]
    ["%F"
     (format "~a-~a-~a"
             (date-year dt)
             (date-month dt)
             (date-day dt))]
    ["%g" (error "unsupported: week-based year, last two digits")]
    ["%G" (error "unsupported: week-based year")]
    ["%h" (get-abbrev-month-name (add1 (date-month dt)))]
    ["%H" (~a (date-hour dt))]
    ["%I"
     (define hour (date-hour dt))
     (if (> hour 12) (~a (- hour 12)) (~a hour))]
    ["%j" (error "unsupported: day of the year as a decimal number [001,366])")]
    ["%m" (~a (date-month dt))]
    ["%M" (~a (date-minute dt))]
    ["%n" "\n"]
    ["%p"
     (define hour (date-hour dt))
     (if (> hour 12) (get-pm-string) (get-am-string))]
    ["%r" (error "unsupported: 12-hour clock time")]
    ["%R" (error "unsupported: 24-hour HH:MM time") ]
    ["%S" (date-second dt)]
    ["%t" "\t"]
    ["%T"
     (format "~a:~a:~a"
             (date-hour dt)
             (date-minute dt)
             (date-second dt))]
    ["%u" (error "unsupported: ISO 8601 weekday as number with Monday as 1")]
    ["%U" (error "unsupported: week number of the year -- Sunday starts")]
    ["%v" (error "unsupported: ISO 8601 week number")]
    ["%w" (~a (add1 (date-week-day dt)))]
    ["%W" (error "unsupported: week number of the year -- Monday starts")]
    ["%x" (format-date dt)]
    ["%X" (format-time dt)]
    ["%y" (~a (remainder (date-year dt) 100))]
    ["%Y" (~a (date-year dt))]
    ["%z"
     (define minute-offset (quotient (date-time-zone-offset dt)))
     (~r (+ (* (quotient minute-offset 60) 100) (remainder minute-offset 60)))]
    ["%Z" 
     ;; TODO: time zone name (no characters if no time zone exists)
     ""]
    ["%%" "%"]
    [else (error "unknown date format variable in " format-str)]))

(module+ test
  (require rackunit)

  (define expected-strings
    '#( #( #( "(1.25$)"  "(1.25 $)"  "(1.25 $)" )
           #( "+1.25$"   "+1.25 $"   "+1.25 $" )
           #( "1.25$+"   "1.25 $+"   "1.25$ +" )
           #( "1.25+$"   "1.25 +$"   "1.25+ $" )
           #( "1.25$+"   "1.25 $+"   "1.25$ +" ) )
        #( #( "($1.25)"  "($ 1.25)"  "($ 1.25)" )
           #( "+$1.25"   "+$ 1.25"   "+ $1.25" )
           #( "$1.25+"   "$ 1.25+"   "$1.25 +" )
           #( "+$1.25"   "+$ 1.25"   "+ $1.25" )
           #( "$+1.25"   "$+ 1.25"   "$ +1.25" ) ) ) )
         
  (define value 1.25)

  (test-case
   "format-currency-and-sign: internal tests"
   (for* ([precedes '(0 1)]
          [sign-posn '(0 1 2 3 4)])
     (for ([sep-by-space '(0 1 2)])
       (check-equal?
        (format-currency-and-sign value "$" precedes sep-by-space "+" sign-posn)
        (vector-ref (vector-ref (vector-ref expected-strings precedes) sign-posn) sep-by-space))))))
