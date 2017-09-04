(defmodule my-db
  (export all))

(defun start
  ()
  (let ((spawner (self)))
    (spawn_link (lambda () (init spawner))))
  (receive
    ('init_done 'ok)))

(defun stop
  ()
  (! (MODULE) 'stop)
  'ok)

(defun write
  (key val)
  (rpc 'write (list key val)))

(defun read
  (key)
  (rpc 'read (list key)))

(defun delete
  (key)
  (rpc 'delete (list key)))

(defun match
  (val)
  (rpc 'match (list val)))

(defun rpc
  (op args)
  (let ((ref (make_ref)))
    (! (MODULE) (tuple ref (self) op args))
    (receive
      ((tuple ref resp) resp))))

(defun init
  (spawner)
  (register (MODULE) (self))
  (! spawner 'init_done)
  (loop (db:new)))

(defun loop
  (db)
  (receive
    ((tuple ref sender 'read args)
     (! sender (tuple ref (apply 'db 'read (++ args (list db)))))
     (loop db))

    ((tuple ref sender 'write args)
     (let ((new-db (apply 'db 'write (++ args (list db)))))
       (! sender (tuple ref 'ok))
       (loop new-db)))

    ((tuple ref sender 'delete args)
     (let ((new-db (apply 'db 'delete (++ args (list db)))))
       (! sender (tuple ref 'ok))
       (loop new-db)))

    ((tuple ref sender 'match args)
     (! sender (tuple ref (apply 'db 'match (++ args (list db)))))
     (loop db))

    ('stop (exit 'normal))))