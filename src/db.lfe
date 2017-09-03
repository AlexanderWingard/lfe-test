(defmodule db
  (export all))

(defun new
  () [])

(defun destroy
  () 'ok)

(defun size
  (db) (size db 0))

(defun size
  (([] n) n)
  (((cons hd tl) n) (size tl (+ n 1))))

(defun write
  (key elem db) (cons (tuple key elem) (delete key db)))

(defun delete
  (key db) (delete key db []))

(defun delete
  ((key [] acc)
   acc)
  ((key (cons (tuple key1 _) tl) acc) (when (== key key1))
   (++ acc tl))
  ((key (cons elem tl) acc)
   (delete key tl (cons elem acc))))

(defun read
  ((key []) #('error 'not_found))
  ((key (cons (tuple key1 value) tl)) (when (== key key1)) (tuple 'ok value))
  ((key (cons _ tl)) (read key tl)))

(defun match
  (value db) (match value db []))

(defun match
  ((value [] acc)
   acc)
  ((value (cons (tuple k v) tl) acc) (when (== value v))
   (match value tl (cons k acc)))
  ((value (cons (tuple k v) tl) acc)
   (match value tl acc)))