(defmodule hello-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest is
  (is (== 2 (hello:test)))
  (is 'true)
  (is (not 'false))
  (is (not (not 'true))))