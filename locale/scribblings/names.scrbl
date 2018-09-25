#lang scribble/manual

@(require racket/sandbox
          scribble/core
          scribble/eval
          locale/names
          (for-label racket/base
                     racket/contract
                     locale/names))

@;{============================================================================}

@(define example-eval (make-base-eval
                      '(require racket/string
                                locale/names)))

@;{============================================================================}

@title[]{Module locale/names.}
@defmodule[locale/names]

More locale/names tools for Racket

@examples[ #:eval example-eval
(require locale/names)
; add more here.
]

@;{============================================================================}

@;Add your API documentation here...


Document  - TBD
