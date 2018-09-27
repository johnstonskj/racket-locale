#lang racket/base
;;
;; racket-locale - locale.
;;   More locale tools for Racket
;;
;; Copyright (c) 2018 Simon Johnston (johnstonskj@gmail.com).

;; Racket Style Guide: http://docs.racket-lang.org/style/index.html

(require racket/contract)

(provide
 (contract-out

  [locale-string?
   (-> string? boolean?)]

  [make-locale-string
   (->* (string?) (string? #:code-page string? #:options string?) (or/c string? #f))]

  [normalize-code-page
   (-> (or/c 'utf-8 'ascii 'iso-8859-1 'iso-8859-15) string?)]
  
  [get-known-locales
   (-> (hash/c string? (hash/c string? (listof string?))))]
  
  [set-minimal-locale
   (-> (or/c string? #f))]

  [set-user-preferred-locale
   (-> (or/c string? #f))]

  [get-locale
   (-> (or/c string? #f))]

  [set-locale
   (-> string? (or/c string? #f))]

  [get-collation-locale
   (-> (or/c string? #f))]

  [set-collation-locale
   (-> string? (or/c string? #f))]

  [get-character-type-locale
   (-> (or/c string? #f))]

  [set-character-type-locale
   (-> string? (or/c string? #f))]

  [get-monetary-locale
   (-> (or/c string? #f))]

  [set-monetary-locale
   (-> string? (or/c string? #f))]

  [get-numeric-locale
   (-> (or/c string? #f))]

  [set-numeric-locale
   (-> string? (or/c string? #f))]

  [get-time-locale
   (-> (or/c string? #f))]

  [set-time-locale
   (-> string? (or/c string? #f))]

  [get-messages-locale
   (-> (or/c string? #f))]

  [set-messages-locale
   (-> string? (or/c string? #f))]

  [get-locale-conventions
   (-> locale?)]

  [grouping-repeats nonnegative-integer?]

  [grouping-ends positive-integer?]

  [unspecified-sign-posn positive-integer?])
 
 (except-out (struct-out locale)
             locale))

;; ---------- Requirements

(require racket/bool
         racket/list
         racket/match
         racket/math
         racket/port
         racket/string
         racket/system
         racket/vector
         locale/private/clocale
         locale/private/system-type)

;; ---------- Internal

;; locale-string := language ["_" country/region ["." code-page ["@" options?]]
;;                  | "C" | ""
;; lanaguage is a lower case ISO-639-1 or ISO_639-2/T identifier
;; country/region is an upper case ISO-3166-1 identifier
;; code-page
;; options
(define locale-name-string
  (pregexp "^([a-z]{2,3})(_[A-Z]{2,3})?(\\.[a-zA-Z0-9\\-]+)?(@[a-zA-Z0-9\\-]+)?$"))

;; ---------- Implementation

(define grouping-repeats 0)

(define grouping-ends VALUE_UNAVAILABLE)

(define unspecified-sign-posn VALUE_UNAVAILABLE)

(struct locale (decimal-point
                thousands-separator
                grouping
                international-currency-symbol
                currency-symbol
                monetary-decimal-point
                monetary-thousands-separator
                monetary-grouping
                positive-sign
                negative-sign
                international-fractional-digits
                fractional-digits
                pos-cs-precedes
                neg-cs-precedes
                pos-sep-by-space
                neg-sep-by-space
                pos-sign-posn
                neg-sign-posn
                international-pos-cs-precedes
                international-neg-cs-precedes
                international-pos-sep-by-space
                international-neg-sep-by-space
                international-pos-sign-posn
                international-neg-sign-posn)
  #:transparent)

(define (normalize-code-page cp)
  (cond
    [(equal? cp "") ""]
    [(equal? cp 'utf-8)
     (match system-type-ext
       ['macosx "UTF-8"]
       ['linux "utf8"]
       [else "utf-8"])]
    [(equal? cp 'ascii)
     (match system-type-ext
       ['macosx "US-ASCII"]
       ['linux ""]
       [else "ASCII"])]
    [equal? cp 'iso-8859-1
     (match system-type-ext
       ['macosx "ISO8859-1"]
       ['linux "iso88591"]
       [else ""])]
    [equal? cp 'iso-8859-15
     (match system-type-ext
       ['macosx "ISO8859-15"]
       ['linux "iso885915"]
       [else ""])]))

(define (make-locale-string language [country ""] #:code-page [code-page ""] #:options [options ""])
  (cond
    [(false? (regexp-match #px"^[a-z]{2,3}$" language))
     (log-warning "language string ~s is invalid" language)
     #f]
    [(and (non-empty-string? country) (false? (regexp-match #px"^[A-Z]{2,3}$" country)))
     (log-warning "country string ~s is invalid" country)
     #f]
    [(and (non-empty-string? code-page) (false? (regexp-match #px"^[a-zA-Z0-9\\-]+$" code-page)))
     (log-warning "code-page string ~s is invalid" code-page)
     #f]
    [(and (non-empty-string? options) (false? (regexp-match #px"^[a-zA-Z0-9\\-]+$" options)))
     (log-warning "options string ~s is invalid" options)
     #f]
    [else (format "~a~a~a~a"
                  language
                  (if (non-empty-string? country)
                      (string-append "_" country)
                      country)
                  (if (non-empty-string? code-page)
                      (string-append "." code-page)
                      code-page)
                  (if (non-empty-string? options)
                      (string-append "@" options)
                      options))]))

(define (locale-string? str)
  (if (or (equal? str MINIMAL_LOCALE) (equal? str USER_LOCALE))
      #t
      (let ([matches (regexp-match locale-name-string str)])
        (list? matches))))

(define (set-minimal-locale)
  (setlocale LC_ALL MINIMAL_LOCALE))

(define (set-user-preferred-locale)
  (setlocale LC_ALL USER_LOCALE))

(define (set-locale locale-string)
  (setlocale LC_ALL locale-string))

(define (get-locale)
  ;; we will use the Linux convention where LC_ALL will return a simple string if all
  ;; categories share the same locale, else we return a set of category=locale pairs.
  (define all-locales (setlocale LC_ALL #f))
  (match system-type-ext
    ['macosx
     (define split-locales (string-split all-locales "/"))
     (cond
       [(> (length split-locales) 1)
        (string-join
         (for/list ([locale split-locales]
                    [name '("COLLATE" "CTYPE" "MONETARY" "NUMERIC" "TIME" "MESSAGES")])
           (format "~a=~a" name locale))
         ";")]
       [else all-locales])]
    [else all-locales]))

(define (set-collation-locale locale-string)
  (setlocale LC_COLLATE locale-string))

(define (get-collation-locale)
  (setlocale LC_COLLATE #f))

(define (set-character-type-locale locale-string)
  (setlocale LC_CTYPE locale-string))

(define (get-character-type-locale)
  (setlocale LC_CTYPE #f))

(define (set-monetary-locale locale-string)
  (setlocale LC_MONETARY locale-string))

(define (get-monetary-locale)
  (setlocale LC_MONETARY #f))

(define (set-numeric-locale locale-string)
  (setlocale LC_NUMERIC locale-string))

(define (get-numeric-locale)
  (setlocale LC_NUMERIC #f))

(define (set-time-locale locale-string)
  (setlocale LC_TIME locale-string))

(define (get-time-locale)
  (setlocale LC_TIME #f))

(define (set-messages-locale locale-string)
  (setlocale LC_MESSAGES locale-string))

(define (get-messages-locale)
  (setlocale LC_MESSAGES #f))

(define (get-locale-conventions)
  (define (bytes->vector byte-string)
    (define vec (for/vector ([b byte-string]) b))
    (cond
      [(= (vector-length vec) 0)
       (vector grouping-repeats)]
      [(= (vector-ref vec (sub1 (vector-length vec))) grouping-ends)
       vec]
      [else
       (vector-append vec (vector grouping-repeats))]))
  (define actual-lconv (localeconv))
  (if (false? actual-lconv)
      #f
      (locale
       (lconv-decimal-point actual-lconv)
       (bytes->string/fallback (lconv-thousands-separator actual-lconv))
       (bytes->vector (lconv-grouping actual-lconv))
       (lconv-international-currency-symbol actual-lconv)
       (bytes->string/fallback (lconv-currency-symbol actual-lconv))
       (lconv-monetary-decimal-point actual-lconv)
       (bytes->string/fallback (lconv-monetary-thousands-separator actual-lconv))
       (bytes->vector (lconv-monetary-grouping actual-lconv))
       (lconv-positive-sign actual-lconv)
       (lconv-negative-sign actual-lconv)
       (lconv-international-fractional-digits actual-lconv)
       (lconv-fractional-digits actual-lconv)
       (lconv-pos-cs-precedes actual-lconv)
       (lconv-neg-cs-precedes actual-lconv)
       (lconv-pos-sep-by-space actual-lconv)
       (lconv-neg-sep-by-space actual-lconv)
       (lconv-pos-sign-posn actual-lconv)
       (lconv-neg-sign-posn actual-lconv)
       (lconv-international-pos-cs-precedes actual-lconv)
       (lconv-international-neg-cs-precedes actual-lconv)
       (lconv-international-pos-sep-by-space actual-lconv)
       (lconv-international-neg-sep-by-space actual-lconv)
       (lconv-international-pos-sign-posn actual-lconv)
       (lconv-international-neg-sign-posn actual-lconv)
       )))

(define (get-known-locales)
  (define locales (make-hash))
  (match (system-type)
    [(or 'unix 'macosx)
     (define raw-output (with-output-to-string (lambda () (system "locale -a"))))
     (for ([line (string-split raw-output "\n")])
       (cond
         [(equal? line "")
          (log-debug "ignoring blank lines")]
         [(or (equal? line "C") (string-prefix? line "C.")
              (equal? line "POSIX") (string-prefix? line "POSIX."))
          (log-debug "ignoring builtin locale identifier: ~s" line)]
         [else 
          (define matches (regexp-match locale-name-string line))
          (cond
            [(or (false? matches) (empty? matches))
             (log-error "unknown locale string format: ~s" line)]
            [else
             (define language (second matches))
             (when (not (hash-has-key? locales language))
               (hash-set! locales language (make-hash)))
             
             (when (third matches)
               (define country (substring (third matches) 1))
               (when (not (hash-has-key? (hash-ref locales language) country))
                 (hash-set! (hash-ref locales language) country '()))
               
               (when (fourth matches)
                 (define current-list (hash-ref (hash-ref locales language) country))
                 (hash-set! (hash-ref locales language)
                            country
                            (if (fifth matches)
                                (cons (string-append (fourth matches) (fifth matches)) current-list)
                                (cons (fourth matches) current-list)))))])]))]
    ['windows
     (log-warning "windows not yet implemented")]
    [else (error "unknown system-type " (system-type))])
  locales)

;; ---------- Internal tests

(module+ test
  (require rackunit)
  
  (check-equal? (set-locale "en_GB.UTF-8") "en_GB.UTF-8")
  (check-equal? (get-locale) "en_GB.UTF-8")
  (check-equal? (get-monetary-locale) "en_GB.UTF-8")
  (check-equal? (get-time-locale) "en_GB.UTF-8")
  
  (define conventions (get-locale-conventions))
  (check-equal? (locale-decimal-point conventions) ".")
  (check-equal? (locale-thousands-separator conventions) ",")
  (check-equal? (locale-currency-symbol conventions) "£")
  (check-equal? (locale-international-currency-symbol conventions) "GBP ")
  (check-equal? (locale-grouping conventions) '#(3 3 0))

  ;(hash-keys (get-known-locales))
  
  (check-true
   (for/and ([str '("en" "en_GB" "en_GB.UTF-8" "eng" "en_GBR" "eng_GBR.UTF-8")])
     (locale-string? str)))

  (check-true
   (for/and ([str '("e" "engl" "EN" "en_G" "en_GBRT" "en_gb")])
     (not (locale-string? str)))))

