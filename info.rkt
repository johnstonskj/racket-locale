#lang info
;;
;; Package racket-locale.
;;   More locale tools for Racket
;;
;; Copyright (c) 2018 Simon Johnston (johnstonskj@gmail.com).

(define collection 'multi)

(define pkg-desc "More locale tools.")
(define version "1.0")
(define pkg-authors '(johnstonskj))

(define deps '(
  "base"
  "rackunit-lib"
  "racket-index"))
(define build-deps '(
  "scribble-lib"
  "racket-doc"
  "sandbox-lib"
  "cover-coveralls"))
