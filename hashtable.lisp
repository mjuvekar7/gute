
(in-package :util)

;; Prints a hash-table readably.
;; https://github.com/phoe/phoe-toolbox/blob/master/phoe-toolbox.lisp
;; https://lispcookbook.github.io/cl-cookbook/data-structures.html
(defun print-hash-table-readably (hash-table
                                  &optional (stream *standard-output*))
  "Prints a hash table readably using ALEXANDRIA:ALIST-HASH-TABLE."
  (declare (type stream stream))
  (let ((test (hash-table-test hash-table))
        (*print-circle* t)
        (*print-readably* t))
    (format stream "#.(ALEXANDRIA:ALIST-HASH-TABLE '(~%")
    (maphash (lambda (k v) (format stream "   (~S . ~S)~%" k v)) hash-table)
    (format stream "   ) :TEST '~A)" test)
    hash-table))

;; Gene's version of print-hash-table-readably. Designed to look similar to
;; Python's representation of hash tables. Can't be read in using 'read' like
;; the original.
(defun print-ht (ht &key (stream *standard-output*) (cutoff 10) (itemsep "~%"))
  "Prints a hash table readably to look like Python hash tables."
  (declare (type stream stream))
  (let ((test (hash-table-test ht))
        (*print-circle* t)
        (*print-readably* t)
        (alist (alexandria:hash-table-alist ht))
        overmax
        printlist)
    (declare (type list alist))
    (setq overmax (> (the fixnum (length alist)) cutoff))
    (setq printlist (if overmax (subseq alist 0 cutoff) alist))
    (format stream "HASH-TABLE(TEST #'~A)~%{" test)
    (if (not (null alist))
      (format stream "~S: ~S" (caar printlist) (cdar printlist)))
    (mapcar (lambda (kv) (format stream
                                 (concatenate 'string "," itemsep "~S: ~S")
                                 (car kv) (cdr kv)))
            (cdr printlist))
    (if overmax
      (format stream (concatenate 'string "," itemsep "...")))
    (format stream "}")))

