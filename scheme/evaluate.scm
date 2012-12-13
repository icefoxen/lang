; evaluate.scm
; A Lisp-y (eval)-type function.
; W00t!  How cool.
; ^_^
;
; evaluate is like eval, invoke is like funcall or apply.
; 
; Simon Heath
; 26/03/2004

(define (atom? n) 
  (not (pair? n)))

(define no-value 'no-value)


;; Error checking...
(define (wrong message data)
  (display "Error: ")
  (display message)
  (newline)
  (display data)
  (newline))

;; Kay, we're using an assoc list for the environment here.
;; Blazingly slow, but simple.

(define env-init ())

(define env-global env-init)

(define (lookup id env)
  (if (pair? env)
      (if (eq? (caar env) id)
	  (cdar env)
	  (lookup id (cdr env)))
      (wrong "No such binding for lookup" id)))

(define (update! id env value)
  (if (pair? env)
      (if (eq? (caar env) id)
	  (begin (set-cdr! (car env) value)
		 value)
	  (update! id (cdr env) value))
      (wrong "No such binding" id)))

; Build a couple macros to make life easier.
; These help define initial functions and values.
(define-syntax definitial
  (syntax-rules ()
    ((definitial name)
     (begin (set! env-global (cons (cons 'name 'void) env-global))
            'name))
    ((definitial name value)
     (begin (set! env-global (cons (cons 'name value) env-global))
            'name))))

(define-syntax defprimitive
  (syntax-rules ()
    ((defprimitive name value arity)
     (definitial name
                 (lambda (values)
                   (if (= arity (length values))
                       (apply value values)  ; SCHEME's apply here!
                       (wrong "Incorrect arity" (list 'name values))))))))

; Scheme's #f is considered false.  Anything else is true.
; T is the canonical true symbol, f the false symbol, and nil the empty list.
; These can all be resassigned, of course.  To change that would require
; hacking (evaluate) to treat them as keywords.
(definitial t #t)
(definitial f 'the-false-value)
(definitial nil '())
(definitial () '())


; More handy initial functions, bootstrapping off Scheme.
(defprimitive cons cons 2)
(defprimitive car car 1)
(defprimitive cdr cdr 1)
(defprimitive set-car! set-car! 1)
(defprimitive set-cdr! set-cdr! 1)
(defprimitive + + 2)
(defprimitive - - 2)
(defprimitive * * 2)
(defprimitive / / 2)
(defprimitive eq? eq? 2)
(defprimitive < < 2)
(defprimitive > > 2)


;; Extends an environment enve with a list of variables and values.
(define (extend env variables values)
  (cond
    ((pair? variables)
     (if (pair? values)
         (cons (cons (car variables) (car values))
               (extend env (cdr variables) (cdr values)))
         (wrong "Too few values for variables" variables)))
    ((null? variables)
     (if (null? values)
         env
         (wrong "Too many values for variables" values)))
    ((symbol? variables)
     (cons (cons variables values) env))))

(define (eprogn exps env)
  (if (pair? exps)
      (if (pair? (cdr exps))
;	  (begin (evaluate (car exps) env)
;		 (eprogn (cdr exps) env))
          ; (begin x y) = ((lambda (null) y) x)
          ((lambda (x)
             (eprogn (cdr exps) env))
           (evaluate (car exps) env))
	  (evaluate (car exps) env))
      no-value))


(define (evlis e env)
  (if (pair? e)
      ;; Note that we explicitly evaluate function arguments from left
      ;; to right.
      (cons (evaluate (car e) env)
	    (evlis (cdr e) env))
      ()))

; At the moment, we just use the Scheme environment to invoke things.
; 'Twill get more sophisticated later.
; If we want to do more complex things like checking function arity or arg type,
; it'll be done here
(define (invoke fn args)
  (if (procedure? fn)
      (fn args)
      (wrong "Not a function!" fn)))

; Kay, here we build a function environment...
; This is open to subtle errors; we have to have a function access the WHOLE
; global environment, but we also have to have it clean up bindings after itself.
(define (make-function variables body env)
  (lambda (values)
    (eprogn body (extend env variables values))))

(define (make-function variables body env)
  (lambda (values)
    (eprogn body (extend env variables values))))


(define (evaluate e env)
  (if (atom? e)
      ;; Resolve symbols.
      ;; Symbols map to variables, and variables map to keys in the
      ;; environment.  Which are symbols, so yay!
      (cond 
        ((symbol? e)
         (lookup e env))
        ;; These other types evaluate to themselves; they're auto-quoting.
        ((or (number? e) (string? e) (char? e) 
             (boolean? e) (vector? e))
         e)
        (else (wrong "Cannot evaluate" e)))
      ;; Resolve lists.
      ;; These here are keywords, special forms, whatever ye call them.
      (case (car e)
        ((quote)   (cadr e))
        ;; We assume a tripartate if statement, always.
        ;; We also assume Scheme-ish boolean semantics.
        ((if)      (if (eq? (evaluate (cadr e) env) (evaluate 't env))
                       (evaluate (caddr e) env)
                       (evaluate (cadddr e) env)))
        ((begin)   (eprogn (cdr e) env))
        ((set!)    (update! (cadr e) env 
                            (evaluate (caddr e) env)))
        ((lambda)  (make-function (cadr e) (cddr e) env))
        ; A bit of a hack, but it lets one define new symbols.  Yay!
        ((define)  (set-cdr! env 
                             (cons (cons (cadr e) (evaluate (caddr e) env)) 
                                   (cdr env))))
        ;; If the list isn't a special form, it's a function.  Evaluate it.
        (else      (invoke (evaluate (car e) env)
                           (evlis (cdr e) env))))))


(define done #f)

; And, the grand finale!  Taran-ta-ta!
(define (rep)
  (define (toplevel)
    (display "evaluate> ")
      (display (evaluate (read) env-global))
    (newline)
    (toplevel))
  (toplevel))
