;; Usage:
;; (defparameter secret1 (make-secret-keeper))
;; (funcall secret1 'set-password 'pass)
;; (funcall secret1 'set-secret 'sec)
;; (funcall secret1 'get-secret 'pass)
;; (funcall secret1 'change-password 'pass 'pass2)

(defun make-secret-keeper ()
  (let ((password nil)
        (secret nil))
    #'(lambda (operation &rest arguments)
        (ecase operation
          (set-password
            (let ((new-passwd (first arguments)))
              (if password
                '|Can't - already set|
                (setq password new-passwd))))
          (change-password
            (let ((old-passwd (first arguments))
                  (new-passwd (second arguments)))
              (if (eq old-passwd password)
                (setq password new-passwd)
                '|Not changed|)))
          (set-secret
            (let ((passwd (first arguments))
                  (new-secret (second arguments)))
              (if (eq passwd password)
                (setq secret new-secret)
                '|Wrong password|)))
          (get-secret
            (let ((passwd (first arguments)))
              (if (eq passwd password)
                secret
                '|Sorry|))))))) 
