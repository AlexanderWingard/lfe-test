(defmodule db-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest db-new
  (is-equal [] (db:new)))

(deftest db-destroy
  (is-equal 'ok (db:destroy)))

(deftest db-size
  (is-equal 0 (db:size (db:new))))

(deftest db-write
  (is-equal 2 (db:size (db:write 'k2 'v2 (db:write 'k 'v (db:new)))))
  (is-equal 1 (db:size (db:write 'k 'v2 (db:write 'k 'v (db:new))))))

(deftest db-delete
  (let ((d (db:write 'k 'v (db:new))))
    (is-equal 0 (db:size (db:delete 'k d)))
    (is-equal 1 (db:size (db:delete 'x d)))))

(deftest db-read
  (let ((d  (db:write 'k 'v (db:new))))
    (is-equal #(ok v) (db:read 'k d)) ;???
    (is-equal #(error not-found) (db:read 'x d))))

(deftest db-match
  (is-equal (list 'k1 'k) (db:match 'v (db:write 'k 'v (db:write 'k1 'v (db:new))))))