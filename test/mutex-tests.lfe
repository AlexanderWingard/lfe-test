(defmodule mutex-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest start
  (let ((sem (mutex:start)))
    (is-equal 'ok (mutex:wait sem))
    (is-equal 'ok (mutex:signal sem))
    (is-equal 'ok (mutex:wait sem))))