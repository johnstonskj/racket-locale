#lang scribble/manual

@(require racket/sandbox
          scribble/core
          scribble/eval
          locale
          (for-label racket/base
                     racket/contract
                     locale))

@;{============================================================================}

@(define example-eval (make-base-eval
                      '(require racket/string
                                locale)))

@;{============================================================================}

@title{Module locale.}
@defmodule[locale]

More locale tools for Racket

@examples[ #:eval example-eval
(require locale)
; add more here.
]

@;{============================================================================}

@;Add your API documentation here...


Document  - TBD

@defproc[(locale-string?
          [str string?])
         boolean?]{
TBD
}

@defproc[(get-known-locales)
         (hash/c string? (hash/c string? (listof string?)))]{
TBD
}
  
@defproc[(set-minimal-locale)
         (or/c locale-string? #f)]{
TBD
}

@defproc[(set-user-preferred-locale)
         (or/c locale-string? #f)]{
TBD
}

@defproc[(get-locale)
         (or/c locale-string? #f)]{
TBD
}

@defproc[(set-locale
          [locale locale-string?])
         (or/c locale-string? #f)]{
TBD
}

@defproc[(get-collation-locale)
         (or/c locale-string? #f)]{
TBD
}

@defproc[(set-collation-locale
          [locale locale-string?])
         (or/c locale-string? #f)]{
TBD
}

@defproc[(get-character-type-locale)
         (or/c locale-string? #f)]{
TBD
}

@defproc[(set-character-type-locale
          [locale locale-string?])
         (or/c locale-string? #f)]{
TBD
}

@defproc[(get-monetary-locale)
         (or/c locale-string? #f)]{
TBD
}

@defproc[(set-monetary-locale
          [locale locale-string?])
         (or/c locale-string? #f)]{
TBD
}

@defproc[(get-numeric-locale)
         (or/c locale-string? #f)]{
TBD
}

@defproc[(set-numeric-locale
          [locale locale-string?])
         (or/c locale-string? #f)]{
TBD
}

@defproc[(get-time-locale)
         (or/c locale-string? #f)]{
TBD
}

@defproc[(set-time-locale
          [locale locale-string?])
         (or/c locale-string? #f)]{
TBD
}

@defproc[(get-messages-locale)
         (or/c locale-string? #f)]{
TBD
}

@defproc[(set-messages-locale
          [locale locale-string?])
         (or/c locale-string? #f)]{
TBD
}

@defthing[CHAR_MAX number?]{
TBD
}

@defstruct*[locale
  ([decimal-point string?]
   [thousands-separator string?]
   [grouping string?]
   [international-currency-symbol string?]
   [currency-symbol string?]
   [monetary-decimal-point string?]
   [monetary-thousands-separator string?]
   [monetary-grouping vector?]
   [positive-sign string?]
   [negative-sign string?]
   [international-fractional-digits integer?]
   [fractional-digits integer?]
   [pos-cs-precedes integer?]
   [neg-cs-precedes integer?]
   [pos-sep-by-space integer?]
   [neg-sep-by-space integer?]
   [pos-sign-posn integer?]
   [neg-sign-posn integer?]
   [international-pos-cs-precedes integer?]
   [international-neg-cs-precedes integer?]
   [international-pos-sep-by-space integer?]
   [international-neg-sep-by-space integer?]
   [international-pos-sign-posn integer?]
   [international-neg-sign-posn integer?])]{
TBD

@itemlist[
 @item{@racket[decimal-point] - Decimal-point separator used for non-monetary quantities.}
 @item{@racket[thousands-separator] - Separators used to delimit groups of digits to the left of
   the decimal point for non-monetary quantities.}
 @item{@racket[grouping] - Specifies the amount of digits that form each of the groups to be
   separated by thousands_sep separator for non-monetary quantities. This is a zero-terminated
   sequence of char values that may contain different grouping sizes for each successive group
   starting from the right, each number indicating the amount of digits for the group; the last
   number before the ending zero in this string is used for the remaining groups. For example,
   assuming thousand_sep is set to @tt{","} and the number to represent is one million
   (@tt{1000000}):
   @itemlist[
    @item{with grouping set to @racket['#(3 0)], the number would be represented as: @tt{1,000,000}}
    @item{with grouping set to @racket['#(1 2 3 0)], the number would be represented as: @tt{1,000,00,0}}
    @item{with grouping set to @racket['#(3 1 0)], the number would be represented as: @tt{1,0,0,0,000}}
    @item{CHAR_MAX indicates that no further grouping is to be performed.}
   ]
  }
 @item{@racket[international-currency-symbol] - International currency symbol. This is formed
   by the three-letter ISO-4217 entry code for the currency, like @tt{"USD"} for U.S.-Dollar or
   @tt{"GBP"} for Pound Sterling, followed by the character used to separate this symbol from the
   monetary quantity.}
 @item{@racket[currency-symbol] - Local currency symbol, like @tt{"$"}.}
 @item{@racket[monetary-decimal-point] - Decimal-point separator used for monetary quantities.}
 @item{@racket[monetary-thousands-separator] - 	Separators used to delimit groups of digits
   to the left of the decimal point for monetary quantities.}
 @item{@racket[monetary-grouping] - Specifies the amount of digits that form each of the
   groups to be separated by mon_thousands_sep separator for monetary quantities.
   See grouping description above.}
 @item{@racket[positive-sign] - Sign to be used for nonnegative (positive or zero) monetary
   quantities.}
 @item{@racket[negative-sign] - Sign to be used for negative monetary quantities.}
 @item{@racket[international-fractional-digits] - Same as @racket[fractional-digits], but for the
   international format (instead of the local format).}
 @item{@racket[fractional-digits] - Amount of fractional digits to the right of the decimal point
   for monetary quantities in the local format.}
 @item{@racket[pos-cs-precedes] - Whether the currency symbol should precede nonnegative (positive
   or zero) monetary quantities. If this value is 1, the currency symbol should precede; if it
   is 0, it should follow.}
 @item{@racket[neg-cs-precedes] - Whether the currency symbol should precede negative monetary
   quantities. If this value is 1, the currency symbol should precede; if it is 0 it should follow.}
 @item{@racket[pos-sep-by-space] - Whether a space should appear between the currency symbol and
   nonnegative (positive or zero) monetary quantities. If this value is 1, a space should appear;
   if it is 0 it should not.}
 @item{@racket[neg-sep-by-space] - Whether a space should appear between the currency symbol and
   negative monetary quantities. If this value is 1, a space should appear; if it is 0 it should not.}
 @item{@racket[pos-sign-posn] - Position of the sign for nonnegative (positive or zero) monetary
   quantities:
  @itemlist[
   @item{0 : Currency symbol and quantity surrounded by parentheses.}
   @item{1 : Sign before the quantity and currency symbol.}
   @item{2 : Sign after the quantity and currency symbol.}
   @item{3 : Sign right before currency symbol.}
   @item{4 : Sign right after currency symbol.}
   @item{CHAR_MAX : Unspecified.}
  ]
  }
 @item{@racket[neg-sign-posn] - Position of the sign for negative monetary quantities. See
   @racket[pos-sign-posn] above.}
 @item{@racket[international-pos-cs-precedes] - Same as @racket[pos-cs-precedes], but for the
   international format.}
 @item{@racket[international-neg-cs-precedes] - Same as @racket[neg-cs-precedes], but for the
   international format.}
 @item{@racket[international-pos-sep-by-space] - Same as @racket[pos-sep-by-space], but for the
   international format.}
 @item{@racket[international-neg-sep-by-space] - Same as @racket[neg-sep-by-space], but for the
   international format.}
 @item{@racket[international-pos-sign-posn] - Same as @racket[pos-sign-posn], but for the
   international format.}
 @item{@racket[international-neg-sign-posn] - Same as @racket[neg-sign-posn], but for the
   international format.}
]

For example, given the currency value @tt{1.25} this is the effect of the various formatting
details above.

@tabular[#:style 'boxed
;         #:column-properties '(() (right-border) ())
;         #:row-properties '(bottom-border ())
         (list
          (list "" "pos-sep-by-space =" "0" "1" "2")
          (list "pos-cs-precedes = 0" "pos-sign-posn = 0" @tt{(1.25$)}    @tt{(1.25 $)}   @tt{(1.25 $)})
          (list ""                    "pos-sign-posn = 1" @tt{+1.25$}     @tt{+1.25 $}    @tt{+1.25 $})
          (list ""                    "pos-sign-posn = 2" @tt{ 1.25$+}    @tt{ 1.25 $+}   @tt{ 1.25$ +})
          (list ""                    "pos-sign-posn = 3" @tt{ 1.25+$}    @tt{ 1.25 +$}   @tt{ 1.25+ $})
          (list ""                    "pos-sign-posn = 4" @tt{ 1.25$+}    @tt{ 1.25 $+}   @tt{ 1.25$ +})
          (list "pos-cs-precedes = 1" "pos-sign-posn = 0" @tt{($1.25)}    @tt{($ 1.25)}   @tt{($ 1.25)})
          (list ""                    "pos-sign-posn = 1" @tt{+$1.25}     @tt{+$ 1.25}    @tt{+ $1.25})
          (list ""                    "pos-sign-posn = 2" @tt{ $1.25+}    @tt{ $ 1.25+}   @tt{  $1.25 +})
          (list ""                    "pos-sign-posn = 3" @tt{+$1.25}     @tt{+$ 1.25}    @tt{+ $1.25})
          (list ""                    "pos-sign-posn = 4" @tt{$+1.25}     @tt{$+ 1.25}    @tt{$ +1.25})
          )]
}

@defproc[(get-locale-conventions)
          locale?]{
TBD
}
