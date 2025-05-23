(define (if-program condition if-true if-false)
    `(if ,condition ,if-true ,if-false)
)

(define (square n) (* n n))

(define (pow-expr base exp)
    (cond
                ((= exp 0) 1)
                ((= exp 1) `(* ,base 1))
                ((odd? exp) `(* ,base (square,(pow-expr base (quotient (- exp 1) 2)))))
                (else `(square,(pow-expr base (quotient exp 2))))
        )
)

(define-macro (repeat n expr)
  `(repeated-call ,n (quote ,expr)))

; Call zero-argument procedure f n times and return the final result.
(define (repeated-call n f)
  (if (= n 1)
      (eval f)
      (begin (eval f) (repeated-call (- n 1) f))))
