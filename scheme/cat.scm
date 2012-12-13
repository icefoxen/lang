(define read-in
    (lambda (i)
      (let ((p (open-input-file i)))
        (letrec ((loc-read (lambda (s)
                             (let ((d (read-line s)))
                               (unless (eof-object? d)
                                 (display d)
                                 (newline)
                                 (loc-read s))))))
          (loc-read p))
      (close-input-port p))))

(read-in (read-line))