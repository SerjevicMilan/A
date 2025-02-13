(define (ascending? s)
    (define (asc s prev)
        (if (null? s) #t
            (if (or (= (car s) prev) (> (car s) prev))
                (asc (cdr s) (car s))
                #f
            )
        )
    )
    (if (null? s) #t
        (if (= 1 (length s)) #t
        (asc (cdr s) (car s))))
)

(define (my-filter pred s)
        (if (null? s) nil
            (if (pred (car s)) (append (list (car s)) (my-filter pred (cdr s)))
                (my-filter pred (cdr s))
            )
        )
)

(define (interleave lst1 lst2)
    (if (null? lst1) lst2
        (if (null? lst2) lst1
            (append (list (car lst1) (car lst2)) (interleave (cdr lst1) (cdr lst2)))
        )
    )
)

(define (no-repeats s)
    (define (filter-repeats s nr)
        (if (null? s) nr
            (filter-repeats (cdr s) (append (filter (lambda (a) (not (= a (car s)))) nr) (list (car s))))
        )
    )
    (filter-repeats s '())
)
