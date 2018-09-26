#lang racket/base
;;
;; racket-locale - private/cuname.
;;   More locale tools for Racket
;;
;; Copyright (c) 2018 Simon Johnston (johnstonskj@gmail.com).

;; Racket Style Guide: http://docs.racket-lang.org/style/index.html


(provide
 (except-out (all-defined-out)
             define-libc))

;; ---------- Requirements

(require ffi/unsafe
         ffi/unsafe/define)

;; ---------- Internal types

(define-ffi-definer define-libc #f
  #:default-make-fail make-not-available)

;; ---------- Implementation

(define _UTSNAME_LENGTH 65)

(define-cstruct _utsname 
  ([systemname _string]
   [node-name _string]
   [release _string]
   [version _string]
   [machine _string]))

(define (allocate-utsname)
  (make-utsname (make-string _UTSNAME_LENGTH #\space)
  (make-string _UTSNAME_LENGTH #\space)
  (make-string _UTSNAME_LENGTH #\space)
  (make-string _UTSNAME_LENGTH #\space)
  (make-string _UTSNAME_LENGTH #\space)))

(define-libc uname (_fun _utsname-pointer -> _int))