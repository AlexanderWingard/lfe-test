(defmodule mutex
  (export all))

(defun start
  ()
  (spawn_link
   (lambda ()
     (process_flag 'trap_exit 'true)
     (free))))

(defun wait
  (sem)
  (let ((ref (make_ref)))
    (! sem (tuple ref (self) 'wait))
    (receive
      (ref 'ok))))

(defun signal
  (sem)
  (let ((ref (make_ref)))
    (! sem (tuple ref (self) 'signal))
    (receive
      (ref 'ok))))

(defun free
  ()
  (receive
    ((tuple ref client 'wait)
     (link client)
     (! client ref)
     (busy))))

(defun busy
  ()
  (receive
    ((tuple 'EXIT from reason)
     (free))
    ((tuple ref client 'signal)
     (! client ref)
     (free))))