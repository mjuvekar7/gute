
(in-package :util)

;; List of characters that constitute whitespace in the trim functions.
(defparameter *trim-whitespace-chars*
  '(#\Space #\Newline #\Backspace #\Tab
    #\Linefeed #\Page #\Return #\Rubout))

;; Trims a string of whitespace.  Optionally you can provide the character list
;; that are trimmed, though in that case you might as well use string-trim.
(defun trim (str &optional trimlist-arg)
  (let ((trimlist (if trimlist-arg trimlist-arg
                    *trim-whitespace-chars* )))
  (string-trim trimlist str)))

;; Same as trim, but only for the left side.
(defun left-trim (str &optional trimlist-arg)
  (let ((trimlist (if trimlist-arg trimlist-arg
                    *trim-whitespace-chars*)))
  (string-left-trim trimlist str)))

;; Same as trim, but only for the right side.
(defun right-trim (str &optional trimlist-arg)
  (let ((trimlist (if trimlist-arg trimlist-arg
                    *trim-whitespace-chars*)))
  (string-right-trim trimlist str)))

;; Converts a symbol to the corresponding string.
(defun sym2str (sym)
  (format nil "~s" sym))

;; Converts a list to a string with a given delimiter between elements.
;; Elements are represented with the usual string representation.
(defun list-to-string (lst delim &optional (remove-newlines nil))
  (reduce
    #'(lambda (x y)
        (concatenate 'string x delim y))
    (mapcar #'(lambda (a)
                (if remove-newlines
                  ;; TODO: remove dependency to allegro re package.
                  (replace-re (format nil "~s" a) "\\n" " ")
                  (format nil "~s" a))) lst)))

