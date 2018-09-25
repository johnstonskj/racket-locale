#lang scribble/manual

@(require racket/sandbox
          scribble/core
          scribble/eval
          locale/format
          (for-label racket/base
                     racket/contract
                     locale/format))

@;{============================================================================}

@(define example-eval (make-base-eval
                      '(require racket/string
                                locale/format)))

@;{============================================================================}
@title{Module locale/format.}
@defmodule[locale/format]



@examples[ #:eval example-eval
(require locale/format)
; add more here.
]

@;{============================================================================}

@;Add your API documentation here...


Document  - TBD

@defproc[(format-number
          [value number?])
         string?]{
TBD
}

@defproc[(format-currency
          [value number?])
         string?]{
TBD
}
 
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
