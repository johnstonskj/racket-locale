#lang scribble/manual

@(require racket/sandbox
          scribble/core
          scribble/eval
          locale/format
          (for-label racket/base
                     racket/contract
                     locale
                     locale/format))

@;{============================================================================}

@(define example-eval (make-base-eval
                      '(require racket/date
                                racket/string
                                locale
                                locale/format)))

@;{============================================================================}
@title{Module locale/format}
@defmodule[locale/format]

This module provides functions to format numbers, currency, and date/time
values. The formats are locale-specific and retrieved from
@secref["Module_locale_language-info"
         #:doc '(lib "locale/scribblings/racket-locale.scrbl")].


@;{============================================================================}
@section{Numbers and Currency}

@defproc[(format-number
          [value number?])
         string?]{
Format a plain numeric value according to locale-specific conventions. In general
this implies ensuring the correct decimal point and thousands separator characters
as well as @italic{thousands grouping}.

@examples[ #:eval example-eval
(require locale
         locale/format)
(set-locale (make-locale-string "en" ; language
                                "US" ; country/territory
                                #:code-page (normalize-code-page 'utf-8)))
(format-number 1234567.89)
]
}

@defproc[(format-currency
          [value number?]
          [internationl boolean? #f])
         string?]{
Formatting a currency follows many of the conventions of @racket[format-number]
but also has to handle placement of currency symbols and sign symbols
(see struct @racket[locale?] for more details).

@examples[ #:eval example-eval
(require locale
         locale/format)
(set-locale (make-locale-string "zh" ; language
                                "CN" ; country/territory
                                #:code-page (normalize-code-page 'utf-8)))
(format-currency 1234.89)
(set-locale (make-locale-string "ko" ; language
                                "KR" ; country/territory
                                #:code-page (normalize-code-page 'utf-8)))
(format-currency 1234.89)
(set-locale (make-locale-string "es" ; language
                                "ES" ; country/territory
                                #:code-page (normalize-code-page 'utf-8)))
(format-currency 1234.89)
]

The @racket[international] argument denotes whether the formatting should
follow international standared conventions, and whether the local currency
symbol should be replaced by a standard three letter currency identifier.

@examples[ #:eval example-eval
(require locale
         locale/format)
(set-locale (make-locale-string "zh" ; language
                                "CN" ; country/territory
                                #:code-page (normalize-code-page 'utf-8)))
(format-currency 1234.89 #t)
]
}

 
@;{============================================================================}
@section{Dates and Times}

@defproc[(format-date
         [value (or/c date? number?)])
         string?]{
Formatting a date value comprises the ordering of the date components, any separator
characters and any localized string elements.

@examples[ #:eval example-eval
(require locale
         locale/format
         racket/date)
(define now (current-date))
(set-locale (make-locale-string "en" ; language
                                "US" ; country/territory
                                #:code-page (normalize-code-page 'utf-8)))
(format-date now)
(set-locale (make-locale-string "zh" ; language
                                "CN" ; country/territory
                                #:code-page (normalize-code-page 'utf-8)))
(format-date now)
]
}

@defproc[(format-time
         [value (or/c date? number?)]
         [am-pm boolean? #f])
         string?]{
Formatting a time value comprises the ordering of the time components, any separator
characters and any localized string elements.


@examples[ #:eval example-eval
(require locale
         locale/format
         racket/date)
(define now (current-date))
(set-locale (make-locale-string "en" ; language
                                "US" ; country/territory
                                #:code-page (normalize-code-page 'utf-8)))
(format-time now)
(set-locale (make-locale-string "zh" ; language
                                "CN" ; country/territory
                                #:code-page (normalize-code-page 'utf-8)))
(format-time now)
]
}

@defproc[(format-datetime
         [value (or/c date? number?)])
         string?]{
Formatting a date-and-time value comprises the ordering of the various components,
any separator characters and any localized string elements.


@examples[ #:eval example-eval
(require locale
         locale/format
         racket/date)
(define now (current-date))
(set-locale (make-locale-string "en" ; language
                                "US" ; country/territory
                                #:code-page (normalize-code-page 'utf-8)))
(format-datetime now)
(set-locale (make-locale-string "zh" ; language
                                "CN" ; country/territory
                                #:code-page (normalize-code-page 'utf-8)))
(format-datetime now)
]
}
