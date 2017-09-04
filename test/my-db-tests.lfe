(defmodule my-db-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest start
  (is-equal 'ok (my-db:start))
  (my-db:stop))

(deftest stop
  (my-db:start)
  (is-equal 'ok (my-db:stop)))

(deftest write
  (my-db:start)
  (is-equal 'ok (my-db:write 'k 'v))
  (my-db:stop))

(deftest read
  (my-db:start)
  (is-equal #(error not-found) (my-db:read 'k))
  (my-db:stop))

(deftest delete
  (my-db:start)
  (my-db:write 'k 'v)
  (is-equal #(ok v) (my-db:read 'k))
  (my-db:delete 'k)
  (is-equal #(error not-found) (my-db:read 'k))
  (my-db:stop))

(deftest match
  (my-db:start)
  (my-db:write 'k 'v)
  (my-db:write 'k2 'v)
  (is-equal '(k k2) (my-db:match 'v)))
