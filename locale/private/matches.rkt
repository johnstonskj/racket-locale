#lang racket/base
;;
;; racket-locale - format.
;;   
;;
;; Copyright (c) 2018 Simon Johnston (simonjo@amazon.com).

;; Racket Style Guide: http://docs.racket-lang.org/style/index.html

(require racket/contract)

(provide

 regex-replace-string

 regex-replace-out

 regex-replace)

;; ---------- Requirements

(require racket/bool
         racket/list
         racket/match
         racket/string)

;; ---------- Implementation

(define (regex-replace-string expression in-str match-handler)
  (define out (open-output-string))
  (regex-replace-out expression
                     in-str
                     match-handler
                     out)
  (get-output-string out))  

(define (regex-replace-out expression in-str match-handler out)
  (regex-replace expression
                 in-str
                 (λ (var) (display (match-handler in-str var) out))
                 (λ (str) (display str out))))
  
(define (regex-replace expression in-str match-handler content-handler)
  (define matches (regexp-match-positions* expression in-str))
  (cond
    [(or (false? matches) (empty? matches))
     in-str]
    [else
     (let next-match ([group (first matches)]
                      [more  (rest matches)]
                      [last-char 0])
       (when (> (car group) last-char)
         (content-handler (substring in-str last-char (car group))))
       (match-handler (substring in-str (car group) (cdr group)))
       (if (empty? more)
           (when (< (cdr group) (string-length in-str))
             (content-handler (substring in-str (cdr group))))
           (next-match (first more) (rest more) (cdr group))))]))

