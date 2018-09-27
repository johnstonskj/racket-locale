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
                      '(require racket/string
                                locale
                                locale/format)))

@;{============================================================================}
@title{Module locale/format}
@defmodule[locale/format]



@examples[ #:eval example-eval
(require locale
         locale/format
         racket/date)
(set-locale "en_US")
(format-date (current-date))
(format-number 1234567.89)
(format-currency 10.99)
(set-locale "fr_FR")
(format-date (current-date))
(format-number 1234567.89)
(format-currency 10.99)
]

@;{============================================================================}
@section{Numbers and Currency}

@defproc[(format-number
          [value number?])
         string?]{
TBD
@examples[ #:eval example-eval
(require locale
         locale/format
         racket/date)
(set-locale "en_US")
(get-locale-conventions)
(format-number 1234567.89)
]
}

@defproc[(format-currency
          [value number?])
         string?]{
TBD
}
 
@;{============================================================================}
@section{Dates and Times}

@defproc[(format-date
         [value (or/c date? number?)])
         string?]{
TBD
}

@defproc[(format-time
         [value (or/c date? number?)]
         [am-pm boolean? #f])
         string?]{
TBD
}

@defproc[(format-datetime
         [value (or/c date? number?)])
         string?]{
TBD
}
