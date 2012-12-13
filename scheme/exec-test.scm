(define a '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))
(define b '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))
(letrec ((foo
          (lambda (lst)
            (if (equal? lst '())
                #t
                (begin
                  (display (car lst))
                  (newline)
                  (foo (cdr lst)))))))
  (foo (map + a b)))