(defmodule echo-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest echo-start
  (is-equal 'ok (echo:start))
  (echo:stop))

(deftest echo-print
  (echo:start)
  (is-equal 'ok (echo:print "test")))

(deftest echo-stop
  (is-equal 'ok (echo:stop)))
