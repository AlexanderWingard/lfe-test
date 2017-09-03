(defmodule echo
  (export all))

(defun start
  ()
  (register (MODULE) (spawn_link (lambda () (loop))))
  'ok)

(defun stop
  ()
  (! (MODULE) 'stop)
  'ok)

(defun print
  (term)
  (! (MODULE) (tuple 'print term))
  'ok)

(defun loop
 ()
  (receive
    ((tuple 'print term) (io:format "~w~n" (list term)))
    ('stop (exit 'normal)))
  (loop))