#lang scribble/manual

@(require racket/sandbox
          scribble/core
          scribble/eval
          locale/language-info
          (for-label racket/base
                     racket/contract
                     locale/language-info))

@;{============================================================================}

@(define example-eval (make-base-eval
                      '(require racket/string
                                locale/language-info)))

@;{============================================================================}

@title{Module locale/language-info.}
@defmodule[locale/language-info]

More locale/language-info tools for Racket

@examples[ #:eval example-eval
(require locale/language-info)
; add more here.
]

@;{============================================================================}

@;Add your API documentation here...


Document  - TBD

@defproc[(get-codeset)
         string?]{
Return a string with the name of the character encoding used
 in the selected locale, such as @tt{"UTF-8"}, @tt{"ISO-8859-1"}, or
 @tt{"ANSI_X3.4-1968"} (better known as US-ASCII).
}

@defproc[(get-datetime-format)
         string?]{
Return a string that can be used as a format string to represent time and date
 in a locale-specific way.
}

@defproc[(get-date-format)
         string?]{
Return a string that can be used as a format string for
              strftime(3) to represent a date in a locale-specific way.
}

@defproc[(get-time-format)
         string?]{
Return a string that can be used as a format string for
              strftime(3) to represent a time in a locale-specific way.
}

@defproc[(get-time-ampm-format)
         string?]{
a.m. or p.m. time format string.
}

@defproc[(get-am-string)
         string?]{
Ante Meridian affix string.
}

@defproc[(get-pm-string)
         string?]{
Post Meridian affix string.
}

@defproc[(get-weekday-name
          [day integer?])
         string?]{
Return name of the @italic{n}-th day of the week. @italic{Warning: this
 follows the US convention where Sunday is the first day of the week, not the
 international convention (ISO 8601) of Monday.}
}

@defproc[(get-abbrev-weekday-name
          [day integer?])
         string?]{
Return abbreviated name of the @italic{n}-th day of the week.
}

@defproc[(get-month-name
          [month integer])
         string?]{
Return name of the n-th month.
}

@defproc[(get-abbrev-month-name
          [month integer])
         string?]{
Return abbreviated name of the n-th month.
}

@defproc[(get-era-description)
         string?]{
Era description segments.
}

@defproc[(get-era-date-format)
         string?]{
Era date format string.
}

@defproc[(get-era-datetime-format)
         string?]{
Era date and time format string.
}

@defproc[(get-era-time-format)
         string?]{
Era time format string.
}

@defproc[(get-alt-digit-symbol)
         string?]{
Alternative symbols for digits.
}

@defproc[(get-radix-character)
         string?]{
Return radix character (decimal dot, decimal comma, etc.).
}

@defproc[(get-thousands-separator)
         string?]{
Return separator character for thousands (groups of three
              digits).
}

@defproc[(get-yes-expression)
         string?]{
Return a regular expression that can be used with the @racket[regexp]
 function to recognize a positive response to a yes/no
 question.
}

@defproc[(get-no-expression)
         string?]{
Return a regular expression that can be used with the @racket[regexp]
 function to recognize a negative response to a yes/no
 question.
}

@defproc[(get-yes-response)
         string?]{
String corresponding to an affirmative response to a yes/no question (deprecated).
}

@defproc[(get-no-response)
         string?]{
String corresponding to a negative response to a yes/no question (deprecated).


}

@defproc[(get-currency-symbol)
         string?]{
Return the currency symbol, preceded by @tt{"-"} if the symbol
 should appear before the value, @tt{"+"} if the symbol should
 appear after the value, or @tt{"."} if the symbol should replace
 the radix character.
}

@defproc[(get-month-day-order)
         string?]{
month/day order (local extension)
}
